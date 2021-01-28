<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登陆页面</title>
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
    <!--这里放登录页面主体部分-->
    <script>
        $(function () {
            $("#loginBtn").click(login);
            $(window).click(function () {
                $(".errorHint").css("visibility", "hidden");
            });
        });

        function login() {
            var name = $("#username").val();
            var pw = $("#password").val();
            $.post(
                "login",
                {name:name,password:pw},
                function (resp) {
                  if(resp){
                      $(location).attr("href","home");
                  }else{
                      $(".errorHint").css("visibility", "visible");
                  }
                },
                "json"
            );
        }
    </script>
    <div class="loginPage" id="loginPage">
        <a class="simpleLogo" href="#"><img src="static/img/site/simpleLogo.png" height="27" width="190"/></a>
        <div style="clear: both"></div>
        <div class="mainBodyDiv">
            <img class="loginBackground" src="static/img/site/loginBackground.png" height="600" width="1190"/>
            <div class="loginInputBox">
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
                    <span class="forgetLoginPassword"><a href="#">忘记登录密码</a></span>
                    <span class="freeRegister"><a href="registerPage">免费注册</a></span>
                    <div style="clear: both"></div>
                </div>
                <button id="loginBtn">登录</button>
            </div>
        </div>
    </div>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</html>