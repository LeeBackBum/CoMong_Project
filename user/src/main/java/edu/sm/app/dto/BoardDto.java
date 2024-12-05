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
    private String userName;  // 작성자 이름
    private String formattedDate; // 포맷된 날짜

}