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
<!-- Spinner Start -->
<%--<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">--%>
<%--    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">--%>
<%--        <span class="sr-only">Loading...</span>--%>
<%--    </div>--%>
<%--</div>--%>
<!-- Spinner End -->


<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
    <a href="<c:url value="/"/> " class="navbar-brand d-flex align-items-center px-4 px-lg-5">
        <h2 class="m-0 text-primary">
            <img class="img-logo" src="img/logo2.jpg" alt="" style="width: 140px; height: auto;">
        </h2>
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="<c:url value="/"/>" class="nav-item nav-link active">Home</a>
            <a href="<c:url value="/about"/>" class="nav-item nav-link">About</a>
            <a href="<c:url value="/courses"/>" class="nav-item nav-link">Courses</a>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                <div class="dropdown-menu fade-down m-0">
                    <a href="<c:url value="/team"/>" class="dropdown-item">Our Team</a>
                    <a href="<c:url value="/testimonial"/>" class="dropdown-item">Testimonial</a>
                    <a href="<c:url value="/errorpage"/>" class="dropdown-item">404 Page</a>
                </div>
            </div>
            <a href="<c:url value="/contact"/>" class="nav-item nav-link">Contact</a>
        </div>
        <a href="<c:url value="/login"/>" class="btn btn-primary py-4 px-lg-5 d-none d-lg-block">Join Now<i class="fa fa-arrow-right ms-3"></i></a>
    </div>
</nav>

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
        <%--function resetDoctor() {--%>
        <%--    // 서버로 Ajax 요청을 보내 의사 정보 데이터를 가져옴--%>
        <%--    fetch('/getDoctorList')  // `/getDoctorList`는 서버에서 의사 정보를 제공하는 엔드포인트--%>
        <%--        .then(response => response.json())  // JSON 형식으로 변환--%>
        <%--        .then(data => {--%>
        <%--            const doctorListArea = document.querySelector('.doctor-list-area');--%>
        <%--            doctorListArea.innerHTML = '';  // 기존 리스트를 초기화--%>

        <%--            // 응답이 배열인지 확인--%>
        <%--            if (Array.isArray(data)) {--%>
        <%--                // data가 배열인 경우 forEach를 사용하여 HTML에 추가--%>
        <%--                data.forEach(doctor => {--%>
        <%--                    const listItem = document.createElement('li');--%>
        <%--                    listItem.innerHTML = `--%>
        <%--                <a href="javascript:void(0);" stfidx="${doctor.id}" reservopen style="border: 2px solid rgb(60, 153, 255);">--%>
        <%--                    <div class="image-box">--%>
        <%--                        <img src="<c:url value="/imgt/dt.png"/>" alt="${doctor.doctor_name}" class="image-doctor" width="100px">--%>
        <%--                    </div>--%>
        <%--                    <span class="doctor-information" id="staffIdx_${doctor.id}" major="${doctor.subject_name}" doctor="${doctor.doctor_name}">--%>
        <%--                        <span class="type" style="font-size:14px;">${doctor.subject_name}</span>--%>
        <%--                        <span class="name" style="font-size:14px;">${doctor.doctor_name}</span>--%>
        <%--                    </span>--%>
        <%--                </a>--%>
        <%--            `;--%>
        <%--                    doctorListArea.appendChild(listItem);--%>
        <%--                });--%>
        <%--            } else {--%>
        <%--                // 배열이 아닌 경우 오류 메시지와 데이터를 확인--%>
        <%--                console.error('Error: Expected an array but received:', data);--%>
        <%--            }--%>
        <%--        })--%>
        <%--        .catch(error => {--%>
        <%--            console.error('Error fetching doctor data:', error);--%>
        <%--        });--%>
        <%--}--%>
        <%--$(document).ready(function() {--%>
        <%--    $("#loadData").click(function() {--%>
        <%--        $.ajax({--%>
        <%--            url: "jdbc:log4jdbc:mysql://127.0.0.1:3306/smhs?characterEncoding=utf8",--%>
        <%--            type: "GET",--%>
        <%--            success: function(data) {--%>
        <%--                let html = "<ul>";--%>
        <%--                data.forEach(item => {--%>
        <%--                    html += `<li>${doctorName}</li>`;  // 예시: name 필드 출력--%>
        <%--                });--%>
        <%--                html += "</ul>";--%>
        <%--                $("#dataContainer").html(html);--%>
        <%--            },--%>
        <%--            error: function(error) {--%>
        <%--                console.log("Error:", error);--%>
        <%--            }--%>
        <%--        });--%>
        <%--    });--%>
        <%--});--%>
        <%--function resetDoctor() {--%>
        <%--    // AJAX 요청을 보내서 서버에서 의사 목록을 가져옴--%>
        <%--    $.ajax({--%>
        <%--        url: "/getDoctorList",  // 서버 URL--%>
        <%--        type: "GET",--%>
        <%--        dataType: "json",  // 서버 응답을 JSON으로 처리--%>
        <%--        success: function(data) {--%>
        <%--            // 응답 받은 doctorList 데이터 처리--%>
        <%--            let html = '';--%>

        <%--            // doctorName과 subjectName을 화면에 출력--%>
        <%--            data.forEach(function(doctor) {--%>
        <%--                html += `--%>
        <%--            <div class="doctor-item">--%>
        <%--                <p><strong>Doctor Name:</strong> ${doctor.doctorName}</p>--%>
        <%--                <p><strong>Subject Name:</strong> ${doctor.subjectName}</p>--%>
        <%--            </div>--%>
        <%--        `;--%>
        <%--            });--%>

        <%--            // 데이터를 doctor-list-area에 삽입--%>
        <%--            $(".doctor-list-area").html(html);--%>
        <%--        },--%>
        <%--        error: function(error) {--%>
        <%--            console.error("Error:", error);--%>
        <%--        }--%>
        <%--    });--%>
        <%--}--%>

        // function resetDoctor(value=" ") {
        //     // 서버에서 testdo.jsp 렌더링 결과를 가져오는 URL
        //     const url = "/testdo";
        //
        //     fetch(url, {
        //         method: "GET",
        //     })
        //         .then(response => {
        //             if (!response.ok) {
        //                 throw new Error("Network response was not ok");
        //             }
        //             return response.text(); // 서버에서 반환된 HTML
        //         })
        //         .then(html => {
        //             if(value==1) {
        //                 // doctor-list-area 영역에 HTML 삽입
        //                 const doctorListArea = document.querySelector(".doctor-list-area");
        //                 doctorListArea.innerHTML = html;
        //             }
        //         })
        //         .catch(error => {
        //             console.error("Error fetching the JSP content:", error);
        //         });
        // }
