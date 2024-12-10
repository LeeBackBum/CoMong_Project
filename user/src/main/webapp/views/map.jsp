<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <link href="<c:url value="/css/kakaomarker.css"/>" rel="stylesheet">
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
            background-color: black;
        }

        .hidden {
            display: none;
        }

        #content {
            display: none;
            border: 1px solid #ccc;
            padding: 20px;
            margin-top: 20px;
            border-radius: 5px;
            background-color: #f9f9f9;
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
<!-- Header End -->


<div id="map" style="width:100%;height:800px;"></div>
<div id="result"></div>
<div id="content">
    <h2>Map Example</h2>
    <p>카카오 지도 API와 관련된 예제가 여기에 표시됩니다.</p>
    <p>더 자세한 정보는 <a href="https://apis.map.kakao.com/web/sample/addMapClickEventWithMarker/" target="_blank">이 링크</a>를 통해 확인하세요.</p>
</div>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        const link = document.getElementById('displayLink');
        if (link) {
            link.addEventListener('click', function (event) {
                event.preventDefault();
                alert('Link clicked!');
            });
        } else {
            console.error('Element with id "displayLink" not found.');
        }
    });

</script>

<%----------------------------사용자 위치 기반 병원 목록--------------------------------------------------------%>
<script>
    var hpid;
    // 사용자가 입력한 주소 (예시)
    var address = '${userAddress}';

    // 카카오 맵 설정
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new kakao.maps.LatLng(36.7989764, 127.0750025), // 초기 지도의 중심좌표
            level: 6 // 지도의 확대 레벨
        };

    // 지도를 생성합니다
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(address, function(result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);  // 위도와 경도
            var latitude = result[0].y;  // 위도
            var longitude = result[0].x; // 경도

            console.log("경도:", longitude);
            console.log("위도:", latitude);

            // API 요청을 위해 queryParams에 동적으로 경도와 위도 값 삽입
            var xhr = new XMLHttpRequest();
            var url = 'https://apis.data.go.kr/B552657/ErmctInfoInqireService/getEgytLcinfoInqire'; /*URL*/
            var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'ViBoL0JKIqkhrZMZhx1K6J7JVyKXHWCA6C%2BHjVHNkKYYZYaAaTdx9Ol1I0au2URlvLKjmWozl%2Fw01r9XXY9ztA%3D%3D'; /*Service Key*/
            queryParams += '&' + encodeURIComponent('WGS84_LON') + '=' + encodeURIComponent(longitude);  // 변환된 경도
            queryParams += '&' + encodeURIComponent('WGS84_LAT') + '=' + encodeURIComponent(latitude);   // 변환된 위도
            queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /*페이지 번호*/
            queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /*목록 건수*/


            // API 요청
            xhr.open('GET', url + queryParams);
            xhr.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    // 응답이 XML 형식이므로, XML 파서 사용
                    var parser = new DOMParser();
                    var xmlDoc = parser.parseFromString(this.responseText, "text/xml");

                    // XML에서 latitude와 longitude 추출
                    var items = xmlDoc.getElementsByTagName('item');
                    var resultDiv = document.getElementById('result');

                    if (items.length > 0) {
                        const positions = [];
                        // 여러 항목의 위도, 경도를 표시
                        for (var i = 0; i < items.length; i++) {
                            const latitude = items[i].getElementsByTagName('latitude')[0].textContent;
                            const longitude = items[i].getElementsByTagName('longitude')[0].textContent;
                            const dutyName = items[i].getElementsByTagName('dutyName')[0].textContent.trim();
                            const dutyAddr = items[i].getElementsByTagName('dutyAddr')[0].textContent.trim();
                            hpid = items[i].getElementsByTagName('hpid')[0].textContent.trim();



                            if (latitude && longitude) {
                                const position = new kakao.maps.LatLng(latitude, longitude);

                                // 오버레이 내용 정의 (이미지와 정보 포함)
                                const content =
                                    '<div class="wrap">' +
                                    '<div class="info">' +
                                    '<div class="title">' +
                                    (dutyName || '병원 이름 없음') +
                                    '<div class="close" title="닫기"></div>' +
                                    '</div>' +
                                    '<div class="body">' +
                                    '<div class="img">' +
                                    '<img src="data:image/png;base64,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" width="73" height="70">' +
                                    '</div>' +
                                    '<div class="desc">' +
                                    '<div class="ellipsis">' + (dutyAddr || '병원 주소 없음') + '</div>' +
                                    '<div class="ellipsis">잔여 병상수: ' + '0' + '개</div>' +
                                    '<a href="https://apis.map.kakao.com/web/sample/addMapClickEventWithMarker/">클릭</a>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>' +
                                    '</div>';

                                positions.push({ content, latlng: position });
                            }
                        }

                        // 지도에 마커 생성 및 오버레이 추가
                        positions.forEach(pos => {
                            const marker = new kakao.maps.Marker({
                                map: map,
                                position: pos.latlng,
                            });

                            const overlay = new kakao.maps.CustomOverlay({
                                content: pos.content,
                                map: null, // 초기에는 표시하지 않음
                                position: pos.latlng,
                            });

                            // 마커 클릭 시 오버레이 표시
                            kakao.maps.event.addListener(marker, 'click', function () {
                                overlay.setMap(map); // 오버레이 표시

                                // 오버레이가 지도에 표시된 후 닫기 버튼에 이벤트 리스너 연결
                                const overlayContent = document.querySelector('.wrap'); // 현재 지도에 추가된 .wrap 요소 찾기
                                const closeButton = overlayContent.querySelector('.close');
                                closeButton.addEventListener('click', function () {
                                    overlay.setMap(null); // 오버레이 닫기
                                });
                            });
                        });

                        document.addEventListener('DOMContentLoaded', function () {
                            const link = document.getElementById('displayLink');
                            if (link) {
                                link.addEventListener('click', function (event) {
                                    event.preventDefault();
                                    alert('Link clicked!');
                                });
                            } else {
                                console.error('Element with id "displayLink" not found.');
                            }
                        });



                    } else {
                        resultDiv.innerHTML = "데이터가 없습니다.";
                    }
                } else if (this.readyState == 4 && this.status != 200) {
                    document.getElementById('result').innerHTML = "API 요청 실패: " + this.status;
                }
            };
            xhr.send('');


            // 지도 중심을 현재 위치로 이동
            map.setCenter(coords);

            var imageSrc = 'https://cdn.icon-icons.com/icons2/2413/PNG/512/pin_location_map_marker_placeholder_icon_146263.png', // 마커이미지의 주소입니다
                imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
                imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);



            // 마커를 추가하여 현재 위치를 표시합니다.
            var usermarker = new kakao.maps.Marker({
                map: map,
                position: coords,
                image: markerImage
            });

            // 인포윈도우로 현재 위치를 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
                // content: '<div style="width:150px;text-align:center;padding:6px 0;">현재 위치입니다.</div>'
                content: '<div class="title">현재 위치입니다.</div>' +
                    '<a href ="/mypage" >내정보 확인</a>'

            });
            infowindow.open(map, usermarker);

        } else {
            console.error("주소를 찾을 수 없습니다.");
        }
    });

    // 인포윈도우를 표시하는 클로저를 만드는 함수입니다
    function makeOverListener(map, marker, overlay) {
        return function() {
            overlay.open(map, marker);
        };
    }

    // 인포윈도우를 닫는 클로저를 만드는 함수입니다
    function makeOutListener(overlay) {
        return function() {
            overlay.close();
        };
    }
