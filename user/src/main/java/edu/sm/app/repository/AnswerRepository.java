package edu.sm.app.repository;

import edu.sm.app.dto.AnswerDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AnswerRepository {
    void insertAnswer(AnswerDto answer);

    void updateGroupId(AnswerDto answer);

    void insertReply(AnswerDto reply);

    List<AnswerDto> selectAnswersByBoardId(int boardId);

    AnswerDto selectAnswerById(@Param("answerId") int answerId);

    List<AnswerDto> selectRepliesByParentId(@Param("parentAnswerId") int parentAnswerId);

    void deleteAnswerById(int answerId);
    // 댓글 및 대댓글 수정 메서드 추가
    void updateAnswer(AnswerDto answer);
}
