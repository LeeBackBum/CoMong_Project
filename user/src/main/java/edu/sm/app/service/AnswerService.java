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
        answer.setAnswerDate(LocalDateTime.now()); // 현재 시간으로 설정
        answerRepository.insertAnswer(answer);
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
}
