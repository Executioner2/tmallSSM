<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>属性管理</title>
    <base href="<%=basePath%>" />
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/adminStyle.css">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</head>
<body>
    <%--这里是nav--%>
    <%@include file="public/adminHeader.jsp"%>

    <!--这里是属性管理的面包屑导航-->
    <div class="breadcrumb">
        <span><a href="admin/category/list">所有分类</a></span>
        <span class="gaySpan">/</span>
        <span><a href="admin/property/list?id=${category.id}">${category.name}</a></span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">属性管理</span>
    </div>

    <script>
        $(function () {
            $("td.delete a").click(confirmDeleteLink);
        })

        confirmDeleteLink = function () {
            if(confirm("确认要删除？")){
                deleteRequest(this);
            }
        }

        function deleteRequest(me){
            var ptid = $(me).attr("ptid");
            $.ajax({
               url:"admin/property/delete",
               data:{id:ptid},
               type:"post",
               success:function (resp) {
                   alert(resp);
                   window.location.reload();
               }
            });
        }

    </script>

    <%--这里是属性管理--%>
    <div class="propertyManager" id="propertyManager">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <tr class="tableHead">
                <th>ID</th>
                <th>属性名称</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            <c:forEach items="${properties}" var="property" varStatus="st">
                <tr class="propertyItem">
                    <td class="propertyId"><c:out value="${property.id}"></c:out></td>
                    <td class="propertyName"><c:out value="${property.name}"></c:out></td>
                    <td class="edit"><a href="admin/property/edit?id=${property.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td class="delete"><a ptid="${property.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <%--这里是分页--%>
    <%@include file="public/adminPage.jsp"%>

    <%--这里是增加框--%>
    <%@include file="add/adminPropertyAdd.jsp"%>
</body>
</html>
