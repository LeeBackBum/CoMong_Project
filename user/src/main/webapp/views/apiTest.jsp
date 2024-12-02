
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>API 데이터 표시</title>
</head>
<body>
<h1>병원 위치 정보</h1>
<!-- 위도, 경도 정보를 표시할 div 추가 -->
<div id="result"></div>

<script>
    var xhr = new XMLHttpRequest();
    var url = 'http://apis.data.go.kr/B552657/ErmctInfoInqireService/getEgytLcinfoInqire'; /*URL*/
    var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'ymM0cegTHI9EEDldHJd0Bk1pFJ7Is8b%2B9qmZ8zQMpMLLoZI9B2zPT0rwSX6dOvLI0736SD4F6yOn0vXUg9OKiw%3D%3D'; /*Service Key*/
    queryParams += '&' + encodeURIComponent('WGS84_LON') + '=' + encodeURIComponent('127.075732161892'); /*경도*/
    queryParams += '&' + encodeURIComponent('WGS84_LAT') + '=' + encodeURIComponent('36.8010404471004'); /*위도*/
    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /*페이지 번호*/
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /*목록 건수*/

    // API 요청
    xhr.open('GET', url + queryParams);
    xhr.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            // 응답이 XML 형식이므로, XML 파서 사용
            var parser = new DOMParser();
            var xmlDoc = parser.parseFromString(this.responseText, "text/xml");

            // XML에서 latitude와 longitude 추출
            var items = xmlDoc.getElementsByTagName('item');
            var resultDiv = document.getElementById('result');

            // 응답 내용 확인을 위한 디버깅
            console.log("응답 XML:", this.responseText); // 응답 전체 확인
            console.log("items 길이:", items.length); // items 배열 길이 확인

            if (items.length > 0) {
                var latitude = items[0].getElementsByTagName('latitude')[0].textContent;
                var longitude = items[0].getElementsByTagName('longitude')[0].textContent;

                // HTML에 위도와 경도 표시
                resultDiv.innerHTML = "<p>위도: " + latitude + "</p><p>경도: " + longitude + "</p>";
            } else {
                // 데이터가 없을 때
                resultDiv.innerHTML = "데이터가 없습니다.";
            }
        } else if (this.readyState == 4 && this.status != 200) {
            // 에러 발생 시 처리
            document.getElementById('result').innerHTML = "API 요청 실패: " + this.status;
        }
    };
    xhr.send('');
</script>
</body>
</html>