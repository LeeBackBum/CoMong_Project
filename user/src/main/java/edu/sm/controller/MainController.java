package edu.sm.controller;

import edu.sm.app.dto.BoardDto;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.service.BoardService;
import edu.sm.app.service.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
public class MainController {

    @RequestMapping("/")
    public String main(Model model) {
        model.addAttribute("center", "center");
        log.info("Start Main ,,,,,,");
        return "index";
    }

    @RequestMapping("/login")
    public String login(Model model) {
        model.addAttribute("center", "center");
        return "login";
    }

    @RequestMapping("/contact")
    public String contact(Model model) {
        model.addAttribute("center", "contact");
        return "contact";
    }


    @RequestMapping("/courses")
    public String courses(Model model) {
        model.addAttribute("center", "courses");
        return "courses";
    }

    @RequestMapping("/team")
    public String team(Model model) {
        model.addAttribute("center", "team");
        return "team";
    }

    @RequestMapping("/errorpage")
    public String errorpage(Model model) {
        model.addAttribute("center", "errorpage");
        return "errorpage";
    }

    @RequestMapping("/testimonial")
    public String testimonial(Model model) {
        model.addAttribute("center", "testimonial");
        return "testimonial";
    }
}
