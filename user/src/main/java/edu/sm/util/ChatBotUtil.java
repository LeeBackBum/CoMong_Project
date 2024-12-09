package edu.sm.util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Date;

public class ChatBotUtil {

    public static String getMsg(String apiUrl, String secretKey, String msg) throws Exception {
        URL url = new URL(apiUrl);
        String chatMessage = msg;
        String message = getReqMessage(chatMessage);
        String encodeBase64String = makeSignature(message, secretKey);
        System.out.println("Request Message: " + message);
        System.out.println("Signature: " + encodeBase64String);

        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json;UTF-8");
        con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.write(message.getBytes("UTF-8"));
        wr.flush();
        wr.close();

        int responseCode = con.getResponseCode();
        System.out.println("Response Code: " + responseCode);

        if (responseCode == 200) { // 정상 호출
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder jsonString = new StringBuilder();
            String decodedString;
            while ((decodedString = in.readLine()) != null) {
                jsonString.append(decodedString);
            }
            in.close();

            System.out.println("Response Body: " + jsonString.toString());

            JSONParser jsonParser = new JSONParser();
            try {
                JSONObject json = (JSONObject) jsonParser.parse(jsonString.toString());
                if (json.containsKey("bubbles")) {
                    JSONArray bubblesArray = (JSONArray) json.get("bubbles");
                    if (!bubblesArray.isEmpty()) {
                        JSONObject bubbles = (JSONObject) bubblesArray.get(0);
                        if (bubbles.containsKey("data")) {
                            JSONObject data = (JSONObject) bubbles.get("data");
                            if (data.containsKey("description")) {
                                chatMessage = (String) data.get("description");
                            }
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("Error while parsing JSON response");
                e.printStackTrace();
            }
        } else { // 에러 발생
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            StringBuilder errorResponse = new StringBuilder();
            String line;
            while ((line = errorReader.readLine()) != null) {
                errorResponse.append(line);
            }
            errorReader.close();
            System.out.println("Error Response: " + errorResponse.toString());
            chatMessage = errorResponse.toString();
        }
        return chatMessage;
    }

    public static String getReqMessage(String voiceMessage) {
        String requestBody = "";
        try {
            JSONObject obj = new JSONObject();
            long timestamp = new Date().getTime();
            System.out.println("Timestamp: " + timestamp);

            obj.put("version", "v2");
            obj.put("userId", "U47b00b58c90f8e47428af8b7bddc1231heo2");
            obj.put("timestamp", timestamp);

            JSONObject bubblesObj = new JSONObject();
            bubblesObj.put("type", "text");

            JSONObject dataObj = new JSONObject();
            dataObj.put("description", voiceMessage);

            bubblesObj.put("data", dataObj);

            JSONArray bubblesArray = new JSONArray();
            bubblesArray.add(bubblesObj);

            obj.put("bubbles", bubblesArray);
            obj.put("event", "send");

            requestBody = obj.toString();
        } catch (Exception e) {
            System.out.println("Error while creating request message: " + e.getMessage());
        }
        return requestBody;
    }

    public static String makeSignature(String message, String secretKey) {
        String encodeBase64String = "";
        try {
            byte[] secretKeyBytes = secretKey.getBytes("UTF-8");
            SecretKeySpec signingKey = new SecretKeySpec(secretKeyBytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
        } catch (Exception e) {
            System.out.println("Error while creating signature: " + e.getMessage());
        }
        return encodeBase64String;
    }
}
