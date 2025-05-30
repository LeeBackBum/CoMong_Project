<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<style>
  .custom-register-btn:hover {
    border-radius: 50px !important;
    background-color: #ECEBFF; /* 진한 파란색으로 hover 효과 */
    color: #000;
  }
  .custom-forgot-btn:hover {
    border-radius: 50px !important;
    background-color: #ECEBFF; /* 진한 파란색으로 hover 효과 */
    color: #000;
  }

</style>

<head>
  <meta charset="utf-8">
  <title>eLEARNING - eLearning HTML Template</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">

  <!-- Favicon -->
  <link href="<c:url value="/img/favicon.ico"/>" rel="icon">

  <!-- Google Web Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

  <!-- Icon Font Stylesheet -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">


  <!-- Libraries Stylesheet -->
  <link href="<c:url value="/lib/animate/animate.min.css"/>" rel="stylesheet">
  <link href="<c:url value="/lib/owlcarousel/assets/owl.carousel.min.css"/>" rel="stylesheet">

  <%-- 틀--%>
  <!-- Customized Bootstrap Stylesheet -->
  <link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet">

  <!-- Template Stylesheet -->
  <link href="<c:url value="/css/style.css"/>" rel="stylesheet">
  <%--틀 끝--%>
  <link href="<c:url value="/css/chat.css"/> " rel="stylesheet">

</head>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<body>
<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-10 text-center">
        <h1 class="display-3 text-white animated slideInDown">채팅 상담</h1>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb justify-content-center">
            <li class="breadcrumb-item"><a class="text-white" href="<c:url value="/"/> ">Home</a></li>
            <li class="breadcrumb-item"><a class="text-white" href="<c:url value="/"/> ">Page</a></li>
            <li class="breadcrumb-item text-white active" aria-current="page">Chat</li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</div>
<!-- Header End -->
<!-- Counseling Start -->



<script>
  let websocket = {
    id: '', // 사용자 ID (로그인한 사용자 이름)
    stompClient: null,
    reconnectAttempts: 0,
    maxReconnectAttempts: 10,
    init: function () {
      this.id = '${userName}'; // JSP에서 전달된 사용자 이름 사용
      console.log("Initialized WebSocket for user:", this.id);

      $('#connect').click(() => {
        this.connect();
      });
      $('#disconnect').click(() => {
        this.disconnect();
      });
      $('#sendall').click(() => {
        let msg = JSON.stringify({
          'sendid': this.id, // 로그인한 사용자 이름 포함
          'content1': $("#alltext").val()
        });
        this.stompClient.send("/receiveall", {}, msg);

        $("#alltext").val('');
      });

      // 페이지 로드 시 자동으로 connect 호출
      this.connect();
    },
    connect: function () {
      let sid = this.id;
      let socket = new SockJS('${serverurl}/ws'); // JSP에서 전달된 서버 URL 사용
      this.stompClient = Stomp.over(socket);

      this.stompClient.connect({}, function (frame) {
        websocket.setConnected(true);
        console.log('WebSocket Connected: ' + frame);

        // 연결 성공 메시지를 채팅창에 추가
        $("#all").append(
                "<p>연결되었습니다.</p>" +
                "<hr>"
        );

        // /send 경로 구독
        this.subscribe('/send', function (msg) {
          const parsedMsg = JSON.parse(msg.body);
          $("#all").append(
                  "<h5>" + parsedMsg.sendid + "</h5>" +
                  "<p>" + parsedMsg.content1 + "</p>" +
                  "<hr>"
          );
        });
      });
    },
    disconnect: function () {
      if (this.stompClient !== null) {
        this.stompClient.disconnect();
      }
      this.setConnected(false);
      console.log("WebSocket Disconnected");
    },
    setConnected: function (connected) {
      if (connected) {
        $("#status").text("Connected");
      } else {
        $("#status").text("Disconnected");
      }
    }
  };

  $(function () {
    websocket.init(); // 페이지 로드 시 WebSocket 초기화
  });
</script>

<style>
  #all h5 {
    margin-top: 5px;
  }
  #all hr {
    margin: 2px 0; /* 위아래 간격을 2px로 설정 */
    border: none; /* 기본 테두리 제거 */
    border-top: 1px solid #ccc; /* 얇은 구분선 */
  }
  #all p {
    margin: 2px 0;
    border: none;
    margin-left: 5px;
  }
</style>

<div id="chat-page">
  <div class="chat-container">
    <!-- 헤더 -->
    <div class="chat-header">
      <h2 id="chat-text">Chat</h2>
    </div>

    <!-- 메시지 리스트 -->
    <ul id="all" class="list-group message-list"></ul>

    <!-- 메시지 입력 -->
    <form id="messageForm" name="messageForm" class="form-group">
      <div class="input-group clearfix">
        <input
                type="text"
                id="alltext"
                placeholder="Enter your message here"
                autocomplete="off"
                class="form-control"
        />
        <button id="sendall" type="button" class="btn btn-primary">Send</button>
      </div>
    </form>
  </div>
</div>






<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/wow/wow.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>
</body>

</html>