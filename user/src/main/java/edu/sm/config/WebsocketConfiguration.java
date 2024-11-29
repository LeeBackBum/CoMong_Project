//package edu.sm.config;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.messaging.simp.config.MessageBrokerRegistry;
//import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
//import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
//import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
//
//@Configuration
//@EnableWebSocketMessageBroker
//public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
//
//    @Override
//    public void configureMessageBroker(MessageBrokerRegistry config) {
//        // 클라이언트가 구독할 수 있는 경로 설정
//        config.enableSimpleBroker("/topic");
//        // 클라이언트가 메시지를 보낼 때 사용할 경로 설정
//        config.setApplicationDestinationPrefixes("/app");
//    }
//
//    @Override
//    public void registerStompEndpoints(StompEndpointRegistry registry) {
//        // 클라이언트가 WebSocket 서버에 연결할 엔드포인트 설정
//        registry.addEndpoint("/ws").setAllowedOrigins("*").withSockJS();
//    }
//}