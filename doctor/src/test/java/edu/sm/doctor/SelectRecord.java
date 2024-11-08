package edu.sm.doctor;

import edu.sm.app.service.MedicalRecordsService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class SelectRecord {
    @Autowired
    MedicalRecordsService medicalRecordsService;
    @Test
    void contextLoads() {
        String id = "doc01";
        try {
            medicalRecordsService.get(id);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
