package edu.sm;

import edu.sm.app.dto.AppointmentDto;
import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Map;

@SpringBootTest
public class DateAppointmentsTest {

    @Autowired
    private SqlSession sqlSession;

    @Test
    public void testDateAppointments() {
        // 테스트용 데이터 설정
        String doctorId = "doc01"; // 테스트할 의사 ID
        String date = "2024-11-07";  // 테스트할 날짜 (YYYY-MM-DD 형식)

        // MyBatis 쿼리 호출
        List<AppointmentDto> appointments = sqlSession.selectList("dateAppointments",
                Map.of("doctorId", doctorId, "date", date));

        // 결과 출력
        System.out.println("=== 조회된 예약 및 상담 내역 ===");
        for (AppointmentDto appointment : appointments) {
            System.out.println(appointment);
        }

        // 결과 검증 (예: 비어 있지 않은지 확인)
        assert appointments != null : "결과가 null입니다.";
        assert !appointments.isEmpty() : "조회된 데이터가 없습니다.";
    }
}