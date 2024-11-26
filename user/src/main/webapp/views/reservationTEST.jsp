<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>eLEARNING - eLearning HTML Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="<c:url value="/img/favicon.ico"/>" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">


    <!-- Libraries Stylesheet -->
    <link href="<c:url value="/lib/animate/animate.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/lib/owlcarousel/assets/owl.carousel.min.css"/>" rel="stylesheet">

    <%-- 틀--%>
    <!-- Customized Bootstrap Stylesheet -->
    <link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/css/contents.css"/>" rel="stylesheet">
    <!-- Template Stylesheet -->
    <link href="<c:url value="/css/style.css"/>" rel="stylesheet">
    <%--틀 끝--%>
</head>

<body>


<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Title</title>
    <style>
        table {border-collapse: collapse;}
        td {border: 1px solid gray; padding: 3px;}
        thead {background-color: #dde0e3; font-weight: bold; }

    </style>
    <script>

        function resetDoctor(id) {
            console.log("받은 id:", id);

            // 먼저 input 요소를 찾고, 그 후 부모 요소로부터 label을 찾습니다.
            const inputElement = document.getElementById(id);
            if (!inputElement) {
                console.error(`input 요소를 찾을 수 없습니다. id="${id}"`);
                return;
            }

            // input과 연관된 label 찾기
            const labelElement = inputElement.nextElementSibling; // input 뒤에 위치한 label을 찾아냄
            if (!labelElement || labelElement.tagName !== "LABEL") {
                console.error(`연관된 label을 찾을 수 없습니다.`);
                return;
            }

            console.log("선택된 라벨:", labelElement);
            const subjectName = labelElement.textContent.trim();
            if (!subjectName) {
                console.error("라벨에서 진료과 이름을 가져오지 못했습니다.");
                return;
            }

            const url = "/testdo2?subjectName=" + encodeURIComponent(subjectName);
            fetch(url, { method: "GET" })
                .then(response => response.text())
                .then(html => {
                    const doctorListArea = document.querySelector(".doctor-list-area");
                    if (doctorListArea) {
                        doctorListArea.innerHTML = html;
                    } else {
                        console.error("doctor-list-area를 찾을 수 없습니다.");
                    }
                })
                .catch(error => console.error("Error fetching the JSP content:", error));
        }

        function get_minutes() {
            // 시와 분 값을 가져오기
            var hour = document.getElementById("times1").value;
            var minute = document.getElementById("times2").value;

            // 값이 없을 경우 (선택하지 않은 경우 처리)
            if (hour === "" || minute === "") {
                console.log("시 또는 분이 선택되지 않았습니다.");
                return;
            }

            // 선택한 시와 분을 결합하여 출력
            var time = hour + ":" + minute;

            // 시간 정보를 콘솔에 출력 (여기서는 콘솔 출력 예시)
            console.log("선택한 시간은: " + time);

            // 선택된 시간 정보를 다른 곳에 표시하거나 다른 작업을 할 수 있습니다.
            // 예를 들어, div에 표시
            document.getElementById("selected_time").innerText = "선택한 시간: " + time;
        }


        function submitAction() {
            const name = document.getElementById('reservName').value.trim();
            const hour = document.getElementById('times1').value;
            const minute = document.getElementById('times2').value;
            const reservGubun_1 = document.getElementById('reservGubun_1').value;
            const reservGubun_2 = document.getElementById('reservGubun_2').value;

            if (!name || !hour || !minute || !reservGubun_1 || !reservGubun_2) {
                alert("모든 필수 정보를 입력해주세요.");
                return;
            }

            // 날짜 계산
            const today = new Date().toISOString().split('T')[0];

            const data = {
                name: name,
                time: `${hour}:${minute}`,
                reservGubun: { reservGubun_1, reservGubun_2 },
                appointment_date: today, // 서버에 전송할 날짜
            };

            fetch('/submitReservation', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data),
            })
                .then((response) => response.json())
                .then((result) => {
                    if (result.success) {
                        alert("예약이 성공적으로 접수되었습니다.");
                    } else {
                        alert("예약 접수 중 문제가 발생했습니다.");
                    }
                })
                .catch((error) => {
                    console.error("Error:", error);
                    alert("서버와의 통신 중 문제가 발생했습니다.");
                    console.log(data);
                });
        }





    </script>
