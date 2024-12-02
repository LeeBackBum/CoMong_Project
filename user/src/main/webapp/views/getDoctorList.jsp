
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    #item_img{
        width:80px;
    }
    /* 클릭된 항목에 테두리와 배경색 추가 */
    a.selected {
        border: 2px solid black; /* 파란색 테두리 */
        background-color: #f0f8ff; /* 선택된 배경색 */
    }


</style>


<script>

</script>


<ul>
    <c:forEach var="doctor" items="${doctorlist}">
        <li>
            <a href="javascript:void(0);" stfidx="144" onclick="handleDoctorClick('${doctor.doctorId}', this)">
                <div class="image-box">
                    <img src="<c:url value='/imgt/dt.png'/>" alt="이가영" class="image-doctor" width="100px">
                </div>
                <span class="doctor-information" id="staffIdx_2" major="${doctor.subjectName}" doctor="${doctor.doctorName}" doctorid="${doctor.doctorId}">
                <span class="type" style="font-size:14px;">${doctor.subjectName}</span>
                <span class="name" style="font-size:14px;">${doctor.doctorName}</span>
                </span>
            </a>
        </li>
    </c:forEach>
</ul>


<form id="doctorForm" action="your_destination_page" method="Get">
    <input type="hidden" id="doctorIdInput" name="doctorId" value="">
</form>