package edu.sm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CalendarController {

    @GetMapping("/calendar")
    public String getCalendar() {
        return "calendar"; // calendar.jsp 파일을 반환
    }


}