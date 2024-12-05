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

    private static final String POWER_LOG_FILE_PATH = "c:/CoMong_Project/logs/power.log";
    private static final String BLOOD_PRESSURE_LOG_FILE_PATH = "c:/CoMong_Project/logs/blood_pressure.log";
    private static final String BLOOD_SUGAR_LOG_FILE_PATH = "c:/CoMong_Project/logs/blood_sugar.log";
    private static final String DEPRESSION_SCORE_LOG_FILE_PATH = "c:/CoMong_Project/logs/depression_score.log";

    private final List<Double> powerDataList = new ArrayList<>();
    private final List<Double> bloodPressureDataList = new ArrayList<>();
    private final List<Double> bloodSugarDataList = new ArrayList<>();
    private final List<Double> depressionScoreDataList = new ArrayList<>();

    @PostConstruct
    public void loadDataFromLogFiles() {
        loadDataFromFile(POWER_LOG_FILE_PATH, powerDataList);
        loadDataFromFile(BLOOD_PRESSURE_LOG_FILE_PATH, bloodPressureDataList);
        loadDataFromFile(BLOOD_SUGAR_LOG_FILE_PATH, bloodSugarDataList);
        loadDataFromFile(DEPRESSION_SCORE_LOG_FILE_PATH, depressionScoreDataList);
    }

    private void loadDataFromFile(String filePath, List<Double> dataList) {
        dataList.clear();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(", ");
                if (parts.length == 2) {
                    try {
                        double value = Double.parseDouble(parts[1].trim());
                        dataList.add(value);
                    } catch (NumberFormatException e) {
                        // 잘못된 데이터 무시
                    }
                }
            }
        } catch (IOException e) {
            log.error("{} 읽기 실패: {}", filePath, e.getMessage());
        }
    }

    @RequestMapping("/power")
    public Object power(@RequestBody String data) {
        return processData(data, POWER_LOG_FILE_PATH, powerDataList);
    }

    @RequestMapping("/bloodPressure")
    public Object bloodPressure(@RequestBody String data) {
        return processData(data, BLOOD_PRESSURE_LOG_FILE_PATH, bloodPressureDataList);
    }

    @RequestMapping("/bloodSugar")
    public Object bloodSugar(@RequestBody String data) {
        return processData(data, BLOOD_SUGAR_LOG_FILE_PATH, bloodSugarDataList);
    }

    @RequestMapping("/depressionScore")
    public Object depressionScore(@RequestBody String data) {
        return processData(data, DEPRESSION_SCORE_LOG_FILE_PATH, depressionScoreDataList);
    }

    private Object processData(String data, String logFilePath, List<Double> dataList) {
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
                dataList.add(value);
                appendToLogFile(data, logFilePath);
            } catch (NumberFormatException e) {
                return "Invalid number format";
            }
        }
        return "Success";
    }

    private void appendToLogFile(String data, String filePath) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true))) {
            bw.write(data);
            bw.newLine();
        } catch (IOException e) {
            log.error("{}에 데이터를 기록하는 중 오류 발생: {}", filePath, e.getMessage());
        }
    }

    @GetMapping("/power/data")
    public JSONArray getPowerData() {
        return getDataFromLog(POWER_LOG_FILE_PATH);
    }

    @GetMapping("/bloodPressure/data")
    public JSONArray getBloodPressureData() {
        return getDataFromLog(BLOOD_PRESSURE_LOG_FILE_PATH);
    }

    @GetMapping("/bloodSugar/data")
    public JSONArray getBloodSugarData() {
        return getDataFromLog(BLOOD_SUGAR_LOG_FILE_PATH);
    }

    @GetMapping("/depressionScore/data")
    public JSONArray getDepressionScoreData() {
        return getDataFromLog(DEPRESSION_SCORE_LOG_FILE_PATH);
    }

    private JSONArray getDataFromLog(String filePath) {
        JSONArray jsonArray = new JSONArray();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
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
            log.error("{} 읽기 실패: {}", filePath, e.getMessage());
        }

        return jsonArray;
    }
}