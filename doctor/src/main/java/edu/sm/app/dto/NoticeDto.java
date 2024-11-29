package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class NoticeDto {
    private int noticeId;
    private String noticeTitle;
    private String noticeContent;
    private LocalDateTime noticeDate;
    private int noticeHits;
    private String managerId;
}
