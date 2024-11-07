<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세 보기</title>
    <link href="<c:url value='/css/bootstrap.min.css' />" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3 class="ui dividing header">공지사항 상세 보기</h3>

    <div class="card">
        <div class="card-header">
            <h4>${notice.noticeTitle}</h4>
        </div>
        <div class="card-body">
            <p><strong>작성자:</strong> ${notice.managerId}</p>
            <p><strong>작성일:</strong> ${formattedDate}</p>
            <p><strong>조회수:</strong> ${notice.noticeHits}</p>
            <hr>
            <p>${notice.noticeContent}</p>
        </div>
        <div class="card-footer text-end">
            <a href="<c:url value='/board' />" class="btn btn-secondary">목록으로</a>
        </div>
    </div>
</div>

<script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>
