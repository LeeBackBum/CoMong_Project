package edu.sm.app.repository;


import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


@Repository
@Mapper
public interface UserRepository extends SMRepository<String, UserDto> {
}