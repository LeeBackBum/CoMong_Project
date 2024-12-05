<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  .admin-webrtc-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
  }
  .video-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
    margin-bottom: 20px;
  }
  .video-wrapper {
    position: relative;
    width: 100%;
    background: #000;
    border-radius: 8px;
    overflow: hidden;
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

<div class="admin-webrtc-container">
  <div class="video-grid">
    <div class="video-wrapper">
      <video id="localVideo" autoplay playsinline muted class="video-stream"></video>
      <div class="video-label">Admin Stream</div>
    </div>
    <div class="video-wrapper">
      <video id="remoteVideo" autoplay playsinline class="video-stream"></video>
      <div class="video-label">User Stream</div>
    </div>
  </div>
  <div class="controls">
    <button id="startButton" class="control-button start-call">Start Call</button>
    <button id="endButton" class="control-button end-call" style="display: none;">End Call</button>
  </div>
  <div class="connection-status" id="connectionStatus">
    Status: Disconnected
  </div>
</div>

<script>
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
        updateConnectionStatus('WebSocket Connected');
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
    updateConnectionStatus('Call Ended');
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