</script>
<%----------------------------사용자 위치 기반 병원 목록--------------------------------------------------------%>



<%----------------------------기관ID 기반 병원 목록--------------------------------------------------------%>
<script>


    var xhr = new XMLHttpRequest();
    var url = 'https://apis.data.go.kr/B552657/ErmctInfoInqireService/getEgytBassInfoInqire'; /*URL*/
    var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'ymM0cegTHI9EEDldHJd0Bk1pFJ7Is8b%2B9qmZ8zQMpMLLoZI9B2zPT0rwSX6dOvLI0736SD4F6yOn0vXUg9OKiw%3D%3D'; /*Service Key*/
    // queryParams += '&' + encodeURIComponent('HPID') + '=' + encodeURIComponent(); /**/
    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('100'); /**/


    // API 요청
    xhr.open('GET', url + queryParams);
    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(this.responseText, "text/xml");
            const items = xmlDoc.getElementsByTagName('item');
            const resultDiv = document.getElementById('result');

            if (items.length > 0) {
                const positions = [];

                for (let i = 0; i < items.length; i++) {
                    const latitude = items[i].getElementsByTagName('wgs84Lat')[0]?.textContent || null;
                    const longitude = items[i].getElementsByTagName('wgs84Lon')[0]?.textContent || null;
                    const dutyName = items[i].getElementsByTagName('dutyName')[0]?.textContent.trim() || '병원 이름 없음';
                    const dutyAddr = items[i].getElementsByTagName('dutyAddr')[0]?.textContent.trim() || '병원 주소 없음';
                    const hpbdn = items[i].getElementsByTagName('hpbdn')[0]?.textContent.trim() || '0';

                    if (latitude && longitude) {
                        const position = new kakao.maps.LatLng(latitude, longitude);

                        // 오버레이 내용 정의 (이미지와 정보 포함)
                        const content =
                            '<div class="wrap">' +
                            '<div class="info">' +
                            '<div class="title">' +
                            (dutyName || '병원 이름 없음') +
                            '<div class="close" title="닫기"></div>' +
                            '</div>' +
                            '<div class="body">' +
                            '<div class="img">' +
                            '<img src="data:image/png;base64,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" width="73" height="70">' +
                            '</div>' +
                            '<div class="desc">' +
                            '<div class="ellipsis">' + (dutyAddr || '병원 주소 없음') + '</div>' +
                            '<div class="ellipsis">잔여 병상수: ' + (hpbdn || '0') + '개</div>' +
                            '<a href="#" id="displayLink">클릭</a>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';

                        positions.push({ content, latlng: position });
                    }
                }

                // 지도에 마커 생성 및 오버레이 추가
                positions.forEach(pos => {
                    const marker = new kakao.maps.Marker({
                        map: map,
                        position: pos.latlng,
                    });

                    const overlay = new kakao.maps.CustomOverlay({
                        content: pos.content,
                        map: null, // 초기에는 표시하지 않음
                        position: pos.latlng,
                    });

                    // 마커 클릭 시 오버레이 표시
                    kakao.maps.event.addListener(marker, 'click', function () {
                        overlay.setMap(map); // 오버레이 표시

                        // 오버레이가 지도에 표시된 후 닫기 버튼에 이벤트 리스너 연결
                        const overlayContent = document.querySelector('.wrap'); // 현재 지도에 추가된 .wrap 요소 찾기
                        const closeButton = overlayContent.querySelector('.close');
                        closeButton.addEventListener('click', function () {
                            overlay.setMap(null); // 오버레이 닫기
                        });
                    });
                });
                console.log("지도 표기 성공")
                resultDiv.innerHTML = "";
            } else {
                resultDiv.innerHTML = "데이터가 없습니다.";
            }
        } else if (this.readyState === 4 && this.status !== 200) {
            document.getElementById('result').innerHTML = "API 요청 실패: " + this.status;
        }
    };
    xhr.send('');

