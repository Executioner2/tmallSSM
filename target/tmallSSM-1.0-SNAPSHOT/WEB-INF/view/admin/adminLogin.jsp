
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
            + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>天猫后台管理员登录</title>
    <base href="<%=basePath%>" />
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/adminStyle.css" />
    <link rel="stylesheet" href="static/css/bootstrap.min.css" />
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <style>
        #adminLogin{
            margin: 100px auto;
            min-width: 350px;
            width: 350px;
        }

        #adminLogin table{
            width: 80%;
            margin: 10px auto;
            height: 130px;
            text-align: center;
        }

        #adminLogin table #buttonTr input{
            display: inline-block;
            margin: 0px 10px;
        }
    </style>
</head>
<body>
    <script>
        $(function () {
            $("#adminLogin #loginBtn").click(loginRequest);
        });

        function loginRequest() {
            if(!checkEmpty("userName", "用户名")){
               return ;
            }
            if(!checkEmpty("password", "密码")){
                return ;
            }
            var name = $("#adminLogin #userName").val();
            var password = $("#adminLogin #password").val();
            $.ajax({
                url:"admin/user/login",
                data:{name:name, password:password},
                type:"post",
                success:function (resp) {
                    if(resp){
                        window.location.href = "admin/category/list";
                    }else{
                        $("#adminLogin .loginError").show();
                    }
                }

            });
        }

        function checkEmpty(id, name){
            var val = $("#"+id).val().trim();
            if(val == ""){
                alert(name + "不能为空");
                return false;
            }
            return true;
        }
    </script>
    <div id="adminLogin" class="panel panel-warning">
        <div class="title panel-heading">
            <span>后台管理员登录</span>
            <span class="loginError pull-right" style="color: #C40000; display: none">用户名或密码错误</span>
        </div>
        <div class="panel-body>">
            <table>
                <tr>
                    <td>账号：</td>
                    <td><input type="text" id="userName" class="form-control" placeholder="请输入管理员账号"></td>
                </tr>
                <tr>
                    <td>密码：</td>
                    <td><input type="password" id="password" class="form-control" placeholder="请输入管理员密码"></td>
                </tr>
                <tr id="buttonTr">
                    <td colspan="2">
                        <a href="admin/register"><button id="registerBtn" type="button" class="btn btn-success">注册</button></a>
                        <input id="loginBtn" type="button" class="btn btn-success" value="登录">
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>