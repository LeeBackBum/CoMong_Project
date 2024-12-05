package edu.sm;

import edu.sm.app.service.DoctorService;
import edu.sm.app.service.MedicalAppointmentService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class ApointmentSelectTest {
    @Autowired
    MedicalAppointmentService medicalAppointmentService;

    @Test
    void contextLoads(){
        try {
            medicalAppointmentService.get();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
