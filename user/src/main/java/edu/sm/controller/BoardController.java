package edu.sm.controller;

import edu.sm.app.dto.AnswerDto;
import edu.sm.app.dto.BoardDto;
import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.AnswerService;
import edu.sm.app.service.BoardService;
import edu.sm.app.service.NoticeService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedList;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    private final NoticeService noticeService;
    private final AnswerService answerService;
    private final String dir = "board/";

    @GetMapping("")
    public String boardMain(Model model, HttpSession session,
                            @RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "size", defaultValue = "10") int pageSize,
                            @RequestParam(value = "keyword", required = false) String keyword) {
        try {
            List<NoticeDto> notices = noticeService.getAllNotices();
            model.addAttribute("notices", notices);

            List<BoardDto> boards;
            int totalPages;

            if (keyword != null && !keyword.trim().isEmpty()) {
                boards = boardService.searchBoards(keyword, page, pageSize);
                int totalResults = boardService.getSearchResultCount(keyword);
                totalPages = (int) Math.ceil((double) totalResults / pageSize);

                LinkedList<String> searchHistory = (LinkedList<String>) session.getAttribute("searchHistory");
                if (searchHistory == null) {
                    searchHistory = new LinkedList<>();
                    session.setAttribute("searchHistory", searchHistory);
                }
                if (!searchHistory.contains(keyword)) {
                    searchHistory.addFirst(keyword);
                    if (searchHistory.size() > 10) {
                        searchHistory.removeLast();
                    }
                }
            } else {
                boards = boardService.getBoardsWithPagination(page, pageSize);
                int totalBoardCount = boardService.getTotalBoardCount();
                totalPages = (int) Math.ceil((double) totalBoardCount / pageSize);
            }

            model.addAttribute("boards", boards);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("keyword", keyword);
            model.addAttribute("searchHistory", session.getAttribute("searchHistory"));

        } catch (Exception e) {
            log.error("게시판 데이터 로딩 실패", e);
        }

        model.addAttribute("center", dir + "board");
        return "index";
    }

    @GetMapping("/{boardId}")
    public String detail(Model model, @PathVariable("boardId") Integer boardId,
                         HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        try {
            boolean isViewed = false;
            if (request.getCookies() != null) {
                for (Cookie cookie : request.getCookies()) {
                    if (cookie.getName().equals("viewed_" + boardId)) {
                        isViewed = true;
                        break;
                    }
                }
            }

            if (!isViewed) {
                boardService.increaseHits(boardId);
                Cookie newCookie = new Cookie("viewed_" + boardId, "true");
                newCookie.setMaxAge(24 * 60 * 60);
                response.addCookie(newCookie);
            }

            BoardDto board = boardService.get(boardId);
            if (board == null) {
                log.warn("존재하지 않는 게시글: boardId={}", boardId);
                return "redirect:/board?error=not_found";
            }

            List<AnswerDto> answers = answerService.getAnswersByBoardId(boardId);

            // 현재 로그인된 사용자 정보를 추가로 JSP로 전달
            UserDto user = (UserDto) session.getAttribute("loginid");
            model.addAttribute("user", user);

            model.addAttribute("board", board);
            model.addAttribute("answers", answers);
        } catch (Exception e) {
            log.error("게시글 상세 조회 중 오류 발생", e);
            return "redirect:/board?error=exception";
        }
        model.addAttribute("center", dir + "detail");
        return "index";
    }

    @GetMapping("/write")
    public String writeForm(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("loginid");

        if (user == null) {
            log.warn("로그인되지 않은 사용자: 글쓰기 페이지 접근");
            model.addAttribute("center", "login");
            return "index";
        }

        model.addAttribute("userName", user.getUserName());
        model.addAttribute("boardDto", new BoardDto());
        model.addAttribute("center", dir + "write");
        return "index";
    }

    @PostMapping("/write")
    public String saveBoard(@ModelAttribute BoardDto boardDto, HttpSession session, Model model) {
        try {
            UserDto user = (UserDto) session.getAttribute("loginid");

            if (user == null) {
                log.warn("로그인 정보 없음: 글 저장 불가");
                return "redirect:/login?error=not_logged_in";
            }

            boardDto.setUserId(user.getUserId());
            boardDto.setUserName(user.getUserName());
            boardService.add(boardDto);

            log.info("게시글 저장 성공: {} (작성자: {})", boardDto.getBoardTitle(), user.getUserName());
        } catch (Exception e) {
            log.error("글 저장 실패", e);
            model.addAttribute("center", dir + "write");
            model.addAttribute("errorMessage", "게시글 저장 중 문제가 발생했습니다.");
            return "index";
        }
        return "redirect:/board";
    }

    @GetMapping("/edit/{boardId}")
    public String editForm(@PathVariable("boardId") Integer boardId, HttpSession session, Model model) throws Exception {
        UserDto user = (UserDto) session.getAttribute("loginid");
        if (user == null) {
            log.warn("로그인되지 않은 사용자: 수정 페이지 접근");
            return "redirect:/login?error=not_logged_in";
        }

        BoardDto board = boardService.get(boardId);
        if (board == null || (!user.getUserId().equals(board.getUserId()) && !"1".equals(user.getRole()))) {
            log.warn("수정 권한 없음: 사용자 ID={}, 게시글 작성자 ID={}", user.getUserId(), board.getUserId());
            return "redirect:/board?error=unauthorized";
        }

        model.addAttribute("boardDto", board);
        model.addAttribute("center", dir + "edit");
        return "index";
    }

    @PostMapping("/edit/{boardId}")
    public String updateBoard(@PathVariable("boardId") Integer boardId, @ModelAttribute BoardDto boardDto) {
        try {
            // 기존 데이터 불러오기
            BoardDto existingBoard = boardService.get(boardId);
            if (existingBoard == null) {
                log.warn("존재하지 않는 게시글: boardId={}", boardId);
                return "redirect:/board?error=not_found";
            }

            // 기존 데이터에 수정된 값만 업데이트
            existingBoard.setBoardTitle(boardDto.getBoardTitle());
            existingBoard.setBoardContent(boardDto.getBoardContent());

            // 저장
            boardService.modify(existingBoard);
        } catch (Exception e) {
            log.error("게시글 수정 실패", e);
            return "redirect:/board?error=exception";
        }
        return "redirect:/board/" + boardId;
    }


    @PostMapping("/delete/{boardId}")
    public String deleteBoard(@PathVariable("boardId") Integer boardId, HttpSession session) throws Exception {
        UserDto user = (UserDto) session.getAttribute("loginid");
        BoardDto board = boardService.get(boardId);

        if (user == null || board == null) {
            log.warn("삭제 권한 없음: 사용자 또는 게시글 존재하지 않음");
            return "redirect:/board?error=unauthorized";
        }

        // 작성자와 관리자 권한 확인
        if (!user.getUserId().equals(board.getUserId()) && !"1".equals(user.getRole())) {
            log.warn("삭제 권한 없음: 사용자 ID={}, 게시글 작성자 ID={}", user.getUserId(), board.getUserId());
            return "redirect:/board?error=unauthorized";
        }

        try {
            boardService.del(boardId);
            log.info("게시글 삭제 성공: boardId={}", boardId);
        } catch (Exception e) {
            log.error("게시글 삭제 실패", e);
            return "redirect:/board?error=true";
        }
        return "redirect:/board";
    }

   

}
