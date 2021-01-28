<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>天猫首页</title>
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

    <!--这里是搜索栏和导航栏-->
    <script>
        $(function () {
            $(".rightMenu:first span").mouseenter(catearShow);
            $(".rightMenu:first span").mouseleave(catearNone);
        });

        function catearNone(){
            $("#catear").css("display","none");
        }

        function catearShow(){
            var width = parseInt($(this).css("width"))/2+3;
            var left = $(this).position().left+width;
            var top = $(this).position().top-20;
            var catear = $("#catear");
            catear.css({"left":""+left+"px","top":""+top+"px"});
            catear.fadeIn(500);
        }
    </script>
    <div id="searchAndNav" class="searchAndNav">
        
        <%@include file="../publicPage/searchBoxPage.jsp"%>
        
        <div style="height: 50px"></div>
        <img id="catear" src="static/img/site/catear.png" style="left: 500px; top: 38px; display: none"/>   <!--间隔120px-->
        <div class="navAndRotDiv" id="navAndRotDiv">
            <div class="navDiv">
                <div class="head">
                    <span class="glyphicon glyphicon-th-list"></span>
                    <span id="text">商品分类</span>
                </div>
                <div class="rightMenu">
                    <span>
                        <a href="home"><img src="static/img/site/chaoshi.png" height="72" width="180"/></a>
                    </span>
                    <span>
                        <a href="home"><img src="static/img/site/guoji.png" height="72" width="180"/></a>
                    </span>
                    <c:forEach begin="0" end="3" varStatus="st">
                        <span>
                            <a href="classify?id=${categories[st.index].id}">${categories[st.index].name}</a>
                        </span>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div id="lunBoDiv">
            <div id="carousel-of-product" class="carousel slide carousel-of-product" data-ride="carousel" data-interval="2000">
                <ol class="carousel-indicators">
                    <li data-target="#carousel-of-product" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-of-product" data-slide-to="1"></li>
                    <li data-target="#carousel-of-product" data-slide-to="2"></li>
                    <li data-target="#carousel-of-product" data-slide-to="3"></li>
                    <li data-target="#carousel-of-product" data-slide-to="4"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <div class="item active"><img src="static/img/lunbo/1.jpg"/></div>
                    <div class="item"><img src="static/img/lunbo/2.jpg"/></div>
                    <div class="item"><img src="static/img/lunbo/3.jpg"/></div>
                    <div class="item"><img src="static/img/lunbo/4.jpg"/></div>
                    <div class="item"><img src="static/img/lunbo/5.jpg"/></div>
                </div>
            </div>
        </div>
    </div>
    <div style="clear: both"></div>

    <!--这里放商品分类-->
    <script>
        $(function () {
            floatMenuHidden();
            randBlueLink();
            $(".leftMenu>.link").mouseenter(floatMenuBlock);
            $(".categoryWithCarousel").mouseleave(floatMenuHidden);
            $(".rightFloatMenu").mouseleave(floatMenuHidden);
        });

        function floatMenuHidden() {
            $(".categoryWithCarousel>.rightFloatMenu").css("display", "none");
            $(".carousel-indicators").css("z-index","2");
        }

        function floatMenuBlock() {
            floatMenuHidden();
            var menus =  $(".rightFloatMenu");
            var index = parseInt($(this).attr("index"));
            menus[index].style.display ="block";
            $(".carousel-indicators").css("z-index","0");
        }

        function randBlueLink(){
            var upper = $(".rightFloatMenu a").length - 1;
            for (var i = 0; i < upper / 7; i++) {
                var rnumber = parseInt(Math.random()*upper);
                $(".rightFloatMenu a:eq("+rnumber+")").css("color","#87CEFA");
            }

        }
    </script>
    <div class="categoryWithCarousel" id="categoryWithCarousel">
        <div class="leftMenu">
            <c:forEach items="${categories}" var="category" varStatus="st">
                <div class="link" index="${st.index}">
                    <span class="glyphicon glyphicon-link"></span>
                    <a href="classify?id=${category.id}">${category.name}</a>
                </div>
            </c:forEach>
        </div>
        <c:forEach items="${categories}" var="category">
            <div class="rightFloatMenu">                
                <c:forEach begin="0" end="7" items="${category.productsByRow}" var="pbr">
                    <div class="row">
                        <c:forEach items="${pbr}" var="product">
                            <c:if test="${!empty product.subTitle}">
                                <c:forEach items="${fn:split(product.subTitle, ' ')}" var="title" varStatus="st">
                                    <c:if test="${st.index == 0}">
                                        <a href="product?id=${product.id}">${title}</a>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:forEach>                    
                </div>
        </c:forEach>
    </div>


    <!--这里是商品主体部分-->
    <script>
        $(function () {
            $("#productBody .price").text(function () {
                return moneyFormatting($(this).text());

            });
        });
    </script>
    <div id="productBody">
        <div class="productList" id="productList">
            <c:forEach items="${categories}" var="category">
                <div class="productDiv">
                    <div class="productTitle">${category.name}</div>
                    <c:forEach items="${category.products}" var="ps" begin="0" end="4">
                        <div class="productItem">
                            <a href="product?id=${ps.id}" class="product">
                                <img src="img/product/${ps.id}/singleImage/${ps.singleImageFirst.id}.jpg"/>
                            </a>
                            <a href="product?id=${ps.id}" class="productItemDescLink">
                                <span class="productItemDesc">[热销] ${fn:substring(ps.name, 0, 20)}</span>
                            </a>
                            <span class="price">${ps.promotePrice}</span>
                        </div>
                    </c:forEach>
                </div>
            </c:forEach>
        <div class="endDiv" id="endDiv">
            <img src="static/img/site/end.png" height="53" width="82"/>
        </div>
    </div>
    </div>

    <!--这里是footer部分-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里是版权部分-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>