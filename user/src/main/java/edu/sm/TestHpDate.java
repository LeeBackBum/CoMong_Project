package edu.sm;


import edu.sm.utill.HpDate;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

import java.io.IOException;

public class TestHpDate {
    public static void main(String[] args) {
        try {
            String key = "ymM0cegTHI9EEDldHJd0Bk1pFJ7Is8b%2B9qmZ8zQMpMLLoZI9B2zPT0rwSX6dOvLI0736SD4F6yOn0vXUg9OKiw%3D%3D"; // 공공데이터포털 서비스 키
            Object response = HpDate.getHpAddress(key);

            // 응답 확인
            System.out.println("응답 데이터: " + response.toString());
        } catch (IOException | ParseException e) {
            // 예외 처리
            e.printStackTrace();
        }
    }
}