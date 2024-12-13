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
  <script src="https://cdn.iamport.kr/v1/iamport.js"></script>

  <!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<body>
<!-- Spinner Start -->


<!-- Navbar End -->


<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-10 text-center">
        <h1 class="display-3 text-white animated slideInDown">About Us</h1>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb justify-content-center">
            <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
            <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
            <li class="breadcrumb-item text-white active" aria-current="page">About</li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</div>
<!-- Header End -->


<!-- Service Start -->
<div class="container-xxl py-5">
  <div class="container">
    <div class="row g-4">
      <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.1s">
        <div class="service-item text-center pt-3">
          <div class="p-4">
            <i class="fa fa-3x fa-graduation-cap text-primary mb-4"></i>
            <h5 class="mb-3">맞춤형 건강관리</h5>
            <p>실시간 의료진과의 화상 상담을 지원하고 진료 예약 기능으로 일정 관리 간소화할 수 있는 서비스 제공.</p>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.3s">
        <div class="service-item text-center pt-3">
          <div class="p-4">
            <i class="fa fa-3x fa-globe text-primary mb-4"></i>
            <h5 class="mb-3">헬스케어 장비 연계</h5>
            <p> 헬스케어 장비에서 수집된 데이터를 기반으로 실시간 상태를 평가하여 필요한 경우 즉각 대응합니다.</p>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.5s">
        <div class="service-item text-center pt-3">
          <div class="p-4">
            <i class="fa fa-3x fa-home text-primary mb-4"></i>
            <h5 class="mb-3">의료 상담 및 진료 관리</h5>
            <p>환자의 실시간 건강 데이터를 모니터링하여 신속히 상태를 파악하고 진료가 가능한 맞춤형 상담을 제공합니다.</p>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.7s">
        <div class="service-item text-center pt-3">
          <div class="p-4">
            <i class="fa fa-3x fa-book-open text-primary mb-4"></i>
            <h5 class="mb-3">실시간 건강확인</h5>
            <p> 환자는 병원 방문 없이도 실시간으로 자신의 건강 상태를 관리할 수 있는 건강 정보를 제공합니다.         </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Service End -->


<!-- About Start -->
<div class="container-xxl py-5">
  <div class="container">
    <div class="row g-5">
      <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.1s" style="min-height: 400px;">
        <div class="position-relative h-100">
          <img class="img-fluid position-absolute w-100 h-100" src="img/docgg.jpg" alt="" style="object-fit: cover;">
        </div>
      </div>
      <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.3s">
        <h6 class="section-title bg-white text-start text-primary pe-3">About Us</h6>
        <h1 class="mb-4">COMONG에 오신 것을 환영합니다</h1>
        <p class="mb-4">환자와 의료진을 연결하여 실시간 건강 관리를 지원하는 스마트 헬스케어 서비스를 소개합니다. 헬스케어 기술을 활용하여 환자의 건강 데이터를 실시간으로 모니터링하며 의료진이 필요한 순간에 신속히 대응할 수 있도록 설계된 서비스를 제공합니다.</p>

        <div class="row gy-2 gx-4 mb-4">
          <div class="col-sm-6">
            <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>맞춤형 건강관리</p>
          </div>
          <div class="col-sm-6">
            <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>헬스케어 장비 연계</p>
          </div>
          <div class="col-sm-6">
            <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>의료 상담 및 진료 관리</p>
          </div>
          <div class="col-sm-6">
            <p class="mb-0"><i class="fa fa-arrow-right text-primary me-2"></i>실시간 건강확인</p>
          </div>
        </div>
        <a class="btn btn-primary py-3 px-5 mt-2" href="">COMONG</a>
      </div>
    </div>
  </div>
</div>
<!-- About End -->

