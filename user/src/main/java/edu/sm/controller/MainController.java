package edu.sm.controller;

import edu.sm.app.dto.UserDto;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@Controller
@Slf4j
public class MainController {
    private final UserService userService;
    @RequestMapping("/")
    public String main(Model model) {
        log.info("Start Main ,,,,,,");
        return "index";
    }

    //login 수정
    // 로그인 페이지 요청(GET)
    @GetMapping("/login")
    public String loginForm() {
        log.info("로그인 페이지 로드");
        return "login"; // 로그인 페이지로 이동
    }

    // 로그인 처리 요청(POST)
    @PostMapping("/login")
    public String login(String username, String password, HttpSession session, Model model) {
        try {
            log.info("로그인 시도: username={}", username);
            UserDto user = userService.authenticate(username, password);
            if (user != null) {
                // 세션에 UserDto 저장
                session.setAttribute("user", user);
                log.info("로그인 성공: userId={}, userName={}", user.getUserId(), user.getUserName());
                return "redirect:/board"; // 로그인 성공 시 게시판 메인으로 이동
            } else {
                model.addAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
                log.warn("로그인 실패: 아이디 또는 비밀번호 오류");
                return "login";
            }
        } catch (Exception e) {
            log.error("로그인 처리 중 오류 발생", e);
            model.addAttribute("errorMessage", "로그인 처리 중 오류가 발생했습니다.");
            return "login";
        }
    }

    @RequestMapping("/register")
    public String register(Model model) {
        model.addAttribute("center", "register");
        return "index";
    }

    // board  --> boardController로 이동

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