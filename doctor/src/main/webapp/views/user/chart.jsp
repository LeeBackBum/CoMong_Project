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
            <h6 class="mb-4">일별 혈압</h6>
            <canvas id="line-chart"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">일별 혈당</h6>
            <canvas id="salse-revenue"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">우울증 수치</h6>
            <canvas id="bar-chart"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">Multiple Bar Chart</h6>
            <canvas id="container2"></canvas>
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
      this.display4();
      this.display5();
      this.display6();
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
      // Single Line Chart
      var ctx3 = $("#line-chart").get(0).getContext("2d");
      this.chartInstance = new Chart(ctx3, {
        type: "line",
        data: {
          labels: [1,2,3,4,5,6,7,8,9,10],
          datasets: [{
            label: "혈압 수치",
            fill: false,
            backgroundColor: "rgba(0, 156, 255, .3)",
            data: [100,110,120,130,180,190,200,180,190,170]
          }]
        },
        options: {
          responsive: true
        }
      });
    },
    display4: function (){
      // Salse & Revenue Chart
      var ctx2 = $("#salse-revenue").get(0).getContext("2d");
      var myChart2 = new Chart(ctx2, {
        type: "line",
        data: {
          labels: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"],
          datasets: [{
            label: "복용 전 혈당",
            data: [55, 75, 65, 45, 70, 65, 85, 70, 65, 85],
            backgroundColor: "rgba(0, 156, 255, .2)",
            fill: true
          },
            {
              label: "복욕 후 혈당",
              data: [20, 32, 44, 34, 36, 45, 38, 36, 45, 38],
              backgroundColor: "rgba(0, 156, 255, .5)",
              fill: true
            }
          ]
        },
        options: {
          responsive: true
        }
      });
    },

    display5: function (){
      // Single Bar Chart
      var ctx4 = $("#bar-chart").get(0).getContext("2d");
      var myChart4 = new Chart(ctx4, {
        type: "bar",
        data: {
          labels: ["11월7일", "11월14일", "11월21일", "11월28일", "12월5일"],
          datasets: [{
            label:"우울증 점수",
            backgroundColor: [
              "rgba(0, 156, 255, .7)",
              "rgba(0, 156, 255, .6)",
              "rgba(0, 156, 255, .5)",
              "rgba(0, 156, 255, .4)",
              "rgba(0, 156, 255, .3)"
            ],
            data: [55, 49, 44, 24, 15]
          }]
        },
        options: {
          responsive: true
        }
      });
    },

    display6:function(){
      const onChartLoad = function () {
        const chart = this,
                series = chart.series[0];

        setInterval(function () {
          // const x = (new Date()).getTime(), // current time
          //         y = Math.random();
          //
          // series.addPoint([x, y], true, true);
          // console.log(x+'  :  '+y);

          $.ajax({
            url:'/charts/chart1',
            success:(datas)=>{
              console.log(new Date(datas.endtime).getTime()+'  :  '+datas.endline);
              series.addPoint([new Date(datas.endtime).getTime(), datas.endline],
                      true, true);
            }
          });
        }, 1000);
      };

      // Create the initial data
      const data = (function () {
        const data = [];
        const time = new Date().getTime();

        for (let i = -19; i <= 0; i += 1) {
          data.push({
            x: time + i * 1000,
            y: Math.random()
          });
        }
        return data;
      }());

      // Plugin to add a pulsating marker on add point
      Highcharts.addEvent(Highcharts.Series, 'addPoint', e => {
        const point = e.point,
                series = e.target;

        if (!series.pulse) {
          series.pulse = series.chart.renderer.circle()
                  .add(series.markerGroup);
        }

        setTimeout(() => {
          series.pulse
                  .attr({
                    x: series.xAxis.toPixels(point.x, true),
                    y: series.yAxis.toPixels(point.y, true),
                    r: series.options.marker.radius,
                    opacity: 1,
                    fill: series.color
                  })
                  .animate({
                    r: 20,
                    opacity: 0
                  }, {
                    duration: 1000
                  });
        }, 1);
      });


      Highcharts.chart('container2', {
        chart: {
          type: 'spline',
          events: {
            load: onChartLoad
          }
        },

        time: {
          useUTC: false
        },

        title: {
          text: 'Live random data'
        },

        accessibility: {
          announceNewData: {
            enabled: true,
            minAnnounceInterval: 15000,
            announcementFormatter: function (allSeries, newSeries, newPoint) {
              if (newPoint) {
                return 'New point added. Value: ' + newPoint.y;
              }
              return false;
            }
          }
        },

        xAxis: {
          type: 'datetime',
          tickPixelInterval: 150,
          maxPadding: 0.1
        },

        yAxis: {
          title: {
            text: 'Value'
          },
          plotLines: [
            {
              value: 0,
              width: 1,
              color: '#808080'
            }
          ]
        },

        tooltip: {
          headerFormat: '<b>{series.name}</b><br/>',
          pointFormat: '{point.x:%Y-%m-%d %H:%M:%S}<br/>{point.y:.2f}'
        },

        legend: {
          enabled: false
        },

        exporting: {
          enabled: false
        },

        series: [
          {
            name: 'Random data',
            lineWidth: 2,
            color: Highcharts.getOptions().colors[2],
            data
          }
        ]
      });
    }
  };


  $(function () {
    chart1.init();
  });
</script>



</body>
</html>