</script>
<%----------------------------기관ID 기반 병원 목록--------------------------------------------------------%>




<%----------------------------도시 기반 병원 목록--------------------------------------------------------%>
<script>


    var xhr = new XMLHttpRequest();
    var url = 'https://apis.data.go.kr/B552657/ErmctInfoInqireService/getEgytListInfoInqire'; /*URL*/
    var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'ymM0cegTHI9EEDldHJd0Bk1pFJ7Is8b%2B9qmZ8zQMpMLLoZI9B2zPT0rwSX6dOvLI0736SD4F6yOn0vXUg9OKiw%3D%3D'; /*Service Key*/
    queryParams += '&' + encodeURIComponent('Q0') + '=' + encodeURIComponent('부산광역시'); /**/
    queryParams += '&' + encodeURIComponent('ORD') + '=' + encodeURIComponent('NAME'); /**/
    queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
    queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /**/


    xhr.open('GET', url + queryParams);


    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(this.responseText, "text/xml");
            const items = xmlDoc.getElementsByTagName('item');
            const resultDiv = document.getElementById('result');

            if (items.length > 0) {
                const positions = [];

                for (let i = 0; i < items.length; i++) {
                    const latitude = items[i].getElementsByTagName('wgs84Lat')[0]?.textContent || null;
                    const longitude = items[i].getElementsByTagName('wgs84Lon')[0]?.textContent || null;
                    const dutyName = items[i].getElementsByTagName('dutyName')[0]?.textContent.trim() || '병원 이름 없음';
                    const dutyAddr = items[i].getElementsByTagName('dutyAddr')[0]?.textContent.trim() || '병원 주소 없음';
                    const hpbdn = items[i].getElementsByTagName('hpbdn')[0]?.textContent.trim() || '0';

                    if (latitude && longitude) {
                        const position = new kakao.maps.LatLng(latitude, longitude);

                        // 오버레이 내용 정의 (이미지와 정보 포함)
                        const content =
                            '<div class="wrap">' +
                            '<div class="info">' +
                            '<div class="title">' +
                            (dutyName || '병원 이름 없음') +
                            '<div class="close" title="닫기"></div>' +
                            '</div>' +
                            '<div class="body">' +
                            '<div class="img">' +
                            '<img src="data:image/png;base64,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" width="73" height="70">' +
                            '</div>' +
                            '<div class="desc">' +
                            '<div class="ellipsis">' + (dutyAddr || '병원 주소 없음') + '</div>' +
                            '<div class="ellipsis">잔여 병상수: ' + (hpbdn || '0') + '개</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';

                        positions.push({ content, latlng: position });
                    }
                }

                // 지도에 마커 생성 및 오버레이 추가
                positions.forEach(pos => {
                    const marker = new kakao.maps.Marker({
                        map: map,
                        position: pos.latlng,
                    });

                    const overlay = new kakao.maps.CustomOverlay({
                        content: pos.content,
                        map: null, // 초기에는 표시하지 않음
                        position: pos.latlng,
                    });

                    // 마커 클릭 시 오버레이 표시
                    kakao.maps.event.addListener(marker, 'click', function () {
                        overlay.setMap(map); // 오버레이 표시

                        // 오버레이가 지도에 표시된 후 닫기 버튼에 이벤트 리스너 연결
                        const overlayContent = document.querySelector('.wrap'); // 현재 지도에 추가된 .wrap 요소 찾기
                        const closeButton = overlayContent.querySelector('.close');
                        closeButton.addEventListener('click', function () {
                            overlay.setMap(null); // 오버레이 닫기
                        });
                    });
                });

                resultDiv.innerHTML = "";
            } else {
                resultDiv.innerHTML = "데이터가 없습니다.";
            }
        } else if (this.readyState === 4 && this.status !== 200) {
            document.getElementById('result').innerHTML = "API 요청 실패: " + this.status;
        }
    };
    xhr.send('');

</script>

<%----------------------------도시 기반 병원 목록--------------------------------------------------------%>
</body>
</html>