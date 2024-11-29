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
    private String userName;  // 작성자 이름
    private int boardId;
    private Integer parentAnswerId; // 상위 댓글 ID
    private int groupId;            // 그룹 ID (최상위 댓글의 ID)
    private int depth;              // 댓글 깊이
}
