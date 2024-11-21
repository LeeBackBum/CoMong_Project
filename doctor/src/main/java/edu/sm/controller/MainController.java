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

    @RequestMapping("button")
    public String button(Model model) {
        model.addAttribute("center", "center");
        return "button";
    }

    @RequestMapping("/chart")
    public String chart(Model model) {
        model.addAttribute("center", "chart");
        return "main";
    }

    @RequestMapping("element")
    public String element(Model model) {
        model.addAttribute("center", "center");
        return "element";
    }

    @RequestMapping("errorpage")
    public String errorpage(Model model) {
        model.addAttribute("center", "center");
        return "errorpage";
    }

    @RequestMapping("form")
    public String form(Model model) {
        model.addAttribute("center", "center");
        return "form";
    }

    @RequestMapping("signin")
    public String signin(Model model) {
        model.addAttribute("center", "center");
        return "signin";
    }

    @RequestMapping("signup")
    public String signup(Model model) {
        model.addAttribute("center", "center");
        return "signup";
    }

    @RequestMapping("table")
    public String table(Model model) {
        model.addAttribute("center", "center");
        return "table";
    }

    @RequestMapping("typography")
    public String typography(Model model) {
        model.addAttribute("center", "center");
        return "typography";
    }

    @RequestMapping("widget")
    public String widget(Model model) {
        model.addAttribute("center", "center");
        return "widget";
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
            return "/";
        }

        return "/main";
    }
}
