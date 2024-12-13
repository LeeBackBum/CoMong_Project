package edu.sm.app.service;

import edu.sm.app.dto.NoticeDto;
import edu.sm.app.repository.NoticeRepository;
import edu.sm.app.frame.SMService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NoticeService implements SMService<Integer, NoticeDto> {
    private final NoticeRepository noticeRepository;

    public NoticeService(NoticeRepository noticeRepository) {
        this.noticeRepository = noticeRepository;
    }

    @Override
    @Transactional
    public void add(NoticeDto noticeDto) throws Exception {
        noticeRepository.insert(noticeDto);
    }

    @Override
    @Transactional
    public void modify(NoticeDto noticeDto) throws Exception {
        noticeRepository.update(noticeDto);
    }

    @Override
    @Transactional
    public void del(Integer noticeId) throws Exception {
        noticeRepository.delete(noticeId);
    }

    @Override
    public NoticeDto get(Integer noticeId) throws Exception {
        return noticeRepository.selectOne(noticeId);
    }

    @Override
    public List<NoticeDto> get() throws Exception {
        return noticeRepository.select();
    }


    // 모든 공지사항 가져오기
    public List<NoticeDto> getAllNotices() throws Exception {
        return noticeRepository.selectAllNotices();
    }

}