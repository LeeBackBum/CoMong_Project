<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <title>eLEARNING - eLearning HTML Template</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">


  <!-- map -->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8848ba17cfa4393e77b560b938dc5a46&libraries=services"></script>




  <!-- Favicon -->
  <link href="<c:url value="/img/icon.ico"/>" rel="icon">

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
  <%-- reservation css--%>
  <link href="<c:url value="/css/contents.css"/>" rel="stylesheet">
  <!-- Customized Bootstrap Stylesheet -->
  <link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet">

  <!-- Template Stylesheet -->
  <link href="<c:url value="/css/style.css"/>" rel="stylesheet">
  <%--틀 끝--%>

  <%-- web socket --%>
  <script src="/webjars/sockjs-client/sockjs.min.js"></script>
  <script src="/webjars/stomp-websocket/stomp.min.js"></script>
  <style>
    /* 버튼 스타일 */
    #chatbot-button {
      position: fixed;
      bottom: 30px;
      left: 30px;
      background-color: #06bbcc;
      color: white;
      border: none;
      border-radius: 50%;
      width: 60px;
      height: 60px;
      font-size: 24px;
      cursor: pointer;
      z-index: 1000;
    }

    #chatbot-popup.open {
      display: block; /* 열렸을 때 표시 */
    }

    #chatbot-popup {
      position: fixed;
      bottom: 30px; /* 팝업 위치 */
      left: 30px;
      width: 300px; /* 팝업 너비 */
      height: 500px; /* 팝업 전체 높이 조정 */
      border: 1px solid #ccc;
      background: white;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
      z-index: 1000;
      display: none; /* 기본적으로 숨김 */
    }

    .chat-header {
      background-color: #06bbcc;
      color: white;
      padding: 10px;
      font-size: 18px;
      font-weight: bold;
      text-align: center;
    }

    .chat-body {
      padding: 10px;
      height: calc(100% - 110px); /* 팝업 높이에서 헤더(50px)와 푸터(60px) 제외 */
      overflow-y: auto; /* 내용이 많으면 스크롤 활성화 */
      background-color: #f9f9f9;
    }

    .chat-footer {
      display: flex;
      padding: 10px;
      height: 60px; /* 푸터 높이 */
      border-top: 1px solid #ddd;
      background-color: white;
    }

    .chat-footer input {
      flex: 1;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }

    .chat-footer button {
      background-color: #06bbcc;
      color: white;
      border: none;
      padding: 10px 15px;
      margin-left: 5px;
      border-radius: 4px;
      cursor: pointer;
    }
  </style>
</head>

<body>
<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
  <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>
<!-- Spinner End -->



<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
  <a href="<c:url value="/"/> " class="navbar-brand d-flex align-items-center px-4 px-lg-5">
    <h2 class="m-0 text-primary">
      <img class="img-logo" src="<c:url value='/img/logo2.jpg'/>"  alt="" style="width: 140px; height: auto;">
    </h2>
  </a>
  <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <div class="navbar-nav ms-auto p-4 p-lg-0">
      <a href="<c:url value="/"/>" class="nav-item nav-link active">Home</a>
      <a href="<c:url value="/about"/>" class="nav-item nav-link">About</a>
      <a href="<c:url value="/webrtc"/>" class="nav-item nav-link">WebRTC</a>
      <a href="<c:url value="/reservation"/>" class="nav-item nav-link">Reservation</a>
      <a href="<c:url value="/mapTest"/>" class="nav-item nav-link">Map</a>
      <div class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
        <div class="dropdown-menu fade-down m-0">
          <a href="<c:url value="/team"/>" class="dropdown-item">Our Team</a>
          <a href="<c:url value="/testimonial"/>" class="dropdown-item">Testimonial</a>
          <a href="<c:url value="/errorpage"/>" class="dropdown-item">404 Page</a>
        </div>
      </div>
      <a href="<c:url value="/counseling"/>" class="nav-item nav-link">Counseling</a>
      <a href="<c:url value="/board"/>" class="nav-item nav-link">게시판</a>
    </div>
    <ul class="nav justify-content-end">
      <c:choose>
      <c:when test="${sessionScope.loginid == null}">
        <a href="<c:url value="/login"/>" class=""
           style="background-color: #38c9d6; color: #ffff; padding: 10.5px 22.5px; border-radius: 5px; font-weight:400; font-size:1rem; margin-right: 30px; ">
          Join Now
          <i class=""></i></a>
      </c:when>
      <c:otherwise>
      <li>
        <div class="nav-item dropdown">
          <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
             style="background-color: #38c9d6; color: #ffffff; padding: 10px 20px; border-radius: 5px; font-weight: 400; font-size: 1rem; margin-right: 30px;">
              ${sessionScope.loginid.userName}님
          </a>
          <div class="dropdown-menu fade-down m-0" style="right: 0; width: 10px;">
            <a href="<c:url value="/mypage"/>" class="dropdown-item">MyPage</a>
            <a href="<c:url value="/recordpage"/>" class="dropdown-item">Record</a>
            <a href="<c:url value="/logoutimpl"/>" class="dropdown-item">LogOut</a>
          </div>
        </div>
      </li>
      </c:otherwise>
      </c:choose>

    </ul>
    <!-- Chatbot Button -->
    <button id="chatbot-button">🤖</button>

    <!-- Chatbot Popup -->
    <div id="chatbot-popup">
      <div class="chat-header">Chatbot</div>
      <div class="chat-body" id="chatbox">
        <!-- 메시지가 여기에 추가됩니다 -->
      </div>
      <div class="chat-footer">
        <input id="user-input" type="text" placeholder="Type a message">
        <button id="send-button">Send</button>
      </div>
    </div>
  </div>
