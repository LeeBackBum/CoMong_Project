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
            border: 2px solid black; /* 흰색 테두리 */
            border-radius: 8px;
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

</script>



<%----------------------------사용자 위치 기반 병원 목록--------------------------------------------------------%>
<script>


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
    geocoder.addressSearch(address, function (result, status) {

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
                            const hpid = items[i].getElementsByTagName('hpid')[0].textContent.trim();

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
                                    '<img src="/imgt/hpmarker.png" width="73" height="70">' +
                                    '</div>' +
                                    '<div class="desc">' +
                                    '<div class="ellipsis">' + (dutyAddr || '병원 주소 없음') + '</div>' +
                                    '<div class="ellipsis">잔여 병상수: ' + (hpbdn || '0') + '개</div>' +
                                    '<div id="cattery" style="display:none;">' + (hpid || '기관아이디없음') + '</div>'+
                                    '<a href="https://map.kakao.com/?q='+encodeURIComponent(dutyAddr || '병원 이름 없음')+'">클릭</a>' +
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
                    const hpid = items[i].getElementsByTagName('hpid')[0]?.textContent.trim() || '0';

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
                            '<img src="/imgt/hpmarker.png" width="73" height="70">' +
                            '</div>' +
                            '<div class="desc">' +
                            '<div class="ellipsis">' + (dutyAddr || '병원 주소 없음') + '</div>' +
                            '<div class="ellipsis">잔여 병상수: ' + (hpbdn || '0') + '개</div>' +
                            '<div id="cattery" style="display:none;">' + (hpid || '기관아이디없음') + '</div>'+
                            '<a href="https://map.kakao.com/?q='+encodeURIComponent(dutyAddr || '병원 이름 없음')+'">클릭</a>' +
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
                    const hpid = items[i].getElementsByTagName('hpid')[0]?.textContent.trim() || '0';

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
                            '<img src="/imgt/hpmarker.png" width="73" height="70">' +
                            '</div>' +
                            '<div class="desc">' +
                            '<div class="ellipsis">' + (dutyAddr || '병원 주소 없음') + '</div>' +
                            '<div class="ellipsis">잔여 병상수: ' + (hpbdn || '0') + '개</div>' +
                            '<div id="cattery" >' + (hpid || '기관아이디없음') + '</div>'+
                            '<a href="https://map.kakao.com/?q='+encodeURIComponent(dutyAddr || '병원 이름 없음')+'">클릭</a>' +
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