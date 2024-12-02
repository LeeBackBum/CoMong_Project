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
</head>

<body>
<div class="container-fluid position-relative bg-white d-flex p-0">
  <!-- Content Start -->
  <div>
    <!-- Chart Start -->
    <div class="container-fluid pt-4 px-4">
      <div class="row g-4">
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">Single Line Chart</h6>
            <canvas id="line-chart"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">Multiple Line Chart</h6>
            <canvas id="salse-revenue"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">Single Bar Chart</h6>
            <canvas id="bar-chart"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">Multiple Bar Chart</h6>
            <canvas id="worldwide-sales"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">Pie Chart</h6>
            <canvas id="pie-chart"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">Doughnut Chart</h6>
            <canvas id="doughnut-chart"></canvas>
          </div>
        </div>
      </div>
    </div>
    <!-- Chart End -->

    <!-- Footer Start -->
    <div class="container-fluid pt-4 px-4">
      <div class="bg-light rounded-top p-4">
        <div class="row">
          <div class="col-12 col-sm-6 text-center text-sm-start">
            &copy; <a href="#">Your Site Name</a>, All Right Reserved.
          </div>
        </div>
      </div>
    </div>
    <!-- Footer End -->
  </div>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
  let chart1 = {
    chartInstance: null, // Chart.js 인스턴스를 저장할 변수
    livedata: null, // 현재 데이터를 저장
    init: function () {
      this.getdata(); // 초기 데이터 가져오기
      this.display2(); // 차트 초기화
      setInterval(() => {
        this.getdata(); // 5초마다 데이터 갱신
      }, 5000);
    },
    getdata: function () {
      $.ajax({
        url: '/iot/power/data',
        success: (datas) => {
          if (Array.isArray(datas)) {
            this.livedata = datas; // 데이터 저장
            this.display(datas); // 차트 업데이트
          } else {
            console.error("Received data is not an array:", datas);
          }
        },
        error: (error) => {
          console.error("Error fetching IoT data:", error);
        }
      });
    },
    display2: function () {
      // 초기 차트 설정
      const ctx = document.getElementById('line-chart').getContext('2d');
      this.chartInstance = new Chart(ctx, {
        type: 'line',
        data: {
          labels: [], // 초기 라벨 값은 비어있음
          datasets: [{
            label: 'Power Consumption',
            data: [],
            borderColor: 'rgba(75, 192, 192, 1)',
            fill: false,
            borderWidth: 2,
            pointRadius: 3
          }]
        },
        options: {
          responsive: true,
          plugins: {
            legend: {
              display: true
            }
          },
          scales: {
            x: {
              title: {
                display: true,
                text: 'Time'
              }
            },
            y: {
              title: {
                display: true,
                text: 'Power (Watts)'
              }
            }
          }
        }
      });
    },
    display: function (datas) {
      if (this.chartInstance) {
        // 기존 데이터에 새로운 데이터를 추가
        const label = `Time ${this.chartInstance.data.labels.length + 1}`; // JavaScript 내에서 계산

        this.chartInstance.data.labels.push(label);
        this.chartInstance.data.datasets[0].data.push(datas[datas.length - 1]);

        // 만약 차트의 데이터 포인트가 너무 많으면 오래된 데이터를 삭제
        if (this.chartInstance.data.labels.length > 10) { // 예: 최대 10개의 데이터만 유지
          this.chartInstance.data.labels.shift();
          this.chartInstance.data.datasets[0].data.shift();
        }

        this.chartInstance.update(); // 차트 업데이트
      }
    }
  };

  $(function () {
    chart1.init();
  });
</script>



</body>
</html>