// --------------------------일단 이거 됨-----------------------
<%--        function resetDoctor(value = " ") {--%>
<%--            // 진료과에 맞는 subjectName 설정--%>
<%--            let subjectName = "";--%>
<%--            switch (value) {--%>
<%--                case 1:--%>
<%--                    subjectName = "내과";--%>
<%--                    break;--%>
<%--                case 2:--%>
<%--                    subjectName = "내과";--%>
<%--                    break;--%>
<%--                case 3:--%>
<%--                    subjectName = "외과";--%>
<%--                    break;--%>
<%--                case 4:--%>
<%--                    subjectName = "외과";--%>
<%--                    break;--%>
<%--                default:--%>
<%--                    console.log("유효하지 않은 진료과 값입니다.");--%>
<%--                    return; // 잘못된 값이면 실행을 멈춤--%>
<%--            }--%>

<%--            // JavaScript에서 encodeURIComponent 사용--%>
<%--            const url = "/testdo2?subjectName=" + encodeURIComponent(subjectName);--%>

<%--            &lt;%&ndash;const url = `reservation2/getlist?subjectName=${encodeURIComponent(subjectName)}`;&ndash;%&gt;--%>

<%--            // const url = "/testdo2"--%>
<%--            fetch(url, {--%>
<%--                method: "GET",--%>
<%--            })--%>
<%--                .then(response => {--%>
<%--                    if (!response.ok) {--%>
<%--                        throw new Error("Network response was not ok");--%>
<%--                    }--%>
<%--                    return response.text(); // 서버에서 반환된 HTML--%>
<%--                })--%>
<%--                .then(html => {--%>
<%--                    if (value == 2) {--%>
<%--                        // doctor-list-area 영역에 HTML 삽입--%>
<%--                        const doctorListArea = document.querySelector(".doctor-list-area");--%>
<%--                        doctorListArea.innerHTML = html;--%>
<%--                    }--%>
<%--                })--%>
<%--                .catch(error => {--%>
<%--                    console.error("Error fetching the JSP content:", error);--%>
<%--                });--%>
<%--        }--%>


        <%--function resetDoctor(value = " ") {--%>
        <%--    const url = "/doctors/search"; // 서버의 검색 엔드포인트--%>

        <%--    // 진료과에 맞는 subjectName 설정--%>
        <%--    let subjectName = "";--%>
        <%--    switch(value) {--%>
        <%--        case 1:--%>
        <%--            subjectName = "내과";--%>
        <%--            break;--%>
        <%--        case 2:--%>
        <%--            subjectName = "외과";--%>
        <%--            break;--%>
        <%--        case 3:--%>
        <%--            subjectName = "안과";--%>
        <%--            break;--%>
        <%--        default:--%>
        <%--            console.log("유효하지 않은 진료과 값입니다.");--%>
        <%--            return; // 잘못된 값이면 실행을 멈춤--%>
        <%--    }--%>

        <%--    // JavaScript에서 encodeURIComponent 사용--%>
        <%--    const encodedSubjectName = encodeURIComponent(subjectName);--%>

        <%--    // 서버에 GET 요청 보내기 (subjectName을 쿼리 파라미터로 전달)--%>
        <%--    fetch(`${url}?subjectName=${encodedSubjectName}`)--%>
        <%--        .then(response => {--%>
        <%--            // 응답이 JSON 형식인지 확인--%>
        <%--            if (!response.ok) {--%>
        <%--                throw new Error('서버 응답이 올바르지 않습니다.');--%>
        <%--            }--%>
        <%--            const contentType = response.headers.get("Content-Type");--%>
        <%--            if (contentType && contentType.includes("application/json")) {--%>
        <%--                return response.json(); // JSON 응답이면 JSON으로 파싱--%>
        <%--            } else {--%>
        <%--                return response.text(); // JSON이 아니라면 텍스트로 반환--%>
        <%--            }--%>
        <%--        })--%>
        <%--        .then(data => {--%>
        <%--            if (typeof data === 'string') {--%>
        <%--                console.error("서버에서 오류 페이지 또는 HTML을 반환했습니다.");--%>
        <%--                return;--%>
        <%--            }--%>

        <%--            if (data && data.length > 0) {--%>
        <%--                let outputHTML = "";--%>
        <%--                data.forEach(doctor => {--%>
        <%--                    outputHTML += `--%>
        <%--                <div class="doctor-item">--%>
        <%--                    <h3>${doctor.name}</h3>--%>
        <%--                    <p>전문분야: ${doctor.specialization}</p>--%>
        <%--                    <p>전화번호: ${doctor.phone}</p>--%>
        <%--                </div>--%>
        <%--            `;--%>
        <%--                });--%>
        <%--                document.querySelector(".doctor-list-area").innerHTML = outputHTML;--%>
        <%--            } else {--%>
        <%--                console.log("해당 진료과에 대한 데이터가 없습니다.");--%>
        <%--            }--%>
        <%--        })--%>
        <%--        .catch(error => {--%>
        <%--            console.error("데이터를 가져오는 중 오류가 발생했습니다:", error);--%>
        <%--        });--%>
        <%--}--%>

        <%--function resetDoctor(value) {--%>
        <%--    // 진료과에 맞는 subjectName 설정--%>
        <%--    let subjectName = "";--%>
        <%--    if (value === 1) subjectName = "내과";--%>
        <%--    else if (value === 2) subjectName = "외과";--%>
        <%--    else return; // 값이 유효하지 않으면 종료--%>

        <%--    // 서버에 GET 요청을 보내서 의사 목록을 가져옵니다.--%>
        <%--    const url = `reservation2/getlist?subjectName=${encodeURIComponent(subjectName)}`;--%>

        <%--    fetch(url)--%>
        <%--        .then(response => response.json())--%>
        <%--        .then(data => {--%>
        <%--            const doctorListArea = document.querySelector(".doctor-list-area");--%>
        <%--            doctorListArea.innerHTML = data.map(doctor => `--%>
        <%--        <div class="doctor-item">--%>
        <%--            <h3>${doctor.doctorName}</h3>--%>
        <%--            <p>전문분야: ${doctor.specialization}</p>--%>
        <%--            <p>전화번호: ${doctor.phone}</p>--%>
        <%--        </div>--%>
        <%--    `).join('');--%>
        <%--        })--%>
        <%--        .catch(error => {--%>
        <%--            console.error("오류 발생:", error);--%>
        <%--        });--%>
        <%--}--%>

        <%--function resetDoctor(value) {--%>
        <%--    // 라디오 버튼 값이 없을 경우 처리--%>
        <%--    if (!value) {--%>
        <%--        console.error("유효하지 않은 값입니다.");--%>
        <%--        return;--%>
        <%--    }--%>

        <%--    // 진료과 라벨 값 가져오기--%>
        <%--    const selectedLabel = document.querySelector(`label[for="radio0101${value}"]`);--%>
        <%--    if (!selectedLabel) {--%>
        <%--        console.error("라벨을 찾을 수 없습니다.");--%>
        <%--        return;--%>
        <%--    }--%>

        <%--    const subjectName = selectedLabel.textContent.trim(); // 선택된 라벨의 텍스트--%>

        <%--    if (!subjectName) {--%>
        <%--        console.error("라벨에서 진료과 이름을 가져오지 못했습니다.");--%>
        <%--        return;--%>
        <%--    }--%>

        <%--    // URL에 subjectName 추가--%>
        <%--    &lt;%&ndash;const url = `/testdo2?subjectName=${encodeURIComponent(subjectName)}`;&ndash;%&gt;--%>
        <%--    const url = "/testdo2?subjectName=" + encodeURIComponent(subjectName);--%>

        <%--    // 데이터 요청--%>
        <%--    fetch(url, {--%>
        <%--        method: "GET",--%>
        <%--    })--%>
        <%--        .then(response => {--%>
        <%--            if (!response.ok) {--%>
        <%--                throw new Error("Network response was not ok");--%>
        <%--            }--%>
        <%--            return response.text(); // 서버에서 반환된 HTML--%>
        <%--        })--%>
        <%--        .then(html => {--%>
        <%--            // doctor-list-area 영역에 데이터 삽입--%>
        <%--            const doctorListArea = document.querySelector(".doctor-list-area");--%>
        <%--            if (doctorListArea) {--%>
        <%--                doctorListArea.innerHTML = html;--%>
        <%--            } else {--%>
        <%--                console.error("doctor-list-area를 찾을 수 없습니다.");--%>
        <%--            }--%>
        <%--        })--%>
        <%--        .catch(error => {--%>
        <%--            console.error("Error fetching the JSP content:", error);--%>
        <%--        });--%>
        <%--}--%>

