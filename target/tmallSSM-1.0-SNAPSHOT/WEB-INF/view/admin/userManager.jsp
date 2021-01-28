<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>用户管理</title>
    <base href="<%=basePath%>" />
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/adminStyle.css">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</head>
<body>
    <!--这里是nav-->
    <%@include file="public/adminHeader.jsp"%>

    <div class="userManager" id="userManager">
        <%--这里是title--%>
        <div class="title">用户管理</div>
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <tr class="tableHead">
                <th>ID</th>
                <th>用户名称</th>
            </tr>
            <c:forEach items="${users}" var="user" varStatus="st">
                <tr class="categoryItem">
                    <td class="userId"><c:out value="${user.id}"></c:out></td>
                    <td class="userName"><c:out value="${user.name}"></c:out></td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!--这里是page管理-->
    <%@include file="public/adminPage.jsp"%>
</body>
</html>
