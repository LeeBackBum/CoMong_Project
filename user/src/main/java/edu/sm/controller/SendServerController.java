package edu.sm.controller;


import edu.sm.app.dto.MedicalAppointmentDto;
import edu.sm.app.service.MedicalAppointmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequiredArgsConstructor
public class SendServerController {

    private final MedicalAppointmentService appointmentService;


    @PostMapping("/saveAppointment")
    public Map<String, String> saveAppointment(@RequestBody MedicalAppointmentDto medicalAppointmentDto) {
        Map<String, String> response = new HashMap<>();
        try {
            appointmentService.add(medicalAppointmentDto);
            response.put("message", "예약이 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            response.put("message", "예약 저장 중 오류가 발생했습니다: " + e.getMessage());
        }
        return response;
    }



    @PostMapping("/submitReservation")
    public Map<String, Object> submitReservation(@RequestBody MedicalAppointmentDto medicalAppointmentDto) {
        Map<String, Object> response = new HashMap<>();
        try {
            System.out.println("Received data: " + medicalAppointmentDto); // 디버깅용 로그
            appointmentService.add(medicalAppointmentDto);
            response.put("success", true);
            response.put("message", "예약이 성공적으로 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace(); // 서버 로그에 예외 출력
            response.put("success", false);
            response.put("message", "예약 저장 중 문제가 발생했습니다: " + e.getMessage());
        }
        return response;
    }




    @PostMapping("/submit")
    public String handleFormSubmission(@RequestParam("subjectName") String subjectName) {
        // subjectName을 처리하는 코드
        return "result";
    }



}

