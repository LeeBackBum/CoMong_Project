package edu.sm.controller;

import edu.sm.app.dto.UserDto;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainInputController {

    private final UserService userService;

    @RequestMapping("/loginimpl")
    public String loginimpl(Model model,
                            @RequestParam("id") String id,
                            @RequestParam("pwd") String pwd,
                            HttpSession session) throws Exception {
        String next = "login";
        UserDto userDto = userService.get(id);
        if(userDto == null || !userDto.getUserPwd().equals(pwd)) {
            //Fail
            model.addAttribute("center", "login");
            model.addAttribute("loginError", "ID나 Password가 틀림");
        } else{
            // Success
            session.setAttribute("loginid", userDto);
            next = "redirect:/";
        }
        return next;
    }
}
