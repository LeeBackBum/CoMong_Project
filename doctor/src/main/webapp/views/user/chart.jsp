<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<script>
  let chart1 = {
    chartInstance : null,
    livedata: [], // 현재 데이터를 저장
    init: function () {
      this.getdata();
      this.display1();
      this.display2();
      this.display3();
      this.display4();
    },
    getdata:function(){
      $.ajax({
        url:'/iot/power/data',
        success: (datas) => {
          this.display6(datas); // 화살표 함수로 this 고정
        },
        error: (xhr, status, error) => {
          console.error('AJAX 요청 실패:', status, error);
        }
      });
    },


    display4: function () {
      // On chart load, start an interval that fetches data from the server and animates the pulsating marker.
      const onChartLoad = function () {
        const chart = this,
                series = chart.series[0];

        // 실시간 데이터 업데이트 (3초 간격)
        setInterval(() => {
          $.ajax({
            url: '/iot/power/data', // 서버에서 데이터를 가져옴
            success: (datas) => {
              datas.forEach((value) => {
                const point = [new Date(value.timestamp).getTime(), value.value];
                console.log('추가할 포인트:', point);
                series.addPoint(point, true, series.data.length > 20); // 차트에 포인트 추가
              });
            },
            error: (xhr, status, error) => {
              console.error('AJAX 요청 실패:', status, error);
            }
          });
        }, 5000);
      };

      // 초기 데이터를 서버에서 가져오기
      const data = (function () {
        let initialData = [];
        $.ajax({
          url: '/iot/power/data', // 최근 데이터 요청
          async: false,
          success: (datas) => {
            initialData = datas.map((item) => ({
              x: new Date(item.timestamp).getTime(), // 타임스탬프를 x축 값으로 변환
              y: item.value // 값을 y축 값으로 설정
            }));
          },
          error: (xhr, status, error) => {
            console.error('초기 데이터 요청 실패:', status, error);
          }
        });
        return initialData;
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

      // Highcharts 차트 생성
      Highcharts.chart('container', {
        chart: {
          type: 'spline',
          events: { load: onChartLoad } // 차트 로드 시 이벤트 등록
        },

        time: { useUTC: false },

        title: { text: 'Live IoT Data with Animation' },

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
          title: { text: 'Value' },
          plotLines: [
            { value: 0, width: 1, color: '#808080' }
          ]
        },

        tooltip: {
          headerFormat: '<b>{series.name}</b><br/>',
          pointFormat: '{point.x:%Y-%m-%d %H:%M:%S}<br/>{point.y:.2f}'
        },

        legend: { enabled: false },

        exporting: { enabled: false },

        series: [
          {
            name: 'IoT Data',
            lineWidth: 2,
            color: Highcharts.getOptions().colors[2],
            data // 초기 데이터 설정
          }
        ]
      });
    },


    display1: function () {
      // 특정 범위 내에서 랜덤 값을 생성하는 함수
      const getRandomValue = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;

      // 랜덤 데이터 배열 생성
      const generateRandomData = (length, min, max) => {
        return Array.from({ length }, () => getRandomValue(min, max));
      };

      // 차트 데이터 생성
      const randomData = generateRandomData(10, 100, 200); // 100~200 범위의 랜덤 값 10개 생성

      // 차트 초기화
      var ctx3 = $("#line-chart").get(0).getContext("2d");
      this.chartInstance = new Chart(ctx3, {
        type: "line",
        data: {
          labels: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], // x축 라벨
          datasets: [{
            label: "혈압 수치",
            fill: false,
            backgroundColor: "rgba(0, 156, 255, .3)",
            data: randomData // 랜덤 데이터 사용
          }]
        },
        options: {
          responsive: true
        }
      });
    },

    display2: function () {
      // 특정 범위 내에서 랜덤 값을 생성하는 함수
      const getRandomValue = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;

      // 복용 전/후 혈당 데이터를 생성하는 함수
      const generateBloodSugarData = (length, minPre, maxPre, minPost, maxPost) => {
        const preBloodSugar = Array.from({ length }, () => getRandomValue(minPre, maxPre));
        const postBloodSugar = preBloodSugar.map(preValue =>
                getRandomValue(minPost, Math.min(preValue - 1, maxPost)) // 복용 후는 항상 복용 전보다 낮게 설정
        );
        return { preBloodSugar, postBloodSugar };
      };

      // 랜덤 데이터 생성 (복용 전: 50~100, 복용 후: 10~99)
      const { preBloodSugar, postBloodSugar } = generateBloodSugarData(10, 50, 100, 10, 99);

      // 차트 초기화
      var ctx2 = $("#salse-revenue").get(0).getContext("2d");
      var myChart2 = new Chart(ctx2, {
        type: "line",
        data: {
          labels: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"], // x축 라벨
          datasets: [
            {
              label: "복용 전 혈당",
              data: preBloodSugar, // 복용 전 랜덤 데이터
              backgroundColor: "rgba(0, 156, 255, .2)",
              fill: true
            },
            {
              label: "복욕 후 혈당",
              data: postBloodSugar, // 복용 후 랜덤 데이터
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

    display3: function () {
      // 특정 범위 내에서 랜덤 값을 생성하는 함수
      const getRandomValue = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;

      // 랜덤 데이터 배열 생성 함수
      const generateRandomScores = (length, min, max) => {
        return Array.from({ length }, () => getRandomValue(min, max));
      };

      // 랜덤 점수 생성 (10~60 범위)
      const randomScores = generateRandomScores(5, 10, 60);

      // 차트 초기화
      var ctx4 = $("#bar-chart").get(0).getContext("2d");
      var myChart4 = new Chart(ctx4, {
        type: "bar",
        data: {
          labels: ["11월7일", "11월14일", "11월21일", "11월28일", "12월5일"], // x축 라벨
          datasets: [{
            label: "우울증 점수",
            backgroundColor: [
              "rgba(0, 156, 255, .7)",
              "rgba(0, 156, 255, .6)",
              "rgba(0, 156, 255, .5)",
              "rgba(0, 156, 255, .4)",
              "rgba(0, 156, 255, .3)"
            ],
            data: randomScores // 랜덤 점수 데이터 사용
          }]
        },
        options: {
          responsive: true
        }
      });
    }



  }



  $(function () {
    chart1.init();
  });
</script>

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
            <h6 class="mb-4">특이사항에 관한 실시간 데이터</h6>
            <div id="container" style="width: 100%; height: 300px;"></div>
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

