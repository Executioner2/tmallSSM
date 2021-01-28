<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>购物车页面</title>
    <base href="<%=basePath%>"/>
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/shoppingPage.js" charset="UTF-8"></script>
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

    <!--这里放结算里面嵌套订单项-->
    <script>
        $(function () {
            initProductMoney();
            $(".cartPullSelectBtn").click(fullSelect);
            $("#orderItemContentTable .cartSelect").click(multipleChoice);
            $("#orderItemContentTable .productNumber").keyup(productNumberFun);
            $("#orderItemContentTable .tableBody .numberSub").click(productNumberSub);
            $("#orderItemContentTable .tableBody .numberAdd").click(productNumberAdd);
            $("#orderItemContentTable .tableBody .deleteProductItem").click(deleteProductItem);
            $(".productNumber").blur(function () {
                numberUpdate($(this).attr("oiid"));
            });
        });
    </script>
        <div class="settieAccountsButton" id="settieAccountsButton">
            <form action="user/settleAccounts" method="post">
            <div class="settieAccountsUpDiv">
                <span>已选商品 (不含运费)</span>
                <span class="settlementAmount totalAmount" id="settlementAmount1" totalAmount="0">￥0.00</span>
                <button type="submit" disabled class="settleAccountBtn">结 算</button>
            </div>

            <!--这里放订单项内容-->
            <div class="orderItemContent" id="orderItemContent">
                <table class="orderItemContentTable" id="orderItemContentTable">
                    <tr id="tableTitle">
                        <td>
                            <a href="javascript:void(0)" class="cartPullSelectBtn">
                                <img class="cartPullSelect" src="static/img/site/cartNotSelected.png"/>
                            </a>
                            <span>全选</span>
                        </td>
                        <td>商品信息</td>
                        <td>单价</td>
                        <td>数量</td>
                        <td>金额</td>
                        <td>操作</td>
                    </tr>
                    <c:forEach items="${orderItems}" var="orderItem">
                        <input type="hidden" class="orderItems" id="input${orderItem.id}" value="${orderItem.id}">
                        <tr class="tableBody" price="${orderItem.product.promotePrice}" productMoney="0" inventory="${orderItem.product.stock}">
                        <td>
                            <a href="javascript:void(0)" class="cartSelectBtn">
                                <img oiid="${orderItem.id}" class="cartSelect" src="static/img/site/cartNotSelected.png"/>
                            </a>
                            <img class="productImage" src="img/product/${orderItem.product.id}/singleImage/${orderItem.product.singleImageFirst.id}.jpg" />
                        </td>
                        <td>
                            <div class="productInformation">
                                <a href="#">${orderItem.product.name}</a>
                                <div class="cartProductLinkInnerDiv">
                                    <img src="static/img/site/creditcard.png" height="11" width="16"/>
                                    <img src="static/img/site/7day.png" height="16" width="16"/>
                                    <img src="static/img/site/promise.png" height="16" width="16"/>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div><del class="orignalPrice formatMoney">${orderItem.product.orignalPrice}</del></div>
                            <div class="promotePrice formatMoney">${orderItem.product.promotePrice}</div>
                        </td>
                        <td>
                            <div>
                                <a href="javascript:void(0)" class="numberSub" oiid="${orderItem.id}">-</a>
                                <span><input type="text" pid="${orderItem.product.id}" oiid="${orderItem.id}" id="number${orderItem.id}" class="productNumber" value="${orderItem.number}"></span>
                                <a href="javascript:void(0)" class="numberAdd" oiid="${orderItem.id}">+</a>
                            </div>
                        </td>
                        <td>
                            <span>￥</span><span class="productMoney formatMoney"></span>
                        </td>
                        <td>
                            <a href="javascript:void(0)" pid="${orderItem.product.id}" oiid="${orderItem.id}" class="deleteProductItem">删除</a>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="settieAccountsDownDiv">
                <a href="javascript:void(0)" class="cartPullSelectBtn">
                    <img class="cartPullSelect" src="static/img/site/cartNotSelected.png"/>
                </a>
                <span>全选</span>
                <span class="rightSpan pull-right">
                    <span>已选商品 <span class="productNumberSum">0</span> 件</span>
                    <span>合计 (不含运费)：</span>
                    <span class="settlementAmount totalAmount" id="settlementAmount2" totalAmount="0">￥0.00</span>
                    <button type="submit" disabled class="settleAccountBtn">结 算</button>
                </span>
            </div>
        </form>
    </div>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>