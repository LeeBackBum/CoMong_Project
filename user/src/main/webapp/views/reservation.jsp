<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en">
<head>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }



        /* 기본 리스트 스타일 */
        #doctorList li {
            list-style-type: none;
            padding: 10px;
            /*border: 1px solid transparent;  !* 기본 테두리 없음 *!*/
            margin: 5px;
            border: 2px solid black;
        }

        /* 클릭된 항목에 테두리와 배경색 추가 */
        /*#doctorList li a.selected {*/
        /*    border: 2px solid #007bff;  !* 파란색 테두리 *!*/
            /*background-color: #f0f8ff;  !* 선택된 배경색 *!*/
        /*}



    </style>




</head>

<body>

<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-white animated slideInDown">SM Korea</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                        <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                        <li class="breadcrumb-item text-white active" aria-current="page">Reservation</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- Header End -->

<!-- Board Start -->


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>

        // ---------------------------------진료과 별 의사정보---------------------------------------------------------
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

            const url = "/getDoctorList?subjectName=" + encodeURIComponent(subjectName);
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
        // ---------------------------------진료과 별 의사정보---------------------------------------------------------


        // ---------------------------------시간정보---------------------------------------------------------
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
        // ---------------------------------시간정보---------------------------------------------------------



        // ---------------------------------예약정보전송---------------------------------------------------------

        function submitAction() {
            /*const name = document.getElementById('reservName').value.trim();*/
            const hour = document.getElementById('times1').value;
            const minute = document.getElementById('times2').value;
            const reservGubun = document.getElementById('selectedReservGubun').value
            const comment = document.getElementById('comment').value;
            const date = document.getElementById('date').value;
            const doctorid = document.getElementById('doctorIdInput').value;
            const userId = document.getElementById('hiddenId').value;


            if (!hour || !minute) {
                alert("모든 필수 정보를 입력해주세요.");
                return;
            }

            // 날짜 및 시간 조합
            const today = new Date().toISOString().split('T')[0];
            const appointmentDate = + today + `T` + hour+ `:` +minute+ `:` +100; // ISO 형식으로 조합

            // 요청 데이터
            const data = {
                appointmentDate: date + `T` + hour + `:` +minute,
                appointmentContent: comment,
                appointmentStatus: "진료",
                userId: userId,  // 실제 사용자 ID로 대체
                doctorId: doctorid, // 실제 의사 ID로 대체
                type: reservGubun,
                subType: null,
            };

            console.log("Sending data:", data); // 디버깅용 로그

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
                        console.log(data);
                    }
                })
                .catch((error) => {
                    console.error("Error:", error);
                    alert("서버와의 통신 중 문제가 발생했습니다.");
                });
        }

        // ---------------------------------예약정보전송---------------------------------------------------------

        // ---------------------------------달력---------------------------------------------------------

        $(document).ready(function() {
            $.ajax({
                url: '/calendar',  // calendar.jsp 파일을 서버에서 가져올 URL
                type: 'GET',
                success: function(data) {
                    // 서버에서 가져온 데이터(HTML)를 schdule-information-area에 삽입
                    $('.schdule-information-area').html(data);
                },
                error: function(error) {
                    console.log('달력을 불러오는 데 실패했습니다.', error);
                }

            });
        });
        // ---------------------------------달력---------------------------------------------------------
        // ----------------------------------달력테스트-------------------------------------------------------
        $(document).ready(function() {
            const selectedDate = sessionStorage.getItem('selectedDate');

            // 날짜 값이 있으면 input 필드에 채워주기
            if (selectedDate) {
                document.getElementById('date').value = selectedDate;
            }
        });

        // ----------------------------------달력테스트-------------------------------------------------------


        // ----------------------------------진료&예약 구분------------------------------------------------------
        document.addEventListener('DOMContentLoaded', () => {
            // 선택된 라디오 버튼 값을 저장할 변수
            let selectedReservGubun = '';

            // 모든 라디오 버튼 선택
            const radioButtons = document.querySelectorAll('input[name="reservGubun"]');

            // 선택된 값을 표시할 hidden input 요소 선택 (또는 생성)
            const hiddenInput = document.getElementById('selectedReservGubun');

            // 각 라디오 버튼에 change 이벤트 리스너 추가
            radioButtons.forEach(radio => {
                radio.addEventListener('change', (event) => {
                    selectedReservGubun = event.target.value; // 선택된 라디오 버튼의 값 저장
                    console.log('선택된 예약 구분:', selectedReservGubun); // 콘솔 출력

                    // hidden input 요소에 값 반영
                    if (hiddenInput) {
                        hiddenInput.value = selectedReservGubun;
                    }
                });
            });
        });
        // ----------------------------------진료&예약 구분------------------------------------------------------




        // ----------------------------------의사ID 제어------------------------------------------------------

        function handleDoctorClick(doctorId, clickedElement) {
            // 모든 항목에서 selected 클래스를 제거
            const doctorItems = document.querySelectorAll('li a');
            doctorItems.forEach(item => item.classList.remove('selected'));

            // 클릭된 항목에 selected 클래스를 추가
            clickedElement.classList.add('selected');

            // doctorId 값을 hidden input에 설정
            const doctorIdInput = document.getElementById("doctorIdInput");
            if (doctorIdInput) {
                doctorIdInput.value = doctorId;
                console.log("Doctor ID set to input:" + doctorId );
            } else {
                console.error("Hidden input field not found.");
            }
        }
        // ----------------------------------의사ID 제어------------------------------------------------------


        // ----------------------------------유저ID 제어------------------------------------------------------




    </script>



