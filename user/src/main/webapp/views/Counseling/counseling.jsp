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
</head>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<body>
<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-10 text-center">
        <h1 class="display-3 text-white animated slideInDown">Counseling</h1>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb justify-content-center">
            <li class="breadcrumb-item"><a class="text-white" href="<c:url value="/"/> ">Home</a></li>
            <li class="breadcrumb-item"><a class="text-white" href="<c:url value="/"/> ">수정</a></li>
            <li class="breadcrumb-item text-white active" aria-current="page">수정</li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</div>
<!-- Header End -->
<!-- Counseling Start -->


<style>
  #all {
    width: 400px;
    height: 200px;
    overflow: auto;
    border: 2px;
  }
</style>

<script>
  let websocket = {
    id:'',
    stompClient:null,
    init:function(){
      this.id = $('#adm_id').text();
      $('#connect').click(()=>{
        this.connect();
      });
      $('#disconnect').click(()=>{
        this.disconnect();
      });
      $('#sendall').click(()=>{
        let msg = JSON.stringify({
          'sendid' : this.id,
          'content1' : $("#alltext").val()
        });
        this.stompClient.send("/receiveall", {}, msg);
      });
      $('#sendme').click(()=>{
        let msg = JSON.stringify({
          'sendid' : this.id,
          'content1' : $("#metext").val()
        });
        this.stompClient.send("/receiveme", {}, msg);
      });
      $('#sendto').click(()=>{
        var msg = JSON.stringify({
          'sendid' : this.id,
          'receiveid' : $('#target').val(),
          'content1' : $('#totext').val()
        });
        this.stompClient.send('/receiveto', {}, msg);
      });
    },
    connect:function(){
      let sid = this.id;
      let socket = new SockJS('${serverurl}/ws');
      this.stompClient = Stomp.over(socket);

      this.stompClient.connect({}, function(frame) {
        websocket.setConnected(true);
        console.log('Connected: ' + frame);
        this.subscribe('/send', function(msg) {
          $("#all").prepend(
                  "<h4>" + JSON.parse(msg.body).sendid +":"+
                  JSON.parse(msg.body).content1
                  + "</h4>");
        });
        this.subscribe('/send/'+sid, function(msg) {
          $("#me").prepend(
                  "<h4>" + JSON.parse(msg.body).sendid +":"+
                  JSON.parse(msg.body).content1+ "</h4>");
        });
        this.subscribe('/send/to/'+sid, function(msg) {
          $("#to").prepend(
                  "<h4>" + JSON.parse(msg.body).sendid +":"+
                  JSON.parse(msg.body).content1
                  + "</h4>");
        });
      });
    },
    disconnect:function(){
      if (this.stompClient !== null) {
        this.stompClient.disconnect();
      }
      websocket.setConnected(false);
      console.log("Disconnected");
    },
    setConnected:function(connected){
      if (connected) {
        $("#status").text("Connected");
      } else {
        $("#status").text("Disconnected");
      }
    }
  };
  $(function(){
    websocket.init();
  });
</script>

<div class="container-fluid">
  <div class="card shadow mb-4">
    <div class="card-body">
      <div class="table-responsive">
        <div class="col-sm-5">
          <h1 id="adm_id">${sessionScope.loginid.userId}</h1>
          <H1 id="status">Status</H1>
          <button id="connect">Connect</button>
          <button id="disconnect">Disconnect</button>

          <h3>All</h3>
          <div id="all"></div>
          <input type="text" id="alltext"><button id="sendall">Send</button>
        </div>
      </div>
    </div>
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