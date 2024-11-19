package edu.sm.controller;

import edu.sm.app.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import edu.sm.app.service.UserService;

import java.security.Principal;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    String dir = "user/";
    final UserService userService;

    @RequestMapping("/mypage")
    public String mypage(Model model, HttpSession session) {
        UserDto loginUser = (UserDto) session.getAttribute("loginid");
        System.out.println("세션에서 가져온 사용자: " + loginUser);
        if (loginUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", loginUser);
        model.addAttribute("center", "mypage");
        return "index";
    }
}