<!-- 아이디 값 전달 -->
<input type="hidden" id="hiddenId" name="id" value="${userId}">
<!-- 아이디 값 전달 -->


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

                        <%--------------------.의사 정보 추가--------------------%>

                            <form id="doctorForm" action="your_destination_page" method="post">
                                <input type="hidden" id="doctorIdInput" name="doctorId" value="">
                            </form>

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

            <ul class="schdule-information">
                <li><img src="../images/common/icon_reservation_ok.gif" alt="">예약가능일</li>
                <li><img src="../images/common/icon_today.gif" alt="">오늘날짜</li>
            </ul>
        </div><!-- //schdule-information-area -->

        <%--        <dt>선택하신 일자입니다.</dt>--%>
<%--        <input type="text" id="date" name="date" readonly />--%>

        <!-- 예약구분 (진료예약 / 상담예약) -->
        <dl class="choice-reservation-gubun">
            <dd>
                <input type="radio" name="reservGubun" id="reservGubun_1" value="진료예약"><label for="reservGubun_1" style="line-height:24px;">진료예약</label>
                <input type="radio" name="reservGubun" id="reservGubun_2" value="상담예약"><label for="reservGubun_2" style="line-height:24px;">채팅상담</label>
                <input type="radio" name="reservGubun" id="reservGubun_3" value="상담예약"><label for="reservGubun_2" style="line-height:24px;">화상상담</label>
                <input type="hidden" id="selectedReservGubun">
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

<%--        <dl class="phone-reservation">--%>
<%--            <dt>예약요청 제목</dt>--%>
<%--            <dd>--%>
<%--                <label for="reservName" class="blind"></label>--%>
<%--                <input type="text" id="reservName" name="reservName" style="width: 217px">--%>
<%--            </dd>--%>
<%--        </dl>--%>

        <dl class="phone-reservation">
            <dt>
                예약요청 내용(<span class="point02">요청하신 상담에대 작성해주세요</span>)
            </dt>
            <dd>
                <div class="form-group">
                    <label for="comment"></label>
                    <textarea class="form-control" rows="5" id="comment"></textarea>
                </div>
            </dd>
        </dl>
        <!--  //예약-->
        <div class="btnCenter mgt60" style="height:500px">
            <a href="javascript:void(0);" onclick="submitAction();" class="btn btn-primary">예약접수하기</a>
        </div>
    </div>



</div>
</body>
</html>



