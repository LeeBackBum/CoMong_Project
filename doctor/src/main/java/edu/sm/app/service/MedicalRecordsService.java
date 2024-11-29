package edu.sm.app.service;

import edu.sm.app.dto.MedicalRecordsDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.MedicalRecordsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MedicalRecordsService implements SMService<String, MedicalRecordsDto> {
    private final MedicalRecordsRepository medicalRecordsRepository;
    @Override
    public void add(MedicalRecordsDto medicalRecordsDto) throws Exception {

    }

    @Override
    public void modify(MedicalRecordsDto medicalRecordsDto) throws Exception {

    }

    @Override
    public void del(String s) throws Exception {

    }

    @Override
    public MedicalRecordsDto get(String s) throws Exception {
        return medicalRecordsRepository.selectOne(s);
    }

    @Override
    public List<MedicalRecordsDto> get() throws Exception {
        return List.of();
    }
}
