package edu.sm.app.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

@Service
@RequiredArgsConstructor
public class MailService {

    private final JavaMailSender javaMailSender;
    private static final String senderEmail= "mj981215@sunmoon.ac.kr";
    private static int number;

    // 랜덤으로 숫자 생성
    public static void createNumber() {
        number = (int)(Math.random() * (90000)) + 100000; //(int) Math.random() * (최댓값-최소값+1) + 최소값
    }

    public MimeMessage CreateMail(String mail) {
        createNumber();
        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            message.setFrom(senderEmail);

            // 수신자 이메일이 올바르게 전달되었는지 확인
            if (mail == null || mail.trim().isEmpty()) {
                throw new MessagingException("Recipient email address is missing");
            }

            message.setRecipients(MimeMessage.RecipientType.TO, mail);
            message.setSubject("이메일 인증");
            String body = "<h3>요청하신 인증 번호입니다.</h3><h1>" + number + "</h1><h3>감사합니다.</h3>";
            message.setText(body, "UTF-8", "html");
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        return message;
    }

    public int sendMail(String mail) {
        try {
            MimeMessage message = CreateMail(mail);
            javaMailSender.send(message);
        } catch (Exception e) {
            System.out.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            return -1; // 에러 발생 시 -1 반환
        }
        System.out.println("Sending email to: " + mail);
        return number;
    }
}