<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<style>
    .form-floating {
        width: auto; /* form-floating이 버튼 옆에 배치되도록 */
    }

    .btn-secondary {
        height: 100%; /* 버튼 높이를 입력 필드와 맞추기 */
    }

    .custom-button {
        width: 100px; /* 원하는 너비 */
        /*height: 40px; !* 원하는 높이 *!*/
    }

    .slide-left {
        transform: translateX(-100%);
        transition: transform 0.5s ease;
    }
</style>

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
    <%--틀 끝--%>
</head>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<body>
<!-- Spinner Start -->


<!-- Navbar End -->


<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-white animated slideInDown">Register</h1>
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
<!-- Header End -->


<!-- Login Start -->
<div class="container-xxl py-5">
    <div class="container">
        <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
            <h6 class="section-title bg-white text-center text-primary px-3">Are you a member?</h6>
            <h1 class="mb-5">Register</h1>
        </div>
        <div class="row g-4 justify-content-center">
            <div class="col-lg-8 col-md-12 wow fadeInUp" data-wow-delay="0.5s">
                <!-- form-container-wrapper에 중앙 정렬 추가 -->
                <div class="form-container-wrapper">
                    <div id="form-container" class="form-container">
                        <form id="register_form" method="post" action="/registerimpl">
                            <!-- 기존 login_form 섹션 -->
                            <div id="login_section" class="row g-3">
                                <div class="col-12">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="id" name="userId" placeholder="Enter ID">
                                        <label for="id">ID</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-floating">
                                        <input type="password" class="form-control" id="password" name="userPwd" placeholder="Enter Password">
                                        <label for="password">Enter Password</label>
                                    </div>
                                </div>
                                <div class="col-12 d-flex align-items-center">
                                    <div class="form-floating me-2 flex-grow-1">
                                        <input type="email" class="form-control" id="email" name="userEmail" placeholder="Enter Email">
                                        <label for="email">Enter Email</label>
                                    </div>
                                    <button type="button" class="btn btn-secondary btn-sm custom-button" onclick="sendEmailVerification()">Send Code</button>
                                </div>
                                <div class="col-12 d-flex align-items-center" id="verification-container" style="visibility: hidden; opacity: 0;">
                                    <div class="form-floating me-2 flex-grow-1">
                                        <input type="text" class="form-control" id="verification-code" placeholder="Enter Code">
                                        <label for="verification-code">Enter Code</label>
                                    </div>
                                    <button type="button" class="btn btn-secondary btn-sm custom-button" onclick="checkCode()">Certified</button>
                                </div>
                                <div class="col-12">
                                    <button id="next-button" class="btn btn-primary w-100 py-3" type="button" disabled onclick="showNextForm()">Next</button>
                                </div>
                            </div>

                            <!-- 새로운 new-form 섹션 -->
                            <div id="new-form" style="display: none;">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="name" name="userName" placeholder="Enter Name">
                                    <label for="name">Enter Name</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="address" name="userAddress" placeholder="Enter Address">
                                    <label for="address">Enter Address</label>
                                </div>
                                <div class="form-floating mb-3 d-flex align-items-center">
                                    <input type="number" class="form-control me-2" id="age" name="userAge" placeholder="Enter Age">
                                    <label for="age">Enter Age</label>
                                    <div class="ms-3">
                                        <label>Gender:</label>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="userSex" id="male" value="M">
                                            <label class="form-check-label" for="male">Male</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="userSex" id="female" value="F">
                                            <label class="form-check-label" for="female">Female</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" id="special-notes" name="diseaseStatus" placeholder="Enter Special Notes">
                                    <label for="special-notes">Enter Special Notes</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="tel" class="form-control" id="phone" name="userNumber" placeholder="Enter Phone Number">
                                    <label for="phone">Enter Phone Number</label>
                                </div>
                                <button id="register-button" class="btn btn-primary w-100 py-3" type="submit">Register</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    /* form-container-wrapper에 중앙 정렬 추가 */
    .form-container-wrapper {
        display: flex;
        justify-content: center; /* 수평 중앙 정렬 */
        align-items: center; /* 수직 중앙 정렬 */
        overflow: hidden;
        width: 100%;
    }

    .form-container {
        display: flex;
        transition: transform 0.5s ease;
        width: 100%; /* 화면에 한 번에 하나의 폼만 보이도록 */
        max-width: 400px; /* 최대 너비를 제한하여 폼 크기 조정 */
        margin: auto; /* 중앙 정렬 */
    }

    .form-slide-left {
        transform: translateX(-100%); /* 기존 폼이 완전히 왼쪽으로 이동하여 새로운 폼이 중앙에 나타남 */
    }

    #login_form, #new-form {
        width: 100%; /* 각각의 폼이 전체 컨테이너를 차지하도록 */
        flex-shrink: 0; /* 폼이 줄어들지 않도록 고정 */
    }

    .form-floating.d-flex {
        align-items: center; /* 중앙 정렬 */
    }
    .form-floating.d-flex input[type="number"] {
        max-width: 100px; /* 입력 필드 너비 조정 */
    }
    .form-floating label {
        margin-right: 10px;
    }
</style>


<script>
    function sendEmailVerification() {
        const email = document.getElementById("email").value;

        if (!email) {
            alert("Please enter an email.");
            return;
        }

        fetch('/mailSend', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ mail: email })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("Verification code sent to your email.");
                    document.getElementById("verification-container").style.visibility = "visible";
                    document.getElementById("verification-container").style.opacity = "1";
                } else {
                    alert("Failed to send verification code.");
                }
            })
            .catch(error => console.error('Error:', error));
    }

    function checkCode() {
        const enteredCode = document.getElementById("verification-code").value;

        if (!enteredCode) {
            alert("Please enter the verification code.");
            return;
        }

        fetch('/mailCheck', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userNumber: enteredCode })
        })
            .then(response => response.json())
            .then(isMatch => {
                if (isMatch) {
                    alert("Verification successful.");
                    document.getElementById("next-button").disabled = false;
                } else {
                    alert("Incorrect verification code.");
                }
            })
            .catch(error => console.error('Error:', error));
    }

    function showNextForm() {
        const loginSection = document.getElementById("login_section");
        const newForm = document.getElementById("new-form");

        // login_section 숨기기
        loginSection.style.display = "none";

        // new-form 표시
        newForm.style.display = "block";
    }

    function submitRegistrationForm() {
        const formData = {
            userId: document.getElementById("id").value,
            userPwd: document.getElementById("password").value,
            userEmail: document.getElementById("email").value,
            userName: document.getElementById("name").value,
            userAddress: document.getElementById("address").value,
            userAge: document.getElementById("age").value,
            userSex: document.querySelector('input[name="userSex"]:checked')?.value,
            diseaseStatus: document.getElementById("special-notes").value,
            userNumber: document.getElementById("phone").value,
        };

        // 서버에 폼 데이터를 POST 요청으로 전송
        fetch('/register', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(formData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert("Registration complete."); // 회원가입 성공 알림
                    window.location.href = "/"; // 메인 페이지로 이동
                } else {
                    alert("Registration failed. Please try again."); // 실패 알림
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert("An error occurred during registration. Please try again."); // 에러 알림
            });
    }

</script>



<!-- Contact End -->


<!-- Footer Start -->

<!-- Footer End -->


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