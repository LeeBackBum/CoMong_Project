<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>게시판 - eLearning HTML Template</title>
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
            <li class="breadcrumb-item text-white active" aria-current="page">Board</li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</div>
<!-- Header End -->

<!-- Board Start -->
<div class="container mt-5">
  <h3 class="ui dividing header">게시판</h3>

  <!-- 검색 폼 -->
  <form action="<c:url value='/board' />" method="get" class="d-flex mb-3">
    <input type="text" name="keyword" class="form-control me-2" placeholder="제목 또는 내용 검색" value="${keyword}">
    <button type="submit" class="btn btn-primary">검색</button>
  </form>

  <table class="table">
    <thead>
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>조회수</th>
    </tr>
    </thead>
    <tbody>
    <!-- 공지사항 출력 -->
    <c:forEach var="notice" items="${notices}">
      <tr>
        <td>${notice.noticeId}</td>
        <td><strong>[공지]</strong> <a href="<c:url value='/notice/${notice.noticeId}' />">${notice.noticeTitle}</a></td>
        <td>${notice.managerName}</td> <!-- managerUsername -> managerName -->
        <td>${notice.noticeDate}</td>
        <td>${notice.noticeHits}</td>
      </tr>
    </c:forEach>
    <!-- 일반 게시글 출력 -->
    <c:forEach var="board" items="${boards}">
      <tr>
        <td>${board.boardId}</td>
        <td><a href="<c:url value='/board/${board.boardId}' />">${board.boardTitle}</a></td>
        <td>${board.userName}</td> <!-- userId -> userName -->
        <td>${board.boardDate}</td>
        <td>${board.boardHits}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- 글쓰기 버튼 및 Pagination -->
  <div class="d-flex justify-content-between align-items-center mt-4">
    <!-- 글쓰기 버튼 -->
    <div>
      <a href="<c:url value='/board/write' />" class="btn btn-primary">글쓰기</a>
    </div>

    <!-- Pagination -->
    <div class="pagination d-flex justify-content-center">
      <c:if test="${currentPage > 1}">
        <a href="?page=${currentPage - 1}&size=${pageSize}&keyword=${keyword}" class="btn btn-secondary mx-1">이전</a>
      </c:if>

      <c:forEach var="i" begin="1" end="${totalPages}">
        <a href="?page=${i}&size=${pageSize}&keyword=${keyword}" class="btn mx-1 ${i == currentPage ? 'btn-primary' : 'btn-light'}">${i}</a>
      </c:forEach>

      <c:if test="${currentPage < totalPages}">
        <a href="?page=${currentPage + 1}&size=${pageSize}&keyword=${keyword}" class="btn btn-secondary mx-1">다음</a>
      </c:if>
    </div>
  </div>
</div>
<!-- Board End -->


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
