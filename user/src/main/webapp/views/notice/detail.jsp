<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--notice의 detail.jsp-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>공지사항 상세보기 - SM Korea</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="<c:url value='/img/favicon.ico'/>" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="<c:url value='/lib/animate/animate.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/lib/owlcarousel/assets/owl.carousel.min.css'/>" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="<c:url value='/css/style.css'/>" rel="stylesheet">
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
                        <li class="breadcrumb-item text-white active" aria-current="page">Notice</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- Header End -->

<div class="container mt-5">
    <h3 class="ui dividing header">공지사항 상세 보기</h3>

    <!-- 공지사항 내용 -->
    <div class="card mb-4">
        <div class="card-header">
            <h4>${notice.noticeTitle}</h4>
        </div>
        <div class="card-body">
            <p><strong>작성자:</strong> ${notice.userName}</p>
            <p><strong>작성일:</strong> ${formattedDate}</p>
            <hr>
            <p>${notice.noticeContent}</p>
        </div>
        <div class="card-footer text-end">
            <a href="<c:url value='/board' />" class="btn btn-secondary">목록으로</a>

            <!-- role이 1인 사용자만 수정 및 삭제 버튼 표시 -->
            <c:if test="${sessionScope.loginid != null && sessionScope.loginid.role == '1'}">
                <a href="<c:url value='/notice/edit/${notice.noticeId}' />" class="btn btn-primary">수정</a>
                <form action="<c:url value='/notice/delete/${notice.noticeId}' />" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
            </c:if>
        </div>
    </div>
</div>
<!-- Notice Detail End -->

<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/lib/wow/wow.min.js'/>"></script>
<script src="<c:url value='/lib/easing/easing.min.js'/>"></script>
<script src="<c:url value='/lib/waypoints/waypoints.min.js'/>"></script>
<script src="<c:url value='/lib/owlcarousel/owl.carousel.min.js'/>"></script>

<!-- Template Javascript -->
<script src="<c:url value='/js/main.js'/>"></script>
</body>
</html>
