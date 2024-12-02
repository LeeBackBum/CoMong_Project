package edu.sm.controller;

import edu.sm.app.service.MailService;
import edu.sm.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.HashMap;
import java.util.Map;

@RestController
public class MailController {

    private static final Logger logger = LoggerFactory.getLogger(MailController.class);

    @Autowired
    private final MailService mailService;
    private int storedCode; // 인증 코드 저장

    private UserService userService;

    public MailController(MailService mailService) {
        this.mailService = mailService;
    }

    // 인증 이메일 전송
    @PostMapping("/mailSend")
    public HashMap<String, Object> mailSend(@RequestBody Map<String, String> request) {
        HashMap<String, Object> map = new HashMap<>();
        String mail = request.get("mail");

        if (mail == null || mail.isEmpty()) {
            map.put("success", Boolean.FALSE);
            map.put("error", "Email is required");
            return map;
        }

        try {
            storedCode = mailService.sendMail(mail); // 인증 코드 생성 후 저장
            logger.info("Generated code: {}", storedCode);
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
            map.put("error", e.getMessage());
            logger.error("Mail sending failed: ", e);
        }

        return map;
    }


    // 인증 코드 전송 메서드
    private HashMap<String, Object> sendVerificationCode(String mail, HashMap<String, Object> map) {
        try {
            storedCode = mailService.sendMail(mail);
            logger.info("Generated verification code for {}: {}", mail, storedCode);
            map.put("success", Boolean.TRUE);
        } catch (Exception e) {
            map.put("success", Boolean.FALSE);
            map.put("error", "Failed to send verification code");
            logger.error("Error sending verification code to {}: ", mail, e);
        }
        return map;
    }



    // 인증번호 일치 여부 확인
    @PostMapping("/mailCheck")
    public ResponseEntity<Boolean> mailCheck(@RequestBody Map<String, String> request) {
        String userNumber = request.get("userNumber");
        logger.info("Received user-provided code: '{}'", userNumber);

        boolean isMatch = userNumber.equals(String.valueOf(storedCode));
        if (isMatch) {
            logger.info("Codes match.");
        } else {
            logger.warn("Codes do not match.");
        }
        return ResponseEntity.ok(isMatch);
    }


}
