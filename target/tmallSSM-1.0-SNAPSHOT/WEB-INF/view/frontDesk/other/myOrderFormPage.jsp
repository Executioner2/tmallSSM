<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的订单页面</title>
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

    <!--这里放我的订单标题部分-->
    <div class="myOrderFormTitle" id="myOrderFormTitle">
        <div class="myOrderFormTitleOption">
            <span class="allOrderForm"><a href="user/order/list">所有订单</a></span>
            <span class="obligation"><a href="user/order/list?status=waitPay">待付款</a></span>
            <span class="toSendTheGoods"><a href="user/order/list?status=waitDeliver">待发货</a></span>
            <span class="waitForReceiving"><a href="user/order/list?status=waitTake">待收货</a></span>
            <span class="remainToBeEvaluated"><a href="user/order/list?status=evaluate">待评价</a></span>
            <div class="redLine"></div>
        </div>
        <table class="productItemTitle">
            <tr>
                <td>宝贝</td>
                <td>单价</td>
                <td>数量</td>
                <td>实付款</td>
                <td>交易操作</td>
            </tr>
        </table>
    </div>
    <!--这里放产品列表部分-->
    <div id="myOrderItem" class="myOrderItem myAllOrder">
       <c:forEach items="${orders}" var="order">
            <table class="myOrderProductItemTable" state="${order.status}">
            <tr class="myOrderPrductItemTitle">
                <td colspan="2">
                    <span class="dateTime">${order.strCreateDate}
                    </span>订单号：<span class="orderNumber">${order.orderCode}</span>
                </td>
                <td colspan="2">
                    <img class="orderItemTmallPng" src="static/img/site/orderItemTmall.png"/>天猫商城
                </td>
                <td>
                    <a href="#"><div class="wangwangGif"></div></a>
                </td>
                <td>
                    <a oid="${order.id}" class="orderDelete" href="javascript:void(0)"><span class="orderListItemDelete glyphicon glyphicon-trash"></span></a>
                </td>
            </tr>
            <c:forEach items="${order.orderItems}" var="oi" varStatus="st">
                <tr class="myOrderProductItem">
                <td>
                    <img class="productImage" src="img/product/${oi.product.id}/singleImage/${oi.product.singleImageFirst.id}.jpg"/>
                </td>
                <td>
                    <div class="productInformation">
                        <a href="product?id=${oi.product.id}">${oi.product.name}</a>
                        <div class="cartProductLinkInnerDiv">
                            <img src="static/img/site/creditcard.png" height="11" width="16"/>
                            <img src="static/img/site/7day.png" height="16" width="16"/>
                            <img src="static/img/site/promise.png" height="16" width="16"/>
                        </div>
                    </div>
                </td>
                <td class="price">
                    <div class="orignalPrice formatMoney">${oi.product.orignalPrice}</div>
                    <div class="promotePrice formatMoney">${oi.product.promotePrice}</div>
                </td>
                <c:if test="${st.index == 0}">
                    <td class="number" rowspan="${fn:length(order.orderItems)}">
                        ${order.totalNumber}
                    </td>
                    <td class="totalPrices" rowspan="${fn:length(order.orderItems)}">
                        <div class="totalPrice formatMoney">${order.totalMoney}</div>
                        <div>(含运费：￥0.00)</div>
                    </td>
                    <td class="${order.status} operation" rowspan="${fn:length(order.orderItems)}">
                        <c:choose>
                            <c:when test="${order.status == 'accomplish'}">
                                <span class="gayInfo" status="${order.status}">完成</span>
                            </c:when>
                            <c:when test="${order.status == 'waitPay'}">
                                <a status="${order.status}" href="user/pay?id=${order.id}">付款</a>
                            </c:when>
                            <c:when test="${order.status == 'waitDeliver'}">
                                <span class="gayInfo" status="${order.status}">待发货</span>
                                <a class="deliveryLink" oid="${order.id}" href="javascript:void(0)" status="${order.status}">催卖家发货</a>
                            </c:when>
                            <c:when test="${order.status == 'waitTake'}">
                                <a href="user/confirmPage?id=${order.id}" status="${order.status}">确认收货</a>
                            </c:when>
                            <c:when test="${order.status == 'evaluate'}">
                                <a href="user/reviewPage?id=${order.id}" status="${order.status}">评价</a>
                            </c:when>
                        </c:choose>
                    </td>
                </c:if>
                </tr>
            </c:forEach>
            </table>
       </c:forEach>
    </div>
    

    <script>
        $(function () {
            redLinePosition();
            $(".myOrderItem .deliveryLink").click(delivery);
            $(".myOrderItem .orderDelete").click(orderDeleteRequest);
        });

        //订单项删除
        function orderDeleteRequest(){
            var oid = $(this).attr("oid");
            if(confirm("确认要删除该订单？")){
                $.ajax({
                    url:"user/order/delete",
                    data:{id:oid},
                    type:"post",
                    success:function (resp) {
                        if(resp){
                            alert("删除成功！");
                            window.location.reload();
                        }else{
                            alert("删除失败！待发货或待收货订单不能删除");
                        }
                    }
                })
            }
        }

        /*发货*/
        function delivery() {
            var oid = $(this).attr("oid");
            $.post(
                "user/order/delivery",
                {id:oid},
                function (resp) {
                    if(resp){
                        alert("卖家已光速发货！");
                        window.location.reload();
                    }else{
                        alert("卖家正在耍猴！");
                    }
                },
                "json"
            );
        }

        //红色下标的位置
        function redLinePosition() {
            $(".myOrderFormTitleOption a").css("color","black");

            switch ("${status}") {
                case "waitPay":
                    $(".obligation a").css("color", "#C40000");
                    $(".redLine").css({"width": parseInt($(".obligation").css("width")) + 4, "left": 113});
                    break;
                case "waitDeliver":
                    $(".toSendTheGoods a").css("color", "#C40000");
                    $(".redLine").css({"width": parseInt($(".toSendTheGoods").css("width")) + 4, "left": 212});
                    break;
                case "waitTake":
                    $(".waitForReceiving a").css("color", "#C40000");
                    $(".redLine").css({"width": parseInt($(".waitForReceiving").css("width")) + 3, "left": 311});
                    break;
                case "evaluate":
                    $(".remainToBeEvaluated a").css("color", "#C40000");
                    $(".redLine").css({"width": parseInt($(".remainToBeEvaluated").css("width")) + 3, "left": 410});
                    break;
                default:
                    $(".allOrderForm a").css("color", "#C40000");
                    $(".redLine").css({"width": $(".allOrderForm").css("width"), "left": "0px"});
                    break;
            }
        }

    </script>
    
    <%@include file="../../admin/public/adminPage.jsp"%>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>