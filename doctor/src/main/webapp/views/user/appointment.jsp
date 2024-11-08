<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
    let user_get = {
        init: function () {},
        update: function (id) {
            let c = confirm('수정하시겠습니까?');
            if (c == true) {
                location.href = '<c:url value="/user/detail"/>?id=' + id;
            }
        },
        delete: function (id) {
            let c = confirm('삭제하시겠습니까?');
            if (c == true) {
                location.href = '<c:url value="/user/delete"/>?id=' + id;
            }
        }
    };
    $(function () {
        user_get.init();
    });
</script>

<div class="container-fluid">
    <h1 class="h3 mb-2 text-gray-800">Appointments</h1>
    <p class="mb-4">This table displays the reservation and consultation details.</p>

    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Appointments and Consultations</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                    <tr>
                        <th>이름</th>
                        <th>나이</th>
                        <th>성별</th>
                        <th>특이사항</th>
                        <th>전화번호</th>
                        <th>유형</th>
                        <th>날짜</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                    </thead>
                    <tfoot>
                    <tr>
                        <th>이름</th>
                        <th>나이</th>
                        <th>성별</th>
                        <th>특이사항</th>
                        <th>전화번호</th>
                        <th>유형</th>
                        <th>날짜</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                    </tfoot>
                    <tbody>
                    <c:forEach var="a" items="${appointments}">
                        <tr>
                            <td>${a.userName}</td>
                            <td>${a.userAge}</td>
                            <td>${a.userSex}</td>
                            <td>${a.diseaseStatus}</td>
                            <td>${a.userNumber}</td>
                            <td>${a.appointmentType}</td>
                            <td>${a.date}</td>
                            <td>
                                <button onclick="user_get.update('${a.userName}')" type="button" class="btn btn-primary">Update</button>
                            </td>
                            <td>
                                <button onclick="user_get.delete('${a.userName}')" type="button" class="btn btn-danger">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
