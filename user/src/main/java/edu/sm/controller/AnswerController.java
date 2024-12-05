package edu.sm.controller;

import edu.sm.app.dto.AnswerDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.AnswerService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
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
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getAnswersByBoardId(@PathVariable int boardId) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<AnswerDto> answers = answerService.getAnswersByBoardId(boardId);
            response.put("answers", answers);
            response.put("status", "success");
            log.info("댓글 목록 로드 완료: boardId={}, 댓글 수={}", boardId, answers.size());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("댓글 조회 실패: {}", e.getMessage());
            response.put("status", "error");
            response.put("message", "댓글을 로드하는 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // 댓글 추가 시 작성 시간 포함
    @PostMapping("/board/{boardId}/add")
    @ResponseBody
    public Map<String, Object> addAnswerAjax(@PathVariable int boardId, @RequestParam("content") String content, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            UserDto user = (UserDto) session.getAttribute("loginid");
            if (user == null) {
                response.put("status", "error");
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            AnswerDto answerDto = AnswerDto.builder()
                    .answerContent(content)
                    .boardId(boardId)
                    .userId(user.getUserId())
                    .userName(user.getUserName())
                    .answerDate(LocalDateTime.now())
                    .build();

            answerService.addAnswer(answerDto);

            response.put("status", "success");
            response.put("answer", answerDto);

            // 서버에서 응답 데이터를 로그로 출력
            log.info("서버 응답 데이터: {}", response);

        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "댓글 추가 실패: " + e.getMessage());
            log.error("댓글 추가 중 오류 발생:", e);
        }
        return response;
    }
    //대댓글
    @PostMapping("/reply/{parentAnswerId}")
    @ResponseBody
    public Map<String, Object> addReplyAjax(@PathVariable int parentAnswerId, @RequestParam("content") String content,
                                            @RequestParam("boardId") int boardId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            UserDto user = (UserDto) session.getAttribute("loginid");
            if (user == null) {
                response.put("status", "error");
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            AnswerDto parentAnswer = answerService.getAnswerById(parentAnswerId);
            if (parentAnswer == null) {
                response.put("status", "error");
                response.put("message", "부모 댓글이 존재하지 않습니다.");
                return response;
            }

            AnswerDto replyDto = AnswerDto.builder()
                    .answerContent(content)
                    .boardId(boardId)
                    .userId(user.getUserId())
                    .userName(user.getUserName()) // 작성자 정보 추가
                    .parentAnswerId(parentAnswerId)
                    .groupId(parentAnswer.getGroupId())
                    .depth(parentAnswer.getDepth() + 1)
                    .answerDate(LocalDateTime.now())
                    .build();

            AnswerDto savedReply = answerService.addReply(replyDto, parentAnswerId);

            if (savedReply.getAnswerId() == 0) {
                throw new RuntimeException("대댓글 저장 실패: 생성된 ID가 유효하지 않음.");
            }

            response.put("status", "success");
            response.put("reply", savedReply);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "대댓글 추가 실패: " + e.getMessage());
            log.error("대댓글 추가 중 오류 발생:", e);
        }
        return response;
    }



    @PostMapping("/delete/{answerId}")
    @ResponseBody
    public Map<String, Object> deleteAnswerAjax(@PathVariable int answerId, @RequestParam int boardId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            UserDto user = (UserDto) session.getAttribute("loginid");

            // 댓글 객체를 삭제 직전에 재조회
            AnswerDto answer = answerService.getAnswerById(answerId);
            if (answer == null) {
                response.put("status", "error");
                response.put("message", "댓글이 이미 삭제되었거나 존재하지 않습니다.");
                return response;
            }

            // 삭제 권한 확인
            if (user == null || (!user.getUserId().equals(answer.getUserId()) && !"1".equals(user.getRole()))) {
                response.put("status", "error");
                response.put("message", "삭제 권한이 없습니다.");
                return response;
            }

            // 댓글 삭제
            answerService.deleteAnswer(answerId);

            // 삭제 후 최신 댓글 목록 가져오기
            List<AnswerDto> updatedAnswers = answerService.getAnswersByBoardId(boardId);

            log.info("삭제 후 남은 댓글 수: {}", updatedAnswers.size());

            response.put("status", "success");
            response.put("answers", updatedAnswers); // 최신 댓글 목록 반환
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "댓글 삭제 실패: " + e.getMessage());
            log.error("댓글 삭제 중 오류 발생:", e);
        }
        return response;
    }




    @PostMapping("/edit/{answerId}")
    @ResponseBody
    public Map<String, Object> editAnswerAjax(@PathVariable int answerId, @RequestParam("content") String content, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            UserDto user = (UserDto) session.getAttribute("loginid");
            if (user == null) {
                response.put("status", "error");
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            AnswerDto answer = answerService.getAnswerById(answerId);
            if (answer == null) {
                response.put("status", "error");
                response.put("message", "댓글이 존재하지 않습니다.");
                return response;
            }

            if (!user.getUserId().equals(answer.getUserId()) && !"1".equals(user.getRole())) {
                response.put("status", "error");
                response.put("message", "수정 권한이 없습니다.");
                return response;
            }

            // 댓글 내용 수정
            answer.setAnswerContent(content);
            answerService.editAnswer(answer);

            // 수정 후 최신 데이터 반환
            AnswerDto updatedAnswer = answerService.getAnswerById(answerId); // 작성자 포함 데이터
            response.put("status", "success");
            response.put("answer", updatedAnswer); // 수정된 댓글 데이터를 반환
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "댓글 수정 실패: " + e.getMessage());
        }
        return response;
    }








    // 권한 확인 메서드
    private boolean hasPermission(UserDto user, AnswerDto answer) {
        return user != null && (user.getUserId().equals(answer.getUserId()) || "1".equals(user.getRole()));
    }

}
