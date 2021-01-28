<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>确认收货页面</title>
    <base href="<%=basePath%>"/>
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

    <!--这里放简单搜索栏-->
    <%@include file="../publicPage/simpleSearchBoxPage.jsp"%>

    <!--这里放确认收货页面上-->
    <div class="confirmReceiptUp" id="confirmReceiptUp">
        <img id="scheduleImage" src="static/img/site/comformPayFlow.png"/>
        <div class="dateTime">
            <span>${order.strCreateDate}</span>
            <span>${order.strPayDate}</span>
            <span>${order.strDeliveryDate}</span>
        </div>
        <div class="hint1">我已收到货，同意支付宝付款</div>
        <table>
            <tr>
                <td>订单信息</td>
            </tr>
            <tr class="tableTitle">
                <td colspan="2">宝贝</td>
                <td>单价</td>
                <td>数量</td>
                <td>商品总价</td>
                <td>运费</td>
            </tr>
            <c:forEach items="${order.orderItems}" var="oi">
                <tr class="tableBody">
                    <td><img class="productImage" src="img/product/${oi.product.id}/singleImage/${oi.product.singleImageFirst.id}.jpg"/></td>
                    <td><a href="product?id=${oi.product.id}">${oi.product.name}</a></td>
                    <td class="unitPrice formatMoney">${oi.product.orignalPrice}</td>
                    <td class="number">${oi.number}</td>
                    <td class="totalPrices formatMoney">${oi.product.promotePrice}</td>
                    <td>快递： 0.00</td>
                </tr>
            </c:forEach>
        </table>
        <div class="actualPayment">
            <span>实付款：<span class="paymentAmount formatMoney">${order.totalMoney}</span></span>
            <div style="clear: both"></div>
        </div>

    </div>

    <!--这里放确认收货页面下-->
    <div class="confirmReceiptDown" id="confirmReceiptDown">
        <table class="gayTable">
            <tr>
                <td>订单编号:</td>
                <td>
                    <span>${order.orderCode}</span>
                    <img src="static/img/site/confirmOrderTmall.png" height="18" width="23"/>
                </td>
            </tr>
            <tr>
                <td>卖家昵称:</td>
                <td>
                    <span>天猫商铺</span>
                    <div class="wangwangGif">
                    </div>
                </td>
            </tr>
            <tr>
                <td>收货信息:</td>
                <td>
                    <span class="address">${order.address}</span>
                    <span class="user_name">${order.receiver}</span>
                    <span class="mobile">${order.mobile}</span>
                    <span class="post">${order.post}</span>
                </td>
            </tr>
            <tr>
                <td>成交时间:</td>
                <td>${order.strPayDate}</td>
            </tr>
        </table>
        <div class="hintDiv">
            <div class="hint">请收到货后，再确认收货！否则您可能钱货两空！</div>
            <form action="user/confirm" method="post">
                <input type="hidden" name="id" value="${order.id}">
                <button type="submit">确认支付</button>
            </form>
        </div>
    </div>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>