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
        // var xhr = new XMLHttpRequest();
        // var url = 'http://apis.data.go.kr/B552657/ErmctInfoInqireService/getEmrrmRltmUsefulSckbdInfoInqire'; /*URL*/
        // var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'ymM0cegTHI9EEDldHJd0Bk1pFJ7Is8b%2B9qmZ8zQMpMLLoZI9B2zPT0rwSX6dOvLI0736SD4F6yOn0vXUg9OKiw%3D%3D'; /*Service Key*/
        // queryParams += '&' + encodeURIComponent('STAGE1') + '=' + encodeURIComponent("서울특별시");  // 변환된 경도
        // queryParams += '&' + encodeURIComponent('STAGE2') + '=' + encodeURIComponent("강남구");   // 변환된 위도
        // queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /*페이지 번호*/
        // queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /*목록 건수*/
        //
        //
        // // API 요청
        // xhr.open('GET', url + queryParams);
        // xhr.onreadystatechange = function () {
        //     if (this.readyState == 4 && this.status == 200) {
        //         // 응답이 XML 형식이므로, XML 파서 사용
        //         var parser = new DOMParser();
        //         var xmlDoc = parser.parseFromString(this.responseText, "text/xml");
        //
        //         // XML에서 latitude와 longitude 추출
        //         var items = xmlDoc.getElementsByTagName('item');
        //         var resultDiv = document.getElementById('result');
        //
        //         if (items.length > 0) {
        //             const positions = [];
        //             // 여러 항목의 위도, 경도를 표시
        //             for (var i = 0; i < items.length; i++) {
        //                 const latitude = items[i].getElementsByTagName('hvec')[0].textContent;
        //                 const longitude = items[i].getElementsByTagName('hvoc')[0].textContent;
        //                 const dutyName = items[i].getElementsByTagName('dutyName')[0].textContent.trim();
        //                 // const dutyAddr = items[i].getElementsByTagName('dutytel3')[0].textContent.trim();
        //                 // hpid = items[i].getElementsByTagName('hpid')[0].textContent.trim();
        //             }
        //         } else {
        //             resultDiv.innerHTML = "데이터가 없습니다.";
        //         }
        //     } else if (this.readyState == 4 && this.status != 200) {
        //         document.getElementById('result').innerHTML = "API 요청 실패: " + this.status;
        //     }
        // };
        // xhr.send('');

            // 전역 변수로 데이터 저장
        //     let hospitalData = [];
        //
        //     function fetchHospitalData() {
        //     var xhr = new XMLHttpRequest();
        //     var url = 'http://apis.data.go.kr/B552657/ErmctInfoInqireService/getEmrrmRltmUsefulSckbdInfoInqire';
        //     var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'ymM0cegTHI9EEDldHJd0Bk1pFJ7Is8b%2B9qmZ8zQMpMLLoZI9B2zPT0rwSX6dOvLI0736SD4F6yOn0vXUg9OKiw%3D%3D';
        //     queryParams += '&' + encodeURIComponent('STAGE1') + '=' + encodeURIComponent("서울특별시");
        //     queryParams += '&' + encodeURIComponent('STAGE2') + '=' + encodeURIComponent("강남구");
        //     queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
        //     queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10');
        //
        //     xhr.open('GET', url + queryParams);
        //     xhr.onreadystatechange = function () {
        //     if (this.readyState == 4 && this.status == 200) {
        //     var parser = new DOMParser();
        //     var xmlDoc = parser.parseFromString(this.responseText, "text/xml");
        //
        //     var items = xmlDoc.getElementsByTagName('item');
        //
        //     if (items.length > 0) {
        //     hospitalData = []; // 이전 데이터 초기화
        //     for (var i = 0; i < items.length; i++) {
        //     const dutyName = items[i].getElementsByTagName('dutyName')[0].textContent.trim();
        //     const hvec = items[i].getElementsByTagName('hvec')[0]?.textContent || 'N/A';
        //     const hvoc = items[i].getElementsByTagName('hvoc')[0]?.textContent || 'N/A';
        //
        //     // 데이터를 객체로 저장
        //     hospitalData.push({
        //     dutyName: dutyName,
        //         hvec: hvec,
        //         hvoc: hvoc
        // });
        // }
        //     // 데이터를 HTML에 렌더링
        //     renderHospitalData();
        // } else {
        //     document.getElementById('result').innerHTML = "데이터가 없습니다.";
        // }
        // } else if (this.readyState == 4 && this.status != 200) {
        //     document.getElementById('result').innerHTML = "API 요청 실패: " + this.status;
        // }
        // };
        //     xhr.send('');
        // }
        //
        //     function renderHospitalData() {
        //     const resultDiv = document.getElementById('result');
        //     resultDiv.innerHTML = hospitalData.map(hospital =>
        //         '<div>'+
        //             '<h3>'+'병원이름:' + (hospital.dutyName || '병원 이름 없음') + '</h3>'+
        //             '<p>'+'응급실:'+ (hospital.hvec || '잔여병실없음')+'</p>' +
        //             '<p>'+'수슬실:'+ (hospital.hvoc|| '잔여병실없음')+'</p>' +
        //         '</div>'
        //     ).join('');
        // }
        //
        //     // 페이지 로드 시 데이터 가져오기
        //     window.onload = fetchHospitalData;

        let hospitalData = [];

        function fetchHospitalData() {
            var xhr = new XMLHttpRequest();
            var url = 'http://apis.data.go.kr/B552657/ErmctInfoInqireService/getEmrrmRltmUsefulSckbdInfoInqire';
            var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'ymM0cegTHI9EEDldHJd0Bk1pFJ7Is8b%2B9qmZ8zQMpMLLoZI9B2zPT0rwSX6dOvLI0736SD4F6yOn0vXUg9OKiw%3D%3D';
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

        // function renderHospitalData() {
        //     const container = document.getElementById('listinfo');
        //     container.innerHTML = ''; // 이전 내용 초기화
        //
        //     hospitalData.forEach(function(hospital, index) {
        //         // 동적으로 ID를 설정
        //         const resultDiv = document.createElement('div');
        //         resultDiv.id = 'result' + index; // 예: result0, result1, ...
        //
        //         // 병원 데이터 추가
        //         resultDiv.innerHTML =
        //             '<h3>' + '병원이름: ' + (hospital.dutyName || '병원 이름 없음') + '</h3>' +
        //             '<p>' + '응급실: ' + (hospital.hvec || '잔여 병실 없음') + '</p>' +
        //             '<p>' + '수술실: ' + (hospital.hvoc || '잔여 병실 없음') + '</p>';
        //
        //         // 컨테이너에 추가
        //         container.appendChild(resultDiv);
        //     });
        // }
        //
        // // 페이지 로드 시 데이터 가져오기
        // window.onload = fetchHospitalData;
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
<%--                <div id="listinfo">--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s"--%>
<%--                     style="visibility: visible; animation-delay: 0.1s;">--%>
<%--                    <div class="team-item bg-light">--%>
<%--                        <div class="overflow-hidden">--%>
<%--                            <img class="img-fluid"--%>
<%--                                 src="https://www.asantoday.com/imgdata/asantoday/201607/2016072036393245.jpg" alt="">--%>
<%--                        </div>--%>
<%--                        <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">--%>
<%--                            <div class="bg-light d-flex justify-content-center pt-2 px-1">--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i--%>
<%--                                        class="fab fa-instagram"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-center p-4">--%>
<%--                            <h5 class="mb-0">Instructor Name</h5>--%>
<%--                            <small>Designation</small>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s"--%>
<%--                     style="visibility: visible; animation-delay: 0.3s;">--%>
<%--                    <div class="team-item bg-light">--%>
<%--                        <div class="overflow-hidden">--%>
<%--                            <img class="img-fluid" src="https://lh6.googleusercontent.com/proxy/S-YMd_0HvoNMIMjG0xrGdkNb7teSaTRdM5Cj16xU8squK47Y-5Dc05WtDGU0fKZCFCAJPlSgufiSKyE" alt="">--%>
<%--                        </div>--%>
<%--                        <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">--%>
<%--                            <div class="bg-light d-flex justify-content-center pt-2 px-1">--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-center p-4">--%>
<%--                            <h5 class="mb-0">Instructor Name</h5>--%>
<%--                            <div id="result"></div>--%>
<%--                            <small>Designation</small>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.5s" style="visibility: visible; animation-delay: 0.5s;">--%>
<%--                    <div class="team-item bg-light">--%>
<%--                        <div class="overflow-hidden">--%>
<%--                            <img class="img-fluid" src="https://yuhs.severance.healthcare/_res/yuhs/yuhs/img/about/sevrance/img-sevrance2.jpg" alt="">--%>
<%--                        </div>--%>
<%--                        <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">--%>
<%--                            <div class="bg-light d-flex justify-content-center pt-2 px-1">--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-center p-4">--%>
<%--                            <h5 class="mb-0">Instructor Name</h5>--%>
<%--                            <small>Designation</small>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.7s" style="visibility: visible; animation-delay: 0.7s;">--%>
<%--                    <div class="team-item bg-light">--%>
<%--                        <div class="overflow-hidden">--%>
<%--                            <img class="img-fluid" src="https://www.snuh.org/asset/img/about/img_overview01.jpg" alt="">--%>
<%--                        </div>--%>
<%--                        <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">--%>
<%--                            <div class="bg-light d-flex justify-content-center pt-2 px-1">--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-center p-4">--%>
<%--                            <h5 class="mb-0">Instructor Name</h5>--%>
<%--                            <small>Designation</small>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s;">--%>
<%--                    <div class="team-item bg-light">--%>
<%--                        <div class="overflow-hidden">--%>
<%--                            <img class="img-fluid" src="data:image/jpeg;base64,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" alt="">--%>
<%--                        </div>--%>
<%--                        <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">--%>
<%--                            <div class="bg-light d-flex justify-content-center pt-2 px-1">--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-center p-4">--%>
<%--                            <h5 class="mb-0">Instructor Name</h5>--%>
<%--                            <small>Designation</small>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s;">--%>
<%--                    <div class="team-item bg-light">--%>
<%--                        <div class="overflow-hidden">--%>
<%--                            <img class="img-fluid" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNssbcEBMFhD4TZmV0V9895m2YmVSR9BveLw&s" alt="">--%>
<%--                        </div>--%>
<%--                        <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">--%>
<%--                            <div class="bg-light d-flex justify-content-center pt-2 px-1">--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-center p-4">--%>
<%--                            <h5 class="mb-0">Instructor Name</h5>--%>
<%--                            <small>Designation</small>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s;">--%>
<%--                    <div class="team-item bg-light">--%>
<%--                        <div class="overflow-hidden">--%>
<%--                            <img class="img-fluid" src="https://lh4.googleusercontent.com/proxy/Nuz4BlBOysRp-41JHgSMDDXA6e1jMXDfzXuF_9thED_3olywWDs_WqXLknXzkJcQfawkx8gt5Y4Xlnopc_RE3-40GUEuflLmxOdukocXVfWn-zBB" alt="">--%>
<%--                        </div>--%>
<%--                        <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">--%>
<%--                            <div class="bg-light d-flex justify-content-center pt-2 px-1">--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-center p-4">--%>
<%--                            <h5 class="mb-0">Instructor Name</h5>--%>
<%--                            <small>Designation</small>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s" style="visibility: visible; animation-delay: 0.1s;">--%>
<%--                    <div class="team-item bg-light">--%>
<%--                        <div class="overflow-hidden">--%>
<%--                            <img class="img-fluid" src="https://www.cmhos.co.kr/images/page/introduction_copy.jpg" alt="">--%>
<%--                        </div>--%>
<%--                        <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">--%>
<%--                            <div class="bg-light d-flex justify-content-center pt-2 px-1">--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-facebook-f"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-twitter"></i></a>--%>
<%--                                <a class="btn btn-sm-square btn-primary mx-1" href=""><i class="fab fa-instagram"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="text-center p-4">--%>
<%--                            <h5 class="mb-0">Instructor Name</h5>--%>
<%--                            <small>Designation</small>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
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