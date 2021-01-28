<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>支付页面</title>
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

    <!--这里是支付二维码-->
    <div class="payPage" id="payPage">
        <form action="user/affirmPay" method="post">
            <img src="static/img/site/simpleLogo.png"/>
            <div class="payMediate">
                <input type="hidden" name="id" value="${id}">
                <div>   扫一扫付款（元）</div>
                <div class="paymentAmount formatMoney">${totalPrice}</div>
                <img src="static/img/site/alipay2wei.png" height="256" width="195"/>
                <button type="submit">确认支付</button>
            </div>
        </form>
    </div>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>