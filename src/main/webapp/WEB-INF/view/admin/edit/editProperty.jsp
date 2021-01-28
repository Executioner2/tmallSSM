<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>分类属性编辑</title>
    <base href="<%=basePath%>" />
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/adminStyle.css">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</head>
<body>
    <%--这里放nav--%>
    <%@include file="../public/adminHeader.jsp"%>

    <%--这里放面包屑导航--%>
    <div class="breadcrumb">
        <span><a href="admin/category/list">所有分类</a></span>
        <span class="gaySpan">/</span>
        <span><a href="admin/property/list?id=${property.category.id}">${property.category.name}</a></span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">编辑属性</span>
    </div>

    <%--这里放修改框--%>
    <script>
        $(function () {
            $("#addForm").submit(isEmpty);
        });

        function isEmpty() {
            if(!checkEmpty("propertyName", "属性名称")){
                return false;
            }
            return true;
        }
    </script>
    <div id="propertyEditDiv" class="panel panel-warning propertyEditDiv addDiv">
        <div class="panel-heading">修改属性</div>
        <div class="panel-body">
            <form id="addForm" method="post" action="admin/property/update">
                <table class="addTable">
                    <tr>
                        <td>属性名称</td>
                        <td><input type="text" class="form-control" name="name" id="propertyName" value="${property.name}"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="hidden" name="id" value="${property.id}">
                            <input type="hidden" name="cid" value="${property.category.id}">
                            <button type="submit" class="btn btn-success">提交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</body>
</html>
