<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3 class="ui dividing header">게시글 상세 보기</h3>

    <!-- 게시글 내용 -->
    <div class="card mb-4">
        <div class="card-header">
            <h4>${board.boardTitle}</h4>
        </div>
        <div class="card-body">
            <p><strong>작성자:</strong> ${board.userName}</p>
            <p><strong>작성일:</strong> ${formattedDate}</p>
            <p><strong>조회수:</strong> ${board.boardHits}</p>
            <hr>
            <p>${board.boardContent}</p>
        </div>
        <div class="card-footer text-end">
            <a href="${pageContext.request.contextPath}/board" class="btn btn-secondary">목록으로</a>
            <a href="${pageContext.request.contextPath}/board/edit/${board.boardId}" class="btn btn-primary">수정</a>
            <form action="${pageContext.request.contextPath}/board/delete/${board.boardId}" method="post" style="display:inline;">
                <button type="submit" class="btn btn-danger">게시글 삭제</button>
            </form>
        </div>
    </div>

    <!-- 댓글 작성 폼 -->
    <div class="comment-form mb-4">
        <h5>댓글 작성</h5>
        <form action="${pageContext.request.contextPath}/answers/board/${board.boardId}/add" method="post">
            <div class="mb-3">
                <textarea name="content" class="form-control" rows="3" placeholder="댓글을 입력하세요..." required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">댓글 작성</button>
        </form>
    </div>

    <!-- 댓글 및 대댓글 목록 -->
    <c:forEach var="answer" items="${answers}">
        <div id="comment-${answer.answerId}" class="card mb-2" style="margin-left: ${answer.depth * 20}px;">
            <div class="card-body">
                <p><strong>${answer.userName}</strong> -
                    <fmt:formatDate value="${answer.answerDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </p>

                <!-- 수정 중인지 확인 -->
                <c:choose>
                    <c:when test="${not empty param.editId and param.editId == answer.answerId}">
                        <!-- 댓글 수정 폼 -->
                        <form action="${pageContext.request.contextPath}/answers/edit/${answer.answerId}" method="post">
                            <textarea name="content" class="form-control" rows="2" required>${answer.answerContent}</textarea>
                            <input type="hidden" name="boardId" value="${board.boardId}">
                            <button type="submit" class="btn btn-sm btn-success">수정 완료</button>
                            <a href="${pageContext.request.contextPath}/board/${board.boardId}" class="btn btn-sm btn-secondary">취소</a>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <!-- 댓글 내용 -->
                        <p>${answer.answerContent}</p>

                        <!-- 버튼 배치 -->
                        <div class="mt-2">
                            <!-- 대댓글 작성 -->
                            <form action="${pageContext.request.contextPath}/answers/reply/${answer.answerId}" method="post" style="display:inline;">
                                <textarea name="content" class="form-control d-inline" rows="1" placeholder="대댓글 입력" required></textarea>
                                <input type="hidden" name="boardId" value="${board.boardId}">
                                <button type="submit" class="btn btn-sm btn-success">대댓글 작성</button>
                            </form>

                            <!-- 댓글 수정 -->
                            <form action="${pageContext.request.contextPath}/board/${board.boardId}" method="get" style="display:inline;">
                                <input type="hidden" name="editId" value="${answer.answerId}">
                                <button type="submit" class="btn btn-sm btn-primary">댓글 수정</button>
                            </form>

                            <!-- 댓글 삭제 -->
                            <form action="${pageContext.request.contextPath}/answers/delete/${answer.answerId}" method="post" style="display:inline;">
                                <input type="hidden" name="boardId" value="${board.boardId}">
                                <button type="submit" class="btn btn-sm btn-danger">댓글 삭제</button>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:forEach>
</div>

</body>
</html>
