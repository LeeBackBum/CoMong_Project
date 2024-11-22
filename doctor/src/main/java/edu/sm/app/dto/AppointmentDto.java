package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

import java.util.Date;
@Builder
@Data
public class AppointmentDto {
    private String userId;
    private String userName;
    private int userAge;
    private String userSex;
    private String diseaseStatus;
    private String userNumber;
    private String appointmentType; // 예약/상담 구분
    private Date date; // 예약 날짜 또는 상담 날짜

    // Getters and Setters
}
