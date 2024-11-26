package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DoctorDto {
        private String doctorId;
        private String doctorPwd;
        private String doctorNumber;
        private String doctorName;
        private String doctorAge;
        private String doctorEmail;
        private String doctorImg; // 업로드된 파일
        private String career;         // 경력
        private String ancestry;       // 학력
        private String society;        // 학회
        private String subjectName;    // 진료과목 이름
}

