<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>结算页面</title>
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

    <form action="user/order/add" method="post" id="orderAddForm">
        <!--这里放头部和收货地址-->
        <div class="headAndPlaceOfReceipt" id="headAndPlaceOfReceipt">
            <div class="title">
                <img class="simpleLogo pull-left" src="static/img/site/simpleLogo.png" height="27" width="190"/>
                <img class="buyflow pull-right" src="static/img/site/buyflow.png" height="72" width="597"/>
            </div>
            <div style="clear: both"></div>  <!--清除浮动避免上面的容器坍塌-->
            <table class="fillInInformation">
                <tr class="tableTitle">
                    <td colspan="2" class="fillInTitle">输入收货地址</td>
                </tr>
                <tr class="tableBody">
                    <td>
                        <span>详细地址</span><span class="important">*</span>
                    </td>
                    <td>
                        <textarea name="address" id="address" cols="60" rows="2" placeholder="建议您如实填写详细收货地址，例如接到名称，门牌号码，楼层和房间号等信息"></textarea>
                    </td>
                </tr>
                <tr class="tableBody">
                    <td>邮政编码</td>
                    <td><input id="post" name="post" type="text" placeholder="如果您不清楚邮递区号，请填写000000"></td>
                </tr>
                <tr class="tableBody">
                    <td><span>收货人姓名</span><span class="important">*</span></td>
                    <td><input id="receiver" name="receiver" type="text" placeholder="长度不超过25个字符"></td>
                </tr>
                <tr class="tableBody">
                    <td><span>手机号码</span><span class="important">*</span></td>
                    <td><input id="mobile" name="mobile" type="text" placeholder="请输入11位手机号码"></td>
                </tr>
            </table>
        </div>
        <!--这里放确认订单信息-->
        <script>
            $(function () {
                init();
                $("#confirmOrderInformation .confirmOrderFooter .leaveMessagePng").click(leaveMessageShow);
                $("#orderAddForm").submit(function () {
                    if(!checkEmpty("address","详细地址")){
                        return false;
                    }else if(!checkEmpty("post","邮政编码")){
                        return false;
                    }else if(!checkEmpty("receiver","收货人姓名")){
                        return false;
                    }else if(!checkEmpty("mobile","手机号码")){
                        return false;
                    }else{
                        return true;
                    }
                });
            });

            function leaveMessageShow(){
                $("#confirmOrderInformation .confirmOrderFooter .leaveMessagePng").css("display","none");
                $("#confirmOrderInformation .confirmOrderFooter .leaveMessage").show();
                $("#confirmOrderInformation .confirmOrderFooter .explainSpan").show();
            }

            function init() {
                var totalParice = 0;
                $(".price").each(function () {
                    $(this).text("￥"+moneyFormatting($(this).text()));
                });
                $(".subtotal").each(function () {
                    var value = parseFloat($(this).text()).toFixed(2);
                    totalParice += parseFloat(value);
                    $(this).text("￥" + moneyFormatting(value));
                });
                totalParice = parseFloat(totalParice).toFixed(2);
                $("#totalPrice").text("店铺合计(含运费): ￥" + moneyFormatting(totalParice));
                $(".actualPayment").text("￥" + moneyFormatting(totalParice));
            }
        </script>
        <div class="confirmOrderInformation" id="confirmOrderInformation">
            <div class="confirmOrderHeadline">确认订单信息</div>
            <table  class="confirmOrderItem" productItemNumber="2">
                <tr class="confirmOrderTitle">
                    <td colspan="2px">
                        <img class="tamllbuyPng" src="static/img/site/tmallbuy.png"/>
                        <a href="javascript:void(0)" class="storeName">店铺：天猫店铺</a>
                        <a href="javascript:void(0)"><div class="wangwangGif"></div></a>
                    </td>
                    <td>单价</td>
                    <td>数量</td>
                    <td>小计</td>
                    <td>配送方式</td>
                </tr>
                <tr class="rowborder">
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td rowspan="${fn:length(orderItems) + 1}">
                        <input type="radio" checked>普通配送
                        <select>
                            <option value="0">快递 普通配送</option>
                        </select>
                    </td>
                </tr>
                <c:forEach items="${orderItems}" var="orderItem">
                    <input type="hidden" name="oiids" value="${orderItem.id}">
                    <tr class="productItem" id="productItem${orderItem.id}">
                    <td>
                        <img class="productImage" src="img/product/${orderItem.product.id}/singleImage/${orderItem.product.singleImageFirst.id}.jpg"/>
                    </td>
                    <td>
                        <div>
                            <a href="javascript:void(0)">${orderItem.product.name}</a>
                            <div>
                                <img src="static/img/site/creditcard.png" height="11" width="16"/>
                                <img src="static/img/site/7day.png" height="16" width="16"/>
                                <img src="static/img/site/promise.png" height="16" width="16"/>
                            </div>
                        </div>
                    </td>
                    <td class="price">
                        ${orderItem.product.promotePrice}
                    </td>
                    <td class="productNumber">
                        ${orderItem.number}
                    </td>
                    <td class="subtotal" oid="${orderItem.id}">
                        <c:out value="${orderItem.product.promotePrice * orderItem.number}"></c:out>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                </c:forEach>
            </table>
            <div class="confirmOrderFooter">
                <span>给卖家留言：</span>
                <span id="totalPrice"></span>
                <a href="javascript:void(0)" class="leaveMessagePng"><img src="static/img/site/leaveMessage.png" height="26" width="255"/></a>
                <textarea name="userMessage" class="leaveMessage" rows="4" cols="40"></textarea>
                <div class="explainSpan">还可以输入200个字符</div>
            </div>
            <div class="submitOrderForm">
                <div><span>实付款：</span><span class="actualPayment"></span></div>
                <button class="submitBtn" id="submitBtn" type="submit">提交订单</button>
            </div>
        </div>
    </form>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>