package edu.sm.controller;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.repository.DoctorRepository;
import edu.sm.app.service.DoctorService;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ReservationController {


    private final DoctorService doctorService;
    private final DoctorRepository doctorRepository;

    @GetMapping("/doctorInfo")
    public String showDoctorInfo(Model model) {
//        DoctorDto doctor = doctorService
        model.addAttribute("doctor"); // 템플릿으로 doctor 변수 전달
        return "doctorInfo";
    }
//    @RequestMapping("/getDoctorList")
////    @GetMapping("/getDoctorList")
//        public String getDoctorList(Model model) throws Exception {
//        List<DoctorDto> doctorList = new ArrayList<>();
//
//            doctorList = doctorService.get();
//            return doctorList.toString();  // JSON 배열로 반환
//        }


    @GetMapping("/getDoctorList")
    public List<DoctorDto> getDoctorList() throws Exception {
        // DB나 서비스에서 의사 리스트를 가져와 반환
        List<DoctorDto> doctorList = doctorService.get();
        return doctorList;  // JSON 배열로 반환
    }


    }

