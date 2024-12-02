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
}
