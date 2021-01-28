<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>分类页面</title>
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

    <!--这里放排序和价格-->
    <script>
        $(function () {
            $("#sortAndPrice .sortTable td:eq(${sort})").css("background-color", "#F1EDEC");
        });
    </script>
    <div id="sortAndPrice">
        <img src="img/category/${category.id}.jpg" height="110" width="1010"/>
        <div class="sortAndPriceDiv">
            <table class="sortTable">
                <tr class="grayColumn">
                    <td><a href="classify?id=${category.id}">综合<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                    <td><a href="classify/sort?id=${category.id}&sort=review&priceLeft=${priceLeft}&priceRight=${priceRight}">人气<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                    <td><a href="classify/sort?id=${category.id}&sort=createDate&priceLeft=${priceLeft}&priceRight=${priceRight}">新品<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                    <td><a href="classify/sort?id=${category.id}&sort=sales&priceLeft=${priceLeft}&priceRight=${priceRight}">销量<span class="glyphicon glyphicon-arrow-down"></span></a></td>
                    <td><a href="classify/sort?id=${category.id}&sort=price&sortType=${sortType}&priceLeft=${priceLeft}&priceRight=${priceRight}">价格<span class="glyphicon glyphicon-resize-vertical"></span></a></td>
                </tr>
            </table>
            <table class="priceRangeTable">
                <tr>
                    <td><input class="price" id="priceLeft" type="text" placeholder="请输入" value="${priceLeft}"></td>
                    <td class="grayColumn priceMiddleColumn">-</td>
                    <td><input class="price" id="priceRight" type="text" placeholder="请输入" value="${priceRight}"></td>
                </tr>
            </table>
        </div>
    </div>

    <!--这里放产品列表-->
    <script>
        $(function () {
            $("#priceRight").blur(priceSectionFun);
            $("#priceLeft").blur(priceSectionFun);
            $("#priceLeft").keyup(delCharFun);
            $("#priceRight").keyup(delCharFun);
        });

        //删除除数字以外的字符
        function delCharFun(v) {
            var value = $(this).val();
            if(isNaN(parseFloat(value))){
                $(this).val(0);
                return ;
            }
            $(this).val(parseFloat(value));
        }

        function priceSectionFun() {
            var priceLeft = $("#priceLeft").val().trim();
            var priceRight = $("#priceRight").val().trim();
            if(priceLeft == ""){
                priceLeft = 0;
            }
            if(priceRight == ""){
                return;
            }
            if(priceRight == "0" && priceLeft == "0"){
                return ;
            }
            window.location.href="classify/sort?sort=${sort}&id=${category.id}&priceLeft="+priceLeft+"&priceRight="+priceRight;
        }

    </script>
    <div class="productListInClassify" id="productListInClassify">
        <c:forEach items="${products}" var="product">
            <div class="productItem" price="${product.promotePrice}">
                <a href="product?id=${product.id}"><img class="productImage" src="img/product/${product.id}/singleImage/${product.singleImageFirst.id}.jpg" width="100%"/></a>
                <span class="price formatMoney">${product.promotePrice}</span>
                <a href="product?id=${product.id}">${product.name}</a>
                <a href="product?id=${product.id}">天猫专卖</a>
                <div class="itemFooter">
                    <span class="monthMake">月成交<span class="monthMakeCount">${product.salesVolume}笔</span></span>
                    <span class="evaluate">评价<span class="evaluateCount">${product.reviewNumber}</span></span>
                    <span class="wangWang"><a href="#"><img src="static/img/site/wangwang.png" height="16" width="16"/></a></span>
                </div>
            </div>
        </c:forEach>
    </div>

    <!--page-->
    <%@include file="../../admin/public/adminPage.jsp"%>

    <!--footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>