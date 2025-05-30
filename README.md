# Spring boot 기반 환자 건강관리 헬스케어 시스템​ ![free-icon-healthcare-3953107](https://github.com/user-attachments/assets/72e45abe-2f46-4775-95f3-fe80d82e18d4)




PM (Project Manager) : 김준희  <br>
PL (Project Leader) : 이백범 <br>
DEV : 윤창현, 이백범 ,이승현,김준희<br>
기간: 2024.10.25~2024.12.20  
<br>
💿[웹 시연영상](https://www.youtube.com/watch?v=AnEqwYsaeNg)  
🔗[노션 링크](https://www.notion.so/Team-CoMong-Project-135010e9dc7c806fbe9dcef17c3a4d46?pvs=4)  

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


![결제영상](https://github.com/user-attachments/assets/57e056cc-dd14-4169-bf7d-2f5439417f6b)


***
<br><br>

### 2) 결제(kakao)
- 카카오 페이 API를 이용하여 결제 시스템 구현


![결제영상](https://github.com/user-attachments/assets/7b2e5d27-e6f1-489d-b64c-477005392015)


***
<br><br>

### 3) 병상정보(공공데이터)
- 공공데이터 API를 통해 남은 병상 수 확인 가능
- 검색 기능을 이용하여 원하는 병원의 정보를 확인 가능


![공공데이터](https://github.com/user-attachments/assets/a26c2719-26b5-4fad-8873-b27d1d65bbdb)


***
<br><br>

### 4) 지도(kakao)
- 카카오 맵 API를 활용
- 사용자의 위치 정보를 이용해 근처 병원들을 표시
- 병원 길 안내등 추가적인 지도 기능도 제공


![카카오맵](https://github.com/user-attachments/assets/5f79d23f-866d-466e-8c55-acd3c0e89627)


***
<br><br>

## 의사 페이지 🧐
### 1) 실시간 건강 데이터 차트
- 당일 특정 시간대 실시간 데이터와 누적 데이터 표시
- Jquery를 활용한 AJAX 통신과, JS의 SET INTERVAL 함수를 활용하여 실시간 통계 구현
- JAVA의 Date 객체를 활용하여 서버 기준 현재 시간으로 설정, 데이터는 JSON 형태로 전달받아 처리 
- 주시해야할 데이터에 대해 실시간 데이터로 받는다고 설정하면 5초마다 데이터를 전달하여 차트로 표시


![image](https://github.com/user-attachments/assets/57147722-99d8-4cdc-841c-86fad583d5d3)

![image](https://github.com/user-attachments/assets/a1285fff-e31c-4fab-a76b-134f05dc473a)

![image](https://github.com/user-attachments/assets/09eb52ec-304a-4cd0-ac94-e6f185445abd)

![실시간차트](https://github.com/user-attachments/assets/d7a07e4f-8cdd-4b02-a45f-90b352c36b04)


***
<br><br>

### 2) 날짜 별 예약 확인
- 캘린더 기능 표시
- 날짜를 클릭하면 해당 날짜들에 예약된 환자들의 정보들과 예약한 시간이 나열됨
- 시간순으로 나열
- Jquery를 활용한 AJAX 통신
- 환자 수에 따라 위에 있는 배너가 실시간으로 수치가 변함

사진
영상
***
<br><br>

## 통신 기능

### 1) 채팅(WebSocket)
- HTTP 기반의 단방향 통신과 달리 지속적인 양방향 연결을 유지하여 실시간 메시지 전송이 가능
- 사용자 간의 채팅 데이터를 빠르게 전달하며, 서버와 클라이언트 간의 실시간 상호작용을 지원
  사진
  영상
***
<br><br>

### 2) 화상상담(WebRTC)
- 브라우저 간의 실시간 오디오 및 비디오 스트리밍을 가능하게 하며, 별도의 플러그인 없이 동작
- 환자와 의사 간의 원격 상담을 지원하여 물리적 거리의 제약을 극복
  사진
  영상
***
<br><br>

# 4. 프로젝트 일반 기능 ✅
## 사용자 페이지 😃
### 1) 메인화면 구성
- 동적인 움직임을 적용함
- 상단 메뉴바와 하단 푸터를 통한 접근성 향상

![메인화면2](https://github.com/user-attachments/assets/7ddf6681-23f6-481f-a3bc-882c95f05082)

***
<br><br>

### 2) 게시판
- 사용자가 이용할 수 있는 게시판
- Ajax를 활용해 댓글작성,삭제,수정 기능 구현

- 게시판 목록
![image](https://github.com/user-attachments/assets/e81b4de4-7add-45d3-8b41-b6762fda5b81)

- 공지사항
![image](https://github.com/user-attachments/assets/e0421d85-2335-40bf-bd3b-6fb0e085d3ad)

- 게시판 검색

![게시판 검색](https://github.com/user-attachments/assets/31b708e8-fdd7-442b-9bd9-2fe44ce1b381)

- 게시판 글쓰기
  
![게시판 글쓰기](https://github.com/user-attachments/assets/b8c9c18c-0441-40eb-a85f-36d1cd99335f)

- 댓글 작성

![댓글작성](https://github.com/user-attachments/assets/e8ca648a-c4e3-4353-8470-b171d787f5ac)

***
<br><br>

## 의사 페이지 🧐
### 1) 로그인
- 할당된 아이디 비밀번호로 로그인
  
![image](https://github.com/user-attachments/assets/c8baaf40-b6dd-4bcd-8e77-5b727b145447)

***
<br><br>

### 2) 메인화면

![image](https://github.com/user-attachments/assets/95dffa1c-9cf2-4dd6-b31a-2cec8645d94b)

***

<br><br>

### 3) 의사 마이페이지
- 우상단 프로필을 클릭하여 마이페이지로 이동가능

  
![image](https://github.com/user-attachments/assets/837353a6-1dde-4e80-82cc-c8d4abfa69af)

- 아이디 비밀번호를 제외한 의사 본인의 정보를 업데이트 가능


![마이페이지](https://github.com/user-attachments/assets/9283e746-3057-4890-b8ee-dd711de126bd)






# 5. Troubleshooting ⁉️

|&nbsp;&nbsp;Name&nbsp;&nbsp;|Issues|Problem solving|
|:--:|--|--|
|김준희|⦁ 문제상황1: 페이징 처리 중 데이터를 List로 전달했지만, 수신 측에서 이를 List로 받지 않아　데이터가　정상적으로　처리되지　않았다.<br><br>⦁ 문제상황2: JSON 데이터를 JavaScript로 받아 HTML에 렌더링하려 했으나, 데이터가 제대로 표시되지 않았다.|⦁ 해결방법1: 페이징 처리를 구현할 때, 서버에서 데이터를 List 형태로 반환했으나 클라이언트나 다른 계층에서 이를 올바르게 매핑하지 못한 경우 발생한 것으로 확인했고 타입 맵핑을 확인하여 데이터 타입을 일치시켜주었다.<br><br>⦁ 해결방법2: 기존에 탬플릿 리터럴 방식(let row = ` string ${data}`; )을 사용했는데 이를 문자열 연결방식(let row = ' string'+ (data);)으로 바꾸었더니 해결. 자세한 원인을 찾고 싶어서 여기저기 검색을 해보았지만 탬플릿 리터럴 방식이 문자열 연결방식보다 간편하고 좋아 권장하는 정보들만 얻을 수 있었다. 문자열 연결방식을 아예 몰랐는데 팀원 중 한 명이 본인도 이런 문제를 겪었고 문자열 연결방식으로 해결하였다고 하여 도움을 받음. 이로 인해 팀 협업의 중요성을 느끼게 되었다.| 
|윤창현|⦁ 문제상황1: JSON 데이터를 JavaScript로 받아 HTML에 렌더링하려 했으나, 데이터가 제대로 표시되지 않았음.<br><br>⦁ 문제상황2: Three.js 사용시 로컬환경과 외부 라이브러리를 가져오는 방식을 이용해 3D 모델을 구현하려 했으나 모델링 제대로 구현되지 않았음.|⦁ 해결방법1: 기존에 탬플릿 리터럴 방식(let row = ` result ${data}`; )을 사용했는데 이를 문자열 연결방식(let row = 'result'+ (data);)으로 바꾸었더니 해결. 자세한 원인을 찾고 싶어서 여기저기 검색을 해보았지만 탬플릿 리터럴 방식이 문자열 연결방식보다 간편하고 좋아 권장하는 정보들만 얻을 수 있었다. 그 후 팀원 중 한 명도 동일한 문제를 발생했고, 해결한 방식을 적용시켜 문제를 해결.이를 통해 팀원과의 소통이 프로젝트에 가장 중요함을 알게 되었다.<br><br>⦁해결방법2: 먼저 three.js 가이드라인에서 로컬환경에서 필요한 라이브러리를 추출해서 경로를 설정하는 방식을 학습하여 개발중인 코드에서 설정하였지만 문제가 해결이 되지 않았고 다음으로 script형식으로 외부 라이브러리를 가져오는 방식을 해결방법으로 사용하였지만 여전히 문제가 해결되지 않아 Import Map을 이용한 모듈 경로 매핑을 이용하여 모듈 로드 시 사용할 경로를 미리 매핑하여 라이브러리들을 가져오니 문제를 해결했다.이 과정에서 라이브러리를 가져오는 방식이 다양하며 개발환경의 버전과 여러 복합적인 환경을 고려해야 함을 중요성을 느꼈다.| 
|이백범|⦁ 문제상황1: WebSocket 연결 후 메시지가 전달되지 않음<br><br>⦁ 문제상황2: user와 doctor 둘 다 같은 session에 로그인 정보를 저장하여 한 쪽이 로그인 되면 다른 한 쪽의 로그인 정보가 초기화됨|⦁ 해결방법1: WebSocket 메시지가 클라이언트로 전달되지 않는 문제는 서버에서 설정한 @SendTo 경로와 클라이언트가 구독하는 경로가 서로 일치하지 않아서 발생. 이를 해결하기 위해 @SendTo에 설정된 경로를 클라이언트에서 구독하는 경로와 동일하게 수정하였으며, 예를 들어 서버 측에@MessageMapping("/chat")과 함께 @SendTo("/topic/messages")를 설정하여 메시지가 올바르게 전달되도록 수정했음.<br><br>⦁해결방법2: 로그인 정보가 다른 데스크톱에서 접속할 때 초기화되는 문제를 해결하기 위해, user와 doctor 각각에 대해 별도의 세션을 생성하여 각자의 로그인 정보를 개별적으로 저장하도록 설정. 이를 통해 두 사용자 유형의 세션이 독립적으로 관리되며, 다른 데스크톱에서 접속하더라도 기존 로그인 정보가 초기화되지 않고 유지되도록 문제를 해결했음.| 
|이승현|⦁문제상황1: 댓글 작성 시 작성자 정보가 잘못 표시되거나 undefined로 출력되는 문제가 발생.대댓글 작성 시 특정 부모 댓글을 찾지 못하는 문제가 발생.<br><br>⦁ 문제상황2: 댓글 작성 후 목록이 바로 갱신되지 않음.댓글 수정 및 삭제 후에도 이전 데이터가 화면에 남아있는 문제가 발생.<br><br>⦁문제상황3: 특정 페이지를 클릭하면 잘못된 게시글 목록이 출력됨.검색 결과 페이지에서 페이지 번호를 클릭해도 검색 결과가 유지되지 않는 문제가 발생.<br><br>⦁문제상황4:닥터 마이페이지에서 프로필 이미지를 로드 하거나 업로드할 때 오류가 발생하여 화면에 이미지가 표시되지 않음.|⦁해결방법1: HTTP Session에서 login id 또는 사용자 객체를 정확히 가져와 JSP에서 처리되도록 수정. 부모 댓글 ID를 전달하기 위해 data-id 속성을 추가하고, JavaScript에서 해당 ID를 정확히 참조하도록 로직을 수정.<br><br>⦁해결방법2: Ajax 요청 완료 후 DOM을 완전히 초기화하고 서버에서 최신 데이터를 받아와 새로 추가하는 로직을 작성하여 목록이 즉시 갱신되도록 수정<br><br>⦁해결방법3: URL에 검색 키워드를 포함하여 페이지 이동 시 검색 결과와 페이징 정보를 함께 처리하도록 수정.JSP에서 현재 페이지와 검색 키워드를 정확히 전달하도록 로직을 개선.<br><br>⦁해결방법4:이미지 파일 경로를 확인하고 JSP에서 올바르게 설정되도록 수정.이미지 업로드를 처리하는 컨트롤러 코드에서 파일 저장 경로를 재설정하여 업로드 된 파일이 지정된 경로에 저장되도록 수정.| 
