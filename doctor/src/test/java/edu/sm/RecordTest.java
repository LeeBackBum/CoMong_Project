package edu.sm;

import edu.sm.app.dto.MedicalRecordsDto;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class RecordTest {
    @Autowired
    private SqlSession sqlSession;

    @Test
    public void testGetMedicalRecords() {
        // 특정 userId를 설정
        String userId = "user01";

        // MyBatis를 통해 쿼리 호출
        List<MedicalRecordsDto> records = sqlSession.selectList("getMedicalRecords", userId);

        // 결과 출력
        for (MedicalRecordsDto record : records) {
            System.out.println(record);
        }
    }
}
