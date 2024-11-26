package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.annotation.PostConstruct;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@Slf4j
@RequestMapping("/iot")
public class IOTRestController {

    private static final String LOG_FILE_PATH = "c:/CoMong_Project/logs/power.log";

    private List<Double> powerDataList = new ArrayList<>();

    @PostConstruct
    public void loadPowerDataFromLogFile() {
        powerDataList.clear(); // 기존 데이터를 초기화

        try (BufferedReader br = new BufferedReader(new FileReader(LOG_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(", ");
                if (parts.length == 2) {
                    try {
                        double value = Double.parseDouble(parts[1].trim());
                        powerDataList.add(value);
                    } catch (NumberFormatException e) {
                        // 잘못된 데이터 무시
                    }
                }
            }
            log.info("로그 파일에서 {}개의 데이터를 로드했습니다.", powerDataList.size());
        } catch (IOException e) {
            log.error("로그 파일 읽기 실패: {}", e.getMessage());
        }
    }

    @RequestMapping("/power")
    public Object power(@RequestBody String data) {
        String[] parts = data.split(", ");
        if (parts.length == 1) { // 숫자 값만 전송된 경우
            // 현재 시간을 yyyy-MM-dd HH:mm:ss 형식으로 추가
            String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            data = timestamp + ", " + parts[0];
            parts = data.split(", ");
        }

        if (parts.length > 1) {
            try {
                double value = Double.parseDouble(parts[1].trim());
                powerDataList.add(value);
                appendToLogFile(data);
            } catch (NumberFormatException e) {
                return "Invalid number format";
            }
        }
        return "Success";
    }

    private void appendToLogFile(String data) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(LOG_FILE_PATH, true))) {
            bw.write(data);
            bw.newLine();
        } catch (IOException e) {
            log.error("로그 파일에 데이터를 기록하는 중 오류 발생: {}", e.getMessage());
        }
    }

    @SuppressWarnings("unchecked")
    @GetMapping("/power/data")
    public JSONArray getPowerData() {
        JSONArray jsonArray = new JSONArray();

        try (BufferedReader br = new BufferedReader(new FileReader(LOG_FILE_PATH))) {
            LinkedList<String> lines = new LinkedList<>();
            String line;

            while ((line = br.readLine()) != null) {
                lines.add(line);
                if (lines.size() > 20) { // 최신 20개만 유지
                    lines.removeFirst();
                }
            }

            for (String logLine : lines) {
                String[] parts = logLine.split(", ");
                if (parts.length == 2) {
                    try {
                        String timestamp = parts[0].trim();
                        double value = Double.parseDouble(parts[1].trim());
                        JSONObject jsonObject = new JSONObject();
                        jsonObject.put("timestamp", timestamp);
                        jsonObject.put("value", value);
                        jsonArray.add(jsonObject);
                    } catch (NumberFormatException e) {
                        // 잘못된 데이터 무시
                    }
                }
            }
        } catch (IOException e) {
            log.error("로그 파일 읽기 실패: {}", e.getMessage());
        }

        return jsonArray;
    }
}