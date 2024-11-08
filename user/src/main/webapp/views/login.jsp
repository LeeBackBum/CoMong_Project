<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<style>
    .custom-register-btn:hover {
        border-radius: 50px !important;
        background-color: #ECEBFF; /* 진한 파란색으로 hover 효과 */
        color: #000;
    }
    .custom-forgot-btn:hover {
        border-radius: 50px !important;
        background-color: #ECEBFF; /* 진한 파란색으로 hover 효과 */
        color: #000;
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

<!-- Navbar End -->


<!-- Header Start -->
<div class="container-fluid bg-primary py-5 mb-5 page-header">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-white animated slideInDown">Login</h1>
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
            <h1 class="mb-5">Login</h1>
        </div>
        <div class="row g-4 justify-content-center">
            <div class="col-lg-4 col-md-12 wow fadeInUp" data-wow-delay="0.5s">
                <form id = "login_form">
                    <div class="row g-3">
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="id" name="id" placeholder="Your ID">
                                <label for="id">Your ID</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-floating">
                                <input type="password" class="form-control" id="password" name="pwd" placeholder="Your Password">
                                <label for="password">Your Password</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <button class="btn btn-primary w-100 py-3" type="button">Log In</button>
                        </div>
                        <div class="col-6 d-flex justify-content-center">
                            <button class="btn custom-forgot-btn w-100 py-3" type="button">Forgot Password</button>
                        </div>
                        <div class="col-6 d-flex justify-content-center">
                            <a href="<c:url value="/register"/>" class="btn custom-register-btn w-100 py-3">register</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    let login = {
        init:function(){
            $('#login_form .btn-primary').click(()=>{
                this.check();
            });
        },
        check:function(){
            console.log("클릭");
            let id = $('#id').val();
            let pwd = $('#password').val();
            if(id == '' || id == null){
                alert('Id is Mandatory');
                $('#id').focus();
                return;
            }
            if(pwd == '' || pwd == null){
                alert('Pwd is Mandatory');
                $('#pwd').focus();
                return;
            }
            this.send();
        },
        send:function(){
            $('#login_form').attr('method', 'post');
            $('#login_form').attr('action', '/loginimpl');
            $('#login_form').submit();
        }
    };

    $(function (){
        login.init();
    });
</script>

<c:if test = "${not empty loginError}">
    <script>
        alert("${loginError}");
    </script>
</c:if>
<!-- Contact End -->


<!-- Footer Start -->
<%----%>
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