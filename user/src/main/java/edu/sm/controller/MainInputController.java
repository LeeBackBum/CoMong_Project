package edu.sm.controller;

import edu.sm.app.dto.UserDto;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

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
        if (userDto == null) {
            // 사용자 정보가 없을 때
            model.addAttribute("center", "login");
            model.addAttribute("loginError", "Login Fail");
        } else {
            if (passwordEncoder.matches(pwd, userDto.getUserPwd())) {
                // 암호화된 비밀번호 비교 성공
                session.setAttribute("loginid", userDto);
                next = "redirect:/";
            } else {
                // 비밀번호가 틀렸을 때
                model.addAttribute("center", "login");
                model.addAttribute("loginError", "Login Fail");
            }
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

    @RequestMapping("/resetpwdimpl")
    public ResponseEntity<Map<String, Object>> resetpwdimpl(@RequestBody Map<String, String> request, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            String userId = request.get("userId");
            String newPassword = request.get("userPwd");

            if (userId == null || newPassword == null) {
                response.put("success", false);
                response.put("message", "유효하지 않은 요청 데이터입니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 사용자 정보 조회 및 비밀번호 업데이트 로직
            UserDto user = userService.get(userId);
            if (user == null) {
                response.put("success", false);
                response.put("message", "사용자를 찾을 수 없습니다.");
                return ResponseEntity.badRequest().body(response);
            }

            String encodedPassword = passwordEncoder.encode(newPassword);
            user.setUserPwd(encodedPassword);
            userService.updatePwd(user);

            session.setAttribute("loginid", user);
            response.put("success", true);
            response.put("message", "비밀번호가 성공적으로 재설정되었습니다.");
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "비밀번호 재설정 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }



}
