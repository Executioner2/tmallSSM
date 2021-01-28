<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>编辑产品</title>
    <base href="<%=basePath%>" />
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/adminStyle.css">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
</head>
<body>
    <%--这里放nav--%>
    <%@include file="../public/adminHeader.jsp"%>

    <%--这里放面包屑导航--%>
    <div class="breadcrumb">
        <span><a href="admin/category/list">所有分类</a></span>
        <span class="gaySpan">/</span>
        <span><a href="admin/product/list?id=${product.category.id}">${product.category.name}</a></span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">${product.name}</span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">编辑产品</span>
    </div>

    <%--这里放编辑框--%>
    <script>
        $(function () {
            init();

            $("#productAddDiv #addForm").submit(function () {
                if(!checkEmpty("productName","产品名称")){
                    return false;
                }else if(!isNumber("productOrignalPrice","原价格")){
                    return false;
                }else if(!isNumber("productPromotePrice","优惠价格")){
                    return false;
                }else if(!isInteger("productStock","库存")){
                    return false;
                }
                return true;
            });
        });

        function init() {
            $("#productAddDiv #productName").val("${product.name}");
            $("#productAddDiv #productSubTitle").val("${product.subTitle}");
            $("#productAddDiv #productOrignalPrice").val("${product.orignalPrice}");
            $("#productAddDiv #productPromotePrice").val("${product.promotePrice}");
            $("#productAddDiv #productStock").val("${product.stock}");
        }
    </script>
    <div id="productAddDiv" class="panel panel-warning productAddDiv addDiv">
        <div class="panel-heading">编辑产品</div>
        <div class="panel-body">
            <form id="addForm" action="admin/product/update" method="post">
                <table class="addTable">
                    <tr>
                        <td>产品名称</td>
                        <td>
                            <input type="text" class="form-control" name="name" id="productName">
                        </td>
                    </tr>
                    <tr>
                        <td>产品小标题</td>
                        <td>
                            <input type="text" class="form-control" name="subTitle" id="productSubTitle">
                        </td>
                    </tr>
                    <tr>
                        <td>原价格</td>
                        <td>
                            <input type="text" class="form-control" name="orignalPrice" id="productOrignalPrice">
                        </td>
                    </tr>
                    <tr>
                        <td>优惠价格</td>
                        <td>
                            <input type="text" class="form-control" name="promotePrice" id="productPromotePrice">
                        </td>
                    </tr>
                    <tr>
                        <td>库存</td>
                        <td>
                            <input type="text" class="form-control" name="stock" id="productStock">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="hidden" name="id" value="${product.id}">
                            <input type="hidden" name="cid" value="${product.category.id}">
                            <button type="submit" class="btn btn-success">提交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</body>
</html>
