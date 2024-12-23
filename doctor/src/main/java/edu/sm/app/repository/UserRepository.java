package edu.sm.app.repository;


import com.github.pagehelper.Page;
import edu.sm.app.dto.AppointmentDto;
import edu.sm.app.dto.CounselDto;
import edu.sm.app.dto.MedicalRecordsDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMRepository;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.core.annotation.MergedAnnotations;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
@Mapper
public interface UserRepository extends SMRepository<String, UserDto> {
    Page<UserDto> getfindpage(MergedAnnotations.Search search) throws Exception;
    // 예약 및 상담 정보 조회 메서드
    List<AppointmentDto> selectAppointments(String doctorId);
    List<MedicalRecordsDto> getMedicalRecords(String userId);
    List<CounselDto> getCounsel(String userId);
    List<AppointmentDto> dateAppointments(String doctorId, String date);
}