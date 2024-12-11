package edu.sm.app.service;

import edu.sm.app.dto.DoctorDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
@RequiredArgsConstructor
public class DoctorService implements SMService<String, DoctorDto> {
    @Value("${app.dir.imgmypage}")
    private String imgmypage;

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

    public Resource loadAsResource(String fileName) throws Exception {
        try {
            Path filePath = Paths.get(imgmypage).resolve(fileName).normalize();
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists() && resource.isReadable()) {
                return resource;
            } else {
                throw new Exception("File not found: " + fileName);
            }
        } catch (Exception e) {
            throw new Exception("Could not load file as resource: " + fileName, e);
        }
    }
}