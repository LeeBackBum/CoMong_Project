<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
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

<script>
    var geocoder = new kakao.maps.services.Geocoder();

    var coord = new kakao.maps.LatLng(36.7989764, 127.0750025);
    var callback = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            console.log('변경된 주소는 [' + result[0].address.address_name + '] 입니다');
        }
    };

    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);

</script>
</body>
</html>