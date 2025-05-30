
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <title>DASHMIN - Bootstrap Admin Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="<c:url value="/img/favicon.ico"/>" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="<c:url value="/lib/owlcarousel/assets/owl.carousel.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"/>" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="<c:url value="/css/style.css"/>" rel="stylesheet">


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script><!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <%-- websocket lib   --%>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
</head>

<body>
<div class="container-fluid position-relative bg-white d-flex p-0">
    <!-- Sidebar Start -->
    <div class="sidebar pe-4 pb-3">
        <nav class="navbar bg-light navbar-light">
            <a href="<c:url value="/"/>" class="navbar-brand mx-4 mb-3">
                <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>Sign In</h3>
            </a>
            <div class="d-flex align-items-center ms-4 mb-4">
                <div class="position-relative">
                    <img class="rounded-circle" src="<c:out value='/img/${sessionScope.doctor.doctorImg}' default='/img/default-doctor.png' />" alt="" style="width: 40px; height: 40px;">
                    <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                </div>
                <div class="ms-3">
                    <h6 class="mb-0">${sessionScope.doctor.doctorName}</h6>
                    <span>Doctor</span>
                </div>
            </div>
            <div class="navbar-nav w-100">
                <a href="<c:url value="/main"/>" class="nav-item nav-link">
                    <i class="fa fa-tachometer-alt me-2"></i>Main</a>
                <a href="<c:url value="/counseling"/>" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>Chat</a>
                <a href="<c:url value="/webrtc"/>" class="nav-item nav-link"><i class="fa fa-table me-2"></i>Cam</a>
                <a href="<c:url value="/user/appointments"/>" class="nav-item nav-link"><i class="fa fa-th me-2"></i>List</a>
                <a href="<c:url value="/blank"/>" class="nav-item nav-link"><i class="far fa-file-alt me-2"></i>Error</a>
            </div>
        </nav>
    </div>
    <!-- Sidebar End -->



    <!-- Content Start -->
    <div class="content">
        <!-- Navbar Start -->
        <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
            <a href="<c:url value="/"/>" class="navbar-brand d-flex d-lg-none me-4">
                <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
            </a>
            <a href="#" class="sidebar-toggler flex-shrink-0">
                <i class="fa fa-bars"></i>
            </a>
            <form class="d-none d-md-flex ms-4">
                <input class="form-control border-0" type="search" placeholder="Search">
            </form>
            <div class="navbar-nav align-items-center ms-auto">
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                        <img class="rounded-circle me-lg-2" src="<c:out value='/img/${sessionScope.doctor.doctorImg}'/>" alt="" style="width: 40px; height: 40px;">
                        <span class="d-none d-lg-inline-flex">${sessionScope.doctor.doctorName}</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                        <a href="<c:url value="/mypage"/> " class="dropdown-item">My Page</a>
                        <a href="#" class="dropdown-item">Log Out</a>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <div>
            <c:choose>
                <c:when test="${center == null}">
                    <jsp:include page="center.jsp"/>
                </c:when>
                <c:otherwise>
                    <jsp:include page="${center}.jsp"/>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <!-- Content End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
</div>




<!-- Template Javascript -->
</body>

</html>
