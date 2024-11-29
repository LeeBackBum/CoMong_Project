package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class AnswerDto {
    private int answerId;
    private String answerContent;
    private LocalDateTime answerDate;
    private String userId;
    private int boardId;
}
