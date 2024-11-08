package edu.sm.controller;

import edu.sm.app.dto.AppointmentDto;
import edu.sm.app.dto.DoctorDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    final UserService userService;

    String dir = "user/";
    @RequestMapping("/get")
    public String get(Model model) throws Exception {
        // Database에서 데이터를 가지고 온다.
        List<UserDto> list = new ArrayList<>();
        try {
            list = userService.get();
            model.addAttribute("users",list);
            model.addAttribute("center",dir+"get");
        } catch (Exception e) {
            throw new Exception("ER0001");
        }
        return "index";
    }
    @RequestMapping("/add")
    public String add(Model model){

        model.addAttribute("center",dir+"add");
        return "index";
    }

    @RequestMapping("/detail")
    public String detail(Model model,@RequestParam("id") String id){
        // Database에서 데이터를 가지고 온다.
        UserDto userDto = null;
        try {
            userDto = userService.get(id);
            model.addAttribute("user", userDto);
            model.addAttribute("center",dir+"detail");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

    @RequestMapping("/addimpl")
    public String addimpl(Model model,UserDto custDto) throws Exception {
        userService.add(custDto);
        return "redirect:/cust/detail?id="+custDto.getUserId();

    }

    @RequestMapping("/appointments")
    public String getAppointments(Model model, HttpSession session) {
        // 세션에서 doctorDto 가져오기
        DoctorDto doctorDto = (DoctorDto) session.getAttribute("doctor");

        if (doctorDto == null) {
            // 로그인 정보가 없을 경우 로그인 페이지로 리다이렉트
            return "redirect:/login";
        }

        // doctorDto에서 doctorId 가져오기
        String doctorId = doctorDto.getDoctorId();

        // doctorId를 사용해 해당 의사의 환자 목록 조회
        List<AppointmentDto> appointments = userService.getAppointments(doctorId);
        model.addAttribute("center",dir+"appointment");
        model.addAttribute("appointments", appointments);

        return "index"; // 예약 및 상담 정보를 출력할 JSP 페이지
    }
}
