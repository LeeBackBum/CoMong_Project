package edu.sm.cart;

import edu.sm.app.dto.CartDto;
import edu.sm.app.service.CartService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class FindByNameTest {
    @Autowired
    CartService cartService;

    @Test
    void contextLoads() {
        CartDto cartDto = CartDto.builder()
                .cartUserId("id01")
                .itemName("pan")
                .build();
        try {
            cartService.findByName(cartDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
