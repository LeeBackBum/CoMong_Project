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
    <h3 class="ui dividing header">새 글 작성</h3>
    <form action="<c:url value='/board/write' />" method="post">
        <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="boardTitle" required>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="boardContent" rows="5" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">작성하기</button>
        <a href="<c:url value='/board' />" class="btn btn-secondary">뒤로가기</a>
    </form>
</div>
</body>
</html>
