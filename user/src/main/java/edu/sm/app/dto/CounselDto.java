package edu.sm.app.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Builder
public class CounselDto {


    private Integer counselId;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date counselDate;
    private String counselContent;
    private String counselType;      // 상담 종류 ('화상' 또는 '채팅')
    private String doctorId;
    private String userId;

    @Override
    public String toString() {
        return "CounselDto{" +
                "counselDate='" + counselDate + '\'' +
                ", counselContent='" + counselContent + '\'' +
                ", counselType='" + counselType + '\'' +
                ", doctorId='" + doctorId + '\'' +
                ", userId='" + userId + '\'' +
                '}';
    }
}