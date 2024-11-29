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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    private final DoctorService doctorService;

    @Value("${app.url.server-url}")
    String serverurl;

    @RequestMapping("/")
    public String index(Model model) {
        model.addAttribute("center", "center");
        log.info("Start Index ,,,,,,");
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

        return "/main";
    }

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
}
