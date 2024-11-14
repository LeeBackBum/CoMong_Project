<%--
  Created by IntelliJ IDEA.
  User: loplo
  Date: 2024-11-13
  Time: 오후 5:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>


<head>
    <title>Title</title>
    <style>
    </style>
    <script>
    </script>
</head>
<body>
<div class="col-12">
    <div class="bg-light rounded h-100 p-4">
        <h6 class="mb-4">${sessionScope.doctor.doctorName}의 환자 목록</h6>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th scope="col">이름</th>
                    <th scope="col">나이</th>
                    <th scope="col">성별</th>
                    <th scope="col">지병</th>
                    <th scope="col">연락처</th>
                    <th scope="col">예약 종류</th>
                    <th scope="col">날짜</th>
                </tr>
</body>
</html>

