<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + '/';
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>查询结果页</title>
    <base href="<%=basePath%>" />
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/style.css">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
    <!--这里放nav-->
    <%@include file="../publicPage/topNavigationPage.jsp"%>

    <!--这里放搜索栏-->
    <%@include file="../publicPage/searchBoxPage.jsp"%>

    <!--这里放查询结果商品列表-->
    <div class="queryResultProductList" id="queryResultProductList">
        <c:forEach items="${products}" var="product">
            <div class="productItem">
            <a href="product?id=${product.id}"><img class="productImage" src="img/product/${product.id}/singleImage/${product.singleImageFirst.id}.jpg"/></a>
            <span class="price formatMoney">${product.promotePrice}</span>
            <span><a href="product?id=${product.id}">${product.name}</a></span>
            <span><a href="javascript:void(0)">天猫专卖</a></span>
            <div>
                <span>月成交 <span class="monthTurnover"><span>
                    <c:choose>
                        <c:when test="${product.salesVolume != '' and product.salesVolume != null}">
                            ${product.salesVolume}
                        </c:when>
                        <c:when test="${product.salesVolume == '' or product.salesVolume == null}">
                            0
                        </c:when>
                    </c:choose>
                </span></span>笔</span>
                <span>评价<span class="evaluateNumber">
                        <c:choose>
                            <c:when test="${product.reviewNumber != '' and product.salesVolume != null}">
                                ${product.reviewNumber}
                            </c:when>
                            <c:when test="${product.reviewNumber == '' or product.reviewNumber == null}">
                                0
                            </c:when>
                        </c:choose>
                        </span></span>
                <span><img src="static/img/site/wangwang.png" height="16" width="16"/></span>
            </div>
        </div>
        </c:forEach>
    </div>

    <!--这里放分页-->
    <%@include file="../../admin/public/adminPage.jsp"%>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>