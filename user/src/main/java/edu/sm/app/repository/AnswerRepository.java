package edu.sm.app.repository;

import edu.sm.app.dto.AnswerDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AnswerRepository {
    void insertAnswer(AnswerDto answer);
    List<AnswerDto> selectAnswersByBoardId(int boardId);
    void deleteAnswerById(int answerId);

    // Answer ID로 특정 답변 조회
    AnswerDto selectAnswerById(@Param("answerId") int answerId);
}
