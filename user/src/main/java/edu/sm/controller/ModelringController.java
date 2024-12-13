package edu.sm.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ModelringController {


    @GetMapping("/3DTest")
    public String index( Model model) {
        model.addAttribute("center","3DTest");
        return "index";  // src/main/resources/static/index.html을 반환
    }

    @GetMapping("/api/3ddata")
    public String get3DData() {
        // 예시 데이터 (API에서 제공할 수 있는 실제 데이터)
        return "{\"x\": 5, \"y\": 8, \"z\": 9}";
    }



}
