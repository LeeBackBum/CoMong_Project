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
import java.util.HashMap;
import java.util.Map;

public class ChatBotUtil {

    public static Map<String, String> getMsg(String apiUrl, String secretKey, String msg) throws Exception {
        Map<String, String> responseMap = new HashMap<>();
        URL url = new URL(apiUrl);
        String message = getReqMessage(msg);
        String encodeBase64String = makeSignature(message, secretKey);

        System.out.println("Request Message: " + message);
        System.out.println("Signature: " + encodeBase64String);

        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json;UTF-8");
        con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);
        con.setDoOutput(true);

        try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
            wr.write(message.getBytes("UTF-8"));
            wr.flush();
        }

        int responseCode = con.getResponseCode();
        System.out.println("Response Code: " + responseCode);

        if (responseCode == 200) { // 정상 호출
            try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                StringBuilder jsonString = new StringBuilder();
                String decodedString;
                while ((decodedString = in.readLine()) != null) {
                    jsonString.append(decodedString);
                }

                System.out.println("Response Body: " + jsonString);

                // JSON 응답 파싱
                JSONParser jsonParser = new JSONParser();
                JSONObject json = (JSONObject) jsonParser.parse(jsonString.toString());
                responseMap = parseChatbotResponse(json); // 응답 파싱
            }
        } else { // 에러 발생
            try (BufferedReader errorReader = new BufferedReader(new InputStreamReader(con.getErrorStream()))) {
                StringBuilder errorResponse = new StringBuilder();
                String line;
                while ((line = errorReader.readLine()) != null) {
                    errorResponse.append(line);
                }
                System.out.println("Error Response: " + errorResponse.toString());
                responseMap.put("description", null);
                responseMap.put("buttonTitle", null);
                responseMap.put("buttonUrl", null);
            }
        }

        return responseMap;
    }

    private static Map<String, String> parseChatbotResponse(JSONObject json) {
        Map<String, String> responseMap = new HashMap<>();
        responseMap.put("description", null);
        responseMap.put("buttonTitle", null);
        responseMap.put("buttonUrl", null);

        try {
            if (json.containsKey("bubbles")) {
                JSONArray bubblesArray = (JSONArray) json.get("bubbles");
                if (!bubblesArray.isEmpty()) {
                    JSONObject firstBubble = (JSONObject) bubblesArray.get(0); // 첫 번째 bubble
                    JSONObject data = (JSONObject) firstBubble.get("data");

                    // "description" 텍스트 추출
                    JSONObject cover = (JSONObject) data.get("cover");
                    JSONObject coverData = (JSONObject) cover.get("data");
                    responseMap.put("description", (String) coverData.get("description"));

                    // "contentTable" 확인 및 버튼 데이터 추출
                    if (data.containsKey("contentTable")) {
                        JSONArray contentTableArray = (JSONArray) data.get("contentTable");
                        if (!contentTableArray.isEmpty()) {
                            JSONArray buttonRow = (JSONArray) contentTableArray.get(0);
                            if (!buttonRow.isEmpty()) {
                                JSONObject button = (JSONObject) buttonRow.get(0);
                                JSONObject buttonData = (JSONObject) button.get("data");
                                responseMap.put("buttonTitle", (String) buttonData.get("title"));

                                // URL 추출
                                if (buttonData.containsKey("data")) { // 중첩된 data 객체 접근
                                    JSONObject nestedData = (JSONObject) buttonData.get("data");
                                    if (nestedData.containsKey("action")) {
                                        JSONObject action = (JSONObject) nestedData.get("action");
                                        if (action != null && action.containsKey("data")) {
                                            JSONObject actionData = (JSONObject) action.get("data");
                                            String url = (String) actionData.get("url");
                                            if (url != null && !url.isEmpty()) {
                                                responseMap.put("buttonUrl", url);
                                            } else {
                                                System.out.println("URL is null or empty in action data.");
                                            }
                                        } else {
                                            System.out.println("Action data is missing or null.");
                                        }
                                    } else {
                                        System.out.println("Action key is missing in nested data.");
                                    }
                                } else {
                                    System.out.println("Data key is missing in button data.");
                                }
                            } else {
                                System.out.println("Button Row is empty.");
                            }
                        } else {
                            System.out.println("Content Table Array is empty.");
                        }
                    } else {
                        System.out.println("Content Table key is missing.");
                    }
                } else {
                    System.out.println("Bubbles Array is empty.");
                }
            } else {
                System.out.println("Bubbles key is missing.");
            }
        } catch (Exception e) {
            System.out.println("Error while parsing chatbot response: " + e.getMessage());
            e.printStackTrace();
        }

        return responseMap;
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
