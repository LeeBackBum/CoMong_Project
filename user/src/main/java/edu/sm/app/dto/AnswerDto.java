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
public class AnswerDto {
    private int answerId;
    private String answerContent;
    private LocalDateTime answerDate;
    private String userId;
    private int boardId;
}
