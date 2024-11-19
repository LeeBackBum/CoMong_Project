package edu.sm.app.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder

public class UserDto {
    private String userId;
    private String userPwd;
    private String userEmail;
    private String userName;
    private String userAddress;
    private String userAge;
    private char userSex;
    private String diseaseStatus;
    private String userNumber;
}
