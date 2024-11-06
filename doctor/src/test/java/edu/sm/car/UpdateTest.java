package edu.sm.car;

import edu.sm.app.dto.CarDto;
import edu.sm.app.service.CarService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@Slf4j
class UpdateTest {
    @Autowired
    CarService carService;

    @Test
    void contextLoads() {
        CarDto carDto = CarDto.builder().carNumber("99퍽1111").carColor("white").carType("G80").carPrice("8천만원").build();
        try{
            carService.modify(carDto);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
