package edu.sm.app.service;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DoctorService implements SMService<String, DoctorDto> {

    private final DoctorRepository doctorRepository;

    @Override
    public void add(DoctorDto doctorDto) throws Exception {
        doctorRepository.insert(doctorDto);
    }

    @Override
    public void modify(DoctorDto doctorDto) throws Exception {
        doctorRepository.update(doctorDto);
    }

    @Override
    public void del(String s) throws Exception {
        doctorRepository.delete(s);
    }

    @Override
    public DoctorDto get(String s) throws Exception {
        return doctorRepository.selectOne(s);
    }

    @Override
    public List<DoctorDto> get() throws Exception {
        return doctorRepository.select();
    }
}