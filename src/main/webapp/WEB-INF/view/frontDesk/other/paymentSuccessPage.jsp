<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>支付成功页面</title>
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

    <!--这里是支付成功信息-->
    <div class="paymentSuccessInformation" id="paymentSuccessInformation">
        <div class="title">
            <img src="static/img/site/paySuccess.png" height="33" width="36"/>
            &nbsp&nbsp您已成功付款
        </div>
        <div class="payInformationContent">
            <ul>
                <li>
                    收货地址：
                    ${address}
                </li>
                <li>
                    实付款：
                    <span class="money formatMoney">${totalPrice}</span>
                </li>
                <li>
                    预计<span>08月08日</span>送达
                </li>
            </ul>
            <div>您可以
                <a href="user/order/list">查看已买到的宝贝</a>
                <a href="user/order/list">查看交易详情</a>
            </div>
        </div>
        <div class="payedSeperateLine"></div>
        <div class="payFooter">
            <img src="static/img/site/warning.png" height="20" width="21"/>
            <span>
                    <strong>安全提醒：</strong>
                    下单后，<span class="redSpan">用QQ给您发送链接办理退款的都是骗子！</span>
                    天猫不存在系统升级，订单异常等问题，谨防假冒客服电话诈骗！
                </span>
        </div>
    </div>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>