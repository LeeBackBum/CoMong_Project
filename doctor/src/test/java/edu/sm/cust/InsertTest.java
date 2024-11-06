package edu.sm.cust;

import edu.sm.app.dto.CustDto;
import edu.sm.app.service.CustService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class InsertTest {
    @Autowired
    CustService custService;

    @Test
    void contextLoads() {
        CustDto custDto = CustDto.builder().custId("id15").custPwd("pwd15").custName("이말자").build();
        try {
            custService.add(custDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
