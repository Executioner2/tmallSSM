<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script>
        $(function () {
            autoFormatMone();
        })

        function autoFormatMone() {
            $(".formatMoney").each(function () {
                $(this).text("￥" + moneyFormatting($(this).text()));
            });
        }

        /*货币格式化*/
        function moneyFormatting(value){
            value = value.toString().trim();
            var pointFront;
            var pointBack;
            if(value.indexOf('.') != -1){
                pointFront = value.substring(0,value.indexOf("."));
                pointBack = value.substring(value.indexOf("."));
            }else{
                pointFront = value;
                pointBack = "";
            }
            var arrays = new Array();
            for (var i = 0; i < pointFront.length; i++) {
                if((i - pointFront.length % 3) % 3 == 0 && i != 0){
                    arrays += ',';
                }
                arrays += pointFront[i];
            }
            arrays += pointBack;
            return arrays.toString();
        }

        /*是否为空*/
        function checkEmpty(id, name){
            var val = $("#"+id).val();
            if(val == ""){
                alert(name + "不能为空");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <nav class="top">
    <div class="navTopDiv">
        <a href="home">
            <span class="glyphicon glyphicon-home redColor"></span>天猫首页
        </a>
        <span>喵，欢迎来天猫</span>
        <a href="loginPage">
            <c:if test="${user != null}">
                <c:out value="${user.name}"></c:out>
                <a href="user/quit">退出</a>
            </c:if>
            <c:if test="${user == null}">
                <c:out value="请登录"></c:out>
                <a href="registerPage">免费注册</a>
            </c:if>
        </a>
        <span class="pull-right">
            <a href="user/order/list">我的订单</a>
            <a href="user/shopping">
                <span class="glyphicon glyphicon-shopping-cart redColor"></span>购物车<strong id="orderItemNumber">0</strong>件
            </a>
        </span>
    </div>
</nav>
    <script>
        $(function () {
            var number = "${user.orderItemNumber}";
            if(number != null && number != ""){
                $(".navTopDiv #orderItemNumber").text(number);
            }
        })
    </script>
</body>
</html>