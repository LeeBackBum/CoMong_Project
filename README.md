# Spring boot 기반 환자 건강관리 헬스케어 시스템​ ![free-icon-healthcare-3953107](https://github.com/user-attachments/assets/72e45abe-2f46-4775-95f3-fe80d82e18d4)




PM (Project Manager) : 김준희  <br>
PL (Project Leader) : 이백범 <br>
DEV : 윤창현, 이백범 <br>
기간: 2024.11.18~2024.12.20  
<br>
💿[웹 시연영상](?)  
🔗[노션 링크](?)  

<br>

![image](https://github.com/user-attachments/assets/d876281a-ac22-4c59-b3d5-fe6d8819ea88)


<br>

# 1. 프롤로그
  ### 주제❗
    Spring Boot 기반 환자 건강관리 헬스케어 시스템
  ### 개발 배경 및 목적
   최근 응급실에서는 환자 수가 급증하고 있지만, 병상 수와 의료 인력이 부족하여 제때 치료를 받지 못하는 환자들이 늘어나고 있습니다. 이는 의료 체계의 구조적 문제와 함께 응급 의료 자원의 효율적 관리 부족에서 기인합니다. 실제로 전국 응급실의 병상 가동률은 지역별로 큰 편차를 보이며, 일부 지역에서는 심각한 병상 부족으로 인해 응급환자가 치료를 받지 못하는 사례가 발생하고 있습니다
   ### 관련 뉴스 헤드라인
   ![관련뉴스헤드라인](https://github.com/user-attachments/assets/9814b7dd-5ef5-470a-8f09-dc69727c668b)

   ### 관련 사례 영상
https://github.com/user-attachments/assets/dc511bc8-6bf5-44b6-85b2-f34aec66c2c9

  ### 개발 의도

   이 문제를 해결하기 위해서는 기존의 건강 관리와 예방적 조치가 중요하다고 생각합니다. 예방적 건강 관리는 만성질환 예방 및 조기 발견을 통해 응급 상황으로 발전할 가능성을 줄이고, 궁극적으로 응급실 부담을 경감시킬 수 있습니다.
   
또한, 병상 수와 의료 자원의 실시간 모니터링 시스템을 구축하여 병상의 가용성을 한눈에 파악할 수 있는 체계적인 관리가 필요하다고 생각했습니다. 

  이 프로젝트는 이러한 문제를 해결하기 위해 시작되었습니다. 기존 건강 관리의 중요성을 강조하며, 병상 수와 의료 자원의 실시간 정보를 제공하는 시스템을 개발함으로써 응급실 내 혼잡도를 줄이고 환자들이 적시에 적절한 치료를 받을 수 있는 환경을 조성하는 데 목표를 두고 있습니다. 이를 통해 국민 건강 증진과 더불어 의료 체계의 효율성을 높이는 데 기여하고자 합니다.


   <br>

# 2. 프로젝트 개요
### ✨프로젝트 계획도  

![몰입형 개발순서도](https://github.com/user-attachments/assets/fc03d574-241d-44a6-ae57-1ede6a1b1eae)

***

### ✨Work-Flow

![몰입형 업무 플로우](https://github.com/user-attachments/assets/7eeb778a-39d3-468e-a3ae-987d2afb9fc9)

***

### ✨요구사항 정의서

![image](https://github.com/user-attachments/assets/9600bf40-0887-4569-92cb-6817857f1e83)

***

### ✨ERD

![몰입형 ERD](https://github.com/user-attachments/assets/d8d79155-fa5d-4f5b-8458-61cea1a1e574)

***

### ✨WBS

![image](https://github.com/user-attachments/assets/4c30f665-859e-4ff3-b463-a47870742ad8)

***

### ✨화면설계

![image](https://github.com/user-attachments/assets/c114e805-00e9-4c60-bada-969978c023a0)
![image](https://github.com/user-attachments/assets/000d7cf0-f816-4990-a374-0dad1a06ea23)

***

### ✨개발환경 및 개발도구

![image](https://github.com/user-attachments/assets/42c5961d-b4a9-47c4-99ea-f0ac0767220e)

협업도구: Github, ERD Cloud, Notion, Canva <br>
개발도구: IntelliJ <br>
언어: Java, JavaScript,HTML5,CSS,SQL <br>
DB: MySQL <br>
프레임워크: Spring Boot, My Batis, Bootstrap, three.js <br>
기술: Ajax, WebSocket, Spring MVC, WebRTC <br>
API: 네이버 클로바 챗봇, 카카오페이 결제, 공공데이터, 파파고 <br>

***

### ✨시스템 구성도

![몰입형시스템구성도](https://github.com/user-attachments/assets/495d26bb-616e-4b1c-a92f-303a3ac06bfb)

***

### ✨SW 구성도

![몰입형sw구성도](https://github.com/user-attachments/assets/f538392f-8ab7-4f01-a847-b8bed02acb05)

***

# 3. 프로젝트 핵심 기능 ✅
## 사용자 페이지 😃
  
### 1) 챗봇(Chatbot)
- NAVER CLOVA Chatbot API를 활용하여 1:1 문의 등을 처리  
- 딥러닝 학습을 하여 가르친 대화를 상세하게 답변
- 링크 답변을 통해 고객에게 직관적인 사이트 이용 경험을 전달  

사진
영상
***
<br><br>

### 2) 결제(kakao)
- 카카오 페이 API를 이용하여 결제 시스템 구현
  사진
  영상

***
<br><br>

### 3) 병상정보(공공데이터)
- 공공데이터 API를 통해 남은 병상 수 확인 가능
- 검색 기능을 이용하여 원하는 병원의 정보를 확인 가능
  사진
  영상
***
<br><br>

### 4) 채팅(WebSocket)
- HTTP 기반의 단방향 통신과 달리 지속적인 양방향 연결을 유지하여 실시간 메시지 전송이 가능
- 사용자 간의 채팅 데이터를 빠르게 전달하며, 서버와 클라이언트 간의 실시간 상호작용을 지원
  사진
  영상
***
<br><br>

### 5) 화상상담(WebRTC)
- 브라우저 간의 실시간 오디오 및 비디오 스트리밍을 가능하게 하며, 별도의 플러그인 없이 동작
- 환자와 의사 간의 원격 상담을 지원하여 물리적 거리의 제약을 극복
  사진
  영상
***
<br><br>
