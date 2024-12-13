package edu.sm.app.service;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class DoctorService implements SMService<String, DoctorDto> {

    final DoctorRepository doctorRepository;

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

    public List<DoctorDto> getDoctorList() throws Exception {
        // DB에서 의사 목록 조회
        List<DoctorDto> doctors = doctorRepository.select();

        // Doctor 객체를 DoctorDto로 변환하여 반환
        return doctors.stream()
                .map(doctor -> new DoctorDto(
                        doctor.getDoctorId(),
                        doctor.getDoctorPwd(),
                        doctor.getDoctorNumber(),
                        doctor.getImgName(),
                        doctor.getDoctorName(),
                        doctor.getDoctorAge(),
                        doctor.getDoctorEmail(),
                        doctor.getCareer(),
                        doctor.getAncestry(),
                        doctor.getSociety(),
                        doctor.getSubjectName()
                ))
                .collect(Collectors.toList());
    }


    // 특정 진료과에 맞는 의사 목록 조회
    public List<DoctorDto> getDoctorsBySubject(String subjectName) {
        return doctorRepository.serachSubjectName(subjectName);
    }

}
