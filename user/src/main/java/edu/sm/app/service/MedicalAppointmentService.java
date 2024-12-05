package edu.sm.app.service;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.dto.MedicalAppointmentDto;
import edu.sm.app.dto.UserDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.MedicalAppointmentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
@RequiredArgsConstructor
public class MedicalAppointmentService implements SMService<String, MedicalAppointmentDto> {

    private final MedicalAppointmentRepository medicalAppointmentrepository;

    @Override
    public void add(MedicalAppointmentDto medicalAppointmentDto) throws Exception {
        System.out.println("Saving appointment: " + medicalAppointmentDto); // 디버깅
        medicalAppointmentrepository.insert(medicalAppointmentDto);
    }

    @Override
    public void modify(MedicalAppointmentDto medicalAppointmentDto) throws Exception {
        medicalAppointmentrepository.update(medicalAppointmentDto);
    }

    @Override
    public void del(String s) throws Exception {
        medicalAppointmentrepository.delete(s);
    }

    @Override
    public MedicalAppointmentDto get(String s) throws Exception {
        return medicalAppointmentrepository.selectOne(s);
    }

    @Override
    public List<MedicalAppointmentDto> get() throws Exception {
        return medicalAppointmentrepository.select();
    }

    public List<MedicalAppointmentDto> findById(String userId) throws Exception {
        return medicalAppointmentrepository.findById(userId);
    }

}
