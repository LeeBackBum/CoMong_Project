<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- pagination start -->
<div class="col text-center ">
    <ul class="pagination justify-content-center">
        <c:choose>
            <c:when test="${a.getPrePage() != 0}">
                <li class="page-item">
                    <a  class="page-link"  href="<c:url value="${target}/appointments?pageNo=${a.getPrePage()}" />">Previous</a>
                </li>
            </c:when>
            <c:otherwise>
                <li class="page-item disabled">
                    <a  class="page-link"  href="#">Previous</a>
                </li>
            </c:otherwise>
        </c:choose>

        <c:forEach begin="${a.getNavigateFirstPage() }" end="${a.getNavigateLastPage() }" var="page">
            <c:choose>
                <c:when test="${a.getPageNum() == page}">
                    <li class="page-item active">
                        <a class="page-link"  href="<c:url value="${target}/appointments?pageNo=${page}" />">${page }</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link"  href="<c:url value="${target}/appointments?pageNo=${page}" />">${page }</a>
                    </li>
                </c:otherwise>
            </c:choose>

        </c:forEach>
        <c:choose>
            <c:when test="${a.getNextPage() != 0}">
                <li class="page-item">
                    <a class="page-link"  href="<c:url value="${target}/appointments?pageNo=${a.getNextPage()}" />">Next</a>
                </li>
            </c:when>
            <c:otherwise>
                <li class="page-item disabled">
                    <a class="page-link"  href="#">Next</a>
                </li>
            </c:otherwise>
        </c:choose>

    </ul>
</div>
<!-- pagination end -->