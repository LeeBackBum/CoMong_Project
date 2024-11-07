<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기</title>
    <link href="<c:url value='/css/bootstrap.min.css' />" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3 class="ui dividing header">게시글 상세 보기</h3>

    <div class="card">
        <div class="card-header">
            <h4>${board.boardTitle}</h4>
        </div>
        <div class="card-body">
            <p><strong>작성자:</strong> ${board.userId}</p>
            <p><strong>작성일:</strong> ${formattedDate}</p>
            <p><strong>조회수:</strong> ${board.boardHits}</p>
            <hr>
            <p>${board.boardContent}</p>
        </div>
        <div class="card-footer text-end">
            <a href="<c:url value='/board' />" class="btn btn-secondary">목록으로</a>
            <a href="<c:url value='/board/edit/${board.boardId}' />" class="btn btn-primary">수정</a>

            <!-- 삭제 버튼 (POST 방식으로 삭제 요청 전송) -->
            <form action="<c:url value='/board/delete/${board.boardId}' />" method="post" style="display:inline;">
                <button type="submit" class="btn btn-danger">삭제</button>
            </form>
        </div>
    </div>
</div>

<script src="<c:url value='/js/bootstrap.bundle.min.js' />"></script>
</body>
</html>
