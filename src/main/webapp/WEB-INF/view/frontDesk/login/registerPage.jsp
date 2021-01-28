<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册页面</title>
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

    <!--这里放注册页面主体-->
    <script>
        $(function () {
            $("#registerPage #submitBtn").click(register);
        })

        function register() {
            var name = $("#username").val().trim();
            var pw = $("#password").val().trim();
            if(name == ""){
                $("#registerErrorMessageDiv #error").text("用户名不能为空");
                $("#registerErrorMessageDiv").css("visibility", "visible");
                return false;
            }else if(pw == ""){
                $("#registerErrorMessageDiv #error").text("密码不能为空");
                $("#registerErrorMessageDiv").css("visibility", "visible");
                return false;
            }
            if($("#affirmPassword").val() !== $("#password").val()){
                $("#registerErrorMessageDiv #error").text("两次密码不一致");
                $("#registerErrorMessageDiv").css("visibility", "visible");
                return false;
            }

            $.post(
                "register",
                {name:name, password:pw},
                function (resp) {
                    if (resp == "注册成功"){
                        alert(resp);
                        window.location.href = "loginPage";
                    }else{
                        $("#registerErrorMessageDiv #error").text(resp);
                        $("#registerErrorMessageDiv").css("visibility", "visible");
                    }
                }
            );

        }
    </script>
    <div class="registerErrorMessageDiv" id="registerErrorMessageDiv">
        <span id="error">用户名已被使用，不能使用</span>
    </div>
    <div class="registerPage" id="registerPage">
        <table>
            <tr>
                <td>
                    <span class="hint" id="hint1">设置会员名</span>
                </td>
            </tr>
            <tr>
                <td>登录名</td>
                <td><input type="text" id="username" name="username" placeholder="会员名一旦设置成功，无法修改"></td>
            </tr>
            <tr>
                <td>
                    <span class="hint" id="hint2">设置登录密码</span>
                </td>
                <td>登录时验证，保护账号信息</td>
            </tr>
            <tr>
                <td>登录密码</td>
                <td><input type="password" id="password" name="password" placeholder="设置你的登录密码"></td>
            </tr>
            <tr class="spaceTr">
                <td colspan="2"></td>
            </tr>
            <tr>
                <td>密码确认</td>
                <td><input type="password" id="affirmPassword" placeholder="请再次输入你的密码"></td>
            </tr>
            <tr class="spaceTr">
                <td colspan="2"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="button" id="submitBtn">提 交</button>
                </td>
            </tr>
        </table>
    </div>

    <!--这里放footer-->
    <%@include file="../publicPage/footerPage.jsp"%>

    <!--这里放copyright-->
    <%@include file="../publicPage/copyrightPage.jsp"%>
</body>
</body>
</html>