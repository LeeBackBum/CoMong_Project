package edu.sm;

import edu.sm.app.service.DoctorService;
import edu.sm.app.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class userSelectTest {
    @Autowired
    UserService userService;

    @Test
    void contextLoads() {
        try {
            userService.get();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
