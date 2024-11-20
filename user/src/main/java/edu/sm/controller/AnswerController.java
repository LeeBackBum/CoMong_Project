package edu.sm.controller;

import edu.sm.app.dto.AnswerDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.AnswerService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
            log.info("댓글 목록 로드 완료: boardId={}, 댓글 수={}", boardId, answers.size());
        } catch (Exception e) {
            log.error("댓글 조회 실패: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "댓글을 로드하는 중 오류가 발생했습니다.");
        }
        return "board/detail";
    }

    // 댓글 추가
    @PostMapping("/board/{boardId}/add")
    public String addAnswer(@PathVariable int boardId, @RequestParam("content") String content, HttpSession session) {
        try {
            // 세션에서 UserDto 가져오기
            UserDto user = (UserDto) session.getAttribute("loginid");
            if (user == null) {
                log.warn("로그인 정보 없음: 댓글 작성 불가");
                return "redirect:/login?error=session_missing";
            }

            AnswerDto answerDto = AnswerDto.builder()
                    .answerContent(content)
                    .boardId(boardId)
                    .userId(user.getUserId())
                    .userName(user.getUserName())
                    .depth(0) // 댓글 기본 깊이
                    .build();

            log.info("댓글 작성 요청 데이터: {}", answerDto);
            answerService.addAnswer(answerDto);

        } catch (Exception e) {
            log.error("댓글 작성 중 오류 발생: {}", e.getMessage(), e);
            return "redirect:/board/" + boardId + "?error=true";
        }
        return "redirect:/board/" + boardId;
    }

    // 대댓글 추가
    @PostMapping("/reply/{parentAnswerId}")
    public String addReply(@PathVariable int parentAnswerId, @RequestParam("content") String content,
                           @RequestParam("boardId") int boardId, HttpSession session) {
        try {
            // 세션에서 UserDto 가져오기
            UserDto user = (UserDto) session.getAttribute("loginid");
            if (user == null) {
                log.warn("로그인 정보 없음: 대댓글 작성 불가");
                return "redirect:/login?error=not_logged_in";
            }

            // 부모 댓글 확인
            AnswerDto parentAnswer = answerService.getAnswerById(parentAnswerId);
            if (parentAnswer == null) {
                log.error("부모 댓글이 존재하지 않습니다: parentAnswerId={}", parentAnswerId);
                return "redirect:/board/" + boardId + "?error=true";
            }

            AnswerDto replyDto = AnswerDto.builder()
                    .answerContent(content)
                    .boardId(boardId)
                    .userId(user.getUserId())
                    .userName(user.getUserName())
                    .parentAnswerId(parentAnswerId)
                    .groupId(parentAnswer.getGroupId()) // 부모와 같은 그룹
                    .depth(parentAnswer.getDepth() + 1) // 부모 깊이에 +1
                    .build();

            log.info("대댓글 작성 요청 데이터: {}", replyDto);
            answerService.addReply(replyDto, parentAnswerId);

        } catch (Exception e) {
            log.error("대댓글 작성 중 오류 발생: {}", e.getMessage(), e);
            return "redirect:/board/" + boardId + "?error=true";
        }
        return "redirect:/board/" + boardId;
    }

    // 댓글 삭제
    @PostMapping("/delete/{answerId}")
    public String deleteAnswer(@PathVariable int answerId, @RequestParam int boardId) {
        try {
            answerService.deleteAnswer(answerId);
            log.info("댓글 삭제 성공: answerId={}", answerId);
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
                log.info("댓글 수정 성공: answerId={}", answerId);
            }
        } catch (Exception e) {
            log.error("댓글 수정 실패: {}", e.getMessage(), e);
            return "redirect:/board/" + boardId + "?error=true";
        }
        return "redirect:/board/" + boardId + "#comment-" + answerId;
    }

}
