<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .admin-webrtc-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    .video-grid {
        display: grid;
        grid-template-columns: 1fr; /* 한 열만 생성 */
        grid-template-rows: repeat(2, 1fr); /* 두 행 생성 */
        gap: 20px; /* 요소 간 간격 유지 */
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

    .record-container {
        display: inline-block;
        width: 100%; /* 적절한 너비 설정 */
        vertical-align: top; /* 상단 정렬 */
        max-width: 700px;
        margin-left: auto;
        margin-right: auto;
        margin-top: auto;
        height: 650px;
        max-height: 900px;
        position: relative;
    }

    .record-title {
        text-align: center;
    }

    form {
        display: flex;
        flex-direction: column; /* 세로 방향으로 배치 */
        gap: 20px; /* 각 요소 간의 간격을 20px로 설정 */
    }

    input, textarea, button {
        margin: 10px 0; /* 각 요소 위아래로 10px의 여백 추가 */
        padding: 12px; /* 내부 여백을 추가해 요소 크기 확대 */
        font-size: 16px; /* 텍스트 크기를 적절히 조정 */
    }

    button {
        border: none;
        border-radius: 5px; /* 모서리를 둥글게 처리 */
        cursor: pointer;
    }

    button:hover {
        background-color: #0056b3; /* 호버 시 버튼 색상 변경 */
    }
</style>
<div class="container-fluid position-relative bg-white d-flex p-0">
    <div class="container-fluid pt-4 px-4">
        <div class="row g-4">
            <div class="col-sm-12 col-xl-6">
                <div class="bg-light rounded h-100 p-4">
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
                </div>
            </div>
            <div class="col-sm-12 col-xl-6">
                <div class="bg-light rounded h-100 p-4">
                    <div class="record-container">
                        <h2 class="mb-4 record-title">Record</h2>
                        <form id="recordForm" name="recordForm" class="form-group" method="post" action="/recordimpl">
                            <!-- 날짜와 시간 입력 -->
                            <div class="form-group">
                                <label for="datetime">날짜 및 시간</label>
                                <input
                                        type="datetime-local"
                                        class="form-control"
                                        id="datetime"
                                        name="counselDate"
                                        required="required"
                                />
                            </div>

                            <!-- 내용 입력 -->
                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea
                                        class="form-control"
                                        rows="11"
                                        id="content"
                                        name="counselContent"
                                        placeholder="내용 작성"
                                ></textarea>
                            </div>

                            <!-- 의사 ID와 환자 이름 입력 -->
                            <div class="form-group">
                                <label for="doctorId">의사 ID</label>
                                <input
                                        type="text"
                                        class="form-control"
                                        id="doctorId"
                                        name="doctorId"
                                        placeholder="의사 ID 입력"
                                        required="required"
                                />
                            </div>
                            <div class="form-group">
                                <label for="userId">환자 ID</label>
                                <input
                                        type="text"
                                        class="form-control"
                                        id="userId"
                                        name="userId"
                                        placeholder="환자 ID 입력"
                                        required="required"
                                />
                            </div>

                            <input type="hidden" name="counselType" value="채팅상담" />

                            <button type="submit" class="btn btn-primary">등록</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- Footer Start -->
<div class="container-fluid pt-4 px-4">
    <div class="bg-light rounded-top p-4">
        <div class="row">
            <div class="col-12 col-sm-6 text-center text-sm-start">
                &copy; <a href="#">Your Site Name</a>, All Right Reserved.
            </div>
            <div class="col-12 col-sm-6 text-center text-sm-end">
                <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                Designed By <a href="https://htmlcodex.com">HTML Codex</a>
            </div>
        </div>
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