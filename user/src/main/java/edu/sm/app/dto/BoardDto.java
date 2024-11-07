package edu.sm.app.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BoardDto {
    private int boardId;
    private String boardTitle;
    private String boardContent;
    private LocalDateTime boardDate;
    private LocalDateTime boardUpdate;
    private int boardHits;
    private int boardAnswerNum;
    private String userId;
    private int isNotice; // 공지사항 여부를 나타내는 필드 추가 (1: 공지, 0: 일반)
}
