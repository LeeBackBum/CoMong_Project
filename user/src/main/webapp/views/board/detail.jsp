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

        const contentElement = $(`#replyContent-${parentAnswerId}`);
        if (!contentElement.length) {
            console.error(`ID가 ${parentAnswerId}인 요소를 찾을 수 없습니다.`);
            alert("대댓글 입력란을 찾을 수 없습니다. 페이지를 새로고침하거나 다시 시도해주세요.");
            return;
        }

        const content = contentElement.val().trim();

        if (!content) {
            alert("대댓글 내용을 입력하세요.");
            return;
        }

        $.ajax({
            url: '<c:url value="/answers/reply/" />'+parentAnswerId,
            method: "POST",
            data: { content, boardId },
            success: function (response) {
                if (response.status === "success") {
                    const reply = response.reply;

                    // 입력창 초기화
                    contentElement.val("");

                    // 대댓글 DOM 추가
                    addReplyToDOM(reply);

                    console.log("대댓글 추가 완료:", reply);
                } else {
                    alert(response.message);
                }
            },
            error: function (xhr) {
                alert("대댓글 추가 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
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
            url: "<c:url value='/answers/edit/' />"+answerId,
            method: "POST",
            data: { content: newContent },
            success: function (response) {
                console.log("댓글 수정 성공 응답:", response);

                if (response.status === "success") {
                    const updatedAnswer = response.answer;

                    // DOM 업데이트: 기존 요소 삭제 후 새로 추가
                    $(`#comment-${answerId}`).remove();
                    addCommentToDOM(updatedAnswer); // 새로 추가

                    console.log("댓글 수정 완료:", updatedAnswer);
                } else {
                    alert(response.message);
                }
            },
            error: function (xhr) {
                alert("댓글 수정 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
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
            url: "<c:url value='/answers/edit/' />"+replyId,
            method: "POST",
            data: { content: newContent },
            success: function (response) {
                console.log("대댓글 수정 성공 응답:", response);

                if (response.status === "success") {
                    const updatedReply = response.answer;

                    // DOM 업데이트
                    const replyElement = $(`#comment-${replyId}`);

                    // 작성자와 날짜 업데이트
                    const formattedDate = new Date(updatedReply.answerDate).toLocaleString("ko-KR", {
                        year: "numeric",
                        month: "2-digit",
                        day: "2-digit",
                        hour: "2-digit",
                        minute: "2-digit",
                    });

                    replyElement.find("p:first").html(
                        `<strong>${updatedReply.userName || "알 수 없음"}</strong> - ${formattedDate}`
                    );

                    // 내용 업데이트
                    replyElement.find("p:nth-of-type(2)").text(updatedReply.answerContent || "내용 없음");

                    console.log("대댓글 수정 완료:", updatedReply);
                } else {
                    alert(response.message);
                }
            },
            error: function (xhr) {
                alert("대댓글 수정 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
            }
        });
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
                    $(`#comment-${answerId}`).remove(); // DOM에서 즉시 삭제
                } else {
                    alert(response.message);
                }
            },
            error: function (xhr) {
                alert("댓글 삭제 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
            }
        });
    }

    // 댓글 목록 갱신
    function reloadComments(boardId) {
        $.ajax({
            url: "<c:url value='/answers/board/' />" + boardId,
            method: "GET",
            success: function (response) {
                if (response.answers) {
                    $("#commentList").empty(); // 기존 댓글 목록 비우기

                    // 댓글 목록 다시 렌더링
                    response.answers.forEach((answer) => {
                        addCommentToDOM(answer);
                    });

                    console.log("댓글 목록 갱신 완료");
                }
            },
            error: function (xhr) {
                alert("댓글 목록 갱신 중 오류가 발생했습니다.");
                console.error(xhr.responseText);
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

        // 댓글 DOM 생성
        const commentCard = $("<div>")
            .attr("id", `comment-${answer.answerId}`)
            .addClass(`card mb-2`)
            .css("margin-left", `${answer.depth * 20}px`); // 들여쓰기 동적 적용

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
            .click(() => editComment(answer.answerId, answer.boardId));
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
            const userName = reply.userName || "알 수 없음";
            const answerContent = reply.answerContent || "내용 없음";

            const formattedDate = new Date(reply.answerDate).toLocaleString("ko-KR", {
                year: "numeric",
                month: "2-digit",
                day: "2-digit",
                hour: "2-digit",
                minute: "2-digit",
            });

            const replyCard = $("<div>")
                .attr("id", `comment-${reply.answerId}`)
                .addClass("card mb-2")
                .css("margin-left", `${reply.depth * 20}px`); // 들여쓰기 적용

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

            // 부모 댓글 바로 아래에 대댓글 추가
            const parentComment = $(`#comment-${reply.parentAnswerId}`);
            if (parentComment.length > 0) {
                parentComment.after(replyCard); // 부모 댓글 바로 아래 추가
            } else {
                console.error(`부모 댓글을 찾을 수 없습니다. parentAnswerId: ${reply.parentAnswerId}`);
                $("#commentList").append(replyCard); // 부모 댓글이 없으면 목록에 추가
            }

            console.log("대댓글 추가 완료:", `#comment-${reply.answerId}`);

            // 대댓글 입력 필드 확인 (수정된 부분)
            const replyField = $(`#replyContent-${reply.answerId}`);
            if (replyField.length > 0) {
                console.log("대댓글 입력 필드 확인 성공:", replyField.attr("id"));
            } else {
                console.error(`대댓글 입력 필드를 찾을 수 없습니다. answerId: ${reply.answerId}`);
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
                        <button type="button" class="btn btn-warning btn-sm" onclick="editComment(${answer.answerId}, ${answer.boardId})">수정</button>
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
