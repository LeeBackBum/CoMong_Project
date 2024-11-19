<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    #item_img{
        width:80px;
    }
</style>


<div class="col-sm-10">
    <table class="table">
        <thead class="thead-dark">
        <tr>
            <th>IMG</th>
            <th>Name</th>
            <th>SUBJECT</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach var="doctor" items="${doctorlist}">
            <tr>
                <td>
                    <a href="<c:url value="/item/detail"/>?id=${doctor.doctorId}">
                        <img id="item_img" src="<c:url value="/imgs"/>/${doctor.doctorName}">
                    </a>
                </td>
                <td>${doctor.doctorName}</td>
                <td>${doctor.subjectName}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>