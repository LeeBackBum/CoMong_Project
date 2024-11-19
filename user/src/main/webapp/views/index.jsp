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
  <!-- Customized Bootstrap Stylesheet -->
  <link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet">

  <!-- Template Stylesheet -->
  <link href="<c:url value="/css/style.css"/>" rel="stylesheet">
  <%--틀 끝--%>
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
      <img class="img-logo" src="img/logo2.jpg" alt="" style="width: 140px; height: auto;">
    </h2>
  </a>
  <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <div class="navbar-nav ms-auto p-4 p-lg-0">
      <a href="<c:url value="/"/>" class="nav-item nav-link active">Home</a>
      <a href="<c:url value="/testdo"/>" class="nav-item nav-link">About</a>
      <a href="<c:url value="/courses"/>" class="nav-item nav-link">Courses</a>
      <a href="<c:url value="/reservation2"/>" class="nav-item nav-link">Reservation</a>
      <div class="nav-item dropdown">
        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
        <div class="dropdown-menu fade-down m-0">
          <a href="<c:url value="/team"/>" class="dropdown-item">Our Team</a>
          <a href="<c:url value="/testimonial"/>" class="dropdown-item">Testimonial</a>
          <a href="<c:url value="/errorpage"/>" class="dropdown-item">404 Page</a>
        </div>
      </div>
      <a href="<c:url value="/contact"/>" class="nav-item nav-link">Contact</a>
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
  </div>
</nav>


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
            <img class="img-fluid bg-light p-1" src="img/course-1.jpg" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="img/course-2.jpg" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="img/course-3.jpg" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="img/course-2.jpg" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="img/course-3.jpg" alt="">
          </div>
          <div class="col-4">
            <img class="img-fluid bg-light p-1" src="img/course-1.jpg" alt="">
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