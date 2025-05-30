<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container-fluid p-0 mb-5">
  <div class="owl-carousel header-carousel position-relative">
    <div class="owl-carousel-item position-relative">
      <img class="img-fluid" src="imgt/medical_service.png" alt="">
      <div class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center" style="background: rgba(24, 29, 56, .7);">
        <div class="container">
          <div class="row justify-content-start">
            <div class="col-sm-10 col-lg-8">
              <h5 class="text-primary text-uppercase mb-3 animated slideInDown">COMONG</h5>
              <h1 class="display-3 text-white animated slideInDown">COMONG Helath Care <div>System</div></h1>
              <p class="fs-5 text-white mb-4 pb-2" style="white-space: normal; word-wrap: break-word; width: 70%;">
                헬스케어 서비스를 제공하는 COMONG에 오신것을 환영합니다! COMONG을 이용하여 건강관리를 실천해보세요!
              </p>


              <a href="<c:url value="/payment"/>" class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Join</a>
              <a href="<c:url value="/about"/>" class="btn btn-light py-md-3 px-md-5 animated slideInRight">More</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="owl-carousel-item position-relative">
      <img class="img-fluid" src="imgt/healthcareimg1.png" alt="">
      <div class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center" style="background: rgba(24, 29, 56, .7);">
        <div class="container">
          <div class="row justify-content-start">
            <div class="col-sm-10 col-lg-8">
              <h5 class="text-primary text-uppercase mb-3 animated slideInDown">Best Service</h5>
              <h1 class="display-3 text-white animated slideInDown">COMONG Health Care Service</h1>
              <p class="fs-5 text-white mb-4 pb-2" style="white-space: normal; word-wrap: break-word; width: 93%;">
                환자와 의료진을 연결하여 실시간 건강 관리를 지원하는 스마트 헬스케어 서비스를 소개합니다. 헬스케어 장비를 활용하여 환자의 건강 데이터를 실시간으로 모니터링하며 의료진이 필요한 순간에 신속히 대응할 수 있도록 설계된 서비스를 제공합니다.
              </p>
              <a href="<c:url value="/payment"/>" class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Join</a>
              <a href="<c:url value="/about"/>" class="btn btn-light py-md-3 px-md-5 animated slideInRight">More</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- Carousel End -->


<!-- Categories Start -->
<div class="container-xxl py-5 category">
  <div class="container">
    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
      <h6 class="section-title bg-white text-center text-primary px-3">Screen</h6>
      <h1 class="mb-5">Screen</h1>
    </div>
    <div class="row g-3">
      <div class="col-lg-7 col-md-6">
        <div class="row g-3">
          <div class="col-lg-12 col-md-12 wow zoomIn" data-wow-delay="0.1s">
            <a class="position-relative d-block overflow-hidden" href="<c:url value="/"/>">
              <img class="img-fluid" src="<c:url value="/img/doctorsss.jpg"/>" alt="">
            </a>
          </div>
          <div class="col-lg-6 col-md-12 wow zoomIn" data-wow-delay="0.3s">
            <a class="position-relative d-block overflow-hidden" href="<c:url value="/"/>">
              <img class="img-fluid" src="<c:url value="/img/medical1.jpg"/>" alt="">
            </a>
          </div>
          <div class="col-lg-6 col-md-12 wow zoomIn" data-wow-delay="0.5s">
            <a class="position-relative d-block overflow-hidden" href="<c:url value="/"/>">
              <img class="img-fluid" src="<c:url value="/img/screenvideo.jpg"/>" alt="">
            </a>
          </div>
        </div>
      </div>
      <div class="col-lg-5 col-md-6 wow zoomIn" data-wow-delay="0.7s" style="min-height: 350px;">
        <a class="position-relative d-block h-100 overflow-hidden" href="<c:url value="/"/>">
          <img class="img-fluid position-absolute w-100 h-100" src="<c:url value="/img/docchart.jpg"/>" alt="" style="object-fit: cover;">
        </a>
      </div>
    </div>
  </div>
</div>


<!-- Testimonial Start -->
<div class="container-xxl py-5 wow fadeInUp" data-wow-delay="0.1s">
  <div class="container">
    <div class="text-center">
      <h6 class="section-title bg-white text-center text-primary px-3">Doctors</h6>
      <h1 class="mb-5">전문의</h1>
    </div>
    <div class="owl-carousel testimonial-carousel position-relative">
      <div class="testimonial-item text-center">
        <img class="border rounded-circle p-2 mx-auto mb-3" src="img/testimonial-1.jpg" style="width: 80px; height: 80px;">
        <h5 class="mb-0">신경외과</h5>
        <p>Profession</p>
        <div class="testimonial-text bg-light text-center p-4">
          <p class="mb-0">신경외과에서는 척추 질환,뇌 및 신경 종양, 뇌졸중 및 혈관 질환 치료를 제공합니다.
            환자 한 분 한 분께 최적화된 진료를 제공하기 위해 노력하고 있습니다.
          </p>
        </div>
      </div>
      <div class="testimonial-item text-center">
        <img class="border rounded-circle p-2 mx-auto mb-3" src="img/testimonial-2.jpg" style="width: 80px; height: 80px;">
        <h5 class="mb-0">심장혈관흉부외과</h5>
        <p>Profession</p>
        <div class="testimonial-text bg-light text-center p-4">
          <p class="mb-0">심장혈관흉부외과에서는 심장수술,흉부질환,혈관질환에 대하여 치료를 제공합니다.
            긴급한 상황에서도 신속한 외과적 대응을 하도록 노력하고 있습니다.
          </p>
        </div>
      </div>
      <div class="testimonial-item text-center">
        <img class="border rounded-circle p-2 mx-auto mb-3" src="img/testimonial-3.jpg" style="width: 80px; height: 80px;">
        <h5 class="mb-0">외과</h5>
        <p>Profession</p>
        <div class="testimonial-text bg-light text-center p-4">
          <p class="mb-0">외과는 소화기계, 갑상선 및 유방 외과, 복벽 질환 치료, 응급 외과 치료를 제공하고,
            24시간 응급 의료 체계를 운영하여 의료 소외계층이 없도록 노력하고 있습니다.
          </p>
        </div>
      </div>
      <div class="testimonial-item text-center">
        <img class="border rounded-circle p-2 mx-auto mb-3" src="img/testimonial-4.jpg" style="width: 80px; height: 80px;">
        <h5 class="mb-0">내과</h5>
        <p>Profession</p>
        <div class="testimonial-text bg-light text-center p-4">
          <p class="mb-0">감기, 독감, 소화기 질환, 만성 피로 등의 일반 질환에 대한 진단 및 치료를 제공합니다.
            환자의 증상에 맞춘 체계적인 관리와 생활 습관 개선을 위한 상담을 진행합니다.
          </p>
        </div>
      </div>
    </div>
  </div>
</div>