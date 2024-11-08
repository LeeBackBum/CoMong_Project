package edu.sm.controller;

import edu.sm.app.dto.DoctorDto;
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
    String serverUrl;

    @RequestMapping("/")
    public String main(Model model){
//        model.addAttribute("charturl",serverUrl);
//        model.addAttribute("serverurl",serverUrl);

        return "index";
    }
//    @RequestMapping("/websocket")
//    public String websocket(Model model){
//        model.addAttribute("serverurl",serverUrl);
//        model.addAttribute("center","websocket");
//        return "index";
//    }
    @RequestMapping("/chat")
    public String chat(Model model){
        model.addAttribute("serverurl",serverUrl);
        model.addAttribute("center","chat");
        return "index";
    }
    @RequestMapping("/logout")
    public String logout(HttpSession httpSession){
        if(httpSession != null){
            httpSession.invalidate();
        }
        return "index";
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
        } catch (Exception e) {
            return "index";
        }

        return "redirect:/";
    }
}