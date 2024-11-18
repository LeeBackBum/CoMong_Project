package edu.sm.app.service;

import edu.sm.app.dto.AnswerDto;
import edu.sm.app.repository.AnswerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AnswerService {

    private final AnswerRepository answerRepository;

    public void addAnswer(AnswerDto answer) {
        answer.setAnswerDate(LocalDateTime.now());
        answer.setDepth(0);
        answerRepository.insertAnswer(answer);
        answer.setGroupId(answer.getAnswerId());
        answerRepository.updateGroupId(answer);
    }

    public void addReply(AnswerDto reply, int parentAnswerId) {
        AnswerDto parent = answerRepository.selectAnswerById(parentAnswerId);
        if (parent != null) {
            reply.setAnswerDate(LocalDateTime.now());
            reply.setGroupId(parent.getGroupId());
            reply.setDepth(parent.getDepth() + 1);
            answerRepository.insertReply(reply);
        }
    }

    public List<AnswerDto> getAnswersByBoardId(int boardId) {
        return answerRepository.selectAnswersByBoardId(boardId);
    }

    public void deleteAnswer(int answerId) {
        answerRepository.deleteAnswerById(answerId);
    }

    public AnswerDto getAnswerById(int answerId) {
        return answerRepository.selectAnswerById(answerId);
    }

    public void editAnswer(AnswerDto answer) {
        answerRepository.updateAnswer(answer);
    }
}
