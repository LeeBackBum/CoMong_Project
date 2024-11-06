package edu.sm.car;

import edu.sm.app.dto.CarDto;
import edu.sm.app.service.CarService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;

@SpringBootTest
@Slf4j
class InsertTest {
    @Autowired
    CarService carService;

    @Test
    void contextLoads(){
        CarDto carDto = CarDto.builder().carNumber("12A2222").carColor("green").carType("K5").carPrice("100000$").carDate(LocalDateTime.now()).build();

        try{
            carService.add(carDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
