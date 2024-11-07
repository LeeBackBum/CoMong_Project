package edu.sm.app.repository;

import edu.sm.app.dto.BoardDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface BoardRepository extends SMRepository<Integer, BoardDto> {

    // 공지사항만 가져오기
    List<BoardDto> selectNotices();

    // 일반 게시글만 가져오기
    List<BoardDto> selectGeneralBoards();

    // 공지사항 포함 모든 게시글 가져오기 (공지사항 상단 정렬)
    List<BoardDto> selectAllBoards();

    // 조회수 증가
    void increaseHits(@Param("boardId") Integer boardId);
}
