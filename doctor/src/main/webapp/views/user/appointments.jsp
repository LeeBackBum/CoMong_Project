<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<script>
    let user_chart = {
        select:function(id){
            let c = confirm('차트를 확인하시겠습니까?');
            if(c == true){
                location.href = '<c:url value="/user/chart"/>?id='+id;
            }
        }
    };
</script>

<div class="container-fluid pt-4 px-4">
    <div class="col-sm12 col-xl-12">
        <div class="bg-light rounded h-100 p-4">
            <h6 class="mb-4">${sessionScope.doctor.doctorName}의 환자 목록</h6>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">이름</th>
                        <th scope="col">나이</th>
                        <th scope="col">성별</th>
                        <th scope="col">연락처</th>
                        <th scope="col">마지막 예약 날짜</th>
                        <th scope="col">차트</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="a" items="${cpage.getList()}">
                        <tr>
                            <td><a href="<c:url value="/user/detail"/>?id=${a.userId}">${a.userName}</a></td>
                            <td>${a.userAge}</td>
                            <td>${a.userSex}</td>
                            <td>${a.userNumber}</td>
                            <td><fmt:formatDate value="${a.date}" pattern="yyyy년 M월 d일 a h시 m분" /></td>
                            <td>
                            <button onclick="user_chart.select('${a.userId}')" type="button" class="btn btn-outline-success m-1">Chart</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <jsp:include page="../nav.jsp"/>
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