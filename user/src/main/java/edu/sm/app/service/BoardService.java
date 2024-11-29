package edu.sm.app.service;

import edu.sm.app.dto.BoardDto;
import edu.sm.app.repository.BoardRepository;
import edu.sm.app.frame.SMService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BoardService implements SMService<Integer, BoardDto> {
    private final BoardRepository boardRepository;

    public BoardService(BoardRepository boardRepository) {
        this.boardRepository = boardRepository;
    }

//    // 공지사항만 가져오기
//    public List<BoardDto> getNotices() {
//        return boardRepository.selectNotices();
//    }
//
//    // 일반 게시글만 가져오기
//    public List<BoardDto> getGeneralBoards() {
//        return boardRepository.selectGeneralBoards();
//    }
//
//    // 공지사항 포함한 모든 게시글 가져오기
//    public List<BoardDto> getAllBoards() {
//        return boardRepository.selectAllBoards();
//    }

    // 게시글 추가
    @Override
    @Transactional
    public void add(BoardDto boardDto) throws Exception {
        boardRepository.insert(boardDto);
    }

    // 게시글 수정
    @Override
    @Transactional
    public void modify(BoardDto boardDto) throws Exception {
        boardRepository.update(boardDto);
    }

    // 게시글 삭제
    @Override
    @Transactional
    public void del(Integer boardId) throws Exception {
        boardRepository.delete(boardId);
    }

    // 단일 게시글 조회
    @Override
    public BoardDto get(Integer boardId) throws Exception {
        return boardRepository.selectOne(boardId);
    }

    // 모든 게시글 조회 (공지사항 포함)
    @Override
    public List<BoardDto> get() throws Exception {
        return boardRepository.select();
    }

    /**
     * 조회수 증가
     * @param boardId - 조회수를 증가시킬 게시글 ID
     */
    @Transactional
    public void increaseHits(Integer boardId) {
        boardRepository.increaseHits(boardId);
    }

    public List<BoardDto> getBoardsWithPagination(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardRepository.selectBoardsWithPagination(offset, pageSize);
    }

    public int getTotalBoardCount() {
        return boardRepository.countTotalBoards();
    }

    public List<BoardDto> searchBoards(String keyword, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardRepository.searchBoards(keyword, offset, pageSize);
    }

    public int getSearchResultCount(String keyword) {
        return boardRepository.countSearchResults(keyword);
    }
}


