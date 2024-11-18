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

    // 특정 게시글의 모든 댓글 조회
    @GetMapping("/board/{boardId}")
    public String getAnswersByBoardId(@PathVariable int boardId, Model model) {
        try {
            List<AnswerDto> answers = answerService.getAnswersByBoardId(boardId);
            model.addAttribute("answers", answers);
        } catch (Exception e) {
            log.error("댓글 조회 실패: {}", e.getMessage(), e);
        }
        return "board/detail";
    }

    // 댓글 추가
    @PostMapping("/board/{boardId}/add")
    public String addAnswer(@PathVariable int boardId, @RequestParam("content") String content, HttpSession session) {
        try {
            String userId = (String) session.getAttribute("loginid");
            AnswerDto answerDto = AnswerDto.builder()
                    .answerContent(content)
                    .boardId(boardId)
                    .userId(userId != null ? userId : "guestUser")
                    .build();
            answerService.addAnswer(answerDto);
        } catch (Exception e) {
            log.error("댓글 작성 실패: {}", e.getMessage(), e);
            return "redirect:/board/" + boardId + "?error=true";
        }
        return "redirect:/board/" + boardId;
    }

    // 대댓글 추가
    @PostMapping("/reply/{parentAnswerId}")
    public String addReply(@PathVariable int parentAnswerId, @RequestParam("content") String content,
                           @RequestParam("boardId") int boardId, HttpSession session) {
        try {
            String userId = (String) session.getAttribute("loginid");
            AnswerDto replyDto = AnswerDto.builder()
                    .answerContent(content)
                    .boardId(boardId)
                    .userId(userId != null ? userId : "guestUser")
                    .parentAnswerId(parentAnswerId)
                    .build();
            answerService.addReply(replyDto, parentAnswerId);
        } catch (Exception e) {
            log.error("대댓글 작성 실패: {}", e.getMessage(), e);
            return "redirect:/board/" + boardId + "?error=true";
        }
        return "redirect:/board/" + boardId;
    }

    // 댓글 삭제
    @PostMapping("/delete/{answerId}")
    public String deleteAnswer(@PathVariable int answerId, @RequestParam int boardId) {
        try {
            answerService.deleteAnswer(answerId);
        } catch (Exception e) {
            log.error("댓글 삭제 실패: {}", e.getMessage(), e);
            return "redirect:/board/" + boardId + "?error=true";
        }
        return "redirect:/board/" + boardId;
    }

    // 댓글 수정
    @PostMapping("/edit/{answerId}")
    public String editAnswer(@PathVariable int answerId, @RequestParam("content") String content,
                             @RequestParam("boardId") int boardId) {
        try {
            AnswerDto answerDto = answerService.getAnswerById(answerId);
            if (answerDto != null) {
                answerDto.setAnswerContent(content);
                answerService.editAnswer(answerDto);
            }
        } catch (Exception e) {
            log.error("댓글 수정 실패: {}", e.getMessage(), e);
            return "redirect:/board/" + boardId + "?error=true";
        }
        return "redirect:/board/" + boardId + "#comment-" + answerId;
    }
}
