package edu.sm.controller;

import edu.sm.app.dto.NoticeDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.service.NoticeService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
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
     */
    @GetMapping("/{noticeId}")
    public String detail(Model model, @PathVariable("noticeId") Integer noticeId) {
        try {
            NoticeDto notice = noticeService.get(noticeId);
            if (notice == null) {
                log.warn("존재하지 않는 공지사항: noticeId={}", noticeId);
                return "redirect:/board?error=not_found";
            }
            String formattedDate = notice.getNoticeDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            model.addAttribute("notice", notice);
            model.addAttribute("formattedDate", formattedDate);
        } catch (Exception e) {
            log.error("공지사항 상세 조회 실패: {}", e.getMessage(), e);
            return "redirect:/board?error=exception";
        }

        model.addAttribute("center", dir + "detail");
        return "index";
    }

    @GetMapping("/write")
    public String noticeWriteForm(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("loginid");
        if (user == null || !"1".equals(user.getRole())) {
            log.warn("공지사항 작성 권한 없음");
            return "redirect:/board?error=unauthorized";
        }
        model.addAttribute("center", dir + "write");
        return "index";
    }

    @PostMapping("/write")
    public String saveNotice(@ModelAttribute NoticeDto noticeDto, HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("loginid");
        if (user == null || !"1".equals(user.getRole())) {
            log.warn("공지사항 작성 권한 없음");
            return "redirect:/board?error=unauthorized";
        }
        try {
            noticeDto.setUserId(user.getUserId());
            noticeDto.setUserName(user.getUserName());
            noticeDto.setNoticeDate(LocalDateTime.now()); // 현재 시간을 작성일로 설정
            noticeService.add(noticeDto);
            log.info("공지사항 작성 성공: {}", noticeDto.getNoticeTitle());
        } catch (Exception e) {
            log.error("공지사항 작성 실패: {}", e.getMessage());
            model.addAttribute("errorMessage", "공지사항 작성 중 오류가 발생했습니다. 다시 시도해주세요.");
            model.addAttribute("center", dir + "write");
            return "index";
        }
        return "redirect:/board";
    }
    @PostMapping("/delete/{noticeId}")
    public String deleteNotice(@PathVariable Integer noticeId, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("loginid");
        if (user == null || !"1".equals(user.getRole())) {
            log.warn("공지사항 삭제 권한 없음");
            return "redirect:/board?error=unauthorized";
        }
        try {
            noticeService.del(noticeId);
            log.info("공지사항 삭제 성공: noticeId={}", noticeId);
        } catch (Exception e) {
            log.error("공지사항 삭제 실패: {}", e.getMessage());
            return "redirect:/board?error=exception";
        }
        return "redirect:/board";
    }

    // 수정 페이지 이동 (GET)
    @GetMapping("/edit/{noticeId}")
    public String editNoticeForm(@PathVariable Integer noticeId, HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("loginid");
        if (user == null || !"1".equals(user.getRole())) {
            log.warn("공지사항 수정 권한 없음");
            return "redirect:/board?error=unauthorized";
        }

        try {
            NoticeDto notice = noticeService.get(noticeId);
            if (notice == null) {
                log.warn("존재하지 않는 공지사항: noticeId={}", noticeId);
                return "redirect:/board?error=not_found";
            }
            model.addAttribute("notice", notice);
            model.addAttribute("center", dir + "edit"); // 수정 페이지 JSP 설정
        } catch (Exception e) {
            log.error("공지사항 수정 페이지 로딩 실패: {}", e.getMessage());
            return "redirect:/board?error=exception";
        }
        return "index";
    }

    // 수정 처리 (POST)
    @PostMapping("/edit/{noticeId}")
    public String updateNotice(@PathVariable Integer noticeId, @ModelAttribute NoticeDto noticeDto, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("loginid");
        if (user == null || !"1".equals(user.getRole())) {
            log.warn("공지사항 수정 권한 없음");
            return "redirect:/board?error=unauthorized";
        }

        try {
            // 기존 공지사항 가져오기
            NoticeDto existingNotice = noticeService.get(noticeId);
            if (existingNotice == null) {
                log.warn("존재하지 않는 공지사항: noticeId={}", noticeId);
                return "redirect:/board?error=not_found";
            }

            // 기존 작성자와 작성시간 유지
            noticeDto.setUserId(existingNotice.getUserId());
            noticeDto.setUserName(existingNotice.getUserName());
            noticeDto.setNoticeDate(existingNotice.getNoticeDate());
            noticeDto.setNoticeId(noticeId); // 수정할 공지 ID 설정

            // 수정 처리
            noticeService.modify(noticeDto);
            log.info("공지사항 수정 성공: {}", noticeDto.getNoticeTitle());
        } catch (Exception e) {
            log.error("공지사항 수정 실패: {}", e.getMessage());
            return "redirect:/board?error=exception";
        }
        return "redirect:/notice/" + noticeId; // 수정 완료 후 상세 페이지로 리다이렉트
    }

}
