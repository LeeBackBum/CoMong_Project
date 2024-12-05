package edu.sm;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class CallController {
    public static void main(String[] args) {
        try {
            // 서버 URL
            URL url = new URL("http://127.0.0.1");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // HTTP 메소드 설정 (GET 또는 POST)
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-Type", "application/json");

            // 응답 코드 확인
            int responseCode = conn.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            // 응답 데이터 읽기
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // 응답 출력
            System.out.println("Response: " + response.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}
