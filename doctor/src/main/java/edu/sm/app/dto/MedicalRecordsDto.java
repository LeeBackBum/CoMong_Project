package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Builder
public class MedicalRecordsDto {
    private int recordsId;
    private String content;
    private String result;
    private String subjectName;
    private Date date;
    private String img;
    private String treatmentDetail;
    private String userId;
    private String doctorId;
}
