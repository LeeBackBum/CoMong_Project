package edu.sm.controller;

import edu.sm.app.dto.UserDto;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import edu.sm.util.HpDate;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.List;

@Controller
@Slf4j
public class MainController {

    @Value("${app.key.apikey}")
    String apikey;

    private final UserService userService;

    @Value("${app.url.server_url}")
    String serverurl;

    public MainController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/webrtc")
    public String webrtc(Model model){
        model.addAttribute("serverurl", serverurl);
        model.addAttribute("roomId", "1");
        model.addAttribute("center", "webrtc");

        return "index";
    }

    @RequestMapping("/")
    public String main(Model model) {
        log.info("Start Main ,,,,,,");
        return "index";
    }

//    @PostMapping("/login")
//    public String login(String username, String password, HttpSession session, Model model) {
//        try {
//            log.info("로그인 시도: username={}", username);
//            UserDto user = userService.authenticate(username, password);
//            if (user != null) {
//                // 세션에 UserDto 저장
//                session.setAttribute("user", user);
//                log.info("로그인 성공: userId={}, userName={}", user.getUserId(), user.getUserName());
//                return "redirect:/board"; // 로그인 성공 시 게시판 메인으로 이동
//            } else {
//                model.addAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
//                log.warn("로그인 실패: 아이디 또는 비밀번호 오류");
//                return "login";
//            }
//        } catch (Exception e) {
//            log.error("로그인 처리 중 오류 발생", e);
//            model.addAttribute("errorMessage", "로그인 처리 중 오류가 발생했습니다.");
//            return "login";
//        }
//    }

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

    @RequestMapping("/Test")
    public String test(Model model) {
        model.addAttribute("center", "Test");
        return "index";
    }



    @RequestMapping("/reservation")
    public String reservations(HttpSession session, Model model) throws Exception {
        UserDto userDto = (UserDto) session.getAttribute("loginid");

        if (userDto == null) {
            System.out.println("세션에 로그인된 사용자 정보 없음");
            model.addAttribute("message", "Please log in first.");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }

        String userId = userDto.getUserId();
        System.out.println("로그인된 사용자 ID: " + userId);


        model.addAttribute("userId",userId);

        model.addAttribute("center","reservation");


        return "index";
    }

    @RequestMapping("/map")
    public String map(HttpSession session, Model model) throws Exception {
        UserDto userDto = (UserDto) session.getAttribute("loginid");

        if (userDto == null) {
            System.out.println("세션에 로그인된 사용자 정보 없음");
            model.addAttribute("message", "Please log in first.");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }

        String userAddress = userDto.getUserAddress();
        System.out.println("로그인된 사용자 Address: " + userAddress);


        model.addAttribute("userAddress",userAddress);

        model.addAttribute("center","map");


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

    @RequestMapping("/forgot")
    public String forgot(Model model) {
        model.addAttribute("center", "forgot");
        return "index";
    }

    @RequestMapping("/renew")
    public String renew(Model model) {
        model.addAttribute("center", "renew");
        return "index";
    }

    @RequestMapping("/counseling")
    public String counseling(HttpSession session, Model model) {
        // 세션에서 로그인된 사용자 정보 가져오기
        Object loginid = session.getAttribute("loginid");

        // 세션에 로그인 정보가 없는 경우 로그인 페이지로 리다이렉트
        if (loginid == null) {
            return "redirect:/login"; // 로그인 페이지로 이동
        }

        // UserDto 객체에서 userName 가져오기 (loginid가 UserDto라고 가정)
        String userName = ((UserDto) loginid).getUserName();

        // JSP에 데이터 전달
        model.addAttribute("serverurl", serverurl);
        model.addAttribute("userName", userName);
        model.addAttribute("center", "Counseling/counseling");

        System.out.println("Server URL: " + serverurl);
        System.out.println("User Name: " + userName);

        return "index";
    }

    @RequestMapping("/hpdataload")
    @ResponseBody
    public Object hpdataload(Model model) throws IOException, ParseException {

        return HpDate.getHpAddress(apikey);
    }

    @RequestMapping("/updateimpl")
    public String updateimpl(HttpSession session,  UserDto userDto
    ) throws Exception {
        UserDto loggedInUser = (UserDto) session.getAttribute("loginid");

        if (loggedInUser == null) {
            // 로그인되지 않은 사용자 처리
            return "redirect:/login";
        }

        // 세션에서 가져온 사용자 ID를 업데이트할 UserDto에 설정
        userDto.setUserId(loggedInUser.getUserId());

        System.out.println("Received UserDto: " + userDto);

        userService.modify(userDto);
        return "redirect:/mypage";
    }

    @RequestMapping("/chatbot")
    public String chatbot(Model model) {
        model.addAttribute("center", "chatbot");
        return "index";
    }

    @RequestMapping("/chart")
    public String chart(Model model) {
        model.addAttribute("center", "chart");
        return "index";
    }

    @RequestMapping("/payment")
    public String payment(Model model) {
        model.addAttribute("center", "payment");
        return "index";
    }
}