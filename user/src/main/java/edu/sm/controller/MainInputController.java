package edu.sm.controller;

import edu.sm.app.dto.UserDto;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainInputController {

    private final UserService userService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @RequestMapping("/logoutimpl")
    public String logoutimpl(HttpSession session, Model model) {
        if(session != null){
            session.invalidate();
        }
        return "redirect:/";
    }

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

    @RequestMapping("/registerimpl")
    public String registerimpl(Model model,
                               UserDto userDto,
                               HttpSession session) throws DuplicateKeyException, Exception {
        log.info("User Info: "+userDto.toString());
        try{
            userDto.setUserPwd(passwordEncoder.encode(userDto.getUserPwd()));
            userService.add(userDto);
        } catch (DuplicateKeyException e){
            throw e;
        } catch (Exception e) {
            throw e;
        }
        session.setAttribute("loginid", userDto);
        model.addAttribute("registerSuccess", true);
        return "redirect:/";
    }
}
