package edu.sm.cart;

import edu.sm.app.dto.CartDto;
import edu.sm.app.service.CartService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class UpdateTest {
    @Autowired
    CartService cartService;

    @Test
    void contextLoads() {

        CartDto cartDto = CartDto.builder()
                .cartUserId("id01")
                .cartItemId(1)
                .cartCount(10)
                .build();
        try {
            cartService.modify(cartDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
