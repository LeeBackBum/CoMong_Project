package edu.sm.app.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
public class Msg {
    private String sendid;
    private String receiveid;
    private String content1;
    private String botResponse;
    private String buttonTitle;
    private String buttonUrl;

    @Override
    public String toString() {
        return "Msg{" +
                "sendid='" + sendid + '\'' +
                ", receiveid='" + receiveid + '\'' +
                ", content1='" + content1 + '\'' +
                ", botResponse='" + botResponse + '\'' +
                ", buttonTitle='" + buttonTitle + '\'' +
                ", buttonUrl='" + buttonUrl + '\'' +
                '}';
    }
}