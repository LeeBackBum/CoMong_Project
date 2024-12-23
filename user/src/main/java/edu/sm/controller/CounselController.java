package edu.sm.controller;

import edu.sm.app.dto.CounselDto;
import edu.sm.app.dto.MedicalAppointmentDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.CounselService;
import edu.sm.app.service.MedicalAppointmentService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
@Controller
@Slf4j
@RequiredArgsConstructor
public class CounselController {

    private final CounselService counselService;


    @RequestMapping("/getCounselList")
    public ResponseEntity<List<CounselDto>> dateAppointments(HttpSession session) throws Exception {
        // 세션에서 userDto 가져오기
        UserDto userDto = (UserDto) session.getAttribute("loginid");

        // doctorDto가 없는 경우 401 Unauthorized 반환
        if (userDto == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        // userId 가져오기
        String userId = userDto.getUserId();

        // 날짜와 의사 ID를 기반으로 예약 및 상담 데이터 조회
        List<CounselDto> counsels = counselService.findById(userId);
        System.out.println(counsels);
        // 결과 반환 (JSON 형식)
        return ResponseEntity.ok(counsels);
    }



}