//----------------------------------진료과 마다 호출하기 1 일단 됨 -------------------------------------
<%--        function resetDoctor(value, id) {--%>
<%--            // 라벨 찾기--%>
<%--            const selectedLabel = document.querySelector(`label[for="radio0101${value}"]`);--%>
<%--            if (!selectedLabel) {--%>
<%--                console.error(`라벨을 찾을 수 없습니다. (for="radio0101${value}")`);--%>
<%--                return;--%>
<%--            }--%>
<%--            const subjectName = selectedLabel.textContent.trim();--%>

<%--            if (!subjectName) {--%>
<%--                console.error("라벨에서 진료과 이름을 가져오지 못했습니다.");--%>
<%--                return;--%>
<%--            }--%>

<%--            const url = "/testdo2?subjectName=" + encodeURIComponent(subjectName);--%>

<%--            fetch(url, { method: "GET" })--%>
<%--                .then(response => response.text())--%>
<%--                .then(html => {--%>
<%--                    const doctorListArea = document.querySelector(".doctor-list-area");--%>
<%--                    if (doctorListArea) {--%>
<%--                        doctorListArea.innerHTML = html;--%>
<%--                    } else {--%>
<%--                        console.error("doctor-list-area를 찾을 수 없습니다.");--%>
<%--                    }--%>
<%--                })--%>
<%--                .catch(error => console.error("Error fetching the JSP content:", error));--%>
<%--        }--%>

        <%--function resetDoctor(id) {--%>
        <%--    // 라벨 찾기--%>
        <%--    const selectedLabel = document.querySelector(`label[for="${id}"]`);--%>
        <%--    if (!selectedLabel) {--%>
        <%--        console.error(`라벨을 찾을 수 없습니다. (for="${id}")`);--%>
        <%--        return;--%>
        <%--    }--%>
        <%--    const subjectName = selectedLabel.textContent.trim();--%>

        <%--    if (!subjectName) {--%>
        <%--        console.error("라벨에서 진료과 이름을 가져오지 못했습니다.");--%>
        <%--        return;--%>
        <%--    }--%>

        <%--    // 서버에 요청할 URL 생성--%>
        <%--    const url = "/testdo2?subjectName=" + encodeURIComponent(subjectName);--%>

        <%--    // 서버로 데이터 요청--%>
        <%--    fetch(url, { method: "GET" })--%>
        <%--        .then(response => response.text())--%>
        <%--        .then(html => {--%>
        <%--            const doctorListArea = document.querySelector(".doctor-list-area");--%>
        <%--            if (doctorListArea) {--%>
        <%--                doctorListArea.innerHTML = html;--%>
        <%--            } else {--%>
        <%--                console.error("doctor-list-area를 찾을 수 없습니다.");--%>
        <%--            }--%>
        <%--        })--%>
        <%--        .catch(error => console.error("Error fetching the JSP content:", error));--%>
        <%--}--%>


        <%--function resetDoctor(id) {--%>
        <%--    // 라벨 찾기--%>
        <%--    console.log("받은 id:", id);--%>
        <%--    const selectedLabel = document.querySelector(`label[for="${id}"]`);--%>

        <%--    if (!selectedLabel) {--%>
        <%--        console.error(`라벨을 찾을 수 없습니다. (for="${value}")`);--%>
        <%--        console.log("선택된 라벨:", selectedLabel);--%>
        <%--        console.log("입력된 value:", value);--%>
        <%--        return;--%>
        <%--    }--%>
        <%--    const subjectName = selectedLabel.textContent.trim();--%>
        <%--    if (!subjectName) {--%>
        <%--        console.error("라벨에서 진료과 이름을 가져오지 못했습니다.");--%>
        <%--        return;--%>
        <%--    }--%>

        <%--    const url = "/testdo2?subjectName=" + encodeURIComponent(subjectName);--%>
        <%--    fetch(url, { method: "GET" })--%>
        <%--        .then(response => response.text())--%>
        <%--        .then(html => {--%>
        <%--            const doctorListArea = document.querySelector(".doctor-list-area");--%>
        <%--            if (doctorListArea) {--%>
        <%--                doctorListArea.innerHTML = html;--%>
        <%--            } else {--%>
        <%--                console.error("doctor-list-area를 찾을 수 없습니다.");--%>
        <%--            }--%>
        <%--        })--%>
        <%--        .catch(error => console.error("Error fetching the JSP content:", error));--%>
        <%--}--%>

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

        // function submitAction() {
        //     // 입력값 수집   phone01
        //     const name = document.getElementById('reservName').value.trim();
        //     const hour = document.getElementById('times1').value;
        //     const minute = document.getElementById('times2').value;
        //     const reservGubun_1 = document.getElementById('reservGubun_1').value;
        //     const reservGubun_2 = document.getElementById('reservGubun_2').value;
        //     // const phone03 = document.getElementById('phone03').value;
        //
        //
        //     // 간단한 검증
        //     if (!name || !hour || !minute || !reservGubun_1 || !reservGubun_2 ) {
        //         alert("모든 필수 정보를 입력해주세요.");
        //         return;
        //     }
        //
        //     // 전송할 데이터 구성
        //     const data = {
        //         name: name,
        //         time: {hour, minute},
        //         reservGubun: {reservGubun_1,reservGubun_2}
        //         // phone: {phone01, phone02, phone03}
        //     };
        //
        //     // 데이터 전송
        //     fetch('/submitReservation', {
        //         method: 'POST',
        //         headers: {
        //             'Content-Type': 'application/json'
        //         },
        //         body: JSON.stringify(data)
        //     })
        //
        //         .then(response => response.json())
        //         .then(result => {
        //             if (result.success) {
        //                 alert("예약이 성공적으로 접수되었습니다.");
        //             } else {
        //                 alert("예약 접수 중 문제가 발생했습니다. 다시 시도해주세요.");
        //                 console.log(data);
        //             }
        //         })
        //         .catch(error => {
        //             console.error("Error:", error);
        //             alert("서버와의 통신 중 문제가 발생했습니다.");
        //             console.log(data);
        //         });
        // }

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
<%--                            <jsp:include page="/views/testdo.jsp" />--%>

