package edu.sm.app.service;

import edu.sm.app.dto.CounselDto;
import edu.sm.app.frame.SMService;
import edu.sm.app.repository.CounselRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CounselService implements SMService< String, CounselDto> {
    private final CounselRepository counselRepository;
    @Override
    public void add(CounselDto counselDto) throws Exception {

    }

    @Override
    public void modify(CounselDto counselDto) throws Exception {

    }

    @Override
    public void del(String s) throws Exception {

    }

    @Override
    public CounselDto get(String s) throws Exception {
        return counselRepository.selectOne(s);
    }

    @Override
    public List<CounselDto> get() throws Exception {
        return List.of();
    }
}
