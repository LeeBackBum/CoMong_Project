package edu.sm.doctor;

import edu.sm.app.dto.AppointmentDto;
import edu.sm.app.repository.DoctorRepository;
import edu.sm.app.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
@SpringBootTest
@Slf4j
class SelectAppointment {
    @Autowired
    UserRepository userRepository;

    @Test
    public void testSelectAppointments() {
        // 테스트용 doctorId 설정
        String doctorId = "doc01";

        // 쿼리 실행
        List<AppointmentDto> appointments = userRepository.selectAppointments(doctorId);

        // 결과 검증
        Assertions.assertNotNull(appointments, "결과가 null이면 안 됩니다.");
        Assertions.assertFalse(appointments.isEmpty(), "결과가 비어있으면 안 됩니다.");

        // 예시: 첫 번째 결과 값 검증 (데이터베이스에 샘플 데이터가 있다고 가정)
        AppointmentDto firstAppointment = appointments.get(0);
        System.out.println("첫 번째 예약 정보: " + firstAppointment.getUserName() + ", " + firstAppointment.getAppointmentType() + ", " + firstAppointment.getDate());

        // 추가적인 검증을 여기에 작성할 수 있습니다.
    }
}