<%--                            <c:choose>--%>
<%--                                <c:when test="${center == null}">--%>
<%--                                    <jsp:include page="testdo.jsp"/>--%>
<%--                                </c:when>--%>
<%--                            </c:choose>--%>

<%--                                <ul>--%>
<%--                                    <c:forEach var="doctor" items="${doctorlist}">--%>
<%--                                    <li><a href="javascript:void(0);" stfidx="144" reservopen style>--%>
<%--                                        <div class="image-box">--%>
<%--                                            <img src="<c:url value="/imgt/dt.png"/>" alt="이가영" class="image-doctor" width="100px">--%>
<%--                                        </div>--%>
<%--                                        <span class="doctor-information" id="staffIdx_2" major="${doctor.subjectName}" doctor="${doctor.doctorName}">--%>
<%--                                                        <span class="type" style="font-size:14px;">${doctor.subjectName}</span>--%>
<%--                                                        <span class="name" style="font-size:14px;">${doctor.doctorName}</span>--%>
<%--                                                    </span>--%>
<%--                                    </a>--%>
<%--                                    </li>--%>
<%--                                        </c:forEach>--%>
<%--                                </ul>--%>




                        </div>




                    <%--            <div class="doctor-list-area">--%>
<%--                <ul>--%>
<%--                    <table class="table">--%>
<%--                        <thead class="thead-dark">--%>
<%--                        <tr>--%>
<%--                            <th>Image</th>--%>
<%--                            <th>DoctorID</th>--%>
<%--                            <th>DoctorName</th>--%>
<%--                            <th>CAREER</th>--%>
<%--                            <th>SUBJECTNAME</th>--%>
<%--                        </tr>--%>
<%--                        </thead>--%>
<%--                        <tbody>--%>
<%--                        <c:forEach var="doctor" items="${doctorlist}">--%>
<%--                            <tr>--%>
<%--                                <td>--%>
<%--                                    <a href="<c:url value="/item/detail"/>?id=${doctor.doctorId}">--%>
<%--                                        <img id="item_img" src="<c:url value="/imgs"/>/${doctor.doctorImg}">--%>
<%--                                    </a>--%>
<%--                                </td>--%>
<%--                                <td>${doctor.doctorId}</td>--%>
<%--                                <td>${doctor.doctorName}</td>--%>
<%--                                <td>${doctor.career}</td>--%>
<%--                                <td>${doctor.subjectName}</td>--%>

