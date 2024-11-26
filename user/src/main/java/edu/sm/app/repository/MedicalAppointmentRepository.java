package edu.sm.app.repository;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.dto.MedicalAppointmentDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface MedicalAppointmentRepository extends SMRepository<String, MedicalAppointmentDto> {
    void insert(MedicalAppointmentDto medicalAppointmentDto);
}