</head>

<body>
<div class="reservation-area01 mgt10">
    <div class="reservation-box choise01">
        <h2>01. 진료과 선택</h2>
        <div class="type-reservation-choise mCustomScrollbar _mCS_1 mCS-autoHide mCS_no_scrollbar" style="position: relative; overflow: visible;"><div id="mCSB_1" class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside" style="max-height: none;" tabindex="0"><div id="mCSB_1_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
            <div class="dept-list-area" id="dept-list-area">
                <p>
                    <input type="radio" id="radio0101" name="wr_4" class="step01" value=0101 onclick="resetDoctor(id)" checked="">
                    <label for="radio0101">내과</label>
                    <input type="hidden" id="step01_cat01" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio0102" name="wr_4" class="step01" value="26" onclick="resetDoctor(id)">
                    <label for="radio0102">
                        외과</label>
                    <input type="hidden" id="step01_cat02" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio0103" name="wr_4" class="step01" value="27" onclick="resetDoctor(id)">
                    <label for="radio0103">
                        소화기내과</label>
                    <input type="hidden" id="step01_cat03" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio0104" name="wr_4" class="step01" value="28" onclick="resetDoctor(id)">
                    <label for="radio0104">
                        순환기내과</label>
                    <input type="hidden" id="step01_cat04" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio0105" name="wr_4" class="step01" value="29" onclick="resetDoctor(id)">
                    <label for="radio0105">
                        신장내과</label>
                    <input type="hidden" id="step01_cat05" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>





                <p>
                    <input type="radio" id="radio0108" name="wr_4" class="step01" value="5" onclick="resetDoctor(id)">
                    <label for="radio0108">
                        비뇨의학과</label>
                    <input type="hidden" id="step01_cat08" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio0109" name="wr_4" class="step01" value="6" onclick="resetDoctor(id)">
                    <label for="radio0109">
                        산부인과</label>
                    <input type="hidden" id="step01_cat09" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio01010" name="wr_4" class="step01" value="7" onclick="resetDoctor(id)">
                    <label for="radio01010">
                        소아청소년과</label>
                    <input type="hidden" id="step01_cat010" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio01011" name="wr_4" class="step01" value="8" onclick="resetDoctor(id)">
                    <label for="radio01011">
                        신경과</label>
                    <input type="hidden" id="step01_cat011" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio01012" name="wr_4" class="step01" value="9" onclick="resetDoctor(id)">
                    <label for="radio01012">
                        신경외과</label>
                    <input type="hidden" id="step01_cat012" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>

                <p>
                    <input type="radio" id="radio01013" name="wr_4" class="step01" value="19" onclick="resetDoctor(id)">
                    <label for="radio01013">
                        심장혈관흉부외과</label>
                    <input type="hidden" id="step01_cat013" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>


                <p>
                    <input type="radio" id="radio01014" name="wr_4" class="step01" value="13" onclick="resetDoctor(id)">
                    <label for="radio01014">
                        이비인후과</label>
                    <input type="hidden" id="step01_cat020" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>



                <p>
                    <input type="radio" id="radio01015" name="wr_4" class="step01" value="16" onclick="resetDoctor(id)">
                    <label for="radio01015">
                        정형외과</label>
                    <input type="hidden" id="step01_cat022" class="step01_cat" name="step01_cat" value="GANGAN_MEDICAL_DEPT">
                    <span style="color:red; font-size:12px; "></span>
                </p>



            </div>
        </div></div><div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 50px; height: 0px; top: 0px;"><div class="mCSB_dragger_bar" style="line-height: 50px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div>
        <!--모바일-->
        <div class="M_select">
            <label for="select01" class="blind">선택</label>
            <select title="검색조건 선택" id="select01" class="select01">
                <!-- <option value="">분류선택</option> -->
                <option value="1" selected="" cat="GANGAN_MEDICAL_DEPT">가정의학과</option>
                <option value="26" cat="GANGAN_MEDICAL_DEPT">내분비내과</option>
                <option value="27" cat="GANGAN_MEDICAL_DEPT">소화기내과</option>
                <option value="28" cat="GANGAN_MEDICAL_DEPT">순환기내과</option>
                <option value="29" cat="GANGAN_MEDICAL_DEPT">신장내과</option>
                <option value="5" cat="GANGAN_MEDICAL_DEPT">비뇨의학과</option>
                <option value="6" cat="GANGAN_MEDICAL_DEPT">산부인과</option>
                <option value="8" cat="GANGAN_MEDICAL_DEPT">신경과</option>
                <option value="9" cat="GANGAN_MEDICAL_DEPT">신경외과</option>
                <option value="12" cat="GANGAN_MEDICAL_DEPT">외과</option>
                <option value="13" cat="GANGAN_MEDICAL_DEPT">이비인후과</option>

            </select>
        </div>
        <!--//모바일-->
    </div>

    <div class="reservation-box choise02">
        <h2>02. 의료진 선택</h2>
        <div class="doctor-list-wrapper mCustomScrollbar _mCS_2 mCS-autoHide mCS_no_scrollbar" style="position: relative; overflow: visible;">
            <div id="mCSB_2" class="mCustomScrollBox mCS-minimal-dark mCSB_vertical mCSB_outside" tabindex="0" style="max-height: none;">
                <div id="mCSB_2_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
                        <div class="doctor-list-area">

