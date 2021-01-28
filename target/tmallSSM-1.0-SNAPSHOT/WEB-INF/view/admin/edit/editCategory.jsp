<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>分类编辑</title>
    <base href="<%=basePath%>"/>
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

    <script>
        $(function () {
            $("#editForm").submit(isEmpty);
        });

        function isEmpty() {
            if(!checkEmpty("categoryName", "分类名称")){
                return false;
            }
            if(!checkEmpty("image", "分类图片")){
                return false;
            }
            return true;
        }
    </script>
    <div id="editCategory" class="editCategory">

        <div class="breadcrumb">
            <span><a href="admin/category/list">所有分类</a></span>
            <span class="gaySpan">/</span>
            <span class="gaySpanText">编辑分类</span>
        </div>

        <div class="panel panel-warning editDiv" id="editDiv">
            <div class="panel-heading">编辑分类</div>
            <div class="panel-body">
                <form id="editForm" action="admin/category/update" method="post" enctype="multipart/form-data">
                    <table class="editTable">
                        <input type="hidden" name="id" value="${category.id}">
                        <tr>
                            <td>分类名称</td>
                            <td><input type="text" class="form-control" name="name" id="categoryName"></td>
                        </tr>
                        <tr>
                            <td>分类图片</td>
                            <td>
                                <input type="file" id="image" name="image" accept="image/*">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <button type="submit" class="btn btn-success">提交</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
