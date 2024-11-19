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
            if (board == null) {
                log.warn("존재하지 않는 게시글: boardId={}", boardId);
                return "redirect:/board?error=not_found";
            }

            List<AnswerDto> answers = answerService.getAnswersByBoardId(boardId);
            if (answers == null || answers.isEmpty()) {
                log.info("댓글 없음: boardId={}", boardId);
            }

            model.addAttribute("board", board);
            model.addAttribute("answers", answers);

        } catch (Exception e) {
            log.error("게시글 상세 조회 중 오류 발생", e);
            return "redirect:/board?error=exception";
        }
        return "board/detail";
    }

    @GetMapping("/write")
    public String writeForm(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("loginid");
        if (user == null) {
            log.warn("로그인되지 않은 사용자: 글쓰기 페이지 접근");
            return "redirect:/login";
        }
        model.addAttribute("userName", user.getUserName());
        model.addAttribute("boardDto", new BoardDto());
        return dir + "write";
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
            model.addAttribute("errorMessage", "게시글 저장 중 문제가 발생했습니다.");
            return dir + "write";
        }
        return "redirect:/board";
    }

    @GetMapping("/edit/{boardId}")
    public String editForm(@PathVariable("boardId") Integer boardId, Model model) {
        try {
            BoardDto board = boardService.get(boardId);
            model.addAttribute("boardDto", board);
        } catch (Exception e) {
            log.error("게시글 수정 폼 로딩 실패", e);
        }
        return dir + "edit";
    }

    @PostMapping("/edit/{boardId}")
    public String updateBoard(@PathVariable("boardId") Integer boardId, @ModelAttribute BoardDto boardDto) {
        try {
            boardDto.setBoardId(boardId);
            boardService.modify(boardDto);
        } catch (Exception e) {
            log.error("게시글 수정 실패", e);
        }
        return "redirect:/board/" + boardId;
    }

    @PostMapping("/delete/{boardId}")
    public String deleteBoard(@PathVariable("boardId") Integer boardId) {
        try {
            boardService.del(boardId);
        } catch (Exception e) {
            log.error("게시글 삭제 실패", e);
        }
        return "redirect:/board";
    }




    @PostMapping("/{boardId}/comments")
    public String addComment(@PathVariable Integer boardId,
                             @RequestParam String content,
                             HttpSession session,
                             Model model) {
        try {
            // 로그인 여부 확인
            String userId = (String) session.getAttribute("loginid");
            String userName = (String) session.getAttribute("username");

            if (userId == null || userName == null) {
                log.warn("세션 정보 누락: 로그인되지 않은 사용자입니다.");
                return "redirect:/login?error=not_logged_in";
            }

            // 댓글 작성 DTO 생성
            AnswerDto comment = AnswerDto.builder()
                    .boardId(boardId)
                    .answerContent(content)
                    .userId(userId)
                    .userName(userName)
                    .build();

            log.info("댓글 작성 요청: {}", comment);

            // 댓글 서비스 호출
            answerService.addAnswer(comment);

        } catch (Exception e) {
            log.error("댓글 작성 중 오류 발생", e);
            model.addAttribute("errorMessage", "댓글 작성 중 문제가 발생했습니다.");
        }

        return "redirect:/board/" + boardId;
    }

    @PostMapping("/{boardId}/comments/{parentId}")
    public String addReply(@PathVariable Integer boardId,
                           @PathVariable Integer parentId,
                           @RequestParam String content,
                           HttpSession session,
                           Model model) {
        try {
            // 로그인 여부 확인
            String userId = (String) session.getAttribute("loginid");
            String userName = (String) session.getAttribute("username");

            if (userId == null || userName == null) {
                log.warn("세션 정보 누락: 로그인되지 않은 사용자입니다.");
                return "redirect:/login?error=not_logged_in";
            }

            // 대댓글 작성 DTO 생성
            AnswerDto reply = AnswerDto.builder()
                    .boardId(boardId)
                    .parentAnswerId(parentId)
                    .answerContent(content)
                    .userId(userId)
                    .userName(userName)
                    .build();

            log.info("대댓글 작성 요청: {}", reply);

            // 대댓글 서비스 호출
            answerService.addReply(reply, parentId);

        } catch (Exception e) {
            log.error("대댓글 작성 중 오류 발생", e);
            model.addAttribute("errorMessage", "대댓글 작성 중 문제가 발생했습니다.");
        }

        return "redirect:/board/" + boardId;
    }
}
