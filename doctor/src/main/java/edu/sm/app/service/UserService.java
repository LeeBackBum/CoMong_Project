package edu.sm.app.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import edu.sm.app.dto.AppointmentDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.core.annotation.MergedAnnotations;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService implements SMService<String, UserDto> {

    private final UserRepository userRepository;

    @Override
    public void add(UserDto userDto) throws Exception {
        userRepository.insert(userDto);
    }

    @Override
    public void modify(UserDto userDto) throws Exception {

    }

    @Override
    public void del(String s) throws Exception {

    }

    @Override
    public UserDto get(String s) throws Exception {
        return null;
    }

    @Override
    public List<UserDto> get() throws Exception {
        return List.of();
    }
    public Page<UserDto> getFindPage(int pageNo, MergedAnnotations.Search search) throws Exception {
        PageHelper.startPage(pageNo, 3);// 3: 한화면에 출력되는 개수
        return userRepository.getfindpage(search);
    }
    // 예약 및 상담 정보 조회
    public List<AppointmentDto> getAppointments(String doctorId,int pageNo) throws Exception {
        PageHelper.startPage(pageNo, 5);
        return userRepository.selectAppointments(doctorId);
    }


}
