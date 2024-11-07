package edu.sm.controller;

import edu.sm.app.dto.NoticeDto;
import edu.sm.app.service.NoticeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.time.format.DateTimeFormatter;

@Controller
@Slf4j
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeController {

    private final NoticeService noticeService;

    private final String dir = "notice/"; // JSP 파일 경로 기본 설정

    /**
     * 공지사항 상세 페이지
     * 특정 공지사항의 상세 정보를 조회하여 화면에 표시합니다.
     *
     * @param noticeId 조회할 공지사항의 ID
     */
    @RequestMapping(value = "/{noticeId}", method = RequestMethod.GET)
    public String detail(Model model, @PathVariable("noticeId") Integer noticeId) {
        try {
            NoticeDto notice = noticeService.get(noticeId); // 공지사항 조회
            // 작성일을 포맷팅하여 문자열로 변환
            String formattedDate = notice.getNoticeDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            model.addAttribute("notice", notice);
            model.addAttribute("formattedDate", formattedDate); // 포맷팅된 작성일 추가
        } catch (Exception e) {
            log.error("공지사항 상세 조회 실패", e);
        }
        model.addAttribute("center", dir + "detail");
        return dir + "detail";
    }
}
