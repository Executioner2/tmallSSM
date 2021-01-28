<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>产品页面</title>
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

    <!--这里放titleImage-->
    <div id="titleImage" class="titleImage">
        <img src="img/category/${product.category.id}.jpg"/>
    </div>

    <!--这里是把产品图片和基本信息装起来的div-->
    <div class="productImageAndProductBasicInformationDiv" id="productImageAndProductBasicInformationDiv">
        <!--这里放产品图片-->
        <script>
            $(function () {
                $("#productImage .productImageList img").mouseenter(setShowImage);
            });

            function setShowImage() {
                $("#showImage")[0].src = $(this)[0].src;
                $("#showImage").css("height","400px");
            }

        </script>
        <div id="productImage">
            <img id="showImage" src="img/product/${product.id}/singleImage/${product.productImages['singleImage'][0].id}.jpg"/>
            <div class="productImageList">
                <c:forEach items="${product.productImages['singleImage']}" var="image">
                    <img src="img/product/${product.id}/singleImage/${image.id}.jpg"/>
                </c:forEach>
            </div>
        </div>

        <!--这里放基本信息-->
        <script>
            $(function () {
                $("#productNumber").keyup(procuctNumberKeyUp);
                $("#upKey").click(numberAdd);
                $("#downKey").click(numberSub);
                $("#joinShopping").click(shopping);
                $("#loginBtn").click(login);
                $("#buyForm").submit(buy);
                $(window).click(function () {
                    $(".errorHint").css("visibility", "hidden");
                });
                init();
            });

            function procuctNumberKeyUp(){
                var number = $("#productNumber").val();
                var inventory = $("#productBasicInformation .inventory").text();
                if(isNaN(parseInt(number)) || parseInt(number) <= 0){
                    $("#productNumber").val(1);
                }
                if(isNaN(number)){
                    $("#productNumber").val(parseInt(number));
                }
                if(parseInt(number) > parseInt(inventory)){
                    $("#productNumber").val(inventory);
                }
            }

            function numberAdd(){
                var number = $("#productNumber").val();
                var inventory = $("#productBasicInformation .inventory").text();
                if(parseInt(number) < parseInt(inventory)){
                    $("#productNumber").val(parseInt(number)+1);
                }
            }

            function numberSub(){
                var number = $("#productNumber").val();
                if(parseInt(number) > 1){
                    $("#productNumber").val(parseInt(number)-1);
                }
            }
            function init(){
                var orignalPrice = moneyFormatting("${product.orignalPrice}");
                var promotePrice = moneyFormatting("${product.promotePrice}");
                $("#productBasicInformation .biTitle").text("${product.name}");
                $("#productBasicInformation .sketchDiv").text("${product.subTitle}");
                $("#productBasicInformation .orignalPrice del").text(orignalPrice);
                $("#productBasicInformation .promotePrice").text(promotePrice);
                $("#productBasicInformation .inventory").text("${product.stock}");
                $("#productBasicInformation .sales").text("${product.salesVolume}");
                $(".reviews").text("${product.reviewNumber}");
            }
            function login() {
                var name = $("#username").val();
                var pw = $("#password").val();
                var href = $(location).attr("href");
                $.post(
                    "login",
                    {name:name,password:pw},
                    function (resp) {
                        if(resp){
                            $(location).attr("href",href);
                        }else{
                            $(".errorHint").css("visibility", "visible");
                        }
                    },
                    "json"
                );
            }
            //加入购物车
            function shopping(){
                <c:if test="${user == null}">
                    $("#loginModal").modal('show');
                    return ;
                </c:if>

                var pid = "${product.id}";
                var uid = "${user.id}";
                var number = $("#productNumber").val();
                $.post(
                    "user/orderItem/add",
                    {pid:pid,uid:uid,number:number},
                    function (resp) {
                        if(resp){
                            $("#joinShopping").text("已加入购物车");
                            $("#joinShopping").attr("disabled",true);
                            $("#joinShopping").css("background-color","#D3D3D3");
                            $("#joinShopping").css("border-color","#D3D3D3");
                            $("#joinShopping").css("color","black");
                        }else{
                            alert("加入购物车失败");
                        }
                    },
                    "json"
                );
            }

            /*立即购买*/
            function buy() {
                <c:if test="${user == null}">
                    $("#loginModal").modal('show');
                    return false;
                </c:if>
            }
        </script>

        <%--登录模态框--%>
        <div class="modal in" id="loginModal" aria-hidden="true" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content loginInputBox">
                    <div class="errorHint">账号密码错误</div>
                    <div class="title">账户登录</div>
                    <table>
                        <tr>
                            <td>
                                <span class="glyphicon glyphicon-user"></span>
                            </td>
                            <td>
                                <input type="text" name="username" id="username">
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <span class="glyphicon glyphicon-lock"></span>
                            </td>
                            <td>
                                <input type="password" name="password" id="password">
                            </td>
                        </tr>
                    </table>
                    <div class="hint">不要输入真实的天猫账号密码</div>
                    <div class="otherOperating">
                        <span class="forgetLoginPassword"><a href="javascript:void(0)">忘记登录密码</a></span>
                        <span class="freeRegister"><a href="registerPage">免费注册</a></span>
                        <div style="clear: both"></div>
                    </div>
                    <button id="loginBtn">登录</button>
                </div>
            </div>
        </div>

        <div id="productBasicInformation" class="productBasicInformation">
            <form action="user/buy" id="buyForm" method="post">
            <div class="biTitle"></div>
            <div class="sketchDiv"></div>
            <div class="juHuaSuanCountDown">
                <span>聚划算</span>
                <span>此商品即将参加聚划算，<span class="countDow">1天19小时</span>后开始</span>
            </div>
            <div class="priceDiv">
                <div>
                    <img src="static/img/site/gouwujuan.png"/>
                    <span>全天猫实物商品通用</span>
                </div>
                <div>
                    <span>价格</span>
                    <span class="orignalPrice"><del></del></span>
                </div>
                <div>
                    <span>促销价</span>
                    <span>￥</span>
                    <span class="promotePrice"></span>
                </div>
            </div>
            <div class="salesAndReviews">
                <span>销量 <span class="sales"></span></span>
                <span>累计评价 <span class="reviews"></span></span>
            </div>
            <div class="numberDiv">
                <span>数量</span>
                <span><input type="text" value="1" name="number" id="productNumber"></span>
                <span class="arrow">
                <a href="javascript:void(0)" id="upKey">
                    <span class="updown">
                        <img src="static/img/site/increase.png" height="3" width="7"/>
                    </span>
                </a>
                <span class="updownMiddle"></span>
                <a href="javascript:void(0)" id="downKey">
                    <span class="updown">
                        <img src="static/img/site/decrease.png" height="3" width="7"/>
                    </span>
                </a>
            </span>
                <span>件 库存<span class="inventory"></span>件</span>
            </div>
            <div class="commitment">
                <span>服务承诺</span>
                <a href="javascript:void(0)">正品保证</a>
                <a href="javascript:void(0)">极速退款</a>
                <a href="javascript:void(0)">赠运费险</a>
                <a href="javascript:void(0)">七天无理由退换</a>
            </div>
            <div class="buyAndJoinShopping">
                <input type="hidden" name="pid" value="${product.id}">
                <button type="submit" id="buy">立即购买</button>
                <button type="button" id="joinShopping"><span class="glyphicon glyphicon-shopping-cart"></span>加入购物车</button>
            </div>
            </form>
        </div>
    </div>

    <!--这里放产品详情-->
    <div id="productParticulars" class="productParticulars">
        <div class="productDetailTopPart">
            <a href="javascript:void(0)" class="productDetailTopPartSelectedLink">商品详情</a>
            <a href="javascript:void(0)" class="productDetailTopReviewLink">累计评价 <span class="reviews"></span></a>
        </div>
        <div class="productParameterDiv">
            <div class="titleDiv">产品参数：</div>
            <div class="productParamterList">
                <c:forEach items="${product.propertyValues}" var="pv">
                    <span>${pv.property.name}: ${fn:substring(pv.value, 0, 10)}</span>
                </c:forEach>
            </div>
        </div>
        <div class="productDescribeImageDiv">
            <c:forEach items="${product.productImages['detailsImage']}" var="image">
                <img src="img/product/${product.id}/detailsImage/${image.id}.jpg"/>
            </c:forEach>
        </div>
    </div>

    <!--这里放积累评价-->
    <div id="productCumulativeAssessment" class="productCumulativeAssessment" show="${reviewShow}">
        <div class="productDetailTopPart">
            <a href="javascript:void(0)" class="productDetailTopPartSelectedLink">商品详情</a>
            <a href="javascript:void(0)" class="productDetailTopReviewLink">累计评价 <span class="reviews"></span></a>
        </div>
        <div class="cumulativeAssessmentDiv">
            <c:forEach items="${reviews}" var="review">
                <div class="productEvaluateItem">
                    <div class="productEvaluateItemDesc">
                        <div class="productEvaluateItemContent">${review.content}</div>
                        <div class="productEvaluateItemDate">${review.strCreateDate}</div>
                    </div>
                    <div class="productEvaluateItemUserInfo">
                        ${review.user.anonymousName}
                        <span class="userInfoGrayPart">（匿名）</span>
                    </div>
                </div>
            </c:forEach>
        </div>
        <!--page-->
        <%@include file="../../admin/public/adminPage.jsp"%>
    </div>

    <!--产品详情与积累评价切换的js-->
    <script>
        $(function () {
            if($(".productCumulativeAssessment").attr("show")){
                productCumulativeAssessmentShow();
            }
            $(".productDetailTopPartSelectedLink").click(productParticularsShow);
            $(".productDetailTopReviewLink").click(productCumulativeAssessmentShow);
        });

        function productParticularsShow() {
            $(".productCumulativeAssessment").css("display","none");
            $(".productParticulars").css("display","block");
        }

        function productCumulativeAssessmentShow(){
            $(".productCumulativeAssessment").css("display","block");
            $(".productParticulars").css("display","none");
        }
    </script>

    <!--footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>