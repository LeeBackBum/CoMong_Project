<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>상세보기 - SM Korea</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="<c:url value='/img/favicon.ico' />" rel="icon">

    <!-- Google Web Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="<c:url value='/lib/animate/animate.min.css' />" rel="stylesheet">
    <link href="<c:url value='/lib/owlcarousel/assets/owl.carousel.min.css' />" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="<c:url value='/css/bootstrap.min.css' />" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="<c:url value='/css/style.css' />" rel="stylesheet">
</head>

<body>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>

    $(document).ready(function () {
        // 페이지 로드 시 댓글 목록 초기화
        const boardId = ${board.boardId}; // 서버에서 전달된 boardId 사용
        reloadComments(boardId);
    });

    // 댓글 추가
    function addComment(boardId) {
        const content = $("#newCommentContent").val().trim();

        if (!content) {
            alert("댓글 내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: "<c:url value='/answers/board/' />" + boardId + "/add",
            method: "POST",
            data: { content },
            success: function (response) {
                console.log("댓글 추가 성공 응답:", response); // 서버 응답 확인

                if (response.status === "success") {
                    console.log("응답 answer 객체:", response.answer); // answer 데이터 점검
                    $("#newCommentContent").val(""); // 입력창 초기화
                    addCommentToDOM(response.answer); // DOM 업데이트
                } else {
                    alert(response.message);
                }
            },
            error: function (xhr) {
                alert("댓글 추가 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
            }
        });
    }

    // 대댓글 추가
    function addReply(parentAnswerId, boardId) {
        console.log("addReply 호출, parentAnswerId:", parentAnswerId, "boardId:", boardId);

        // DOM에서 부모 댓글의 대댓글 입력 필드 찾기
        const contentElement = $(`#replyContent-${parentAnswerId}`);
        if (!contentElement.length) {
            console.error(`ID가 ${parentAnswerId}인 요소를 찾을 수 없습니다.`);
            alert("대댓글 입력란을 찾을 수 없습니다. 댓글 목록을 다시 불러옵니다.");

            // 댓글 목록 다시 로드
            reloadComments(boardId);
            return;
        }

        const content = contentElement.val().trim();
        if (!content) {
            alert("대댓글 내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: '<c:url value="/answers/reply/" />' + parentAnswerId,
            method: "POST",
            data: { content, boardId },
            success: function (response) {
                if (response.status === "success" && response.reply.answerId > 0) {
                    const reply = response.reply;

                    // 대댓글 입력 필드 초기화
                    contentElement.val("");

                    // DOM에 대댓글 추가
                    addReplyToDOM(reply);

                    console.log("대댓글 추가 완료:", reply);
                } else {
                    alert(response.message || "대댓글 추가 실패");
                    reloadComments(boardId); // 댓글 목록 재로드
                }
            },
            error: function (xhr) {
                alert("대댓글 추가 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
                reloadComments(boardId); // 댓글 목록 재로드
            }
        });
    }



    // 댓글 수정
    function editComment(answerId, boardId) {
        const newContent = prompt("수정할 내용을 입력하세요:");
        if (!newContent || newContent.trim() === "") {
            alert("내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: '<c:url value="/answers/edit/" />'+answerId,
            method: "POST",
            data: { content: newContent },
            success: function (response) {
                if (response.status === "success") {
                    // 댓글 목록을 다시 불러오기
                    reloadComments(boardId);
                } else {
                    alert(response.message || "댓글 수정 실패");
                }
            },
            error: function (xhr) {
                console.error("댓글 수정 중 오류:", xhr.responseText);
                alert("댓글 수정 중 문제가 발생했습니다.");
            }
        });
    }




    // 대댓글 수정
    function editReply(replyId, boardId) {
        const newContent = prompt("수정할 내용을 입력하세요:");
        if (!newContent || newContent.trim() === "") {
            alert("내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: '<c:url value="/answers/edit/" />'+replyId,
            method: "POST",
            data: { content: newContent },
            success: function (response) {
                if (response.status === "success") {
                    const updatedReply = response.answer;

                    // DOM 업데이트
                    updateReplyDOM(updatedReply);
                    console.log("대댓글 수정 완료:", updatedReply);
                } else {
                    alert(response.message || "대댓글 수정 실패");
                }
            },
            error: function (xhr) {
                console.error("대댓글 수정 중 오류:", xhr.responseText);
                alert("대댓글 수정 중 문제가 발생했습니다.");
            }
        });
    }

    // 대댓글 DOM 업데이트 함수
    function updateReplyDOM(reply) {
        const replyElement = $(`#comment-${reply.answerId}`);
        if (!replyElement.length) {
            console.error("대댓글 DOM을 찾을 수 없습니다:", reply.answerId);
            return;
        }

        // 날짜 포맷팅
        const formattedDate = new Date(reply.answerDate).toLocaleString("ko-KR", {
            year: "numeric",
            month: "2-digit",
            day: "2-digit",
            hour: "2-digit",
            minute: "2-digit",
        });

        // 작성자와 내용 업데이트
        replyElement.find("p:first").html(
            `<strong>${reply.userName || "알 수 없음"}</strong> - ${formattedDate}`
        );
        replyElement.find("p:nth-of-type(2)").text(reply.answerContent || "내용 없음");
    }





    function updateCommentDOM(answer) {
        const commentElement = $(`#comment-${answer.answerId}`);
        if (!commentElement.length) {
            console.error("댓글 DOM을 찾을 수 없습니다:", answer.answerId);
            return;
        }

        // 날짜 포맷팅
        const formattedDate = new Date(answer.answerDate).toLocaleString("ko-KR", {
            year: "numeric",
            month: "2-digit",
            day: "2-digit",
            hour: "2-digit",
            minute: "2-digit",
        });

        // 작성자와 내용 업데이트
        commentElement.find("p:first").html(
            `<strong>${answer.userName || "알 수 없음"}</strong> - ${formattedDate}`
        );
        commentElement.find("p:nth-of-type(2)").text(answer.answerContent || "내용 없음");
    }






    // 댓글 삭제
    function deleteComment(answerId, boardId) {
        if (!confirm("정말로 삭제하시겠습니까?")) return;

        $.ajax({
            url: "<c:url value='/answers/delete/' />" + answerId,
            method: "POST",
            data: { boardId },
            success: function (response) {
                if (response.status === "success") {
                    reloadComments(boardId); // 댓글 목록 갱신
                } else {
                    alert(response.message || "댓글 삭제 중 문제가 발생했습니다.");
                }
            },
            error: function (xhr) {
                console.error("댓글 삭제 요청 실패:", xhr.responseText);
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    }


    // 댓글 목록 갱신
    function reloadComments(boardId) {
        $.ajax({
            url: '<c:url value="/answers/board/"/>'+ boardId,
            method: "GET",
            success: function (response) {
                if (response.status === "success" && response.answers) {
                    $("#commentList").empty(); // 기존 댓글 목록 비우기
                    response.answers.forEach((answer) => {
                        if (answer.depth === 0) {
                            addCommentToDOM(answer); // 댓글
                        } else {
                            addReplyToDOM(answer); // 대댓글
                        }
                    });
                    console.log("댓글 목록 갱신 완료:", response.answers);
                } else {
                    alert(response.message || "댓글을 불러오는 중 문제가 발생했습니다.");
                }
            },
            error: function (xhr) {
                console.error("AJAX 요청 실패:", xhr.responseText);
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    }







    // 댓글 목록 DOM 업데이트

    function addCommentToDOM(answer) {
        const commentList = $("#commentList");

        // 작성자 정보와 내용
        const userName = answer.userName || "알 수 없음";
        const answerContent = answer.answerContent || "내용 없음";

        // 날짜 변환
        const formattedDate = new Date(answer.answerDate).toLocaleString("ko-KR", {
            year: "numeric",
            month: "2-digit",
            day: "2-digit",
            hour: "2-digit",
            minute: "2-digit",
        });

        // 들여쓰기 계산 (depth에 따라 20px씩 증가)
        const indent = answer.depth * 20;

        // 댓글 DOM 생성
        const commentCard = $("<div>")
            .attr("id", `comment-${answer.answerId}`)
            .addClass("card mb-2")
            .css("margin-left", `${indent}px`); // 들여쓰기 적용

        const cardBody = $("<div>").addClass("card-body");

        const authorDate = $("<p>")
            .append($("<strong>").text(userName))
            .append(` - ${formattedDate}`);
        cardBody.append(authorDate);

        const commentContent = $("<p>").text(answerContent);
        cardBody.append(commentContent);

        const replyForm = $("<form>")
            .attr("id", `replyForm-${answer.answerId}`)
            .addClass("mt-2");
        const replyTextarea = $("<textarea>")
            .attr("id", `replyContent-${answer.answerId}`)
            .addClass("form-control mb-2")
            .attr("rows", 3)
            .attr("placeholder", "대댓글을 입력하세요");
        const replyButton = $("<button>")
            .addClass("btn btn-success btn-sm")
            .attr("type", "button")
            .text("대댓글")
            .click(() => addReply(answer.answerId, answer.boardId));

        replyForm.append(replyTextarea).append(replyButton);
        cardBody.append(replyForm);

        const buttonGroup = $("<div>").addClass("mt-2");
        const editButton = $("<button>")
            .addClass("btn btn-warning btn-sm")
            .attr("type", "button")
            .text("수정")
            .click(() => editReply(answer.answerId, answer.boardId));
        const deleteButton = $("<button>")
            .addClass("btn btn-danger btn-sm")
            .attr("type", "button")
            .text("삭제")
            .click(() => deleteComment(answer.answerId, answer.boardId));

        buttonGroup.append(editButton).append(deleteButton);
        cardBody.append(buttonGroup);

        commentCard.append(cardBody);
        commentList.append(commentCard); // 댓글 목록에 추가
    }





    // 대댓글 DOM에 추가
    function addReplyToDOM(reply) {
        if (!reply.answerId || reply.answerId === 0) {
            console.error("유효하지 않은 answerId:", reply);
            alert("대댓글 추가 중 문제가 발생했습니다. 다시 시도해주세요.");
            return;
        }

        const userName = reply.userName || "알 수 없음";
        const answerContent = reply.answerContent || "내용 없음";

        const formattedDate = new Date(reply.answerDate).toLocaleString("ko-KR", {
            year: "numeric",
            month: "2-digit",
            day: "2-digit",
            hour: "2-digit",
            minute: "2-digit",
        });

        // 들여쓰기 계산 (depth 기반)
        const indent = reply.depth * 20;

        const replyCard = $("<div>")
            .attr("id", `comment-${reply.answerId}`)
            .addClass("card mb-2")
            .css("margin-left", `${indent}px`); // 들여쓰기 동적 적용

        const cardBody = $("<div>").addClass("card-body");

        const authorDate = $("<p>")
            .append($("<strong>").text(userName))
            .append(` - ${formattedDate}`);
        cardBody.append(authorDate);

        const commentContent = $("<p>").text(answerContent);
        cardBody.append(commentContent);

        const replyForm = $("<form>")
            .attr("id", `replyForm-${reply.answerId}`)
            .addClass("mt-2");
        const replyTextarea = $("<textarea>")
            .attr("id", `replyContent-${reply.answerId}`)
            .addClass("form-control mb-2")
            .attr("rows", 3)
            .attr("placeholder", "대댓글을 입력하세요");
        const replyButton = $("<button>")
            .addClass("btn btn-success btn-sm")
            .attr("type", "button")
            .text("대댓글")
            .click(() => addReply(reply.answerId, reply.boardId));

        replyForm.append(replyTextarea).append(replyButton);
        cardBody.append(replyForm);

        const buttonGroup = $("<div>").addClass("mt-2");
        const editButton = $("<button>")
            .addClass("btn btn-warning btn-sm")
            .attr("type", "button")
            .text("수정")
            .click(() => editReply(reply.answerId, reply.boardId));
        const deleteButton = $("<button>")
            .addClass("btn btn-danger btn-sm")
            .attr("type", "button")
            .text("삭제")
            .click(() => deleteComment(reply.answerId, reply.boardId));

        buttonGroup.append(editButton).append(deleteButton);
        cardBody.append(buttonGroup);

        replyCard.append(cardBody);

        // 부모 댓글 아래에 삽입
        const parentComment = $(`#comment-${reply.parentAnswerId}`);
        if (parentComment.length > 0) {
            parentComment.after(replyCard);
        } else {
            console.error(`부모 댓글을 찾을 수 없습니다. parentAnswerId: ${reply.parentAnswerId}`);
            $("#commentList").append(replyCard);
        }
    }




</script>

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
            <!-- 수정 및 삭제 버튼 -->
            <c:if test="${user != null && (user.userId == board.userId || user.role == '1')}">
                <a href="<c:url value='/board/edit/${board.boardId}' />" class="btn btn-warning">수정</a>
                <form action="<c:url value='/board/delete/${board.boardId}' />" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                </form>
            </c:if>
        </div>
    </div>

    <!-- 댓글 작성 -->
    <div class="comment-form">
        <textarea id="newCommentContent" class="form-control mb-2" placeholder="댓글을 입력하세요"></textarea>
        <button type="button" class="btn btn-primary" onclick="addComment(${board.boardId})">댓글 작성</button>
    </div>

    <!-- 댓글 목록 -->
    <div id="commentList">
        <c:forEach var="answer" items="${answers}">
            <div id="comment-${answer.answerId}" class="card mb-2 comment-depth-${answer.depth}">
                <div class="card-body">
                    <p><strong>${answer.userName}</strong> - ${answer.answerDate}</p>
                    <p>${answer.answerContent}</p>

                    <!-- 대댓글 입력 폼 -->
                    <form id="replyForm-${answer.answerId}" class="mt-2">
                        <textarea id="replyContent-${answer.answerId}" class="form-control mb-2" rows="3" placeholder="대댓글을 입력하세요"></textarea>
                        <button type="button" class="btn btn-success btn-sm" onclick="addReply(${answer.answerId}, ${answer.boardId})">대댓글</button>
                    </form>

                    <div class="mt-2">
                        <button type="button" class="btn btn-warning btn-sm" onclick="editReply(${answer.answerId}, ${answer.boardId})">수정</button>
                        <button type="button" class="btn btn-danger btn-sm" onclick="deleteComment(${answer.answerId}, ${answer.boardId})">삭제</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>


</div>


<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

<!-- JavaScript Libraries -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/lib/wow/wow.min.js' />"></script>
<script src="<c:url value='/lib/easing/easing.min.js' />"></script>
<script src="<c:url value='/lib/waypoints/waypoints.min.js' />"></script>
<script src="<c:url value='/lib/owlcarousel/owl.carousel.min.js' />"></script>

<!-- Template Javascript -->
<script src="<c:url value='/js/main.js' />"></script>
</body>
</html>