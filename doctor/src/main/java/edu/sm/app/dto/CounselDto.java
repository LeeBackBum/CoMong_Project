package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CounselDto {
    private Integer counselId;
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
