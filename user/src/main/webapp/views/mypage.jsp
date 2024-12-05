
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    body {
        color: #1a202c;
        text-align: left;
        background-color: #e2e8f0;
    }

    .main-body {
        padding: 15px;
    }

    .card {

        box-shadow: 0 1px 3px 0 rgba(0,0,0,.1), 0 1px 2px 0 rgba(0,0,0,.06);
        position: relative;
        display: flex;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 0 solid rgba(0,0,0,.125);
        border-radius: .25rem;

        width: 100%; /* 카드가 부모의 전체 너비를 차지 */
    }

    .card-body {
        flex: 1 1 auto;
        min-height: 1px;
        padding: 1rem;

        /* 아래 박스와 동일한 폭 */
        width: 100%;
    }

    .gutters-sm {
        display: flex; /* 가로 정렬 */
        justify-content: space-between; /* 카드 간 간격 균등 분배 */
        flex-wrap: nowrap; /* 한 줄에 카드 배치 */
        gap: 1rem; /* 카드 간 간격 */
    }

    .gutters-sm>.col, .gutters-sm>[class*=col-] {
        flex: 0 0 100%; /* 각 카드가 부모 컨테이너의 100%를 차지 */
        max-width: 100%; /* 카드 너비를 부모 컨테이너에 맞춤 */
        margin-right: 0; /* 오른쪽 여백 제거 */
    }

    .mb-3, .my-3 {
        margin-bottom: 1rem !important;
    }

    .bg-gray-300 {
        background-color: #e2e8f0;
    }

    .h-100 {
        height: 100% !important;
    }

    .shadow-none {
        box-shadow: none !important;
    }


    .card.h-100 {
        height: auto; /* 카드 높이를 내용에 맞춤 */
    }

    h2 {
        padding-top: 1rem;
        text-align: left;
        margin-left: 1rem;

    }

</style>

<head>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/wowjs@1.1.2/dist/wow.min.js"></script>
</head>


<script>
    $(document).ready(function () {
        $.ajax({
            url: '/getAppointmentList', // 컨트롤러의 경로
            method: 'GET',
            success: function (data) {
                console.log("서버 응답:", data); // 서버 응답을 콘솔에서 확인

                if (Array.isArray(data)) { // data가 배열인지 확인
                    let tableBody = $('#appointmentTable');
                    tableBody.empty(); // 기존 내용을 비웁니다

                    data.forEach(function (appointment) {
                        let row =
                            '<tr>'+
                            '<td>'+(appointment.doctorId)+'</td>'+
                            // '<td>'+(appointment.userId)+'</td>'+
                            '<td>'+(appointment.appointmentContent)+'</td>'+
                            '<td>'+(appointment.appointmentStatus)+'</td>'+
                            '<td>'+(appointment.type)+'</td>'+
                            '<td>'+(appointment.appointmentDate)+'</td>'+
                            '</tr>';
                        tableBody.append(row);
                    });
                } else {
                    console.error("응답 데이터가 배열이 아닙니다:", data);
                    alert("데이터가 잘못 전달되었습니다.");
                }
            },
            error: function (xhr, status, error) {
                console.error("데이터 로드 실패:", error);
                alert("데이터를 로드할 수 없습니다.");
            }
        });
    });


</script>


<script>
    $(document).ready(function () {
        $.ajax({
            url: '/getCounselList', // 컨트롤러의 경로
            method: 'GET',
            success: function (data) {
                console.log("서버 응답:", data); // 서버 응답을 콘솔에서 확인

                if (Array.isArray(data)) { // data가 배열인지 확인
                    let tableBody = $('#CounselTable');
                    tableBody.empty(); // 기존 내용을 비웁니다

                    data.forEach(function (counsels) {
                        let row =
                            '<tr>'+
                            '<td>'+(counsels.doctorId)+'</td>'+
                            // '<td>'+(counsels.userId)+'</td>'+
                            '<td>'+(counsels.counselContent)+'</td>'+
                            '<td>'+(counsels.counselType)+'</td>'+
                            '<td>'+(counsels.counselDate)+'</td>'+
                            '</tr>';
                        tableBody.append(row);
                    });
                } else {
                    console.error("응답 데이터가 배열이 아닙니다:", data);
                    alert("데이터가 잘못 전달되었습니다.");
                }
            },
            error: function (xhr, status, error) {
                console.error("데이터 로드 실패:", error);
                alert("데이터를 로드할 수 없습니다.");
            }
        });
    });


</script>





<div class="container">
    <div class="row">
        <h2>MyPage</h2>
    </div>
    <div class="main-body">
        <div class="row gutters-sm">
            <div class="col-md-8">
                <c:if test="${not empty message}">
                    <div class="alert alert-warning">${message}</div>
                </c:if>
                <c:if test="${not empty user}">
                    <form id="mypage_form">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">ID</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <c:out value="${user.userId}" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Name</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <c:out value="${user.userName}" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Email</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <c:out value="${user.userEmail}" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Phone</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <c:out value="${user.userNumber}" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Age</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <c:out value="${user.userAge}" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Gender</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <c:choose>
                                            <c:when test="${user.userSex == 'M'}">Male</c:when>
                                            <c:otherwise>Female</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Address</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <c:out value="${user.userAddress}" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <a href="<c:url value='/renew'/>" class="btn btn-info">Edit</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
                <div class="row gutters-sm">
                    <div class="col-sm-6 mb-3">
                        <div class="card h-100">
                            <div class="card-body">
<%--                                <h6 class="d-flex align-items-center mb-3"><i class="material-icons text-info mr-2">assignment</i>Project Status</h6>--%>
<%--                                <small>BPM</small>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 80%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                                <small>Website Markup</small>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 72%" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                                <small>One Page</small>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 89%" aria-valuenow="89" aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                                <small>Mobile Template</small>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 55%" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
<%--                                <small>Backend API</small>--%>
<%--                                <div class="progress mb-3" style="height: 5px">--%>
<%--                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 66%" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100"></div>--%>
<%--                                </div>--%>
                            </div>
                            <div class="container-fluid pt-4 px-4">
                                <div class="row g-4">
                                    <div class="col-sm-12 col-xl-5">
                                        <div class="bg-light rounded h-100 p-4">
                                            <h6 class="mb-4">상담기록</h6>
                                                <div class="table-responsive">
                                                    <table class="table table-bordered" id="Counsel-table">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">담당의사</th>
<%--                                                                <th scope="col">예약ID</th>--%>
                                                                <th scope="col">상담내용</th>
                                                                <th scope="col">예약상태</th>
                                                                <th scope="col">예약 시간</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="CounselTable">
                                                        <!-- 데이터를 추가할 위치 -->
                                                        </tbody>
                                                    </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-xl-7">
                                        <div class="bg-light rounded h-100 p-4">
                                            <h6 class="mb-4"> 예약 현황</h6>
                                            <div class="table-responsive">
                                                <table class="table table-bordered" id="patient-table">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">담당의사</th>
<%--                                                            <th scope="col">예약ID</th>--%>
                                                            <th scope="col">예약내용</th>
                                                            <th scope="col">예약상태</th>
                                                            <th scope="col">종류</th>
                                                            <th scope="col">예약 시간</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="appointmentTable">
                                                    <!-- 데이터를 추가할 위치 -->
                                                    </tbody>
                                                </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