</nav>



<!-- JavaScript -->
<script>
  document.addEventListener("DOMContentLoaded", () => {
    const chatbotButton = document.getElementById("chatbot-button");
    const chatbotPopup = document.getElementById("chatbot-popup");
    const userInput = document.getElementById("user-input");
    const chatbox = document.getElementById("chatbox");
    const sendButton = document.getElementById("send-button");

    let stompClient = null;

    // 챗봇 팝업 열기/닫기
    chatbotButton.addEventListener("click", () => {
      chatbotPopup.classList.toggle("open");
    });

    // WebSocket 연결
    function connectWebSocket() {
      const socket = new SockJS('/chatbot'); // WebSocket 엔드포인트
      stompClient = Stomp.over(socket);

      stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);

        // 서버에서 메시지 수신
        stompClient.subscribe('/sendto/user1', function (message) {
          const msg = JSON.parse(message.body);
          addMessage(`Bot: ${msg.content1}`, 'left');
        });
      }, function (error) {
        console.error('WebSocket connection error:', error);
      });
    }

    // 메시지 추가 함수
    function addMessage(message, align) {
      const messageDiv = document.createElement('div');
      messageDiv.textContent = message;
      messageDiv.style.textAlign = align;
      messageDiv.style.marginBottom = "10px";
      messageDiv.style.padding = "5px 10px";
      messageDiv.style.borderRadius = "10px";
      messageDiv.style.backgroundColor = align === 'right' ? '#06bbcc' : '#ddd';
      messageDiv.style.color = align === 'right' ? 'white' : 'black';
      chatbox.appendChild(messageDiv);
      chatbox.scrollTop = chatbox.scrollHeight; // 스크롤 아래로 이동
    }

    // 메시지 전송
    function sendMessage() {
      const message = userInput.value.trim();
      if (message) {
        // 사용자 메시지 표시
        addMessage(`You: ${message}`, 'right');

        // 서버로 메시지 전송
        if (stompClient) {
          stompClient.send('/app/sendchatbot', {}, JSON.stringify({ sendid: 'user1', content1: message }));
        }

        // 입력 필드 초기화
        userInput.value = '';
      }
    }

    // 메시지 전송 버튼 클릭 이벤트
    sendButton.addEventListener("click", sendMessage);

    // Enter 키로 메시지 전송
    userInput.addEventListener("keydown", (event) => {
      if (event.key === "Enter") {
        sendMessage();
        event.preventDefault();
      }
    });

    // WebSocket 연결 초기화
    connectWebSocket();
  });

</script>


<!-- Navbar End -->
<div class="container-fluid" style="margin-top:0px">
  <div class="row">
    <c:choose>
      <c:when test="${center == null}">
        <jsp:include page="center.jsp"/>
      </c:when>
      <c:otherwise>
        <jsp:include page="${center}.jsp"/>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<!-- Carousel Start -->

<!-- Testimonial End -->


<!-- Footer Start -->
<div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
  <div class="container py-5">
    <div class="row g-5">
      <div class="col-lg-3 col-md-6">
        <h4 class="text-white mb-3">Quick Link</h4>
        <a class="btn btn-link" href="<c:url value="/"/>">About Us</a>
        <a class="btn btn-link" href="<c:url value="/"/>">Contact Us</a>
        <a class="btn btn-link" href="<c:url value="/"/>">Privacy Policy</a>
        <a class="btn btn-link" href="<c:url value="/"/>">Terms & Condition</a>
        <a class="btn btn-link" href="<c:url value="/"/>">FAQs & Help</a>
      </div>
      <div class="col-lg-3 col-md-6">
        <h4 class="text-white mb-3">Contact</h4>
        <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
        <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
        <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
        <div class="d-flex pt-2">
          <a class="btn btn-outline-light btn-social" href="<c:url value="/"/>"><i class="fab fa-twitter"></i></a>
          <a class="btn btn-outline-light btn-social" href="<c:url value="/"/>"><i class="fab fa-facebook-f"></i></a>
          <a class="btn btn-outline-light btn-social" href="<c:url value="/"/>"><i class="fab fa-youtube"></i></a>
          <a class="btn btn-outline-light btn-social" href="<c:url value="/"/>"><i class="fab fa-linkedin-in"></i></a>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <h4 class="text-white mb-3">Gallery</h4>
        <div class="row g-2 pt-2">
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src=<c:url value="/img/course-1.jpg" /> alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="<c:url value='/img/course-2.jpg' />" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="<c:url value='/img/course-3.jpg' />" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="<c:url value='/img/course-2.jpg' />" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="<c:url value='/img/course-1.jpg' />" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="<c:url value='/img/course-1.jpg' />" alt="">
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6">
        <h4 class="text-white mb-3">Newsletter</h4>
        <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
        <div class="position-relative mx-auto" style="max-width: 400px;">
          <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
          <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
        </div>
      </div>
    </div>
  </div>
  <div class="container">
    <div class="copyright">
      <div class="row">
        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
          &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved.

          <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
          Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a><br><br>
          Distributed By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
        </div>
        <div class="col-md-6 text-center text-md-end">
          <div class="footer-menu">
            <a href="<c:url value="/"/>">Home</a>
            <a href="<c:url value="/"/>">Cookies</a>
            <a href="<c:url value="/"/>">Help</a>
            <a href="<c:url value="/"/>">FQAs</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Footer End -->


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