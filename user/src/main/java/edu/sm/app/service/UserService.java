package edu.sm.app.service;

import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
    public UserDto get(String id) throws Exception {
        return userRepository.selectOne(id);
    }

    @Override
    public List<UserDto> get() throws Exception {
        return userRepository.select();
    }

    public void updatePwd(UserDto userDto) throws Exception {
        userRepository.updatePwd(userDto);
    }

    public List<UserDto> findById(String userId) throws Exception {
        return userRepository.findById(userId);
    }

    public UserDto authenticate(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }
}
