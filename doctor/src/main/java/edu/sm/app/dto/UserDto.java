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
    private char userSex;               // 성별 (1: 남자, 0: 여자)
    private String diseaseStatus;       // 특이사항 (지병 정보 등)
    private String userNumber;
}
