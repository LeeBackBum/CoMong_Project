package edu.sm.app.service;

import edu.sm.app.dto.AdminDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.AdminRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminService implements SMService<String, AdminDto> {

    private final AdminRepository adminRepository;

    @Override
    public void add(AdminDto adminDto) throws Exception {

    }

    @Override
    public void del(String s) throws Exception {

    }

    @Override
    public void modify(AdminDto adminDto) throws Exception {

    }

    @Override
    public AdminDto get(String s) throws Exception {
        return adminRepository.selectOne(s);
    }

    @Override
    public List<AdminDto> get() throws Exception {
        return adminRepository.select();
    }
}
