<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%--    <meta charset="utf-8">--%>
<style>
    html, body {
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
    }


    #map {
        width: 100%;
        height: 100%;
    }
</style>

</head>
<body>

<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-white animated slideInDown">SM Korea</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                        <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                        <li class="breadcrumb-item text-white active" aria-current="page">Map</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div id="map" style="width:100%;height:800px;"></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>


    var address = '${userAddress}'

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 4 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(address, function(result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            console.log(result[0].y)
            console.log(result[0].x)
            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker1 = new kakao.maps.Marker({
                map: map,
                position: coords
            });


            var positions = [
                {
                    content: '<div>카카오</div>',
                    latlng: new kakao.maps.LatLng(33.450705, 126.570677)
                },
                {
                    content: '<div>생태연못</div>',
                    latlng: new kakao.maps.LatLng(33.450936, 126.569477)
                },
                {
                    content: '<div>현대병원</div>'
                    + '<a href="https://map.naver.com/p/directions/14145913.7728633,4411147.3249289,%EC%84%A0%EB%AC%B8%EB%8C%80%ED%95%99%EA%B5%90%20%EC%95%84%EC%82%B0%EC%BA%A0%ED%8D%BC%EC%8A%A4,11591584,PLACE_POI/14139780.1468443,4408383.6319274,%EC%95%84%EC%82%B0%EC%B6%A9%EB%AC%B4%EB%B3%91%EC%9B%90,36432793,PLACE_POI/-/transit?c=12.00,0,0,0,dh">길안내</a>',
                    latlng: new kakao.maps.LatLng(36.78311829920936, 127.00097027728451)
                },
                {
                    content: '<div>아산충무병원</div>'
                    + '<a href="https://map.naver.com/p/directions/14145913.7728633,4411147.3249289,%EC%84%A0%EB%AC%B8%EB%8C%80%ED%95%99%EA%B5%90%20%EC%95%84%EC%82%B0%EC%BA%A0%ED%8D%BC%EC%8A%A4,11591584,PLACE_POI/14139780.1468443,4408383.6319274,%EC%95%84%EC%82%B0%EC%B6%A9%EB%AC%B4%EB%B3%91%EC%9B%90,36432793,PLACE_POI/-/transit?c=12.00,0,0,0,dh">길안내</a>',
                    latlng: new kakao.maps.LatLng(36.779292504897654, 127.01994885495239)
                }
            ];

            for (var i = 0; i < positions.length; i++) {
                // 마커를 생성합니다
                var marker = new kakao.maps.Marker({
                    map: map, // 마커를 표시할 지도
                    position: positions[i].latlng // 마커의 위치
                });

                // 마커에 표시할 인포윈도우를 생성합니다
                var infowindow = new kakao.maps.InfoWindow({
                    content: positions[i].content // 인포윈도우에 표시할 내용
                });

                // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
                // 이벤트 리스너로는 클로저를 만들어 등록합니다
                // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
                kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
                kakao.maps.event.addListener(marker, 'mouseover', makeOutListener(infowindow));
            }

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다
            function makeOverListener(map, marker, infowindow) {
                return function() {
                    infowindow.open(map, marker);
                };
            }

            // 인포윈도우를 닫는 클로저를 만드는 함수입니다
            function makeOutListener(infowindow) {
                return function() {
                    infowindow.close();
                };
            }







            // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="width:150px;text-align:center;padding:6px 0;">현재 위치입니다.</div>'
            });
            infowindow.open(map, marker1);

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);

            var lat = result[0].x
            var lng = result[0].y
        }
    });
</script>
</body>
</html>