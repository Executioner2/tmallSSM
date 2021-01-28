<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>分类管理</title>
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

    <script>
        $(function () {
            $("td.delete a").click(confirmDeleteLink);
        })

        confirmDeleteLink = function () {
            if(confirm("确认要删除？")){
                deleteRequest(this);
            }
        }
        
        function deleteRequest(me) {
            var cid = $(me).attr("cid");
            $.ajax({
                url:"admin/category/delete",
                data:{id:cid},
                type:"post",
                success:function (resp) {
                    alert(resp);
                    window.location.reload();
                }
            });
        }
    </script>

    <%--这里是分类管理--%>
    <div class="sortManagement" id="sortManagement">
        <div class="title">分类管理</div>
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <tr class="tableHead">
                <th>ID</th>
                <th>图片</th>
                <th>分类名称</th>
                <th>属性管理</th>
                <th>产品管理</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            <c:forEach items="${categories}" var="category" varStatus="st">
                <tr class="categoryItem">
                    <td class="categoryId"><c:out value="${category.id}"></c:out></td>
                    <td class="categoryImage">
                        <img class="titleImage" src="img/category/${category.id}.jpg"/>
                    </td>
                    <td class="categoryName"><c:out value="${category.name}"></c:out></td>
                    <td class="propertyManagement"><a href="admin/property/list?id=${category.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>
                    <td class="productManagement"><a href="admin/product/list?id=${category.id}"><span class="glyphicon glyphicon-shopping-cart"></span></a></td>
                    <td class="edit"><a href="admin/category/edit?id=${category.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td class="delete"><a cid="${category.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!--这里是page管理-->
    <%@include file="public/adminPage.jsp"%>

    <%--这里是分类添加jsp--%>
    <%@include file="add/adminCategoryAdd.jsp"%>
</body>
</html>