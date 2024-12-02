package edu.sm.doctor;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.service.DoctorService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;

@SpringBootTest
@Slf4j
class InsertTest {
    @Autowired
    DoctorService doctorService;

    @Test
    void contextLoads(){
        DoctorDto doctorDto = DoctorDto.builder()
             .doctorId("doctor04")
             .doctorPwd("pwd03")
             .doctorNumber("5649")
             .doctorName("DR.ron")
             .doctorAge("56")
             .doctorEmail("ron@gmail.com")
             .doctorImg("img")
             .career("15년")        // 경력
             .ancestry("순천향대학교")     // 학력
             .society("대한의학")        // 학회
             .subjectName("외과")   // 진료과목 이름
             .build();

        try {
            doctorService.add(doctorDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
