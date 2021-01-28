<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>评价页面</title>
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

    <!--这里放评价页面上-->
    <div id="theEvaluationUp" class="theEvaluationUp">
        <div id="productItem">
            <div class="leftProductImage">
                <img id="productImage" class="productImage" src="img/product/${orderItem.product.id}/singleImage/${orderItem.product.singleImageFirst.id}.jpg"/>
            </div>
            <div class="rightProductInfo">
                <div id="productTitle" class="productTitle">
                    ${orderItem.product.name}
                </div>
                <table class="tableInfo">
                    <tr>
                        <td>价格:</td>
                        <td><span id="price" class="price formatMoney">${orderItem.product.promotePrice}</span>元</td>
                    </tr>
                    <tr>
                        <td>配送:</td>
                        <td>快递：0.00</td>
                    </tr>
                    <tr>
                        <td>月销量:</td>
                        <td><span id="daySalesVolume" class="daySalesVolume">${orderItem.product.salesVolume}</span>件</td>
                    </tr>
                </table>
                <div class="hintDiv">
                    <table>
                        <tr>
                            <td class="hintImage"><img src="static/img/site/reviewLight.png" height="38" width="23"/></td>
                            <td class="hintText">现在查看的是 您所购买商品的信息 于<span id="createDate">${order.chineseCreateDate}</span>下单购买了此商品</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!--这里放评价页面下-->
    <div id="theEvaluationDown" class="theEvaluationDown">
        <div class="theCumulativeAssessment">
            <div class="contentDiv">
                <span>累计评价</span>
                <span id="reviews">${orderItem.product.reviewNumber}</span>
            </div>
            <div class="backgroundDiv"></div>
        </div>
        <form action="user/affirmReview">
            <div id="evaluateDiv${orderItem.product.id}" class="evaluateDiv">
                <div class="evaluateDivTop">
                    <div class="evaluateHint">
                        其他买家，需要你的建议哦！
                    </div>
                    <table>
                        <tr>
                            <td>评价商品</td>
                            <td><textarea id="reviewsText" name="content"></textarea></td>
                        </tr>
                    </table>
                </div>
                <input type="submit" class="submitBtn" value="提交评价" />
            </div>
        </form>
    </div>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>