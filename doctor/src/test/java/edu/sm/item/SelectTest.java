package edu.sm.item;

import edu.sm.app.service.ItemService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class SelectTest {
    @Autowired
    ItemService itemService;

    @Test
    void contextLoads() {
        try {
            itemService.get();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
