package edu.sm;

import edu.sm.app.service.DoctorService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;


@SpringBootTest
@Slf4j
class DoctorSelectTest {
    @Autowired
    DoctorService doctorService;
    @Test
    void select() {
        try {
            doctorService.get();
        }catch (Exception e) {
            log.error(e.getMessage());
        }
    }

}