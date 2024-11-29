package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor
@Data
@AllArgsConstructor
@Builder
public class NoticeDto {
    private int noticeId;
    private String noticeTitle;
    private String noticeContent;
    private LocalDateTime noticeDate;
    private int noticeHits;
    private String userId;
    private String userName; // 관리자 이름 필드 추가
}
