package edu.sm;

import edu.sm.util.HttpSendData;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class Main {
    public static void main(String[] args) {
        Random random = new Random();

        // 각 데이터 타입에 대한 URL 설정
        String bloodPressureUrl = "http://127.0.0.1:81/iot/bloodPressure";
        String bloodSugarUrl = "http://127.0.0.1:81/iot/bloodSugar";
        String depressionScoreUrl = "http://127.0.0.1:81/iot/depressionScore";
        String randomNumberUrl = "http://127.0.0.1:81/iot/power";

        // 날짜 설정: 2024년 1월 1일 22시
        Calendar calendar = Calendar.getInstance();
        calendar.set(2024, Calendar.JANUARY, 1, 22, 0, 0);
        String formattedDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTime());

        // 혈압, 혈당, 우울증 점수 데이터를 한번만 전송
        sendDataOnce(bloodPressureUrl, bloodSugarUrl, depressionScoreUrl, random, formattedDate);

        // 랜덤 숫자 데이터를 5초마다 전송
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        scheduler.scheduleAtFixedRate(() -> {
            int randomNumber = 1 + random.nextInt(170);
            HttpSendData.send(randomNumberUrl, String.valueOf(randomNumber));
        }, 0, 1, TimeUnit.SECONDS);
    }

    private static void sendDataOnce(String bloodPressureUrl, String bloodSugarUrl,
                                     String depressionScoreUrl, Random random,
                                     String formattedDate) {
        // 혈압 데이터 (90 ~ 180)
        float bloodPressure = 90 + random.nextFloat() * (180 - 90);
        HttpSendData.send(bloodPressureUrl, formattedDate + ", " + bloodPressure);

        // 혈당 데이터 (50 ~ 150)
        float bloodSugar = 50 + random.nextFloat() * (150 - 50);
        HttpSendData.send(bloodSugarUrl, formattedDate + ", " + bloodSugar);

        // 우울증 점수 (0 ~ 100)
        float depressionScore = random.nextFloat() * 100;
        HttpSendData.send(depressionScoreUrl, formattedDate + ", " + depressionScore);
    }
}