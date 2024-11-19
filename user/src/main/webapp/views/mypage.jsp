
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
</head>

<script>
    $(document).ready(function () {
        $('#mypage_form').attr({
            'method': 'post',
            'enctype': 'multipart/form-data',
            'action': '<c:url value="/user/mypage"/>'
        });
    });
</script>

<div class="container">
    <div class="row">
        <h2>MyPage</h2> <!-- 추가된 h2 -->
    </div>
    <div class="main-body">
        <div class="row gutters-sm">
            <div class="col-md-8">
                <form id="mypage_form">
                    <c:out value="${user}" default="No user data found" />
                    <c:out value="${user.userId}" default="No ID" />
                    <c:out value="${user.userName}" default="No Name" />
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">ID</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    ${user.userId}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Name</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    ${user.userName}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    ${user.userEmail}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Phone</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    ${user.userNumber}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Age</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    ${user.userAge}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Gender</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    ${user.userSex == 'M' ? 'Male' : 'Female'}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Address</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    ${user.userAddress}
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-12">
                                    <a href="<c:url value="/register"/>" class="btn btn-info" target="__blank">Edit</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <div class="row gutters-sm">
                    <div class="col-sm-6 mb-3">
                        <div class="card h-100">
                            <div class="card-body">
                                <h6 class="d-flex align-items-center mb-3"><i class="material-icons text-info mr-2">assignment</i>Project Status</h6>
                                <small>Web Design</small>
                                <div class="progress mb-3" style="height: 5px">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <small>Website Markup</small>
                                <div class="progress mb-3" style="height: 5px">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 72%" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <small>One Page</small>
                                <div class="progress mb-3" style="height: 5px">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 89%" aria-valuenow="89" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <small>Mobile Template</small>
                                <div class="progress mb-3" style="height: 5px">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 55%" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <small>Backend API</small>
                                <div class="progress mb-3" style="height: 5px">
                                    <div class="progress-bar bg-primary" role="progressbar" style="width: 66%" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>