<%--                            </tr>--%>
<%--                        </c:forEach>--%>
<%--                        </tbody>--%>
<%--                    </table>--%>
<%--                    --%>


                <%--                    <li>--%>
<%--                        <c:forEach var="doctor" items="${doctorlist}">--%>
<%--                        <span class="doctor-information" id="staffIdx_1" value="${doctor.doctorName}" doctor="이가영&nbsp;과장">--%>
<%--                        <span class="type" style="font-size:14px;">${doctor.doctorName}</span>--%>
<%--                        <span class="name" style="font-size:14px;">${doctor.doctorName}</span>--%>
<%--                        </span>--%>
<%--                        </c:forEach>--%>
<%--           -------------------tlqkfsha------------------%>
<%--                    <ul>--%>
<%--                    <li><a href="javascript:void(0);" stfidx="144" reservopen style>--%>
<%--                        <c:forEach var="doctor" items="${doctorlist}">--%>
<%--                        <div class="image-box">--%>
<%--                            <img src="<c:url value="/imgt/dt.png"/>" alt="이가영" class="image-doctor" width="100px">--%>
<%--                        </div>--%>
<%--                        <span class="doctor-information" id="staffIdx_2" major="${doctor.subjectName}" doctor="${doctor.doctorName}">--%>
<%--                            <span class="type" style="font-size:14px;">${doctor.subjectName}</span>--%>
<%--                            <span class="name" style="font-size:14px;">${doctor.doctorName}</span>--%>
<%--                        </span>--%>
<%--                        </a>--%>
<%--                        </c:forEach>--%>
<%--                    </li>--%>
<%--                    </ul>--%>

