<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    let center = {
        init:function(){
            <%--$.ajax({--%>
            <%--    url:'<c:url value="/hpdataload"/>',--%>
            <%--    success:(result)=>{--%>
            <%--        let wtext = result.response.body.items.item[0].wfSv;--%>
            <%--        $('#hpdataload').text(wtext);--%>
            <%--    }--%>
            <%--});--%>
            $.ajax({
                url:'<c:url value="/hpdataload"/>',
                success:(result)=>{
                    console.log("응답받은 데이터 입니다."+ result)
                    let icon = result.weather[0].icon;
                    let temp = result.main.temp;

                    let url = 'https://openweathermap.org/img/wn/'+icon+'@2x.png';
                    let resultHtml = '<img src="'+url+'">';
                    resultHtml += '<h3>'+temp+'<h3>';
                    $('#hpdataload').html(resultHtml);

                }
            });
            $.ajax({
                url:'<c:url value="/hpdataload"/>', // JSON 형식으로 요청
                method: 'GET',
                success: function (data) {
                    try {
                        // JSON 데이터인지 확인
                        if (typeof data === 'object') {
                            console.log(data.response.body.items[0]);
                        } else {
                            console.warn("API 응답이 JSON이 아닙니다.");
                        }
                    } catch (error) {
                        console.error("JSON 파싱 오류:", error);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("AJAX 요청 실패");
                    console.error("응답 상태:", status);
                    console.error("오류 메시지:", xhr.responseText);
                }
            });



        }
    };
    $(function(){
        center.init();
    });
</script>

<div class="col-sm-10">

    <h2>TITLE HEADING</h2>
    <h5>공공데이터 요청 테스트</h5>
    <p id="hpdataload2"></p>
    <div id="hpdataload"></div>
</div>