package edu.sm.controller;

import com.github.pagehelper.PageInfo;
import edu.sm.app.dto.*;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.catalina.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    final UserService userService;

    String dir = "user/";

    @RequestMapping("/appointments")
    public String getAppointments(@RequestParam(value = "pageNo", defaultValue = "1") int pageNo,Model model, HttpSession session) {
        // 세션에서 doctorDto 가져오기
        DoctorDto doctorDto = (DoctorDto) session.getAttribute("doctor");

        if (doctorDto == null) {
            // 로그인 정보가 없을 경우 로그인 페이지로 리다이렉트
            return "redirect:/";
        }

        // doctorDto에서 doctorId 가져오기
        String doctorId = doctorDto.getDoctorId();
        // doctorId를 사용해 해당 의사의 환자 목록 조회
        try {
            PageInfo<AppointmentDto> a;
            a = new PageInfo<>(userService.getAppointments(pageNo,doctorId),5);
            model.addAttribute("cpage", a);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error fetching appointments.");
        }
        model.addAttribute("target","/user/appointments");
        model.addAttribute("center",dir+"appointments");


        return "main"; // 예약 및 상담 정보를 출력할 JSP 페이지
    }

    @RequestMapping("/detail")
    public String userDetail(@RequestParam("id")String userId, Model model) {

        try {
            // Medical Records 페이징 처리
            PageInfo<MedicalRecordsDto> record;
            record = new PageInfo<>(userService.getMedicalRecords(userId),3);
            // Counsel 페이징 처리
            PageInfo<CounselDto> counsel;
            counsel = new PageInfo<>(userService.getCounsel(userId),3);
            model.addAttribute("cpage", record);
            model.addAttribute("counselpage", counsel);
//            model.addAttribute("target","/user/detail");
            model.addAttribute("center",dir+"detail");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "main";
    }

    @RequestMapping("/chart")
    public String chart(Model model) {
        model.addAttribute("center", dir+"chart");
        return "main";
    }



}
