<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script>
        /*是否为空*/
        function checkEmpty(id, name){
            var val = $("#"+id).val().trim();
            if(val == ""){
                alert(name + "不能为空");
                return false;
            }
            return true;
        }

        /*删除前确认*/
        function confirmDeleteLink(){
            $("td.delete a").click(function () {
                var flag = confirm("确认要删除？");
                return flag;
            });
        }

        /*判断是否是数字，包括小数*/
        function isNumber(id,name){
            var value = $("#"+id).val();
            if (isNaN(value) || value == ""){
                alert(name + "只能是数字");
                return false;
            }
            return true;
        }

        /*判断是否是整数*/
        function isInteger(id,name) {
            var value = $("#"+id).val();
            var intRegExp = /^[0-9]+$/;
            if (!intRegExp.test(value)){
                alert(name + "只能是整数");
                return false;
            }
            return true;
        }

        /*货币格式化*/
        function moneyFormatting(value){
            value = value.toString();
            var pointFront = value.substring(0,value.indexOf("."));
            var pointBack = value.substring(value.indexOf("."));
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
    </script>

    <style>
        .tmallAdminNav .rightInfo span{
            margin-top: 10px;
            color: #EEEEEE;
            display: inline-block;
        }
        .tmallAdminNav .rightInfo #adminName{
            margin-right: 10px;
            font-size: 17px;
            font-weight: bold;
        }
        .tmallAdminNav .rightInfo a{
            font-size: 14px;
            text-decoration: none;
            margin-right: 20px;
            color: #EEEEEE;
        }
    </style>
</head>
<body>
    <nav class="tmallAdminNav" id="tmallAdminNav">
        <img class="tmallbuyPng" src="static/img/site/tmallbuy.png"/>
        <a href="#nowhere">天猫后台</a>
        <a href="admin/category/list">分类管理</a>
        <a href="admin/user/list">用户管理</a>
        <a href="admin/order/list">订单管理</a>
        <span class="pull-right rightInfo">
            <span>管理员：</span>
            <span id="adminName">${adminUser.name}</span>
            <a href="admin/user/exit">退出</a>
        </span>
    </nav>
</body>
</html>
