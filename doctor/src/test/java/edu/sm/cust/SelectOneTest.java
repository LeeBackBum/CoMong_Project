package edu.sm.cust;

import edu.sm.app.dto.CustDto;
import edu.sm.app.service.CustService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class SelectOneTest {
    @Autowired
    CustService custService;

    @Test
    void contextLoads() {
        String id = "id88";
        try {
            CustDto custDto = custService.get(id);
            log.info(custDto.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
