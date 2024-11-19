package edu.sm.controller;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.dto.MedicalAppointmentDto;
import edu.sm.app.repository.DoctorRepository;
import edu.sm.app.repository.MedicalAppointmentRepository;
import edu.sm.app.service.DoctorService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

//@RestController
@Controller
@Slf4j
@RequiredArgsConstructor

public class ReservationController {


    private final DoctorService doctorService;
    private final DoctorRepository doctorRepository;
    MedicalAppointmentRepository AppointmentRepository;

    @GetMapping("/doctorInfo")
    public String showDoctorInfo(Model model) {
//        DoctorDto doctor = doctorService
        model.addAttribute("doctor"); // 템플릿으로 doctor 변수 전달
        return "doctorInfo";
    }
//    @RequestMapping("/getDoctorList")
//        @GetMapping("/getDoctorList")
//        public String getDoctorList(Model model) throws Exception {
//        List<DoctorDto> doctorList = new ArrayList<>();
//
//            doctorList = doctorService.get();
//            return "reservation2";  // JSON 배열로 반환
//        }


//    @GetMapping("/getDoctorList")
//    public List<DoctorDto> getDoctorList() throws Exception {
//        // DB나 서비스에서 의사 리스트를 가져와 반환
//        List<DoctorDto> doctorList = new ArrayList<>();
//            doctorList = doctorService.get();
//        return doctorList;  // JSON 배열로 반환
//    }
//    @RequestMapping("/getDoctorList")
////    @GetMapping("/getDoctorList")
//    public List<DoctorDto> getDoctorList() throws Exception {
//        // DB에서 의사 리스트 가져오기
//        DoctorDto doctorDto = null;
//        return doctorService.get();
//
//    }

//
//    @RequestMapping("/getDoctorList")
//    public List<DoctorDto> getDoctorList() throws Exception {
//        // DoctorService를 통해 DB에서 DoctorDto 데이터를 가져옵니다
//        List<DoctorDto> doctorList = doctorService.getDoctorList();
//        return doctorList;  // 클라이언트로 JSON 형식으로 반환
//    }


//    @GetMapping("/testdo")
//    public String get( Model model) throws Exception {
//        List<DoctorDto> list = new ArrayList<>();
//        list = doctorService.get();
//        model.addAttribute("doctorlist",list);
//        return "reservation2";
//    }

    @RequestMapping("/testdo")
    public String loadTestdo(Model model) throws Exception {
        // 필요한 데이터를 JSP에 전달
        List<DoctorDto> list = doctorService.get();
        model.addAttribute("doctorlist", list);
        // testdo.jsp를 렌더링
        return "testdo";
    }

//    @RequestMapping("/testdo2")
//    public String loadTestdo2(Model model) throws Exception {
//        // 필요한 데이터를 JSP에 전달
//        List<DoctorDto> list = doctorService.get();
//        model.addAttribute("doctorlist", list);
//        // testdo.jsp를 렌더링
//        return "testdo2";
//    }

//
//    @RequestMapping("/testdo2")
//    public String loadTestdo2(Model model) throws Exception {
//        // 필요한 데이터를 JSP에 전달
//        List<DoctorDto> list = doctorService.get();
//        model.addAttribute("doctorlist", list);
//        // testdo.jsp를 렌더링
//        return "testdo2";
//    }

    @RequestMapping("/submitReservation")
    public String submitReservation(Model model) throws Exception {
        // subjectName에 해당하는 데이터 가져오기
        // 데이터를 모델에 추가
        // JSP 파일 렌더링
        return "testdo";
    }




    @RequestMapping("/testdo2")
    public String loadTestdo2(@RequestParam("subjectName") String subjectName, Model model) throws Exception {
        // subjectName에 해당하는 데이터 가져오기
        List<DoctorDto> filteredDoctors = doctorService.getDoctorsBySubject(subjectName);

        // 데이터를 모델에 추가
        model.addAttribute("doctorlist", filteredDoctors);

        // JSP 파일 렌더링
        return "testdo2";
    }




    @GetMapping("/reservation2")
    public String getDoctor(String doctorId, Model model) throws Exception {
        List<DoctorDto> list = doctorService.get();

        // 모델에 doctorDto 객체를 추가하여 뷰로 전달
        model.addAttribute("doctorlist", list);

        return "reservation2"; // "doctor.html" 템플릿으로 이동
    }


    @GetMapping("/search")
    public ResponseEntity<List<DoctorDto>> searchDoctors(@RequestParam String subjectName) throws Exception {
        List<DoctorDto> doctors = doctorService.getDoctorsBySubject(subjectName);
        return ResponseEntity.ok(doctors); // JSON 형식으로 응답을 반환
    }



    }

