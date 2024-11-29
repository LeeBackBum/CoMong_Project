<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>

    <meta charset="utf-8">
    <title>Appointment List</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="<c:url value='/img/favicon.ico'/>" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="<c:url value='/lib/owlcarousel/assets/owl.carousel.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css'/>" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="<c:url value='/css/style.css'/>" rel="stylesheet">

    <script>
        let user_chart = {
            select:function(id){
                let c = confirm('차트를 확인하시겠습니까?');
                if(c == true){
                    location.href = '<c:url value="/user/chart"/>?id='+id;
                }
            }
        };
    </script>
</head>
<body>
<div class="container-fluid pt-4 px-4">
        <div class="col-sm12 col-xl-12">
            <div class="bg-light rounded h-100 p-4">
                <h6 class="mb-4">${sessionScope.doctor.doctorName}의 환자 목록</h6>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th scope="col">이름</th>
                            <th scope="col">나이</th>
                            <th scope="col">성별</th>
                            <th scope="col">연락처</th>
                            <th scope="col">마지막 예약 날짜</th>
                            <th scope="col">차트</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="a" items="${cpage.getList()}">
                            <tr>
                                <td><a href="<c:url value="/user/detail"/>?id=${a.userId}">${a.userName}</a></td>
                                <td>${a.userAge}</td>
                                <td>${a.userSex}</td>
                                <td>${a.userNumber}</td>
                                <td><fmt:formatDate value="${a.date}" pattern="yyyy년 M월 d일 a h시 m분" /></td>
                                <td>
                                <button onclick="user_chart.select('${a.userId}')" type="button" class="btn btn-outline-success m-1">Chart</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <jsp:include page="../nav.jsp"/>
                </div>
            </div>
        </div>
</div>
</body>
