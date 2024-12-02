package edu.sm.controller;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.DoctorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    @Value("${app.dir.imgmypage}")
    private String imgmypage;



    private final DoctorService doctorService;

    @Value("${app.url.server-url}")
    String serverurl;

    @RequestMapping("/")
    public String index(Model model) {
        model.addAttribute("center", "center");
        log.info("Start Index ,,,,,,");
        return "index";
    }

    @RequestMapping("/main")
    public String main(Model model) {
        log.info("Start Main ,,,,,,");
        return "main";
    }

    @RequestMapping("blank")
    public String blank(Model model) {
        model.addAttribute("center", "blank");
        return "main";
    }


    @RequestMapping("/loginimpl")
    public String loginimpl(
            @RequestParam("id") String id,
            @RequestParam("pwd") String pwd,
            HttpSession httpSession){
        DoctorDto doctorDto = null;

        try {
            doctorDto = doctorService.get(id);
            if(doctorDto == null){
                throw new Exception();
            }
            if(!doctorDto.getDoctorPwd().equals(pwd)){
                throw new Exception();
            }
            httpSession.setAttribute("doctor",doctorDto);
            httpSession.setAttribute("doctorid", doctorDto);
        } catch (Exception e) {
            return "/";
        }

        return  "redirect:/main";
    }

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

}