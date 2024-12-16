<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        canvas {
            /*position: absolute;*/
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }


        /* hidden으로 설정된 div */
        #hiddenDiv {
            display: none; /* 기본적으로 숨기기 */
        }




    </style>



    <meta charset="utf-8" />
    <title>React App</title>

</head>
<body>
<canvas id="canvas" width="" height=""></canvas>
<%-------------------------------Chart  Main Start-----------------------------------%>
<div id="hiddenDiv" >
    <!-- Chart Start -->
    <div class ="row" width="500" height="500">
        <%--    <div class="container-fluid pt-4 px-4">--%>
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
<%--</div>--%>
<%-------------------------------Chart  Main End-----------------------------------%>


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

                title: { text: 'HealthCare Live Data' },

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


        // display1: function(data) {
        //     const normalRange = { min: 80, max: 139 }; // 예시 정상 범위
        //     const processedData = data.map(item => item.value);
        //     const pointBackgroundColors = processedData.map(value =>
        //         (value < normalRange.min || value > normalRange.max) ? "red" : "rgba(0, 156, 255, .3)"
        //     );
        //
        //     // 날짜와 혈압 수치를 추출
        //     const labels = data.map(item => {
        //         const date = new Date(item.timestamp);
        //         return (date.getMonth() + 1) + '월 ' + date.getDate() + '일'; // "12월 1일" 형식으로 변환
        //     });
        //
        //     var ctx3 = $("#line-chart").get(0).getContext("2d");
        //     this.chartInstance = new Chart(ctx3, {
        //         type: "line",
        //         data: {
        //             labels: labels, // 변환된 라벨 사용
        //             datasets: [{
        //                 label: "위험 수치",
        //                 fill: false,
        //                 backgroundColor: pointBackgroundColors,
        //                 data: processedData
        //             }]
        //         },
        //         options: {
        //             responsive: true
        //         }
        //     });
        // },
        display1: function(data = []) { // 기본값 설정
            if (!Array.isArray(data) || data.length === 0) {
                console.error("혈압 데이터가 비어 있거나 잘못되었습니다.");
                return;
            }

            const normalRange = { min: 80, max: 139 }; // 예시 정상 범위
            const processedData = data.map(item => item.value);
            const pointBackgroundColors = processedData.map(value =>
                (value < normalRange.min || value > normalRange.max) ? "red" : "rgba(0, 156, 255, .3)"
            );

            const labels = data.map(item => {
                const date = new Date(item.timestamp);
                return `${date.getMonth() + 1}월 ${date.getDate()}일`;
            });

            const ctx3 = $("#line-chart").get(0).getContext("2d");
            this.chartInstance = new Chart(ctx3, {
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

        // display3: function(data) {
        //     // 최근 5개의 데이터만 가져오기
        //     const recentData = data.slice(-5); // 배열의 마지막 5개 요소를 선택
        //
        //     // 날짜와 우울증 점수를 추출
        //     const labels = recentData.map(item => {
        //         const date = new Date(item.timestamp);
        //         return (date.getMonth() + 1)+'월' +(date.getDate())+'일'; // "12월 1일" 형식으로 변환
        //     });
        //     const depressionScores = recentData.map(item => item.value); // 우울증 점수 추출
        //
        //     var ctx4 = $("#bar-chart").get(0).getContext("2d");
        //     if (this.charts && this.charts.depressionChart) {
        //         this.charts.depressionChart.destroy(); // 기존 차트 인스턴스 제거
        //     }
        //     this.charts.depressionChart = new Chart(ctx4, {
        //         type: "bar",
        //         data: {
        //             labels: labels, // x축 라벨 설정
        //             datasets: [{
        //                 label: "우울증 점수",
        //                 backgroundColor: [
        //                     "rgba(0, 156, 255, .7)",
        //                     "rgba(0, 156, 255, .6)",
        //                     "rgba(0, 156, 255, .5)",
        //                     "rgba(0, 156, 255, .4)",
        //                     "rgba(0, 156, 255, .3)"
        //                 ],
        //                 data: depressionScores // y축 데이터 설정
        //             }]
        //         },
        //         options: {
        //             responsive: true
        //         }
        //     });
        // },
        display3: function(data = []) {
            if (!this.charts) {
                this.charts = {}; // charts 객체 초기화
            }

            const recentData = data.slice(-5);
            const labels = recentData.map(item => {
                const date = new Date(item.timestamp);
                return `${date.getMonth() + 1}월 ${date.getDate()}일`;
            });
            const depressionScores = recentData.map(item => item.value);

            const ctx4 = $("#bar-chart").get(0).getContext("2d");
            if (this.charts.depressionChart) {
                this.charts.depressionChart.destroy(); // 기존 차트 제거
            }

            this.charts.depressionChart = new Chart(ctx4, {
                type: "bar",
                data: {
                    labels: labels,
                    datasets: [{
                        label: "우울증 점수",
                        backgroundColor: [
                            "rgba(0, 156, 255, .7)",
                            "rgba(0, 156, 255, .6)",
                            "rgba(0, 156, 255, .5)",
                            "rgba(0, 156, 255, .4)",
                            "rgba(0, 156, 255, .3)"
                        ],
                        data: depressionScores
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



<%--&lt;%&ndash;-----------------------------Chart  Main Start---------------------------------&ndash;%&gt;--%>
<%--<div id="hiddenDiv">--%>
<%--        <!-- Chart Start -->--%>
<%--        <div class="container-fluid pt-4 px-4">--%>
<%--            <div class="row g-4">--%>
<%--                <div class="col-sm-12 col-xl-6">--%>
<%--                    <div class="bg-light rounded h-100 p-4">--%>
<%--                        <div class="d-flex align-items-center justify-content-between mb-4">--%>
<%--                            <h6 class="mb-0">일별 혈압</h6>--%>
<%--                        </div>--%>
<%--                        <canvas id="line-chart"></canvas>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-sm-12 col-xl-6">--%>
<%--                    <div class="bg-light rounded h-100 p-4">--%>
<%--                        <div class="d-flex align-items-center justify-content-between mb-4">--%>
<%--                            <h6 class="mb-0">일별 혈당</h6>--%>
<%--                        </div>--%>
<%--                        <canvas id="line-chart2"></canvas>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-sm-12 col-xl-6">--%>
<%--                    <div class="bg-light rounded h-100 p-4">--%>
<%--                        <h6 class="mb-4">우울증 수치</h6>--%>
<%--                        <canvas id="bar-chart"></canvas>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-sm-12 col-xl-6">--%>
<%--                    <div class="bg-light rounded h-100 p-4">--%>
<%--                        <h6 class="mb-4">특이사항에 관한 실시간 데이터</h6>--%>
<%--                        <div id="container" style="width: 100%; height: 300px;"></div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <!-- Chart End -->--%>

<%--        <!-- Footer Start -->--%>
<%--        <div class="container-fluid pt-4 px-4">--%>
<%--            <div class="bg-light rounded-top p-4">--%>
<%--                <div class="row">--%>
<%--                    <div class="col-12 col-sm-6 text-center text-sm-start">--%>
<%--                        &copy; <a href="#">Your Site Name</a>, All Right Reserved.--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <!-- Footer End -->--%>
<%--    </div>--%>
<%--&lt;%&ndash;-----------------------------Chart  Main End---------------------------------&ndash;%&gt;--%>


<script type="importmap">
    {
      "imports": {
        "three": "https://unpkg.com/three@0.171.0/build/three.module.js",
        "GLTFLoader": "https://unpkg.com/three@0.171.0/examples/jsm/loaders/GLTFLoader.js",
        "OBJLoader": "https://unpkg.com/three@0.171.0/examples/jsm/loaders/OBJLoader.js",
        "OrbitControls": "https://unpkg.com/three@0.171.0/examples/jsm/controls/OrbitControls.js"
      }
    }
</script>
<script type="module">
    import { GLTFLoader } from 'GLTFLoader';
    import { OBJLoader } from 'OBJLoader';
    import * as THREE from 'three';
    import { OrbitControls } from 'OrbitControls';

    document.addEventListener('click', onclick, true)

    let selectedObject = null
    const raycaster = new THREE.Raycaster()
    const mouse = new THREE.Vector2()
    const hiddenDiv = document.getElementById('hiddenDiv');

    let hasClicked = false;

    function onclick(event) {
        if (hasClicked) return;
        hiddenDiv.style.display = 'block';
        alert('테스트')
        console.log('click', event)
        console.log('mouse', mouse)
        console.log('camera position:', camera.position);
        console.log('scene.resource.obj', scene.resource.obj.children)
        if (selectedObject) {
            // console.log('selectedObj', selectedObject)
        }
        mouse.x = (event.clientX / window.innerWidth) * 2 - 1
        mouse.y = -(event.clientY / window.innerHeight) * 2 + 1
        raycaster.setFromCamera(mouse, camera)
        const intersects = raycaster.intersectObjects(scene.resource.obj.children, true) //array
        console.log('intersects', intersects)
        // console.log('mouse:', mouse);
        // console.log('scene.resource.obj.children:', scene.resource.obj.children);
        // console.log('camera position:', camera.position);

        if (intersects.length > 0) {
            const res = intersects.filter(function (res) {
                return res && res.object
            })[0]
            if (res && res.object) {
                selectedObject = res.object
                alert(selectedObject.parent.name)
                if (selectedObject.parent.name == 'FinalBaseMesh') {
                    alert('모델 찾았습니다')
                }
            }
        }
        hasClicked = true;  // 첫 번째 클릭 후 상태 변경
        document.removeEventListener('click', onclick, true);  // 클릭 이벤트 리스너 제거
    }


    let mesh;

    let scene = new THREE.Scene();
    scene.resource = { obj: new THREE.Group() };
    // const mesh = new THREE.Mesh(
    //     new THREE.BoxGeometry(1, 1, 1),
    //     new THREE.MeshBasicMaterial({ color: 0xff0000 })
    // );
    // scene.resource.obj.add(mesh); // mesh 객체를 추가합니다.
    console.log(scene.resource.obj.children);

    let renderer = new THREE.WebGLRenderer({
        canvas: document.querySelector('#canvas'),
        antialias : true,
    });

    const width = 1900;  // 너비
    const height = 700; // 높이

    // 고정된 사이즈로 설정
    renderer.setSize(width, height);
    // renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(window.devicePixelRatio); // 고해상도 디스플레이 대응
    // document.body.appendChild(renderer.domElement); //코드 사용시 document방식이라  문서가 로딩된후 마지막에 랜더링 됨


    const light = new THREE.DirectionalLight(0xffffff, 1);
    light.position.set(10, 10, 10);
    // scene.add(light);

    renderer.outputEncoding = THREE.sRGBEncoding;
    // let camera = new THREE.PerspectiveCamera(30, 1);


    // const targetPosition = new THREE.Vector3(30, 69, 93);

    const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
    camera.position.z = 3;

    // 초기 카메라 위치 설정
    camera.position.set(124.97597954293448, 74.56251244431301, 64.75197312890715);

    // 카메라가 바라볼 목표 지점 계산 (Camera Position + Camera Direction)
    const direction = new THREE.Vector3(-5.6738031984021, -5.6738031984021, -6.734449223092222);
    const target = new THREE.Vector3();
    target.copy(camera.position).add(direction);

    // 카메라가 목표 지점을 바라보도록 설정
    camera.lookAt(target);

    // camera.lookAt(0,0,0);      // 모델 중심을 향하도록 설정
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
    console.log("Camera Direction: x=" + camera.position.x + ", y=" + camera.position.y + ", z=" + camera.position.z);



    // OrbitControls를 추가합니다.
    let controls = new OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true; // 부드러운 회전을 위한 damping 활성화
    controls.dampingFactor = 0.25;
    controls.target.set(0, 0, 0); // 카메라가 바라보는 초기 목표 지점
    controls.update();



    // controls.target.copy(targetPosition);


    const textureLoader = new THREE.TextureLoader();
    const map = textureLoader.load( 'examples/models/gltf/LeePerrySmith/Map-COL.jpg' );
    map.colorSpace = THREE.SRGBColorSpace;
    const specularMap = textureLoader.load( 'examples/models/gltf/LeePerrySmith/Map-SPEC.jpg' );
    const normalMap = textureLoader.load( 'examples/models/gltf/LeePerrySmith/Infinite-Level_02_Tangent_SmoothUV.jpg' );

    // -------------------------------------gltf 모델 렌더링 start------------------------------------------------
    // let loader = new GLTFLoader();
    // loader.load('examples/models/gltf/LeePerrySmith/LeePerrySmith.glb', function (gltf) {
    //     mesh = gltf.scene.children[ 0 ];
    //     mesh.material = new THREE.MeshPhongMaterial( {
    //         specular: 0x111111,
    //         map: map,
    //         specularMap: specularMap,
    //         normalMap: normalMap,
    //         shininess: 25
    //     } );
    //
    //     scene.add( mesh );
    //     mesh.scale.multiplyScalar( 10 );
    //
    //
    //     //
    //     scene.add(gltf.scene);
    //     scene.background = new THREE.Color('black');
    //
    //     let ambientLight = new THREE.AmbientLight(0xffffff, 0.5);  // 색상과 강도
    //     scene.add(ambientLight);
    //
    //     let dirLight = new THREE.DirectionalLight(0xffffff, 0.5);
    //     dirLight.position.set(0, 5, 5);  // 위치 설정
    //     scene.add(dirLight);
    //
    //     function animate(){
    //         requestAnimationFrame(animate);
    //         controls.update(); // OrbitControls 업데이트를 추가합니다.
    //         renderer.render(scene, camera);
    //     }
    //     animate();
    // });
    // -------------------------------------gltf 모델 렌더링 end------------------------------------------------
    var material = new THREE.MeshStandardMaterial;

    var texture = new THREE.TextureLoader().load('examples/models/obj/apple_watch_nike_face.jpg');
    // vmppmax_v4_1_3_2_g.png
    material.map = texture;


    let loader = new OBJLoader();
    loader.load('examples/models/obj/Apple_watch_Nike.obj', function (object) {
        object.traverse(function(child) {
            if(child instanceof THREE.Mesh) {
                child.material = material;
                scene.add(object)
                scene.background = new THREE.Color('white');

                let ambientLight = new THREE.AmbientLight(0xffffff, 0.5);  // 색상과 강도
                scene.add(ambientLight);

                let dirLight = new THREE.DirectionalLight(0xffffff, 0.5);
                dirLight.position.set(0, 5, 5);  // 위치 설정
                scene.add(dirLight);

                function animate(){
                    requestAnimationFrame(animate);
                    controls.update(); // OrbitControls 업데이트를 추가합니다.


                    // // 카메라 방향 계산
                    // const direction = new THREE.Vector3();
                    // camera.getWorldDirection(direction);
                    //
                    // // 카메라의 위치를 OrbitControls.target을 기준으로 설정
                    // const distance = 10; // 원하는 거리
                    // const newPosition = new THREE.Vector3();
                    // newPosition.copy(controls.target).sub(direction.multiplyScalar(distance));
                    //
                    // camera.position.set(newPosition.x, newPosition.y, newPosition.z);
                    //
                    // // 콘솔에 카메라 위치와 방향 출력
                    // console.log("Camera Position: x=" + camera.position.x + ", y=" + camera.position.y + ", z=" + camera.position.z);
                    // console.log("Camera Direction: x=" + direction.x + ", y=" + direction.y + ", z=" + direction.z);




                    renderer.render(scene, camera);
                }
                animate();
            }
        });
    });

</script>
</body>
</html>