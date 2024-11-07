package edu.sm.controller;

import edu.sm.app.dto.BoardDto;
import edu.sm.app.dto.NoticeDto;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;
    private final NoticeService noticeService;

    private final String dir = "board/"; // JSP 파일 경로 기본 설정

    /**
     * 게시판 메인 페이지
     * 공지사항과 일반 게시글을 함께 조회하여 화면에 표시합니다.
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String boardMain(Model model) {
        try {
            List<NoticeDto> notices = noticeService.getAllNotices();
            List<BoardDto> boards = boardService.getAllBoards();
            model.addAttribute("notices", notices);
            model.addAttribute("boards", boards);
        } catch (Exception e) {
            log.error("게시판 데이터 로딩 실패", e);
        }
        model.addAttribute("center", dir + "boardMain");
        return dir + "boardMain";
    }

    /**
     * 글쓰기 페이지로 이동
     */
    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String writeForm(Model model) {
        model.addAttribute("boardDto", new BoardDto());
        model.addAttribute("center", dir + "write");
        return dir + "write";
    }

    /**
     * 글쓰기 요청 처리 및 저장
     */
    @RequestMapping(value = "/write", method = RequestMethod.POST)
    public String saveBoard(@ModelAttribute BoardDto boardDto, HttpSession session) {
        try {
            boardDto.setUserId("guestUser");  // 세션 구현 시 `loginid`로 대체
            boardService.add(boardDto);
        } catch (Exception e) {
            log.error("글 저장 실패", e);
        }
        return "redirect:/board";
    }

    /**
     * 게시글 상세 페이지
     */
    @RequestMapping(value = "/{boardId}", method = RequestMethod.GET)
    public String detail(Model model, @PathVariable("boardId") Integer boardId, HttpServletRequest request, HttpServletResponse response) {
        try {
            // 조회수 증가 여부 확인을 위한 쿠키 체크
            boolean isViewed = false;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("viewed_" + boardId)) {
                        isViewed = true;
                        break;
                    }
                }
            }

            // 조회수 증가 (쿠키가 없는 경우만)
            if (!isViewed) {
                boardService.increaseHits(boardId); // 조회수 증가
                Cookie newCookie = new Cookie("viewed_" + boardId, "true");
                newCookie.setMaxAge(24 * 60 * 60); // 1일간 유지
                response.addCookie(newCookie);
            }

            BoardDto board = boardService.get(boardId);
            String formattedDate = board.getBoardDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            model.addAttribute("board", board);
            model.addAttribute("formattedDate", formattedDate);
        } catch (Exception e) {
            log.error("게시글 상세 조회 실패", e);
        }
        model.addAttribute("center", "board/detail");
        return "board/detail";
    }

    /**
     * 게시글 삭제 요청 처리
     */
    @RequestMapping(value = "/delete/{boardId}", method = RequestMethod.POST)
    public String deleteBoard(@PathVariable("boardId") Integer boardId) {
        try {
            boardService.del(boardId);
            log.info("게시글 삭제 성공: {}", boardId);
        } catch (Exception e) {
            log.error("게시글 삭제 실패: {}", boardId, e);
        }
        return "redirect:/board";
    }

    /**
     * 수정 페이지로 이동
     */
    @RequestMapping(value = "/edit/{boardId}", method = RequestMethod.GET)
    public String editForm(@PathVariable("boardId") Integer boardId, Model model) {
        try {
            BoardDto board = boardService.get(boardId);
            model.addAttribute("boardDto", board);
        } catch (Exception e) {
            log.error("수정 페이지 로딩 실패", e);
        }
        model.addAttribute("center", dir + "edit");
        return dir + "edit";
    }

    /**
     * 수정 요청 처리 및 저장
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String updateBoard(@ModelAttribute BoardDto boardDto, HttpSession session) {
        try {
            // 게시글 작성자의 userId를 유지합니다.
            BoardDto existingBoard = boardService.get(boardDto.getBoardId());
            boardDto.setUserId(existingBoard.getUserId());

            // 로그인된 사용자와 게시글 작성자가 일치하는지 확인하는 로직 (나중에 사용 예정)
            /*
            String loginUserId = (String) session.getAttribute("loginid");
            if (!loginUserId.equals(existingBoard.getUserId())) {
                // 만약 로그인된 사용자와 게시글 작성자가 다르다면 수정 금지
                log.warn("수정 권한 없음: 로그인한 사용자와 작성자가 일치하지 않습니다.");
                return "redirect:/board/" + boardDto.getBoardId();
            }
            */

            boardService.modify(boardDto);
            log.info("게시글 수정 성공: {}", boardDto.getBoardId());
        } catch (Exception e) {
            log.error("게시글 수정 실패", e);
        }
        return "redirect:/board/" + boardDto.getBoardId();
    }
}
