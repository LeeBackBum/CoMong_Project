package edu.sm.ncp;


import edu.sm.util.ChatBotUtil;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class ChatbotTests {

    @Value("${app.url.chatbot}")
    String url;
    @Value("${app.key.chatbot}")
    String key;

    @Test
    void contextLoads() throws Exception {
        log.info("Start: " + url);
        log.info("API Key: " + key); // 디버깅용
        String sendMsg = "병원";
        String result = ChatBotUtil.getMsg(url, key, sendMsg);
        log.info(result);
    }
}