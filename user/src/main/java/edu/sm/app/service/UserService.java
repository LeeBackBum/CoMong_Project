package edu.sm.app.service;

import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService implements SMService<String, UserDto> {

    final UserRepository userRepository;


    @Override
    public void add(UserDto userDto) throws Exception {
        userRepository.insert(userDto);
    }

    @Override
    public void modify(UserDto userDto) throws Exception {
        userRepository.update(userDto);
    }

    @Override
    public void del(String s) throws Exception {
        userRepository.delete(s);
    }

    @Override
    public UserDto get(String s) throws Exception {
        return userRepository.selectOne(s);
    }

    @Override
    public List<UserDto> get() throws Exception {
        return userRepository.select();
    }

    public void updatePwd(UserDto userDto) throws Exception {
        userRepository.updatePwd(userDto);
    }
    public UserDto authenticate(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }
}
