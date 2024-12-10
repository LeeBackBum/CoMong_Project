package edu.sm.app.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Data
@Builder
public class MedicalAppointmentDto {
    private int appointmentId;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private String appointmentDate;
    private String appointmentContent;
    private String appointmentStatus;   // '진료' 또는 '상담'
    private String userId;
    private String doctorId;
    private String type;                // '진료' 또는 '상담'
    private String subType;             // '채팅상담', '화상상담', 또는 NULL
}
