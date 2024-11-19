<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <link href="<c:url value='/css/bootstrap.min.css' />" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3>새 글 작성</h3>
    <p>작성자: <strong>${userName != null ? userName : '익명'}</strong></p>
    <form action="<c:url value='/board/write' />" method="post" enctype="application/x-www-form-urlencoded">
        <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="boardTitle" maxlength="255" required>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="boardContent" rows="5" maxlength="2000" required></textarea>
        </div>
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">작성하기</button>
            <a href="<c:url value='/board' />" class="btn btn-secondary">뒤로가기</a>
        </div>
    </form>
</div>
</body>
</html>
