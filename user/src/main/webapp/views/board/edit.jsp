<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <link href="<c:url value='/css/bootstrap.min.css' />" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3 class="ui dividing header">게시글 수정</h3>
    <form action="<c:url value='/board/edit/${boardDto.boardId}' />" method="post">
    <input type="hidden" name="boardId" value="${boardDto.boardId}">
        <div class="mb-3">
            <label for="title" class="form-label">제목</label>
            <input type="text" class="form-control" id="title" name="boardTitle" value="${boardDto.boardTitle}" required>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">내용</label>
            <textarea class="form-control" id="content" name="boardContent" rows="5" required>${boardDto.boardContent}</textarea>
        </div>
        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="<c:url value='/board/${boardDto.boardId}' />" class="btn btn-secondary">취소</a>
    </form>
</div>
<script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>
