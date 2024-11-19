package edu.sm.controller;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.repository.DoctorRepository;
import edu.sm.app.service.DoctorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@Controller
//@RestController
//@RequestMapping("/reservation2")
@Slf4j
@RequiredArgsConstructor

public class RestReservationController {

    private final DoctorService doctorService;
    private final DoctorRepository doctorRepository;


    @GetMapping("/reservation2/getlist")
    public ResponseEntity<List<DoctorDto>> getDoctorsBySubject(@RequestParam String subjectName) {
        try {
            List<DoctorDto> doctors = doctorService.getDoctorsBySubject(subjectName);
            if (doctors.isEmpty()) {
                return ResponseEntity.noContent().build();
            }
            return ResponseEntity.ok(doctors);
        } catch (Exception e) {
            // 예외 처리: 서버 오류
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

}
