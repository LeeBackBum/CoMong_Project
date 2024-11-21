package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@Slf4j
@RequestMapping("/iot")
public class IOTRestController {
    // 숫자 데이터만 저장하는 리스트
    private List<Double> powerDataList = new ArrayList<>();
    @RequestMapping("/power")
    public Object power(@RequestBody String data) {

        log.info(data);
        // 데이터에서 숫자만 추출
        String[] parts = data.split(", ");
        if (parts.length > 1) {
            try {
                double value = Double.parseDouble(parts[1]);
                powerDataList.add(value);  // 숫자 값을 리스트에 추가
                log.info("Saved value: " + value);
            } catch (NumberFormatException e) {
                log.error("Failed to parse number from data: " + data, e);
            }
        }
        return 1;
    }
    // 클라이언트가 차트 데이터를 요청할 때 호출될 엔드포인트
    @GetMapping("/power/data")
    public JSONArray getPowerData() {
        JSONArray jsonArray = new JSONArray();
        jsonArray.addAll(powerDataList);  // 저장된 숫자 데이터를 JSON 배열로 반환
        return jsonArray;
    }
}
