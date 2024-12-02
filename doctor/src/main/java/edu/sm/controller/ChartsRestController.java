package edu.sm.controller;

import com.opencsv.CSVReader;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.FileReader;

@RestController
@Slf4j
@RequestMapping("/charts")
public class ChartsRestController {

    @Value("${app.dir.readlogdir}")
    String readlogdir;

    @RequestMapping("/chart1")
    public Object chart1() throws Exception {
        String logfile = readlogdir+"power.log";

        JSONObject result = new JSONObject();

        //[{}]
        JSONArray jsonArray = new JSONArray();
        JSONObject jsonObject = new JSONObject();

        jsonObject.put("name", "Power");

        CSVReader reader = null;
        reader = new CSVReader(new FileReader(logfile));

        String [] lineData = null;
        JSONArray jsonArray1 = new JSONArray();
        JSONArray timeArray = new JSONArray();
        String endline = "";
        String endTime = "";
        while((lineData = reader.readNext()) != null){
            jsonArray1.add(Float.parseFloat(lineData[1]));
            timeArray.add(lineData[0]);
            endTime = lineData[0];
            endline = lineData[1];
        }

        jsonObject.put("data", jsonArray1);

        jsonArray.add(jsonObject);
        log.info(jsonArray.toJSONString());

        // [{}]
        // {'x':[], result:[{}]}
        result.put("result", jsonArray);
        result.put("x",timeArray );
        result.put("endtime",endTime );
        result.put("endline",Float.parseFloat(endline) );
        log.info(result.toJSONString());
        return result;
    }
}