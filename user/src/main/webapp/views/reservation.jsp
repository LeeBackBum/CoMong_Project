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
    <%--틀 끝--%>
</head>

<body>
<!-- Spinner Start -->
<%--<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">--%>
<%--    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">--%>
<%--        <span class="sr-only">Loading...</span>--%>
<%--    </div>--%>
<%--</div>--%>
<!-- Spinner End -->


<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
    <a href="<c:url value="/"/> " class="navbar-brand d-flex align-items-center px-4 px-lg-5">
        <h2 class="m-0 text-primary">
            <img class="img-logo" src="img/logo2.jpg" alt="" style="width: 140px; height: auto;">
        </h2>
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">
            <a href="<c:url value="/"/>" class="nav-item nav-link active">Home</a>
            <a href="<c:url value="/about"/>" class="nav-item nav-link">About</a>
            <a href="<c:url value="/courses"/>" class="nav-item nav-link">Courses</a>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                <div class="dropdown-menu fade-down m-0">
                    <a href="<c:url value="/team"/>" class="dropdown-item">Our Team</a>
                    <a href="<c:url value="/testimonial"/>" class="dropdown-item">Testimonial</a>
                    <a href="<c:url value="/errorpage"/>" class="dropdown-item">404 Page</a>
                </div>
            </div>
            <a href="<c:url value="/contact"/>" class="nav-item nav-link">Contact</a>
        </div>
        <a href="<c:url value="/login"/>" class="btn btn-primary py-4 px-lg-5 d-none d-lg-block">Join Now<i class="fa fa-arrow-right ms-3"></i></a>
    </div>
</nav>

<html>
<head>
    <title>Title</title>
    <style>
    </style>
    <script>
    </script>
</head>
<body>
<h1>Main Page</h1>
<!-- Service Start -->
<div class="row">
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-3 col-sm-10 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="service-item text-center pt-3">
                        <div class="p-4">
                            <i class="fa fa-3x fa-graduation-cap text-primary mb-4"></i>
                            <h5 class="mb-3">Skilled Instructors</h5>
                            <form>
                                <div class="center-Ro">
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio">Custom radio 1</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio2" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio2">Custom radio 2</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio9" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio2">Custom radio 2</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio8" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio2">Custom radio 2</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio7" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio2">Custom radio 2</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio6" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio2">Custom radio 2</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio5" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio2">Custom radio 2</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio4" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio2">Custom radio 2</label>
                                    </div>
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="customRadio3" name="example" value="customEx">
                                        <label class="custom-control-label" for="customRadio2">Custom radio 2</label>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-10 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="service-item text-center pt-3">
                        <div class="p-4">
                            <i class="fa fa-3x fa-globe text-primary mb-4"></i>
                            <h5 class="mb-3">Doctor1</h5>
                            <img src="<c:url value='/imgs/dt.png'/>" >
                            <p>Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam</p>
                        </div>
                    </div>
                    <div class="service-item text-center pt-3">
                        <div class="p-4">
                            <i class="fa fa-3x fa-globe text-primary mb-4"></i>
                            <h5 class="mb-3">Doctor2</h5>
                            <img src="<c:url value='/imgs/dt.png'/>" >
                            <p>Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam</p>
                        </div>
                    </div>
                    <div class="service-item text-center pt-3">
                        <div class="p-4">
                            <i class="fa fa-3x fa-globe text-primary mb-4"></i>
                            <h5 class="mb-3">Doctor3</h5>
                            <img src="<c:url value='/imgs/dt.png'/>" >
                            <p>Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-10 wow fadeInUp" data-wow-delay="0.5s">
                    <div class="service-item text-center pt-3">
                        <div class="p-4">
                            <i class="fa fa-3x fa-home text-primary mb-4"></i>
                            <h5 class="mb-3">Home Projects</h5>
                            <p>Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam</p>
                        </div>
                    </div>
                </div>
                <%--            <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.7s">--%>
                <%--                <div class="service-item text-center pt-3">--%>
                <%--                    <div class="p-4">--%>
                <%--                        <i class="fa fa-3x fa-book-open text-primary mb-4"></i>--%>
                <%--                        <h5 class="mb-3">Book Library</h5>--%>
                <%--                        <p>Diam elitr kasd sed at elitr sed ipsum justo dolor sed clita amet diam</p>--%>
                <%--                    </div>--%>
                <%--                </div>--%>
                <%--            </div>--%>
            </div>
        </div>
    </div>
</div>
<!-- Service End -->



</body>
</html>