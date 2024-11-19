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
    private String userSex;
    private String diseaseStatus;
    private String userNumber;

    public String getUserSex() {
        return userSex != null ? userSex.trim() : null;
    }

    public void setUserSex(String userSex) {
        this.userSex = userSex;
    }
}
