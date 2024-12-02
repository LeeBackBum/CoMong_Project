//package edu.sm.controller;
//
//import org.springframework.messaging.handler.annotation.MessageMapping;
//import org.springframework.messaging.handler.annotation.Payload;
//import org.springframework.messaging.handler.annotation.SendTo;
//import org.springframework.stereotype.Controller;
//
//@Controller
//public class ChatController {
//
//    // 클라이언트에서 /app/chat.sendMessage 경로로 전송된 메시지를 처리
//    @MessageMapping("/chat.sendMessage")
//    @SendTo("/topic/public")
//    public ChatMessage sendMessage(@Payload ChatMessage chatMessage) {
//        System.out.println("Received message: " + chatMessage);
//        return chatMessage; // 브로드캐스트
//    }
//
//    // 클라이언트에서 /app/chat.addUser 경로로 전송된 메시지를 처리
//    @MessageMapping("/chat.addUser")
//    @SendTo("/topic/public")
//    public ChatMessage addUser(@Payload ChatMessage chatMessage) {
//        chatMessage.setContent(chatMessage.getSender() + " joined the chat!");
//        return chatMessage; // 브로드캐스트
//    }