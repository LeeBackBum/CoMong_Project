package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class BoardDto {
    private int boardId;
    private String boardTitle;
    private String boardContent;
    private LocalDateTime boardDate;
    private LocalDateTime boardUpdate;
    private int boardHits;
    private int boardAnswerNum;
    private String userId;
}