<div class="container-xxl py-5">
  <div class="container">
    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
      <h6 class="section-title bg-white text-center text-primary px-3">payment</h6>
      <h1 class="mb-5">Comong 멤버십</h1>
    </div>
    <div class="row g-4 justify-content-center">
      <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
        <div class="course-item bg-light">
          <div class="position-relative overflow-hidden">
            <img class="img-fluid" src="<c:url value="img/pexels-oles-kanebckuu-34911-127873.jpg"/>" alt="">
            <div class="w-100 d-flex justify-content-center position-absolute bottom-0 start-0 mb-4">
              <button href="#" class="flex-shrink-0 btn btn-sm btn-primary px-3 border-end pay-button1" style="border-radius: 30px 0 0 30px;">결제하기</button>
              <a href="<c:url value="/login"/> " class="flex-shrink-0 btn btn-sm btn-primary px-3" style="border-radius: 0 30px 30px 0;">로그인</a>
            </div>
          </div>
          <div class="text-center p-4 pb-0">
            <h3 class="mb-0">9900원</h3>
            <div class="mb-3">
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small>(90)</small>
            </div>
            <h5 class="mb-4">기본적인 실시간 건강 모니터링과 월간 리포트</h5>
          </div>
          <div class="d-flex border-top">
            <small class="flex-fill text-center border-end py-2"><i class="fa fa-user-tie text-primary me-2"></i>Nomal 스탠다드</small>
            <small class="flex-fill text-center border-end py-2"><i class="fa fa-clock text-primary me-2"></i>1달</small>
            <small class="flex-fill text-center py-2"><i class="fa fa-user text-primary me-2"></i>877 users</small>
          </div>
        </div>
      </div>
      <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
        <div class="course-item bg-light">
          <div class="position-relative overflow-hidden">
            <img class="img-fluid" src="<c:url value="img/pexels-karolina-grabowska-4386470.jpg"/>" alt="">
            <div class="w-100 d-flex justify-content-center position-absolute bottom-0 start-0 mb-4">
              <button class="flex-shrink-0 btn btn-sm btn-primary px-3 border-end pay-button2" style="border-radius: 30px 0 0 30px;">결제하기</button>
              <a href="<c:url value="/login"/> " class="flex-shrink-0 btn btn-sm btn-primary px-3" style="border-radius: 0 30px 30px 0;">로그인</a>
            </div>
          </div>
          <div class="text-center p-4 pb-0">
            <h3 class="mb-0">14900원</h3>
            <div class="mb-3">
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small>(66)</small>
            </div>
            <h5 class="mb-4">추가 건강 지표와 주간 리포트, 화상 상담 등 심화된 서비스</h5>
          </div>
          <div class="d-flex border-top">
            <small class="flex-fill text-center border-end py-2"><i class="fa fa-user-tie text-primary me-2"></i>High 스탠다드</small>
            <small class="flex-fill text-center border-end py-2"><i class="fa fa-clock text-primary me-2"></i>1달</small>
            <small class="flex-fill text-center py-2"><i class="fa fa-user text-primary me-2"></i>378 users</small>
          </div>
        </div>
      </div>
      <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
        <div class="course-item bg-light">
          <div class="position-relative overflow-hidden">
            <img class="img-fluid" src="<c:url value="img/pexels-karolina-grabowska-4021769.jpg"/>" alt="">
            <div class="w-100 d-flex justify-content-center position-absolute bottom-0 start-0 mb-4">
              <button class="flex-shrink-0 btn btn-sm btn-primary px-3 border-end pay-button3" style="border-radius: 30px 0 0 30px;">결제하기</button>
              <a href="<c:url value="/login"/>" class="flex-shrink-0 btn btn-sm btn-primary px-3" style="border-radius: 0 30px 30px 0;">로그인</a>
            </div>
          </div>
          <div class="text-center p-4 pb-0">
            <h3 class="mb-0">19900원</h3>
            <div class="mb-3">
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small class="fa fa-star text-primary"></small>
              <small>(97)</small>
            </div>
            <h5 class="mb-4">실시간 모니터링, 무제한 화상 상담, 가족 관리 기능 등 최상의 서비스</h5>
          </div>
          <div class="d-flex border-top">
            <small class="flex-fill text-center border-end py-2"><i class="fa fa-user-tie text-primary me-2"></i>프리미엄</small>
            <small class="flex-fill text-center border-end py-2"><i class="fa fa-clock text-primary me-2"></i>1달</small>
            <small class="flex-fill text-center py-2"><i class="fa fa-user text-primary me-2"></i>400 users</small>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


