package edu.sm.app.repository;


import edu.sm.app.dto.DoctorDto;
import edu.sm.app.frame.SMRepository;
import edu.sm.app.service.DoctorService;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface DoctorRepository extends SMRepository<String, DoctorDto> {
    List<DoctorDto> select(String name);

    List<DoctorDto> serachSubjectName(String subjectName);
}
