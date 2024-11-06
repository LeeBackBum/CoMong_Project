package edu.sm.item;

import edu.sm.app.dto.ItemDto;
import edu.sm.app.service.ItemService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class UpdateTest {
    @Autowired
    ItemService itemService;

    @Test
    void contextLoads() {

        ItemDto itemDto = ItemDto.builder().itemId(1).itemName("상의3333").itemPrice(2222).imgName("a.jpg").build();
        try {
            itemService.modify(itemDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