<%--                            ------------------.의사 정보 추가--------------------%>
                        </div>
        </div>
            </div>
            <div id="mCSB_2_scrollbar_vertical" class="mCSB_scrollTools mCSB_2_scrollbar mCS-minimal-dark mCSB_scrollTools_vertical" style="display: none;">
                <div class="mCSB_draggerContainer"><div id="mCSB_2_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 50px; height: 0px; top: 0px;">
                    <div class="mCSB_dragger_bar" style="line-height: 50px;"></div></div><div class="mCSB_draggerRail">
                </div>
                </div>
            </div>
        </div>
    </div>

    <div class="reservation-box choise03">
        <h2>03. 예약 날짜/시간 선택</h2>

        <div class="schdule-information-area">
            <div id="datepicker" style="margin-bottom:10px;" class="hasDatepicker">
                <div class="ui-datepicker-inline ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" style="display: block;">
                    <div class="ui-datepicker-header ui-widget-header ui-helper-clearfix ui-corner-all">
                        <a class="ui-datepicker-prev ui-corner-all ui-state-disabled" title="이전달">
                        <span class="ui-icon ui-icon-circle-triangle-w">이전달</span></a>
                        <a class="ui-datepicker-next ui-corner-all" data-handler="next" data-event="click" title="다음달">
                        <span class="ui-icon ui-icon-circle-triangle-e">다음달</span></a>
                        <div class="ui-datepicker-title">
                        <span class="ui-datepicker-year">2024</span>년&nbsp;<span class="ui-datepicker-month">11월</span>
                    </div>
                    </div>
                    <table class="ui-datepicker-calendar">
                        <thead><tr>
                            <th class="ui-datepicker-week-end">
                                <span title="일">일</span>
                            </th>
                            <th><span title="월">월</span>
                            </th>
                            <th><span title="화">화</span></th><th><span title="수">수</span>
                            </th>
                            <th><span title="목">목</span></th><th><span title="금">금</span>
                        </th><th class="ui-datepicker-week-end"><span title="토">토</span>
                        </th></tr></thead><tbody><tr><td class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;
                    </td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;
                    </td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;
                    </td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;
                    </td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;
                    </td><td class=" ui-datepicker-unselectable ui-state-disabled event"><span class="ui-state-default">1</span>
                    </td><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">2</span>
                    </td></tr><tr><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">3</span>
                    </td><td class=" ui-datepicker-unselectable ui-state-disabled event"><span class="ui-state-default">4</span>
                    </td><td class=" ui-datepicker-unselectable ui-state-disabled event"><span class="ui-state-default">5</span>
                    </td><td class=" ui-datepicker-days-cell-over ui-datepicker-unselectable ui-state-disabled  ui-datepicker-current-day ui-datepicker-today">
                        <span class="ui-state-default">6</span>
                    </td><td class=" ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">7</span>
                    </td><td class=" ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">8</span>
                    </td><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">9</span>
                    </td></tr><tr><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">10</span>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">11</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">12</a>
                        </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">13</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">14</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">15</a>
                    </td><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">16</span>
                    </td></tr><tr><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">17</span>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">18</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">19</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">20</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">21</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">22</a>
                    </td><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">23</span>
                    </td></tr><tr><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">24</span>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">25</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">26</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">27</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">28</a>
                    </td><td class=" event" data-handler="selectDay" data-event="click" data-month="10" data-year="2024"><a class="ui-state-default" href="#">29</a>
                    </td><td class=" ui-datepicker-week-end ui-datepicker-unselectable ui-state-disabled "><span class="ui-state-default">30</span></td></tr></tbody></table>
                </div></div>
            <ul class="schdule-information">
                <li><img src="../images/common/icon_reservation_ok.gif" alt="">예약가능일</li>
                <li><img src="../images/common/icon_today.gif" alt="">오늘날짜</li>
            </ul>
        </div><!-- //schdule-information-area -->


        <!-- 예약구분 (재진료예약 / 첫진료예약) (강안병원만) -->
        <!-- <input type="hidden" name="reservGubun" id="reservGubun" value="record"> -->
        <dl class="choice-reservation-gubun">
            <dd>
                <input type="radio" name="reservGubun" id="reservGubun_1" value="record"><label for="reservGubun_1" style="line-height:24px;">진료예약</label>
                <input type="radio" name="reservGubun" id="reservGubun_2" value="first"><label for="reservGubun_2" style="line-height:24px;">상담예약</label>
            </dd>
        </dl>
        <dl class="cohise-reservation">
            <dt>
                예약시간 선택
            </dt>
            <dd>
                <label for="times1" class="blind">시</label>
                <select name="times1" id="times1" class="text18s" onchange="javascript:get_minutes();">
                    <option value="">-시</option>
                    <option value="09">09</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                </select>
                <span>:</span>
                <span id="times2_div">
							<label for="times2" class="blind">분</label>
							<select name="times2" id="times2" class="text18s">
								<option value="">-분</option>
                                <option value="00">00</option>
                                <option value="30">30</option>

							</select>
						</span>
            </dd>
        </dl>

        <div id="selected_time"></div>

        <dl class="phone-reservation">
            <dt>예약자 이름</dt>
            <dd>
                <label for="reservName" class="blind">예약자 이름</label>
                <input type="text" id="reservName" name="reservName" style="width: 217px">
            </dd>
        </dl>

        <dl class="phone-reservation">
            <dt>
                보호자이름 (<span class="point02">소아청소년과 예약시 입력</span>)
            </dt>
            <dd>
                <label for="guardianName" class="blind">보호자이름</label>
                <input type="text" id="guardianName" name="guardianName" style="width:100%;">
            </dd>
        </dl>
        <!--  //예약-->
        <div class="btnCenter mgt60" style="height:500px">
            <a href="javascript:void(0);" onclick="submitAction();" class="btnTypeJ">예약접수하기</a>
        </div>

    </div>
</div>
</body>
</html>











</body>
</html>