package edu.sm.doctor;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.service.DoctorService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
class SelectTest {
    @Autowired
    DoctorService doctorService;

    @Test
    void contextLoads(){
        try {
            doctorService.get();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
