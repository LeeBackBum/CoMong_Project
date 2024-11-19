package edu.sm.controller;

import edu.sm.app.dto.UserDto;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
public class MainController {

    private final UserService userService;

    public MainController(UserService userService) {
        this.userService = userService;
    }

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
    public String mypage(HttpSession session, Model model) throws Exception {
        // 세션에서 UserDto 가져오기
        UserDto userDto = (UserDto) session.getAttribute("loginid");

        // 세션에 로그인 정보가 없는 경우 처리
        if (userDto == null) {
            System.out.println("세션에 로그인된 사용자 정보 없음");
            model.addAttribute("message", "Please log in first.");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }

        // UserDto에서 userId 추출
        String userId = userDto.getUserId();
        System.out.println("로그인된 사용자 ID: " + userId);

        // userId로 사용자 정보 조회
        List<UserDto> users = userService.findById(userId);

        // 사용자 정보 모델에 추가
        if (users.isEmpty()) {
            model.addAttribute("message", "No user data found for ID: " + userId);
            System.out.println("사용자 정보 없음");
        } else {
            model.addAttribute("user", users.get(0));
        }

        model.addAttribute("center", "mypage");
        return "index";
    }


}