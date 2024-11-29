
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <title>DASHMIN - Bootstrap Admin Template</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">

  <!-- Favicon -->
  <link href="<c:url value="/img/favicon.ico"/>" rel="icon">

  <!-- Google Web Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

  <!-- Icon Font Stylesheet -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

  <!-- Libraries Stylesheet -->
  <link href="<c:url value="/lib/owlcarousel/assets/owl.carousel.min.css"/>" rel="stylesheet">
  <link href="<c:url value="/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"/>" rel="stylesheet" />

  <!-- Customized Bootstrap Stylesheet -->
  <link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet">

  <!-- Template Stylesheet -->
  <link href="<c:url value="/css/style.css"/>" rel="stylesheet">

  <!-- Include jQuery Library -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <script src="/webjars/sockjs-client/sockjs.min.js"></script>
  <script src="/webjars/stomp-websocket/stomp.min.js"></script>

  <script>
    let index = {
      init:function(){
        $('#login_form > button').click(()=>{
          let id = $('#id').val();
          let pwd = $('#pwd').val();
          console.log(id,pwd);
          $('#login_form').attr({
            'action':'<c:url value="/loginimpl"/>',
            'method':'POST'
          });
          $('#login_form').submit();
        });
      }
    };
    $(function(){
      index.init();
    });
  </script>
</head>

<body>
<div class="container-fluid position-relative bg-white d-flex p-0">
  <!-- Spinner Start -->
  <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
      <span class="sr-only">Loading...</span>
    </div>
  </div>
  <!-- Spinner End -->


  <!-- Sign In Start -->
  <div class="container-fluid">
    <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
      <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
        <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
          <div class="d-flex align-items-center justify-content-between mb-3">
            <a href="<c:url value="/"/>" class="">
              <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>DASHMIN</h3>
            </a>
            <h3>Sign In</h3>
          </div>
          <form id="login_form">
            <div class="form-floating mb-3">
              <input type="email" class="form-control" id="id" placeholder="ID" name="id">
              <label for="id">ID</label>
            </div>
            <div class="form-floating mb-4">
              <input type="password" class="form-control" id="pwd" placeholder="Password" name="pwd">
              <label for="pwd">Password</label>
            </div>

            <button type="button" class="btn btn-primary py-3 w-100 mb-4">Sign In</button>
          </form>
          <div class="d-flex align-items-center justify-content-between mb-4">
            <div class="form-check">
              <input type="checkbox" class="form-check-input" id="exampleCheck1">
              <label class="form-check-label" for="exampleCheck1">Check me out</label>
            </div>
            <a href="<c:url value="/"/>">Forgot Password</a>
          </div>

          <p class="text-center mb-0">Don't have an Account? <a href="<c:url value="/"/>">Sign Up</a></p>
        </div>
      </div>
    </div>
  </div>
  <!-- Sign In End -->
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/chart/chart.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>
<script src="lib/tempusdominus/js/moment.min.js"></script>
<script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
<script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>
</body>

</html>