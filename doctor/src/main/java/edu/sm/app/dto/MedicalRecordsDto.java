package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class MedicalRecordsDto {
    private int recordsId;
    private String content;
    private String result;
    private String subjectName;
    private LocalDateTime date;
    private String img;
    private String treatmentDetail;
    private String userId;
    private String doctorId;
}
