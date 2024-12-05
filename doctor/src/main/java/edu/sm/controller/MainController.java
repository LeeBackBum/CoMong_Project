package edu.sm.controller;

import edu.sm.app.dto.CounselDto;
import edu.sm.app.dto.DoctorDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.CounselService;
import edu.sm.app.service.DoctorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    private final DoctorService doctorService;
    private final CounselService counselService;

    @Value("${app.dir.imgmypage}")
    private String imgmypage;

    @Value("${app.url.server-url}")
    String serverurl;

    @RequestMapping("/")
    public String index(Model model) {
        model.addAttribute("center", "center");
        log.info("Start Index ,,,,,,");
        return "index";
    }

    @RequestMapping("/main")
    public String main(Model model) throws Exception {
        List<DoctorDto> doctors = doctorService.get();

        model.addAttribute("doctors",doctors);
        log.info("Start Main ,,,,,,");
        return "main";
    }

    @RequestMapping("blank")
    public String blank(Model model) {
        model.addAttribute("center", "blank");
        return "main";
    }

    @RequestMapping("/webrtc")
    public String webrtc(Model model) {
        model.addAttribute("roomId", "1");    // 하드코딩된 roomId
        model.addAttribute("center", "webrtc");
        return "main";
    }

    @RequestMapping("/loginimpl")
    public String loginimpl(
            @RequestParam("id") String id,
            @RequestParam("pwd") String pwd,
            HttpSession httpSession) {
        DoctorDto doctorDto = null;

        try {
            doctorDto = doctorService.get(id);
            if (doctorDto == null) {
                throw new Exception();
            }
            if (!doctorDto.getDoctorPwd().equals(pwd)) {
                throw new Exception();
            }
            httpSession.setAttribute("doctor", doctorDto);
            httpSession.setAttribute("doctorid", doctorDto);
        } catch (Exception e) {
            return "/";
        }

        return "redirect:/main";
    }

    //mypage
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model) {
        DoctorDto doctor = (DoctorDto) session.getAttribute("doctor");
        if (doctor == null) {
            return "redirect:/";
        }
        model.addAttribute("doctor", doctor);
        model.addAttribute("center", "mypage");
        return "main";
    }

    @PostMapping("/mypage/update")
    public String updateDoctorInfo(
            @RequestParam("doctorId") String doctorId,
            @RequestParam(value = "doctorImg", required = false) MultipartFile doctorImg,
            @RequestParam("doctorName") String doctorName,
            @RequestParam("doctorEmail") String doctorEmail,
            @RequestParam("doctorNumber") String doctorNumber,
            @RequestParam("doctorAge") String doctorAge,
            @RequestParam("subjectName") String subjectName,
            HttpSession session
    ) {
        try {
            String fileName = null;

            // 파일 업로드 처리
            if (doctorImg != null && !doctorImg.isEmpty()) {
                File destDir = new File(imgmypage);

                if (!destDir.exists()) {
                    destDir.mkdirs();
                }

                fileName = UUID.randomUUID() + "_" + doctorImg.getOriginalFilename();
                File destFile = new File(destDir, fileName);
                doctorImg.transferTo(destFile);
            }

            // DB에서 기존 데이터 가져오기
            DoctorDto existingDoctor = doctorService.get(doctorId);

            if (existingDoctor == null) {
                throw new Exception("Doctor not found with ID: " + doctorId);
            }

            // 업데이트할 데이터를 기존 데이터로 초기화
            existingDoctor.setDoctorName(doctorName);
            existingDoctor.setDoctorEmail(doctorEmail);
            existingDoctor.setDoctorNumber(doctorNumber);
            existingDoctor.setDoctorAge(doctorAge);
            existingDoctor.setSubjectName(subjectName);

            // 새로운 이미지가 업로드된 경우에만 업데이트
            if (fileName != null) {
                existingDoctor.setDoctorImg(fileName);
            }

            // DB 업데이트
            doctorService.modify(existingDoctor);

            // 세션 업데이트
            session.setAttribute("doctor", existingDoctor);

            return "redirect:/mypage?success=true";

        } catch (Exception e) {
            log.error("Error updating doctor info: {}", e.getMessage(), e);
            return "redirect:/mypage?error=update_failed";
        }
    }

    // 웹소켓
    @RequestMapping("/counseling")
    public String counseling(HttpSession session, Model model) {
        // 세션에서 로그인된 사용자 정보 가져오기
        Object loginid = session.getAttribute("doctorid");

        // UserDto 객체에서 userName 가져오기 (loginid가 UserDto라고 가정)
        String doctorName = ((DoctorDto) loginid).getDoctorName();

        // JSP에 데이터 전달
        model.addAttribute("serverurl", serverurl);
        model.addAttribute("doctorName", doctorName);
        model.addAttribute("center", "Counseling/counseling");

        System.out.println("Server URL: " + serverurl);
        System.out.println("User Name: " + doctorName);

        return "/main";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @PostMapping("/recordimpl")
    public String recordImpl(@ModelAttribute CounselDto counselDto, Model model) {
        System.out.println("받은 CounselDto: " + counselDto);

        try {
            // Counsel 데이터 저장
            counselService.add(counselDto);
            System.out.println("Counsel 데이터 삽입 성공: " + counselDto);

            // 성공 메시지 설정
            model.addAttribute("message", "상담 기록이 성공적으로 저장되었습니다.");
            return "forward:/counseling"; // 성공 시 메시지와 함께 원래 페이지로 이동
        } catch (Exception e) {
            // 에러 처리
            String errorMessage = "알 수 없는 오류가 발생했습니다.";

            // 외래 키 제약 조건 위반 에러 처리
            if (e.getCause() instanceof java.sql.SQLIntegrityConstraintViolationException) {
                if (e.getMessage().contains("FOREIGN KEY (`doctor_id`)")) {
                    errorMessage = "존재하지 않는 의사 ID입니다.";
                } else if (e.getMessage().contains("FOREIGN KEY (`user_id`)")) {
                    errorMessage = "존재하지 않는 환자 ID입니다.";
                }
            }

            System.err.println("Counsel 데이터 삽입 실패: " + errorMessage);
            model.addAttribute("error", errorMessage);

            // 에러 페이지 대신 원래 페이지로 리턴
            return "forward:/counseling";
        }
    }
}