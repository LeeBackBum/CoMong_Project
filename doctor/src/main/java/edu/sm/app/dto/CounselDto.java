package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Builder
public class CounselDto {
    private int counselId;
    private Date counselDate;
    private String counselContent;
    private String counselType;      // 상담 종류 ('화상' 또는 '채팅')
    private String doctorId;
    private String userId;
}