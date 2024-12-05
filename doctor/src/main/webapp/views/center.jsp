    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <%--Calender Lib--%>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>

    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    <script>
        let calender = {
            init: function () {
                // 캘린더 초기화
                $('#calender').datetimepicker({
                    inline: true,
                    format: 'L'
                });

                // 오늘 날짜 데이터 로드
                let today = moment().format('YYYY-MM-DD');
                calender.loadPatients(today);

                // 날짜 변경 이벤트 처리
                $('#calender').on('change.datetimepicker', function (event) {
                    let selectedDate = event.date.format('YYYY-MM-DD'); // 선택된 날짜
                    calender.loadPatients(selectedDate); // 선택된 날짜의 환자 목록 불러오기
                });
            },

            // AJAX 요청으로 환자 데이터 가져오기
            loadPatients: function (date) {
                $.ajax({
                    url: '/user/getPatients', // 서버 API 엔드포인트
                    type: 'GET',
                    data: { date: date }, // 선택된 날짜 전달
                    success: function (response) {
                        calender.updatePatientTable(response); // 테이블 업데이트
                    },
                    error: function () {
                        alert('환자 데이터를 불러오는 데 실패했습니다.');
                    }
                });
            },

            // 테이블 업데이트
            updatePatientTable: function (patients) {
                console.log("받은 환자 데이터:", patients);

                let tableBody = $('#patient-table tbody');
                console.log(tableBody);
                tableBody.empty();

                if (!patients || patients.length === 0) {
                    console.log("환자 데이터 없음");
                    tableBody.append('<tr><td colspan="6" class="text-center">예약된 환자가 없습니다.</td></tr>');
                    // "오늘 환자" <h6> 요소에 환자 수 추가
                    document.querySelector('#today-patient-count h6').textContent = '총 환자 수: 0';
                } else {
                    let rows = ''; // 모든 행을 저장할 변수
                    patients.forEach(function (patient) {
                        console.log("환자 추가:", patient);
                        let formattedDate = moment(patient.date).format('YYYY-MM-DD HH:mm:ss');
                        console.log(formattedDate)
                        let row =
                        '<tr>'+
                            '<td>'+(patient.userName || '')+'</td>'+
                            '<td>'+(patient.userAge || '')+'</td>'+
                            '<td>'+(patient.diseaseStatus || '')+'</td>'+
                            '<td>'+(patient.userNumber || '')+'</td>'+
                            '<td>'+(patient.appointmentType || '')+'</td>'+
                            '<td>'+(formattedDate || '')+'</td>'+
                        '</tr>';
                        console.log("생성된 행:", row);
                        rows += row; // 문자열로 누적
                    });
                    tableBody.append(rows); // 누적된 모든 행을 한 번에 추가

                    let rowCount = patients.length;
                    console.log("총 행 수:", rowCount);
                    // "오늘 환자" <h6> 요소에 환자 수 추가
                    document.querySelector('#today-patient-count h6').textContent = '총 환자 수: '+(rowCount);
                }
            }
        };


        $(function () {
            let today = moment().format('YYYY-MM-DD'); // 오늘 날짜
            calender.init(today); // 캘린더 초기화 및 오늘 데이터 로드
        });
    </script>

    <div>
        <!-- Sale & Revenue Start -->
        <div class="container-fluid pt-4 px-4">
            <div class="row g-4">
                <div class="col-sm-6 col-xl-3">
                    <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                        <img src="<c:url value="/img/icon1.png"/> " style="width: 48px; height: 48px;">
                        <div id="today-patient-count" class="ms-3">
                            <p class="mb-2">오늘 환자</p>
                            <h6 class="mb-0"> </h6>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                        <img src="<c:url value="/img/icon2.png"/> " style="width: 48px; height: 48px;">
                        <div class="ms-3">
                            <p class="mb-2">총 환자</p>
                            <h6 class="mb-0">x명</h6>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                        <img src="<c:url value="/img/icon3.png"/> " style="width: 48px; height: 48px;">
                        <div class="ms-3">
                            <p class="mb-2">주의 환자</p>
                            <h6 class="mb-0">x명</h6>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xl-3">
                    <div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
                        <img src="<c:url value="/img/icon4.png"/> " style="width: 48px; height: 48px;">
                        <div class="ms-3">
                            <p class="mb-2">위험 환자</p>
                            <h6 class="mb-0">x명</h6>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sale & Revenue End -->

        <!-- Sales Chart Start -->
        <div class="container-fluid pt-4 px-4">
            <div class="row g-4">
                <div class="col-sm-12 col-xl-4">
                    <div class="h-100 bg-light rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Calender</h6>
                            <a href="<c:url value="/"/>">Show All</a>
                        </div>
                        <div id="calender"></div>
                    </div>
                </div>
                <div class="col-sm-12 col-xl-8">
                    <div class="bg-light rounded h-100 p-4">
                        <h6 class="mb-4"> 환자 목록</h6>
                        <div class="table-responsive">
                            <table class="table table-bordered" id="patient-table">
                                <thead>
                                <tr>
                                    <th scope="col">이름</th>
                                    <th scope="col">나이</th>
                                    <th scope="col">특이사항</th>
                                    <th scope="col">연락처</th>
                                    <th scope="col">종류</th>
                                    <th scope="col">예약 시간</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody> <!-- 데이터를 추가할 위치 -->
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 col-xl-12">
                    <div class="h-100 bg-light rounded p-4">
                        <h6 class="mb-4">다른 의사 정보</h6>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Phone Number</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Society</th>
                                        <th scope="col">SubjectName</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="d" items="${doctors}">
                                        <tr>
                                            <td>${d.doctorName}</td>
                                            <td>${d.carType}</td>
                                            <td>${c.carPrice}</td> <!-- carPrice는 String이므로 그냥 출력 -->
                                            <!-- carDate(LocalDateTime)는 형식을 지정해서 출력 -->
                                            <td>${c.formattedCarDate}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                </div>
            </div>
        </div>
        <!-- Sales Chart End -->


        <!-- Footer Start -->
        <div class="container-fluid pt-4 px-4">
            <div class="bg-light rounded-top p-4">
                <div class="row">
                    <div class="col-12 col-sm-6 text-center text-sm-start">
                        &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                    </div>
                    <div class="col-12 col-sm-6 text-center text-sm-end">
                        <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                        Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->
    </div>

