package edu.sm.app.service;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.repository.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DoctorService {

    private final DoctorRepository doctorRepository;

    public void add(DoctorDto doctorDto) throws Exception {
        doctorRepository.insert(doctorDto);
    }

    public void modify(DoctorDto doctorDto) throws Exception {
        doctorRepository.update(doctorDto);
    }

    public void del(String doctorId) throws Exception {
        doctorRepository.delete(doctorId);
    }

    public DoctorDto get(String doctorId) throws Exception {
        return doctorRepository.selectOne(doctorId);
    }

    public List<DoctorDto> getAll() throws Exception {
        return doctorRepository.select();
    }



}
