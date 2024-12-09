<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <style>
    #input-container {
      width: 800px;
      margin: 20px auto;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      text-align: center;
    }
    input[type="text"] {
      width: 80%;
      padding: 10px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    button {
      padding: 10px 20px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    button:hover {
      background-color: #45a049;
    }
    #output {
      margin-top: 10px;
      font-size: 14px;
      color: #333;
    }
  </style>


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

  <script>
    function displayInput() {
      const input = document.getElementById('user-input').value;
      const outputDiv = document.getElementById('output');

      if (input.trim() !== "") {
        outputDiv.textContent = `You entered: ${input}`;
      } else {
        outputDiv.textContent = "Please enter a value.";
      }
    }
  </script>


  <!-- 병상정보 호출 -->
  <script>
    let hospitalData = [];

    function fetchHospitalData() {
      var xhr = new XMLHttpRequest();
      var url = 'https://apis.data.go.kr/B552657/ErmctInfoInqireService/getEmrrmRltmUsefulSckbdInfoInqire';
      var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'ViBoL0JKIqkhrZMZhx1K6J7JVyKXHWCA6C%2BHjVHNkKYYZYaAaTdx9Ol1I0au2URlvLKjmWozl%2Fw01r9XXY9ztA%3D%3D';
      queryParams += '&' + encodeURIComponent('STAGE1') + '=' + encodeURIComponent("서울특별시");
      // queryParams += '&' + encodeURIComponent('STAGE2') + '=' + encodeURIComponent("강남구");
      queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
      queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10');

      xhr.open('GET', url + queryParams);
      xhr.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
          var parser = new DOMParser();
          var xmlDoc = parser.parseFromString(this.responseText, "text/xml");

          var items = xmlDoc.getElementsByTagName('item');

          if (items.length > 0) {
            hospitalData = []; // 이전 데이터 초기화
            for (var i = 0; i < items.length; i++) {
              const dutyName = items[i].getElementsByTagName('dutyName')[0]?.textContent.trim() || '병원 이름 없음';
              const hvec = items[i].getElementsByTagName('hvec')[0]?.textContent || '잔여 병실 없음';
              const hvoc = items[i].getElementsByTagName('hvoc')[0]?.textContent || '잔여 병실 없음';

              // 데이터를 객체로 저장
              hospitalData.push({
                dutyName: dutyName,
                hvec: hvec,
                hvoc: hvoc
              });
            }
            // 데이터를 HTML에 렌더링
            renderHospitalData();
          } else {
            document.getElementById('container').innerHTML = "<p>데이터가 없습니다.</p>";
          }
        } else if (this.readyState == 4 && this.status != 200) {
          document.getElementById('container').innerHTML = "<p>API 요청 실패: " + this.status + "</p>";
        }
      };
      xhr.send('');
    }
    function renderHospitalData() {
      const container = document.getElementById('listinfo'); // row-g-8 요소를 선택
      if (!container) {
        console.error("Error: 'row-g-8' element not found.");
        return;
      }
      container.innerHTML = ''; // 이전 내용 초기화

      hospitalData.forEach(function(hospital, index) {
        // 병원 데이터마다 <div class="col-lg-3 col-md-6 ..."> 요소 생성
        const resultDiv = document.createElement('div');
        resultDiv.classList.add('col-lg-3', 'col-md-6', 'wow', 'fadeInUp');
        resultDiv.setAttribute('data-wow-delay', '0.1s');

        const imageUrl = (hospital.imageName || 'https://www.asantoday.com/imgdata/asantoday/201607/2016072036393245.jpg');

        resultDiv.innerHTML =
                '<div class="team-item bg-light">' +
                '<div class="overflow-hidden">' +
                '<img class="img-fluid" src="' + imageUrl + '" alt="병원 이미지">' +
                '</div>' +
                '<div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">' +
                '<div class="bg-light d-flex justify-content-center pt-2 px-1">' +
                '<a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>' +
                '<a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>' +
                '<a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>' +
                '</div>' +
                '</div>' +
                '<div class="text-center p-4">' +
                '<h5 class="mb-0">' + (hospital.dutyName || '병원 이름 없음') + '</h5>' +
                '<small>응급실: ' + (hospital.hvec || '잔여 병실 없음') + '</small>' +
                '<p>수술실: ' + (hospital.hvoc || '잔여 병실 없음') + '</p>' +
                '</div>' +
                '</div>';

        container.appendChild(resultDiv); // 새로 생성된 병원 정보를 row-g-8에 추가
      });
    }

    document.addEventListener('DOMContentLoaded', function() {
      fetchHospitalData();  // DOM이 로드된 후 데이터를 가져옵니다.
    });
  </script>



</head>

<body>


<!-- Navbar End -->


<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-10 text-center">
        <h1 class="display-3 text-white animated slideInDown">Courses</h1>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb justify-content-center">
            <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
            <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
            <li class="breadcrumb-item text-white active" aria-current="page">Courses</li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</div>

<div id="input-container">
  <h3>검색 하실 주소(시도)입력해주세요</h3>
  <input type="text" id="user-input" placeholder="서울특별시 강남구">
  <button onclick="displayInput()">검색</button>
  <div id="output"></div>
</div>


<div>
  <div class="container-xxl py-5">
    <div class="container">
      <div class="text-center wow fadeInUp" data-wow-delay="0.1s"
           style="visibility: visible; animation-delay: 0.1s;">
        <h6 class="section-title bg-white text-center text-primary px-3">병상정보</h6>
        <h1 class="mb-5">실시간 가용병상정보</h1>
      </div>
      <div class="row g-8" id="listinfo">
      </div>
    </div>
  </div>
</div>


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