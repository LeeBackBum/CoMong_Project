package edu.sm.app.repository;

import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface UserRepository extends SMRepository <String, UserDto>{
    int updatePwd(UserDto user);
    List<UserDto> findById(String userId);
    UserDto findByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
}
