<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>订单管理</title>
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

    <%--这里是订单管理--%>
    <script>
        $(function () {
            $("#orderManager .total").each(function () {
                var value = moneyFormatting(this.innerText);
                this.innerText = "￥" + value;
            });

            $("#orderManager .orderItemTr .productPrice").each(function () {
                var value = moneyFormatting(this.innerText);
                this.innerText = "单价：￥" + value;
            });

            $("#orderManager .orderItemTr .productNumber").each(function () {
                var value = this.innerText;
                this.innerText = value+"个";
            });

            $("#orderManager .orderPageCheckOrderItems").each(function () {
               $(this).click(function () {
                   var orderId = $(this).attr("orderid");
                   $("#orderManager #"+orderId+"").toggle();
               });
            });

            $("#orderManager td .deliver").click(deliverRequest);
        });

        //发货请求
        function deliverRequest(){
            var orderid =$(this).attr("orderid");
            $.ajax({
                url:"admin/order/deliver",
                data:{id:orderid},
                type:"post",
                success:function () {
                    window.location.reload();
                }
            });
        }


    </script>
    <div class="orderManager" id="orderManager">
        <div class="title">订单管理</div>
        <table class="table table-striped table-bordered table-hover  table-condensed">
            <tr class="tableHead">
                <th>ID</th>
                <th>状态</th>
                <th>金额</th>
                <th>商品数量</th>
                <th>买家名称</th>
                <th>创建时间</th>
                <th>支付时间</th>
                <th>发货时间</th>
                <th>确认收货时间</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${orders}" var="order" varStatus="st">
                <tr class="orderTr">
                    <td class="orderId">${order.id}</td>
                    <td class="orderStatus">${order.chineseStatus}</td>
                    <td class="total">${order.totalMoney}</td>
                    <td class="totalNumber">${order.totalNumber}</td>
                    <td class="userName">${order.orderItems[0].user.name}</td>
                    <td class="createdate datetime">${order.strCreateDate}</td>
                    <td class="payDate datetime">${order.strPayDate}</td>
                    <td class="deliveryDate datetime">${order.strDeliveryDate}</td>
                    <td class="confirmDate datetime">${order.strConfirmDate}</td>
                    <td>
                        <button class="orderPageCheckOrderItems btn btn-primary btn-xs" orderid="${order.id}">查看详情</button>
                        <c:if test="${order.status == 'waitDeliver'}">
                            <button class="deliver btn btn-primary btn-xs" orderid="${order.id}">发货</button>
                        </c:if>
                    </td>
                </tr>
                <tr class="orderItemTr" style="display: none" id="${order.id}">
                    <td class="orderItemTd" colspan="10">
                    <c:forEach items="${order.orderItems}" var="orderItem" varStatus="st">
                        <div>
                            <img width="40px" src="img/product/${orderItem.product.id}/singleImage/${orderItem.product.singleImageFirst.id}.jpg">
                            <a href="javascript:void(0)">${orderItem.product.name}</a>
                            <span class="productNumber">${orderItem.number}</span>
                            <span class="productPrice">${orderItem.product.promotePrice}</span>
                        </div>
                    </c:forEach>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!--这里是page管理-->
    <%@include file="public/adminPage.jsp"%>
</body>
</html>