<%--                    <li><a href="javascript:void(0);" stfidx="144" reservopen style>--%>
<%--                        <div class="image-box">--%>
<%--                            <img src="<c:url value="/imgt/dt.png"/>" alt="이가영" class="image-doctor" width="100px">--%>
<%--                        </div>--%>
<%--                        <span class="doctor-information" id="staffIdx_2" major="가정의학과" doctor="이가영&nbsp;과장">--%>
<%--                            <span class="type" style="font-size:14px;">가정의학과</span>--%>
<%--                            <span class="name" style="font-size:14px;">이가영&nbsp;과장</span>--%>
<%--                        </span>--%>
<%--                    </a>--%>
<%--                    </li>--%>

<%--                </ul>--%>
<%--            </div>--%>
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

<%--        <dl class="phone-reservation">--%>
<%--            <dt>연락처</dt>--%>
<%--            <dd>--%>
<%--                <label for="phone01" class="blind">휴대전화 번호 입력</label>--%>
<%--                <select name="phone01" id="phone01" style="width:72px; height:40px;">--%>
<%--                    <option value="010">010</option>--%>
<%--                    <option value="011">011</option>--%>
<%--                </select>--%>
<%--                <!-- <input type="text" id="phone01" name="phone01" maxlength="3" value="010"/> -->--%>
<%--                <span>-</span>--%>
<%--&lt;%&ndash;                <label for="phone02" class="blind">휴대전화 중간자리 입력</label>&ndash;%&gt;--%>
<%--                <input type="text" id="phone02" name="phone02" maxlength="4">--%>
<%--                <span>-</span>--%>
<%--&lt;%&ndash;                <label for="phone03" class="blind">휴대전화 뒷자리 입력</label>&ndash;%&gt;--%>
<%--                <input type="text" id="phone03" name="phone03" maxlength="4">--%>
<%--            </dd>--%>
<%--        </dl>--%>

        <!-- 강안병원만 -->
        <!--<dl class="phone-reservation">
            <dt>
                주민번호
            </dt>
            <dd>
                <div class="input-jumin-number">
                    <input type="text" id="jumin1" name="jumin1" maxlength="6">
                    <span>-</span>
                    <input type="password" id="jumin2" name="jumin2" maxlength="7">
                </div>
            </dd>
        </dl>-->

        <dl class="phone-reservation">
            <dt>
                보호자이름 (<span class="point02">소아청소년과 예약시 입력</span>)
            </dt>
            <dd>
                <label for="guardianName" class="blind">보호자이름</label>
                <input type="text" id="guardianName" name="guardianName" style="width:100%;">
            </dd>
        </dl>
        <!--  //강안 병원만 -->
        <div class="btnCenter mgt60" style="height:500px">
            <a href="javascript:void(0);" onclick="submitAction();" class="btnTypeJ">예약접수하기</a>
        </div>

    </div>
