package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DoctorDto {
        private String doctorId;
        private String doctorPwd;
        private String doctorNumber;
        private String doctorName;
        private String doctorAge;
        private String doctorEmail;
        private String doctorImg;
        private String career;         // 경력
        private String ancestry;       // 학력
        private String society;        // 학회
        private String subjectName;    // 진료과목 이름
}
