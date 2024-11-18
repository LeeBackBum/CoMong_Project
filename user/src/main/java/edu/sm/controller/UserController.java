package edu.sm.controller;

import edu.sm.app.dto.UserDto;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequestMapping("/user")
public class UserController {

    @RequestMapping("mypage")
    public String myPage(Model model, HttpSession session) {
        UserDto userDto = (UserDto) session.getAttribute("loginid"); // 세션에서 로그인된 사용자 정보 가져오기
        if (userDto != null) {
            model.addAttribute("user", userDto);
        } else {
            // 로그인하지 않은 경우, 로그인 페이지로 리다이렉트 또는 예외 처리
            return "redirect:/login";
        }
        return "index";
    }
}
