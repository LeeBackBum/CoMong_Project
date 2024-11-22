package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ManagerDto {
    private String managerId;
    private String managerPwd;
    private char role;
}
