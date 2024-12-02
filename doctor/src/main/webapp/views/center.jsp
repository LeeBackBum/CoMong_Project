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
            console.log("받은 환자 데이터:", patients); // 디버깅용 로그 추가

            let tableBody = $('#patient-table tbody');
            console.log(tableBody); // 제대로 선택되었는지 확인
            tableBody.empty(); // 기존 데이터 제거

            if (!patients || patients.length === 0) {
                console.log("환자 데이터 없음");
                tableBody.append('<tr><td colspan="6" class="text-center">예약된 환자가 없습니다.</td></tr>');
            } else {
                patients.forEach(function (patient) {
                    console.log("환자 추가:", patient); // 각 환자 데이터를 출력
                    console.log("날짜 원본 데이터:", patient.date);
                    let formattedDate = moment(patient.date).format('YYYY-MM-DD HH:mm:ss');
                    console.log("포맷된 날짜:", formattedDate);
                    console.log(patient.userName);
                    let row = `
                <tr>
                    <td>${patient.userName || ''}</td>
                    <td>${patient.userAge || ''}</td>
                    <td>${patient.diseaseStatus || ''}</td>
                    <td>${patient.userNumber || ''}</td>
                    <td>${patient.appointmentType || ''}</td>
                    <td>${formattedDate || ''}</td>
                </tr>`;
                    console.log("생성된 행:", row);
                    tableBody.append(row); // 테이블에 행 추가
                });
            }
        }
    };


    $(function () {
        let today = moment().format('YYYY-MM-DD'); // 오늘 날짜
        calender.init(today); // 캘린더 초기화 및 오늘 데이터 로드
    });
</script>

<div>
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
                            <tbody></tbody> <!-- 데이터를 추가할 위치 -->
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


