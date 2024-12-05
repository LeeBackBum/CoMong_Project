package edu.sm.controller;

import edu.sm.app.dto.MedicalAppointmentDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.MedicalAppointmentService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MedicalAppointmentController {

    private final MedicalAppointmentService medicalAppointmentService;


    @RequestMapping("/getAppointmentList")
    public ResponseEntity<List<MedicalAppointmentDto>> dateAppointments(HttpSession session) throws Exception {
        // 세션에서 userDto 가져오기
        UserDto userDto = (UserDto) session.getAttribute("loginid");

        // doctorDto가 없는 경우 401 Unauthorized 반환
        if (userDto == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        // userId 가져오기
        String userId = userDto.getUserId();

        // 날짜와 의사 ID를 기반으로 예약 및 상담 데이터 조회
        List<MedicalAppointmentDto> appointments = medicalAppointmentService.findById(userId);
        System.out.println(appointments);
        // 결과 반환 (JSON 형식)
        return ResponseEntity.ok(appointments);
    }



//    @RequestMapping("/getAppointmentList")
//    @ResponseBody
//    public ResponseEntity<List<MedicalAppointmentDto>> getAppointmentList(HttpSession session) {
//        UserDto userDto = (UserDto) session.getAttribute("loginid");
//
//        if (userDto == null) {
//            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
//        }
//
//        String userId = userDto.getUserId();
//
//        // 단일 객체 반환을 리스트로 변환
//        List<MedicalAppointmentDto> appointmentList = new ArrayList<>();
//
//        try {
//            // medicalAppointmentService.get(userId)는 단일 객체 반환
//            MedicalAppointmentDto appointment = medicalAppointmentService.get(userId);
//
//            if (appointment != null) {
//                appointmentList.add(appointment); // 리스트에 단일 객체를 추가
//            }
//        } catch (Exception e) {
//            // 예외 처리: 로그 기록 및 클라이언트에 오류 응답 반환
//            e.printStackTrace();
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
//        }
//
//        return ResponseEntity.ok(appointmentList); // List<MedicalAppointmentDto>를 반환
//    }



}
