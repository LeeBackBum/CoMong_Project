package edu.sm.app.repository;

import edu.sm.app.dto.NoticeDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface NoticeRepository extends SMRepository<Integer, NoticeDto> {

    // 모든 공지사항 가져오기
    List<NoticeDto> selectAllNotices();
}
