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

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    String dir = "user/";
    final UserService userService;

    @RequestMapping("mypage")
    public String mypage(Model model, @RequestParam("id") String id) throws Exception {
        UserDto userDto = null;
        userDto = userService.get(id);
        model.addAttribute("user", userDto);
        model.addAttribute("center", dir + "mypage");
        return "index";
    }
}
