package edu.sm.util;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class HttpSendData {
//    public static void send(String url, String data){
//        HttpClient client = HttpClient.newHttpClient();
//        HttpRequest request = HttpRequest.newBuilder()
//                .uri(URI.create(url))
//                .header("Content-Type", "application/json")
//                .POST(HttpRequest.BodyPublishers.ofString(data))
//                .build();
//        try {
//            client.send(request, HttpResponse.BodyHandlers.ofString());
//        }catch(Exception e){
//            System.out.println("Server Error");
//        }
//    }

    public static void send(String url, String data) {
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(data))
                .build();
        try {
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                System.out.println("Error: Received HTTP status " + response.statusCode());
            } else {
                System.out.println("Success: " + response.body());
            }
        } catch (Exception e) {
            System.err.println("Exception occurred while sending request: " + e.getMessage());
            e.printStackTrace();
        }
    }






}