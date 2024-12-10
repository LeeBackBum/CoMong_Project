package edu.sm.controller;

import edu.sm.app.dto.Msg;
import edu.sm.util.ChatBotUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class ChatbotController {

    private final SimpMessagingTemplate template;

    @Value("${app.url.chatbot}")
    private String url;

    @Value("${app.key.chatbot}")
    private String key;

    @MessageMapping("/sendchatbot")
    public void sendchat(Msg msg) throws Exception {
        String id = msg.getSendid();
        String userMessage = msg.getContent1();

        log.info("Incoming WebSocket Message: {}", msg);

        // ChatBotUtil 호출
        Map<String, String> responseMap = ChatBotUtil.getMsg(url, key, userMessage);
        log.info("ChatBotUtil Response Map: {}", responseMap);

        // 응답 데이터 추출
        String botResponse = responseMap.getOrDefault("description", "응답이 없습니다.");
        String buttonTitle = responseMap.get("buttonTitle");
        String buttonUrl = responseMap.get("buttonUrl");

        if (botResponse == null || botResponse.isEmpty()) {
            botResponse = "죄송하지만 잘 이해하지 못했어요.";
            buttonTitle = null;
            buttonUrl = null;
        }

        // 결과 설정
        msg.setBotResponse(botResponse);
        msg.setButtonTitle(buttonTitle);
        msg.setButtonUrl(buttonUrl);

        log.info("Sending WebSocket Message to /sendto/{}: {}", id, msg);

        // 클라이언트로 메시지 전송
        template.convertAndSend("/sendto/" + id, msg);
    }
}
