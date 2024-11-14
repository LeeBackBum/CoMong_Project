package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class MainController {

    @RequestMapping("/")
    public String main(Model model) {
        log.info("Start Main ,,,,,,");
        return "index";
    }

    @RequestMapping("/login")
    public String login(Model model) {
        model.addAttribute("center", "login");
        return "index";
    }
    @RequestMapping("/register")
    public String register(Model model) {
        model.addAttribute("center", "register");
        return "index";
    }

    @RequestMapping("/contact")
    public String contact(Model model) {
        model.addAttribute("center", "contact");
        return "index";
    }

    @RequestMapping("/about")
    public String about(Model model) {
        model.addAttribute("center", "about");
        return "index";
    }

    @RequestMapping("/courses")
    public String courses(Model model) {
        model.addAttribute("center", "courses");
        return "index";
    }

    @RequestMapping("/team")
    public String team(Model model) {
        model.addAttribute("center", "team");
        return "index";
    }

    @RequestMapping("/errorpage")
    public String errorpage(Model model) {
        model.addAttribute("center", "errorpage");
        return "index";
    }

    @RequestMapping("/testimonial")
    public String testimonial(Model model) {
        model.addAttribute("center", "testimonial");
        return "index";
    }

    @RequestMapping("/mypage")
    public String mypage(Model model) {
        model.addAttribute("center", "mypage");
        return "index";
    }

    @RequestMapping("/forgot")
    public String forgot(Model model) {
        model.addAttribute("center", "forgot");
        return "index";
    }
}