</div>
</body>
</html>


<!-- Footer Start -->
<div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-lg-3 col-md-6">
                <h4 class="text-white mb-3">Quick Link</h4>
                <a class="btn btn-link" href="<c:url value="/"/>">About Us</a>
                <a class="btn btn-link" href="<c:url value="/"/>">Contact Us</a>
                <a class="btn btn-link" href="<c:url value="/"/>">Privacy Policy</a>
                <a class="btn btn-link" href="<c:url value="/"/>">Terms & Condition</a>
                <a class="btn btn-link" href="<c:url value="/"/>">FAQs & Help</a>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-white mb-3">Contact</h4>
                <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                <div class="d-flex pt-2">
                    <a class="btn btn-outline-light btn-social" href="<c:url value="/"/>"><i class="fab fa-twitter"></i></a>
                    <a class="btn btn-outline-light btn-social" href="<c:url value="/"/>"><i class="fab fa-facebook-f"></i></a>
                    <a class="btn btn-outline-light btn-social" href="<c:url value="/"/>"><i class="fab fa-youtube"></i></a>
                    <a class="btn btn-outline-light btn-social" href="<c:url value="/"/>"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-white mb-3">Gallery</h4>
                <div class="row g-2 pt-2">
                    <div class="col-4">
                        <img class="img-fluid bg-light p-1" src="img/course-1.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid bg-light p-1" src="img/course-2.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid bg-light p-1" src="img/course-3.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid bg-light p-1" src="img/course-2.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid bg-light p-1" src="img/course-3.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid bg-light p-1" src="img/course-1.jpg" alt="">
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h4 class="text-white mb-3">Newsletter</h4>
                <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                <div class="position-relative mx-auto" style="max-width: 400px;">
                    <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                    <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="copyright">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved.

                    <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                    Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a><br><br>
                    Distributed By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <div class="footer-menu">
                        <a href="<c:url value="/"/>">Home</a>
                        <a href="<c:url value="/"/>">Cookies</a>
                        <a href="<c:url value="/"/>">Help</a>
                        <a href="<c:url value="/"/>">FQAs</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->








</body>
</html>