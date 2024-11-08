package edu.sm.app.repository;

import edu.sm.app.dto.MedicalRecordsDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


@Repository
@Mapper
public interface MedicalRecordsRepository extends SMRepository<String, MedicalRecordsDto> {
}