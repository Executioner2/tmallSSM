<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>产品管理</title>
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
    <%@include file="public/adminHeader.jsp"%>

    <%--这里放面包屑导航--%>
    <div class="breadcrumb">
        <span><a href="admin/category/list">所有分类</a></span>
        <span class="gaySpan">/</span>
        <span><a href="admin/product/list?id=${category.id}">${category.name}</a></span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">产品管理</span>
    </div>

    <script>
        $(function () {
            $("td.delete a").click(deleteRequest);
        });



        function deleteRequest() {
            var pid;

            if(confirm("确认要删除?")){
               pid = $(this).attr("pid");
               $.ajax({
                   url:"admin/product/delete",
                   data:{id:pid},
                   type:"post",
                   success:function (resp) {
                       alert(resp);
                       window.location.reload();
                   }
               });
            }
        }

    </script>
    <%--这里放table--%>
    <div class="productManger" id="productManger">
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <tr class="tableHead">
                <th>ID</th>
                <th>图片</th>
                <th>产品名称</th>
                <th>产品小标题</th>
                <th>原价格</th>
                <th>优惠价格</th>
                <th>库存数量</th>
                <th>图片管理</th>
                <th>设置属性</th>
                <th>编辑</th>
                <th>删除</th>
            </tr>
            <c:forEach items="${products}" var="product" varStatus="st">
                <tr class="productsItem">
                    <td class="id"><c:out value="${product.id}"></c:out></td>
                    <td class="productsImage">
                        <img width="40px" src="img/product/${product.id}/singleImage/${product.singleImageFirst.id}.jpg"/>
                    </td>
                    <td class="name"><c:out value="${product.name}"></c:out></td>
                    <td class="subTitle"><c:out value="${product.subTitle}"></c:out></td>
                    <td class="orignalPrice"><c:out value="${product.orignalPrice}"></c:out></td>
                    <td class="promotePrice"><c:out value="${product.promotePrice}"></c:out></td>
                    <td class="stock"><c:out value="${product.stock}"></c:out></td>
                    <td class="productImageManager"><a href="admin/productImage/list?id=${product.id}"><span class="glyphicon glyphicon-picture"></span></a></td>
                    <td class="propertySet"><a href="admin/propertyValue/list?id=${product.id}&cid=${category.id}"><span class="glyphicon glyphicon-th-list"></span></a></td>
                    <td class="edit"><a href="admin/product/edit?id=${product.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td class="delete"><a pid="${product.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <%--这里放分页--%>
    <%@include file="public/adminPage.jsp"%>

    <%--这里放新增框--%>
    <%@include file="add/adminProductAdd.jsp"%>
</body>
</html>
