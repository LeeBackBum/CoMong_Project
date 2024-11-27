<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>게시판 상세보기 - eLearning HTML Template</title>
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
                        <li class="breadcrumb-item"><a class="text-white" href="<c:url value='/' />">Home</a></li>
                        <li class="breadcrumb-item text-white active" aria-current="page">Board</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- Header End -->

<!-- Board Detail Start -->
<div class="container mt-5">
    <h3 class="ui dividing header">게시글 상세 보기</h3>
<%--    <c:if test="${user.role == '1' || user.userId == board.userId}">--%>
<%--        <a href="<c:url value='/board/edit/${board.boardId}' />" class="btn btn-primary">수정</a>--%>
<%--        <form action="<c:url value='/board/delete/${board.boardId}' />" method="post" style="display:inline;">--%>
<%--            <button type="submit" class="btn btn-danger">삭제</button>--%>
<%--        </form>--%>
<%--    </c:if>--%>
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
            <a href="<c:url value='/board' />" class="btn btn-secondary">목록으로</a>

            <!-- 자신의 게시글이거나 관리자인 경우 수정 및 삭제 버튼 표시 -->
            <c:if test="${sessionScope.loginid != null && (sessionScope.loginid.role == '1' || sessionScope.loginid.userId == board.userId)}">
                <a href="<c:url value='/board/edit/${board.boardId}' />" class="btn btn-primary">수정</a>
                <form action="<c:url value='/board/delete/${board.boardId}' />" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
            </c:if>
    </div>
    <!-- 댓글 작성 폼 -->
    <div class="comment-form mb-4">
        <h5>댓글 작성</h5>
        <form action="<c:url value='/answers/board/${board.boardId}/add' />" method="post">
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
                <!-- 댓글 작성자와 작성일 -->
                <p><strong>${answer.userName}</strong> - ${answer.answerDate}</p>

                <!-- 댓글 내용 -->
                <c:if test="${empty param.editId || param.editId != answer.answerId}">
                    <p>${answer.answerContent}</p>
                </c:if>

                <!-- 댓글 수정 폼 -->
                <c:if test="${!empty param.editId && param.editId == answer.answerId}">
                    <form action="<c:url value='/answers/edit/${answer.answerId}' />" method="post">
                        <textarea name="content" class="form-control mb-2">${answer.answerContent}</textarea>
                        <input type="hidden" name="boardId" value="${board.boardId}">
                        <button type="submit" class="btn btn-primary btn-sm">등록</button>
                        <a href="<c:url value='/board/${board.boardId}' />" class="btn btn-secondary btn-sm">취소</a>
                    </form>
                </c:if>

                <!-- 대댓글 입력창 -->
                <form action="<c:url value='/answers/reply/${answer.answerId}' />" method="post" class="mt-2">
                <textarea name="content"
                          class="form-control mb-2"
                          rows="3"
                          style="width: 50%; height: 80px;"
                          placeholder="대댓글을 입력하세요"
                          required></textarea>
                    <input type="hidden" name="boardId" value="${board.boardId}">
                    <button type="submit" class="btn btn-sm btn-success mb-2">답글</button>
                </form>

                <!-- 자신의 댓글이거나 관리자인 경우 삭제 버튼 표시 -->
                <c:if test="${not empty user and (user.role == '1' || user.userId == answer.userId)}">
                    <div class="d-flex justify-content-start align-items-center">
                        <!-- 수정 버튼 -->
                        <c:if test="${user.userId == answer.userId}">
                            <form action="<c:url value='/board/${board.boardId}' />" method="get" style="margin-right: 5px;">
                                <input type="hidden" name="editId" value="${answer.answerId}">
                                <button type="submit" class="btn btn-sm btn-primary">수정</button>
                            </form>
                        </c:if>

                        <!-- 삭제 버튼 -->
                        <form action="<c:url value='/answers/delete/${answer.answerId}' />" method="post" style="margin-right: 5px;">
                            <input type="hidden" name="boardId" value="${board.boardId}">
                            <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                        </form>
                    </div>
                </c:if>

            </div>
        </div>
    </c:forEach>


</div>
<!-- Board Detail End -->

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
