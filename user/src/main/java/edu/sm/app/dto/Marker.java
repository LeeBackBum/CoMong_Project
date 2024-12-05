package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Marker {
    //     {lat:37.564472, lng:126.990841, title:'순대국1', img:'ss1.jpg', code:101},
    private double lat;
    private double lng;
    private String title;
    private String img;
    private int code;
}