<!-- Team Start -->
<div class="container-xxl py-5">
  <div class="container">
    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
      <h6 class="section-title bg-white text-center text-primary px-3">doctors</h6>
      <h1 class="mb-5">전문의</h1>
    </div>
    <div class="row g-4">
      <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
        <div class="team-item bg-light">
          <div class="overflow-hidden">
            <img class="img-fluid" src="img/team-1.jpg" alt="">
          </div>
          <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">
            <div class="bg-light d-flex justify-content-center pt-2 px-1">
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>
            </div>
          </div>
          <div class="text-center p-4">
            <h5 class="mb-0">Instructor Name</h5>
            <small>Designation</small>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
        <div class="team-item bg-light">
          <div class="overflow-hidden">
            <img class="img-fluid" src="img/team-2.jpg" alt="">
          </div>
          <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">
            <div class="bg-light d-flex justify-content-center pt-2 px-1">
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>
            </div>
          </div>
          <div class="text-center p-4">
            <h5 class="mb-0">Instructor Name</h5>
            <small>Designation</small>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
        <div class="team-item bg-light">
          <div class="overflow-hidden">
            <img class="img-fluid" src="img/team-3.jpg" alt="">
          </div>
          <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">
            <div class="bg-light d-flex justify-content-center pt-2 px-1">
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>
            </div>
          </div>
          <div class="text-center p-4">
            <h5 class="mb-0">Instructor Name</h5>
            <small>Designation</small>
          </div>
        </div>
      </div>
      <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.7s">
        <div class="team-item bg-light">
          <div class="overflow-hidden">
            <img class="img-fluid" src="img/team-4.jpg" alt="">
          </div>
          <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">
            <div class="bg-light d-flex justify-content-center pt-2 px-1">
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>
              <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>
            </div>
          </div>
          <div class="text-center p-4">
            <h5 class="mb-0">Instructor Name</h5>
            <small>Designation</small>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Team End -->
<script>
  $(document).ready(function () {
    $('.pay-button1').click(function () {
      const IMP = window.IMP; // 아임포트 객체 초기화
      IMP.init('imp73521054'); // 가맹점 식별코드 입력

      // 결제 요청
      IMP.request_pay({
        pg: 'kakaopay', // PG사 설정 (사용하는 PG사에 맞게 수정)
        pay_method: 'card', // 결제 수단
        merchant_uid: 'order_' + new Date().getTime(), // 주문번호
        name: 'Nomal 스탠다드 서비스', // 상품명
        amount: 9900, // 결제 금액
      }, function (rsp) {
        if (rsp.success) {
          alert('결제가 완료되었습니다.\n결제 금액: ' + rsp.paid_amount.toLocaleString() + '원');
        } else {
          alert('결제에 실패하였습니다.\n에러 메시지: ' + rsp.error_msg);
        }
      });
    });
  });

  $(document).ready(function () {
    $('.pay-button2').click(function () {
      const IMP = window.IMP; // 아임포트 객체 초기화
      IMP.init('imp73521054'); // 가맹점 식별코드 입력

      // 결제 요청
      IMP.request_pay({
        pg: 'kakaopay', // PG사 설정 (사용하는 PG사에 맞게 수정)
        pay_method: 'card', // 결제 수단
        merchant_uid: 'order_' + new Date().getTime(), // 주문번호
        name: 'High 스탠다드 서비스', // 상품명
        amount: 14900, // 결제 금액
      }, function (rsp) {
        if (rsp.success) {
          alert('결제가 완료되었습니다.\n결제 금액: ' + rsp.paid_amount.toLocaleString() + '원');
        } else {
          alert('결제에 실패하였습니다.\n에러 메시지: ' + rsp.error_msg);
        }
      });
    });
  });

  $(document).ready(function () {
    $('.pay-button3').click(function () {
      const IMP = window.IMP; // 아임포트 객체 초기화
      IMP.init('imp73521054'); // 가맹점 식별코드 입력

      // 결제 요청
      IMP.request_pay({
        pg: 'kakaopay', // PG사 설정 (사용하는 PG사에 맞게 수정)
        pay_method: 'card', // 결제 수단
        merchant_uid: 'order_' + new Date().getTime(), // 주문번호
        name: '프리미엄 서비스', // 상품명
        amount: 19900, // 결제 금액
      }, function (rsp) {
        if (rsp.success) {
          alert('결제가 완료되었습니다.\n결제 금액: ' + rsp.paid_amount.toLocaleString() + '원');
        } else {
          alert('결제에 실패하였습니다.\n에러 메시지: ' + rsp.error_msg);
        }
      });
    });
  });
</script>


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