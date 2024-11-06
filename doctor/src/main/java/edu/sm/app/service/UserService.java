package edu.sm.app.service;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService implements SMService<String, UserDto> {

    private final DoctorRepository userRepository;

    @Override
    public void add(UserDto userDto) throws Exception {

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
}
