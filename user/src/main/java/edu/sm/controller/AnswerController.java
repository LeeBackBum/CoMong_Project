package edu.sm.controller;

import edu.sm.app.dto.AnswerDto;
import edu.sm.app.service.AnswerService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/answers")
@RequiredArgsConstructor
public class AnswerController {

    private final AnswerService answerService;

    // 특정 게시글의 모든 댓글 조회 (페이지 리디렉션)
    @GetMapping("/board/{boardId}")
    public String getAnswersByBoardId(@PathVariable int boardId, Model model) {
        List<AnswerDto> answers = answerService.getAnswersByBoardId(boardId);
        model.addAttribute("answers", answers);
        return "board/detail"; // 댓글 리스트가 포함된 게시글 상세 페이지로 이동
    }

    // 댓글 추가
    @PostMapping("/board/{boardId}/add")
    public String addAnswer(@PathVariable int boardId,
                            @RequestParam("content") String content,
                            HttpSession session) {
        try {
            String userId = (String) session.getAttribute("loginid");
            AnswerDto answerDto = AnswerDto.builder()
                    .answerContent(content)
                    .boardId(boardId)
                    .userId(userId != null ? userId : "guestUser")
                    .answerDate(java.time.LocalDateTime.now())
                    .build();
            answerService.addAnswer(answerDto);
        } catch (Exception e) {
            log.error("댓글 작성 실패", e);
            return "redirect:/board/" + boardId + "?error=true";  // 에러 시 게시글 페이지로 리디렉션, 쿼리 파라미터로 에러 전달
        }
        return "redirect:/board/" + boardId;  // 댓글 작성 후 게시글 상세 페이지로 리디렉션
    }

    // 댓글 삭제
    @PostMapping("/delete/{answerId}")
    public String deleteAnswer(@PathVariable int answerId, @RequestParam int boardId) {
        try {
            answerService.deleteAnswer(answerId);
        } catch (Exception e) {
            log.error("댓글 삭제 실패", e);
            return "redirect:/board/" + boardId + "?error=true";  // 에러 시 게시글 페이지로 리디렉션, 쿼리 파라미터로 에러 전달
        }
        return "redirect:/board/" + boardId;  // 댓글 삭제 후 게시글 상세 페이지로 리디렉션
    }
}
