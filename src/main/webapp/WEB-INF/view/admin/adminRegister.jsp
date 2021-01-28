<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>天猫管理员账户注册</title>
    <base href="<%=basePath%>" />
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <script src="static/js/adminRegister.js" charset="UTF-8"></script>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/adminStyle.css">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</head>
<body>
    <script>
        var userNameFlag = false, passwordFlag = false, registerKeyFlag = false;

        $(function () {
            $("#registerBtn").click(registerRequest);
            $("#userName").blur(userNameCheck);

            $("#password").blur(function (){
                var cpw = $("#confirmPassword").val().trim();
                if($(this).val().trim() != cpw && cpw != ""){
                    $(".passwordError").text("两次密码不一致");
                    $(".passwordError").show();
                    passwordFlag = false;
                }else{
                    $(".confirmPasswordError").hide();
                    passwordFlag = cpw;
                }
            });
            $("#confirmPassword").blur(passwordCheck);
            $("#registerKey").blur(registerKeyCheck);

            $("#password").focus(function (){
                $(".passwordError").hide();
            });
            $("#confirmPassword").focus(function () {
                $(".confirmPasswordError").hide();
            });
            $("#registerKey").focus(function () {
                $(".registerKeyError").hide();
            });
            $("#userName").focus(function () {
               $(".userNameError").hide();
            });
        });

    </script>
    <div id="adminRegister" class="panel panel-warning">
        <div class="title panel-heading">
            <span>后台管理员注册</span>
        </div>
        <div class="panel-body>">
            <table>
                <tr>
                    <td>账号：</td>
                    <td><input type="text" id="userName" class="form-control" placeholder="请输入管理员账号"></td>
                    <td><span class="userNameError" style="color: #C40000; display: none"></span></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="password" id="password" class="form-control" placeholder="请输入管理员密码"></td>
                    <td><span class="passwordError" style="color: #C40000; display: none"></span></td>
                </tr>
                <tr>
                    <td>确认密码：</td>
                    <td><input type="password" id="confirmPassword" class="form-control" placeholder="请确认管理员密码"></td>
                    <td><span class="confirmPasswordError" style="color: #C40000; display: none"></span></td>
                </tr>
                <tr>
                    <td>注册码：</td>
                    <td><input type="text" id="registerKey" class="form-control" placeholder="请输入注册码"></td>
                    <td><span class="registerKeyError" style="color: #C40000; display: none"></span></td>
                </tr>
                <tr id="buttonTr">
                    <td colspan="2">
                        <button id="registerBtn" type="button" class="btn btn-success">确认注册</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>