package edu.sm.app.repository;

import edu.sm.app.dto.BoardDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardRepository extends SMRepository<Integer, BoardDto> {

//    // 공지사항만 가져오기
//    List<BoardDto> selectNotices();
//
//    // 일반 게시글만 가져오기
//    List<BoardDto> selectGeneralBoards();
//
//    // 공지사항 포함 모든 게시글 가져오기 (공지사항 상단 정렬)
//    List<BoardDto> selectAllBoards();

    // 조회수 증가
    void increaseHits(@Param("boardId") Integer boardId);

    // 페이징을 위한 게시글 가져오기
    List<BoardDto> selectBoardsWithPagination(@Param("offset") int offset, @Param("pageSize") int pageSize);

    // 게시글 총 개수 가져오기
    int countTotalBoards();

    // 제목 또는 내용으로 게시글 검색
    List<BoardDto> searchBoards(@Param("keyword") String keyword, @Param("offset") int offset, @Param("pageSize") int pageSize);

    // 검색 결과 총 개수
    int countSearchResults(@Param("keyword") String keyword);
}
