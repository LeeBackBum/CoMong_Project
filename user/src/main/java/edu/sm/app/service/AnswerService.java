package edu.sm.app.service;

import edu.sm.app.dto.AnswerDto;
import edu.sm.app.repository.AnswerRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
@Slf4j
@Service
@RequiredArgsConstructor
public class AnswerService {

    private final AnswerRepository answerRepository;

    public void addAnswer(AnswerDto answer) {
        try {
            answer.setAnswerDate(LocalDateTime.now());
            answer.setDepth(0); // 댓글 깊이 설정
            answerRepository.insertAnswer(answer);

            // 그룹 ID 설정
            answer.setGroupId(answer.getAnswerId());
            answerRepository.updateGroupId(answer);

            log.info("댓글 저장 성공: {}", answer);
        } catch (Exception e) {
            log.error("댓글 저장 실패: {}", e.getMessage(), e);
            throw e;
        }
    }

    public AnswerDto addReply(AnswerDto reply, int parentAnswerId) {
        try {
            AnswerDto parent = answerRepository.selectAnswerById(parentAnswerId);
            if (parent == null) {
                throw new IllegalArgumentException("부모 댓글이 존재하지 않습니다: parentAnswerId=" + parentAnswerId);
            }

            reply.setAnswerDate(LocalDateTime.now());
            reply.setGroupId(parent.getGroupId()); // 그룹 ID는 부모와 동일
            reply.setDepth(parent.getDepth() + 1); // 깊이는 부모 + 1

            // 대댓글 저장
            answerRepository.insertReply(reply);

            if (reply.getAnswerId() == 0) {
                throw new RuntimeException("대댓글 저장 실패: 생성된 ID가 유효하지 않음.");
            }

            log.info("대댓글 저장 성공: {}", reply);
            return reply; // 저장된 대댓글 반환
        } catch (Exception e) {
            log.error("대댓글 저장 실패: {}", e.getMessage(), e);
            throw e;
        }
    }

    public List<AnswerDto> getAnswersByBoardId(int boardId) {
        return answerRepository.selectAnswersByBoardId(boardId);
    }

    public void deleteAnswer(int answerId) {
        AnswerDto answer = answerRepository.selectAnswerById(answerId);
        if (answer == null) {
            throw new IllegalArgumentException("삭제하려는 댓글이 존재하지 않습니다. answerId=" + answerId);
        }
        answerRepository.deleteAnswerById(answerId);
    }

    public AnswerDto getAnswerById(int answerId) {
        return answerRepository.selectAnswerById(answerId);
    }

    public void editAnswer(AnswerDto answer) {
        answer.setAnswerDate(LocalDateTime.now());
        answerRepository.updateAnswer(answer);
    }
}