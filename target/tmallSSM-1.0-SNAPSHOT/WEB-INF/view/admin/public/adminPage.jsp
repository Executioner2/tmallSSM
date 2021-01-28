<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</head>
<body>
    <script>
        $(function () {
            setDisabled();
            if($("#pageDiv").attr("pages") <= 1){
                $("#pageDiv").css("visibility", "hidden");
            }

        });

        function setDisabled() {
            $("ul.pagination li.disabled a").click(function(){
                return false;
            });
        }
    </script>
    <div id="pageDiv" class="pageDiv" pages="${pageUtil.pageInfo.pages}">
        <ul class="pagination">
            <li <c:if test="${!pageUtil.pageInfo.hasPreviousPage}">class="disabled" </c:if> id="homePage">
                <a href="${pageUtil.uri}pageNum=0">
                    <span aria-hidden="true">«</span>
                </a>
            </li>
            <li <c:if test="${!pageUtil.pageInfo.hasPreviousPage}">class="disabled" </c:if> id="upPage">
                <a href="${pageUtil.uri}pageNum=${(pageUtil.pageInfo.pageNum - 2) * pageUtil.count}">
                    <span aria-hidden="true">‹</span>
                </a>
            </li>
            <c:choose>
                <c:when test="${pageUtil.pageInfo.pages > 7}">
                    <c:forEach begin="0" end="6" varStatus="st">
                        <li <c:if test="${pageUtil.startPage + st.index == pageUtil.pageInfo.pageNum}">class="disabled"</c:if>>
                            <a href="${pageUtil.uri}pageNum=${(pageUtil.startPage + st.index - 1) * pageUtil.count}">${pageUtil.startPage + st.index}</a>
                        </li>
                    </c:forEach>
                </c:when>
                <c:when test="${pageUtil.pageInfo.pages <= 7}">
                    <c:forEach items="${pageUtil.pageInfo.navigatepageNums}" var="page" varStatus="st">
                        <li <c:if test="${pageUtil.pageInfo.pageNum == st.index + 1}">class="disabled"</c:if>>
                            <a href="${pageUtil.uri}pageNum=${(page - 1) * pageUtil.count}">${page}</a>
                        </li>
                    </c:forEach>
                </c:when>
            </c:choose>
            <li id="downPage" <c:if test="${!pageUtil.pageInfo.hasNextPage}">class="disabled" </c:if>>
                <a href="${pageUtil.uri}pageNum=${pageUtil.pageInfo.pageNum * pageUtil.count}">
                    <span aria-hidden="true">›</span>
                </a>
            </li>
            <li id="lastPage" <c:if test="${!pageUtil.pageInfo.hasNextPage}">class="disabled" </c:if>>
                <a href="${pageUtil.uri}pageNum=${(pageUtil.pageInfo.pages - 1) * pageUtil.count}">
                    <span aria-hidden="true">»</span>
                </a>
            </li>
        </ul>
    </div>
</body>
</html>
