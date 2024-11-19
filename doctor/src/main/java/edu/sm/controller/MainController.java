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
        model.addAttribute("center", "center");
        log.info("Start Main ,,,,,,");
        return "index";
    }

    @RequestMapping("blank")
    public String blank(Model model) {
        model.addAttribute("center", "center");
        return "blank";
    }

    @RequestMapping("button")
    public String button(Model model) {
        model.addAttribute("center", "center");
        return "button";
    }

    @RequestMapping("chart")
    public String chart(Model model) {
        model.addAttribute("center", "center");
        return "chart";
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
        model.addAttribute("center", "widget");
        return "index";
    }
}
