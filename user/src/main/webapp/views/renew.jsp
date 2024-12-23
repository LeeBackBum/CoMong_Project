<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<style>
  .form-floating {
    width: auto; /* form-floating이 버튼 옆에 배치되도록 */
  }

  .btn-secondary {
    height: 100%; /* 버튼 높이를 입력 필드와 맞추기 */
  }

  .custom-button {
    width: 100px; /* 원하는 너비 */
    /*height: 40px; !* 원하는 높이 *!*/
  }

  .slide-left {
    transform: translateX(-100%);
    transition: transform 0.5s ease;
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
<!-- Spinner Start -->


<!-- Navbar End -->


<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-10 text-center">
        <h1 class="display-3 text-white animated slideInDown">Update Profile</h1>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb justify-content-center">
            <li class="breadcrumb-item"><a class="text-white" href="<c:url value="/"/> ">Home</a></li>
            <li class="breadcrumb-item"><a class="text-white" href="<c:url value="renew"/> ">Update</a></li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</div>
<!-- Header End -->


<!-- Login Start -->
<div class="container-xxl py-5">
  <div class="container">
    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
      <h6 class="section-title bg-white text-center text-primary px-3">Profile</h6>
      <h1 class="mb-5">Edit</h1>
    </div>
    <div class="row g-4 justify-content-center">
      <div class="col-lg-8 col-md-12 wow fadeInUp" data-wow-delay="0.5s">
        <!-- form-container-wrapper에 중앙 정렬 추가 -->
        <div class="form-container-wrapper">
          <div id="form-container" class="form-container">
            <form id="register_form" method="post" action="/updateimpl">
              <!-- 기존 login_form 섹션 -->
              <div id="login_section" class="row g-3" style="max-width: 500px; margin: auto;">
                <div class="col-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" id="email" name="userEmail" placeholder="New Email">
                    <label for="email">New Email</label>
                  </div>
                </div>
                <div class="col-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" id="phone" name="userNumber" placeholder="New Phone">
                    <label for="phone">New Phone</label>
                  </div>
                </div>
                <div class="col-12">
                  <div class="form-floating">
                    <input type="text" class="form-control" id="address" name="userAddress" placeholder="New Address">
                    <label for="address">New Address</label>
                  </div>
                </div>
                <div class="col-12">
                  <button id="update-button" class="btn btn-primary w-100 py-3" type="submit">Update</button>
                </div>
                <div class="col-12 d-flex justify-content-center">
                  <a href="<c:url value="/forgot"/>" class="btn custom-register-btn w-100 py-3">Edit Password</a>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  /* form-container-wrapper에 중앙 정렬 추가 */
  .form-container-wrapper {
    display: flex;
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    overflow: hidden;
    width: 100%;
  }

  .custom-register-btn:hover {
    border-radius: 50px !important;
    background-color: #ECEBFF; /* 진한 파란색으로 hover 효과 */
    color: #000;
  }

  .form-container {
    transition: transform 0.5s ease;
    width: 100%; /* 화면에 한 번에 하나의 폼만 보이도록 */
    max-width: 400px; /* 최대 너비를 제한하여 폼 크기 조정 */
    margin: auto; /* 중앙 정렬 */
  }

  .form-slide-left {
    transform: translateX(-100%); /* 기존 폼이 완전히 왼쪽으로 이동하여 새로운 폼이 중앙에 나타남 */
  }

  #login_form, #new-form {
    width: 100%; /* 각각의 폼이 전체 컨테이너를 차지하도록 */
    flex-shrink: 0; /* 폼이 줄어들지 않도록 고정 */
  }

  .form-floating.d-flex {
    align-items: center; /* 중앙 정렬 */
  }
  .form-floating.d-flex input[type="number"] {
    max-width: 100px; /* 입력 필드 너비 조정 */
  }
  .form-floating label {
    margin-right: 10px;
  }
</style>


<script>
  let detail = {
    init:function(){
      $('#update_button').click(() => {
        this.check();
      })
    },
    check:function(){
      let email = $('#email').val();
      let phone = $('#phone').val();
      let address = $('#address').val();
      console.log("Email: ", email, "Phone: ", phone, "Address: ", address);

      if(email == '' || email == null){
        alert('email is Mandatory');
        $('#email').focus();
        return;
      }
      if(phone == '' || phone == null){
        alert('phone is Mandatory');
        $('#phone').focus();
        return;
      }
      if(address == '' || address == null){
        alert('address is Mandatory');
        $('#address').focus();
        return;
      }
      this.send();
    },
    send:function(){
      console.log('Form Data:', $('#register_form').serialize());
      $('#register_form').attr('method','post');
      $('#register_form').attr('action','/updateimpl');
      $('#register_form').submit();
    }
  }
  $(function(){
    detail.init();
  })
</script>



<!-- Contact End -->


<!-- Footer Start -->

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