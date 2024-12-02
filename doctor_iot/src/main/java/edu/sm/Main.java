package edu.sm;

import edu.sm.util.HttpSendData;

import java.util.Random;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        String url = "http://127.0.0.1:81/iot/power";
        String data = "100.0";
        Random r = new Random();
        for (int i = 0; i < 100; i++) {
            float num = r.nextFloat() * 100;
            HttpSendData.send(url, num+"");
            try {
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }

        HttpSendData.send(url,data);
    }
}