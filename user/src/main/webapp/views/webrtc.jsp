<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
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
</head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<body>
<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-lg-10 text-center">
        <h1 class="display-3 text-white animated slideInDown">Counseling</h1>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb justify-content-center">
            <li class="breadcrumb-item"><a class="text-white" href="<c:url value="/"/> ">Home</a></li>
            <li class="breadcrumb-item"><a class="text-white" href="<c:url value="/"/> ">수정</a></li>
            <li class="breadcrumb-item text-white active" aria-current="page">수정</li>
          </ol>
        </nav>
      </div>
    </div>
  </div>
</div>

<div class="admin-webrtc-container">
  <div class="video-grid">
    <div class="video-my">
      <video id="localVideo" autoplay playsinline muted class="video-stream"></video>
      <div class="video-label">내 화면</div>
      <div class="memo-app">
        <div class="memo-title">메모</div>
        <textarea id="memo-input"></textarea>
      </div>
    </div>
    <div class="video-wrapper">
      <video id="remoteVideo" autoplay playsinline class="video-stream"></video>
      <div class="video-label">상대방</div>
    </div>
  </div>
  <div class="controls">
    <button id="startButton" class="control-button start-call">Start Call</button>
    <button id="endButton" class="control-button end-call" style="display: none;">End Call</button>
  </div>
  <div class="connection-status" id="connectionStatus">
    연결중..
  </div>
</div>

<style>
  .memo-title {
    font-size: 12px; /* 작은 글씨 크기 */
    color: gray; /* 글씨 색상 */
  }
  #memo-input {
    width: 100%;
    height: 100%;
    padding: 10px;
    box-sizing: border-box;
    margin-bottom: 10px;
  }
  .memo-app {
    width: 100%;
    height: 155%;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    background-color: #fff;
    border-radius: 5px;
    bottom: 10px;
  }
  .admin-webrtc-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 8px;
  }
  .video-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
    margin-bottom: 20px;
  }
  .video-wrapper {
    position: relative;
    width: 140%;
    height: 95%;
    margin-left: -40%;
    background: #000;
    border-radius: 8px;
    overflow: hidden;
  }
  .video-my {
    position: relative;
    width: 50%;
    height: 35%;
    margin-left: 10%;
    margin-bottom: -30%;
    background: #000;
    border-radius: 8px;
    overflow: visible;
  }
  .video-stream {
    width: 100%;
    height: auto;
    aspect-ratio: 16/9;
  }
  .video-label {
    position: absolute;
    bottom: 10px;
    left: 10px;
    color: white;
    background: rgba(0, 0, 0, 0.5);
    padding: 5px 10px;
    border-radius: 4px;
  }
  .controls {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin: 20px 0;
  }
  .control-button {
    padding: 10px 20px;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    font-size: 16px;
  }
  .start-call {
    background: #4CAF50;
    color: white;
  }
  .end-call {
    background: #f44336;
    color: white;
  }
  .connection-status {
    text-align: center;
    font-size: 14px;
  }
</style>

