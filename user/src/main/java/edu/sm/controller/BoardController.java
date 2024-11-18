package edu.sm.controller;

import edu.sm.app.dto.AnswerDto;
import edu.sm.app.dto.BoardDto;
import edu.sm.app.dto.NoticeDto;
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

import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    private final NoticeService noticeService;
    private final AnswerService answerService; // AnswerService 추가
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

        model.addAttribute("center", dir + "boardMain");
        return dir + "boardMain";
    }

    @GetMapping("/{boardId}")
    public String detail(Model model, @PathVariable("boardId") Integer boardId,
                         HttpServletRequest request, HttpServletResponse response) {
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
            String formattedDate = board.getBoardDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

            // 댓글 및 대댓글 목록 추가
            List<AnswerDto> answers = answerService.getAnswersByBoardId(boardId);
            model.addAttribute("answers", answers); // 댓글 및 대댓글 목록을 Model에 추가

            model.addAttribute("board", board);
            model.addAttribute("formattedDate", formattedDate);
        } catch (Exception e) {
            log.error("게시글 상세 조회 실패", e);
        }
        model.addAttribute("center", "board/detail");
        return "board/detail";
    }

    @GetMapping("/write")
    public String writeForm(Model model) {
        model.addAttribute("boardDto", new BoardDto());
        model.addAttribute("center", dir + "write");
        return dir + "write";
    }

    @PostMapping("/write")
    public String saveBoard(@ModelAttribute BoardDto boardDto, HttpSession session) {
        try {
            boardDto.setUserId("guestUser");
            boardService.add(boardDto);
        } catch (Exception e) {
            log.error("글 저장 실패", e);
        }
        return "redirect:/board";
    }

    @GetMapping("/edit/{boardId}")
    public String editForm(@PathVariable("boardId") Integer boardId, Model model) {
        try {
            BoardDto board = boardService.get(boardId);  // 해당 게시글의 정보를 가져옴
            model.addAttribute("boardDto", board);  // 수정 폼에 게시글 데이터 전달
        } catch (Exception e) {
            log.error("게시글 수정 폼 로딩 실패", e);
        }
        model.addAttribute("center", dir + "edit");
        return dir + "edit";
    }

    @PostMapping("/edit/{boardId}")
    public String updateBoard(@PathVariable("boardId") Integer boardId, @ModelAttribute BoardDto boardDto) {
        try {
            boardDto.setBoardId(boardId);  // 게시글 ID 설정
            boardService.modify(boardDto);  // 게시글 수정 요청
        } catch (Exception e) {
            log.error("게시글 수정 실패", e);
        }
        return "redirect:/board/" + boardId;  // 수정 완료 후 해당 게시글 상세 페이지로 리디렉션
    }

    @PostMapping("/delete/{boardId}")
    public String deleteBoard(@PathVariable("boardId") Integer boardId) {
        try {
            boardService.del(boardId);  // 게시글 삭제 서비스 호출
        } catch (Exception e) {
            log.error("게시글 삭제 실패", e);
        }
        return "redirect:/board";  // 삭제 후 게시판 목록으로 리디렉션
    }

    // 대댓글 작성 메서드
    @PostMapping("/reply/{parentAnswerId}")
    public String addReply(@PathVariable int parentAnswerId,
                           @RequestParam("content") String content,
                           @RequestParam("boardId") int boardId,
                           HttpSession session) {
        try {
            String userId = (String) session.getAttribute("loginid");
            AnswerDto replyDto = AnswerDto.builder()
                    .answerContent(content)
                    .boardId(boardId)
                    .userId(userId != null ? userId : "guestUser")
                    .parentAnswerId(parentAnswerId)
                    .build();
            answerService.addReply(replyDto, parentAnswerId); // 대댓글 추가
        } catch (Exception e) {
            log.error("대댓글 작성 실패", e);
            return "redirect:/board/" + boardId + "?error=true";
        }
        return "redirect:/board/" + boardId;  // 대댓글 작성 후 게시글 상세 페이지로 리디렉션
    }
}
