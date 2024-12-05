package edu.sm.controller;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.dto.MedicalAppointmentDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.repository.DoctorRepository;
import edu.sm.app.repository.MedicalAppointmentRepository;
import edu.sm.app.service.DoctorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@RestController
@Controller
@Slf4j
@RequiredArgsConstructor

public class ReservationController {


    private final DoctorService doctorService;
    private final DoctorRepository doctorRepository;






//    의사 정보 가져오는 컨트롤러

    @RequestMapping("/getDoctorList")
    public String loadTestdo2(@RequestParam("subjectName") String subjectName, Model model) throws Exception {
        // subjectName에 해당하는 데이터 가져오기
        List<DoctorDto> filteredDoctors = doctorService.getDoctorsBySubject(subjectName);

        // 데이터를 모델에 추가
        model.addAttribute("doctorlist", filteredDoctors);

        // JSP 파일 렌더링
        return "getDoctorList";
    }






    }