<script>
  const memoInput = document.getElementById('memo-input');
  const roomId = '1'; // 하드코딩된 방 번호
  let peerConnection = null;
  let localStream = null;
  let websocket = null;

  const configuration = {
    iceServers: [{
      urls: 'stun:stun.l.google.com:19302'

    }]
  };

  async function initialize() {
    try {
      websocket = new WebSocket('${serverurl}/signal');

      websocket.onopen = () => {
        console.log('WebSocket connected');
        updateConnectionStatus('연결되었습니다.');
        sendSignalingMessage({
          type: 'join',
          roomId: roomId
        });
      };

      const stream = await navigator.mediaDevices.getUserMedia({
        video: {
          width: { ideal: 1280 },
          height: { ideal: 720 }
        },
        audio: true
      });

      localStream = stream;
      document.getElementById('localVideo').srcObject = stream;
      document.getElementById('startButton').disabled = false;

      setupWebSocketHandlers();
    } catch (error) {
      console.error('Error initializing WebRTC:', error);
      updateConnectionStatus('Error: ' + error.message);
    }
  }

  function setupWebSocketHandlers() {
    websocket.onmessage = async (event) => {
      try {
        const message = JSON.parse(event.data);
        console.log('Received message:', message.type);

        switch (message.type) {
          case 'offer':
            await handleOffer(message.data);
            break;
          case 'answer':
            await handleAnswer(message.data);
            break;
          case 'ice-candidate':
            await handleIceCandidate(message.data);
            break;
        }
      } catch (error) {
        console.error('Error handling WebSocket message:', error);
      }
    };

    websocket.onclose = () => {
      updateConnectionStatus('WebSocket Disconnected');
    };

    websocket.onerror = (error) => {
      console.error('WebSocket error:', error);
      updateConnectionStatus('WebSocket Error');
    };
  }

  function sendSignalingMessage(message) {
    if (websocket?.readyState === WebSocket.OPEN) {
      websocket.send(JSON.stringify(message));
    }
  }

  async function createPeerConnection() {
    peerConnection = new RTCPeerConnection(configuration);

    localStream.getTracks().forEach(track => {
      peerConnection.addTrack(track, localStream);
    });

    peerConnection.ontrack = (event) => {
      if (document.getElementById('remoteVideo') && event.streams[0]) {
        document.getElementById('remoteVideo').srcObject = event.streams[0];
      }
    };

    peerConnection.onicecandidate = (event) => {
      if (event.candidate) {
        sendSignalingMessage({
          type: 'ice-candidate',
          data: event.candidate,
          roomId: roomId
        });
      }
    };

    peerConnection.onconnectionstatechange = () => {
      updateConnectionStatus('Connection: ' + peerConnection.connectionState);
    };

    return peerConnection;
  }

  async function startCall() {
    try {
      if (!peerConnection) {
        await createPeerConnection();
      }

      const offer = await peerConnection.createOffer();
      await peerConnection.setLocalDescription(offer);

      sendSignalingMessage({
        type: 'offer',
        data: offer,
        roomId: roomId
      });

      document.getElementById('startButton').style.display = 'none';
      document.getElementById('endButton').style.display = 'block';
    } catch (error) {
      console.error('Error starting call:', error);
      updateConnectionStatus('Error starting call');
    }
  }

  async function handleOffer(offer) {
    try {
      if (!peerConnection) {
        await createPeerConnection();
      }

      await peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
      const answer = await peerConnection.createAnswer();
      await peerConnection.setLocalDescription(answer);

      sendSignalingMessage({
        type: 'answer',
        data: answer,
        roomId: roomId
      });
    } catch (error) {
      console.error('Error handling offer:', error);
    }
  }

  async function handleAnswer(answer) {
    try {
      await peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
    } catch (error) {
      console.error('Error handling answer:', error);
    }
  }

  async function handleIceCandidate(candidate) {
    try {
      await peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
    } catch (error) {
      console.error('Error handling ICE candidate:', error);
    }
  }

  function endCall() {
    if (localStream) {
      localStream.getTracks().forEach(track => track.stop());
    }
    if (peerConnection) {
      peerConnection.close();
      peerConnection = null;
    }
    document.getElementById('remoteVideo').srcObject = null;
    document.getElementById('startButton').style.display = 'block';
    document.getElementById('endButton').style.display = 'none';
    updateConnectionStatus('연결 가능');
  }

  function updateConnectionStatus(status) {
    document.getElementById('connectionStatus').textContent = 'Status: ' + status;
  }

  // Event Listeners
  document.getElementById('startButton').addEventListener('click', startCall);
  document.getElementById('endButton').addEventListener('click', endCall);

  // Initialize on page load
  initialize();
</script>
<!-- Back to Top -->
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