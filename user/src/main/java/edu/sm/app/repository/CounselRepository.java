package edu.sm.app.repository;

import edu.sm.app.dto.CounselDto;
import edu.sm.app.dto.MedicalAppointmentDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface CounselRepository extends SMRepository<String, CounselDto> {

    List<CounselDto> findById(String userId);
}