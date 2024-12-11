<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<script>
  let chart1 = {
    chartInstance : null,
    livedata: [], // 현재 데이터를 저장
    init: function () {
      this.getBloodPressure();
      this.getBloodSugar();
      this.getDepressionScore();
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
          this.display4(datas); // 화살표 함수로 this 고정
        },
        error: (xhr, status, error) => {
          console.error('AJAX 요청 실패:', status, error);
        }
      });
    },
    getBloodPressure:function(){
      $.ajax({
        url:'/iot/bloodPressure/data',
        success: (bloodPressuredatas) => {
          this.display1(bloodPressuredatas); // 화살표 함수로 this 고정
        },
        error: (xhr, status, error) => {
          console.error('AJAX 요청 실패:', status, error);
        }
      });
    },
    getBloodSugar:function(){
      $.ajax({
        url:'/iot/bloodSugar/data',
        success: (bloodSugardatas) => {
          this.display2(bloodSugardatas); // 화살표 함수로 this 고정
        },
        error: (xhr, status, error) => {
          console.error('AJAX 요청 실패:', status, error);
        }
      });
    },
    getDepressionScore:function(){
      $.ajax({
        url:'/iot/depressionScore/data',
        success: (depressionScoredatas) => {
          this.display3(depressionScoredatas); // 화살표 함수로 this 고정
        },
        error: (xhr, status, error) => {
          console.error('AJAX 요청 실패:', status, error);
        }
      });
    },


    display4: function () {
      let alertTimer = null; // 알림 타이머를 관리하는 변수
      const alertDuration = 5000; // 5초 이상 지속되면 알림 발생
      const dangerThreshold = { low: 65, high: 120 }; // 위험 수치 기준

      const onChartLoad = function () {
        const chart = this,
                series = chart.series[0];

        // 실시간 데이터 업데이트 (5초 간격)
        setInterval(() => {
          $.ajax({
            url: '/iot/power/data', // 서버에서 데이터를 가져옴
            success: (datas) => {
              datas.forEach((value) => {
                const point = [new Date(value.timestamp).getTime(), value.value];
                console.log('추가할 포인트:', point);
                series.addPoint(point, true, series.data.length > 20); // 차트에 포인트 추가

                // 위험 수치인지 확인
                if (point[1] < dangerThreshold.low || point[1] > dangerThreshold.high) {
                  if (!alertTimer) {
                    // 위험 상태가 지속되면 알림 트리거
                    alertTimer = setTimeout(() => {
                      alert(`⚠️ 위험 수치 감지: ${point[1]}`);
                      alertTimer = null; // 타이머 초기화
                    }, alertDuration);
                  }
                } else {
                  // 정상 상태로 돌아오면 타이머 초기화
                  if (alertTimer) {
                    clearTimeout(alertTimer);
                    alertTimer = null;
                  }
                }
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

      // Highcharts 차트 생성
      Highcharts.chart('container', {
        chart: {
          type: 'spline',
          events: { load: onChartLoad } // 차트 로드 시 이벤트 등록
        },

        time: { useUTC: false },

        title: { text: 'HealthCare Live Data' },

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
    }
    ,


    display1: function(data) {
      const normalRange = { min: 80, max: 139 }; // 예시 정상 범위
      const processedData = data.map(item => item.value);
      const pointBackgroundColors = processedData.map(value =>
              (value < normalRange.min || value > normalRange.max) ? "red" : "rgba(0, 156, 255, .3)"
      );

      // 날짜와 혈압 수치를 추출
      const labels = data.map(item => {
        const date = new Date(item.timestamp);
        return (date.getMonth() + 1) + '월 ' + date.getDate() + '일'; // "12월 1일" 형식으로 변환
      });

      var ctx3 = $("#line-chart").get(0).getContext("2d");
      this.chartInstance = new Chart(ctx3, {
        type: "line",
        data: {
          labels: labels, // 변환된 라벨 사용
          datasets: [{
            label: "위험 수치",
            fill: false,
            backgroundColor: pointBackgroundColors,
            data: processedData
          }]
        },
        options: {
          responsive: true
        }
      });
    },

    display2: function(data) {
      // 데이터 처리
      const processedData = data.map(item => item.value);

      // 날짜와 혈당 수치를 추출하여 라벨 형식 지정
      const labels = data.map(item => {
        const date = new Date(item.timestamp);
        return (date.getMonth() + 1) + '월 ' + date.getDate() + '일'; // "12월 1일" 형식으로 변환
      });

      // 혈당 수치의 위험 범위 설정
      const pointBackgroundColors = processedData.map(value =>
              (value < 70 || value > 140) ? "red" : "rgba(0, 156, 255, .6)"
      );

      var ctx2 = $("#line-chart2").get(0).getContext("2d");
      this.chartInstance = new Chart(ctx2, {
        type: "line",
        data: {
          labels: labels,
          datasets: [{
            label: "위험 수치",
            fill: false,
            backgroundColor: pointBackgroundColors,
            data: processedData
          }]
        },
        options: {
          responsive: true,
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      });
    },

    display3: function(data) {
      // 최근 5개의 데이터만 가져오기
      const recentData = data.slice(-5); // 배열의 마지막 5개 요소를 선택

      // 날짜와 우울증 점수를 추출
      const labels = recentData.map(item => {
        const date = new Date(item.timestamp);
        return (date.getMonth() + 1)+'월' +(date.getDate())+'일'; // "12월 1일" 형식으로 변환
      });
      const depressionScores = recentData.map(item => item.value); // 우울증 점수 추출

      var ctx4 = $("#bar-chart").get(0).getContext("2d");
      if (this.charts && this.charts.depressionChart) {
        this.charts.depressionChart.destroy(); // 기존 차트 인스턴스 제거
      }
      this.charts.depressionChart = new Chart(ctx4, {
        type: "bar",
        data: {
          labels: labels, // x축 라벨 설정
          datasets: [{
            label: "우울증 점수",
            backgroundColor: [
              "rgba(0, 156, 255, .7)",
              "rgba(0, 156, 255, .6)",
              "rgba(0, 156, 255, .5)",
              "rgba(0, 156, 255, .4)",
              "rgba(0, 156, 255, .3)"
            ],
            data: depressionScores // y축 데이터 설정
          }]
        },
        options: {
          responsive: true
        }
      });
    },



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
            <div class="d-flex align-items-center justify-content-between mb-4">
              <h6 class="mb-0">일별 혈압</h6>
            </div>
            <canvas id="line-chart"></canvas>
          </div>
        </div>
        <div class="col-sm-12 col-xl-6">
          <div class="bg-light rounded h-100 p-4">
            <div class="d-flex align-items-center justify-content-between mb-4">
              <h6 class="mb-0">일별 혈당</h6>
            </div>
            <canvas id="line-chart2"></canvas>
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

