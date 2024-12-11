package edu.sm.app.service;

import com.github.pagehelper.PageHelper;
import edu.sm.app.dto.AppointmentDto;
import edu.sm.app.dto.CounselDto;
import edu.sm.app.dto.MedicalRecordsDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.util.List;

@Slf4j
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
        return userRepository.selectOne(s);
    }

    @Override
    public List<UserDto> get() throws Exception {
        return List.of();
    }
    // 예약 및 상담 정보 조회
    public List<AppointmentDto> getAppointments(int pageNo, String doctorId){
        PageHelper.startPage(pageNo, 10);// 3: 한화면에 출력되는 개수
        return userRepository.selectAppointments(doctorId);
    }

    public List<MedicalRecordsDto> getMedicalRecords(String userId){
        return userRepository.getMedicalRecords(userId);
    }
    public List<CounselDto> getCounsel(String userId){
        return userRepository.getCounsel(userId);
    }




}

