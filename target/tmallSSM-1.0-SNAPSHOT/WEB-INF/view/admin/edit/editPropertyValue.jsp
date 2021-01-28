<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>编辑产品属性值</title>
    <base href="<%=basePath%>" />
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/bootstrap.min.css">
    <link rel="stylesheet" href="static/css/adminStyle.css">
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
</head>
<body>
    <%--这里放nav--%>
    <%@include file="../public/adminHeader.jsp"%>

    <%--这里放面包屑导航--%>
    <div class="breadcrumb">
        <span><a href="admin/category/list">所有分类</a></span>
        <span class="gaySpan">/</span>
        <span><a href="admin/product/list?id=${product.category.id}">${product.category.name}</a></span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">${product.name}</span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">编辑产品属性</span>
    </div>

    <script>
        $(function () {
            $("#editPropertyValue .productValue").blur(updatePropertyValue);
            $("#editPropertyValue .productValue").focus(function () {
                $("#editPropertyValue .productValue").css("border-color","#D3D3D3");
            });
        });

        function updatePropertyValue() {
            var id = this.name;
            var value = this.value;
            $.post(
                "admin/propertyValue/update",
                {id:id, value:value},
                function (resp) {
                    if(resp){
                        $("#"+id+"").css("border-color","green");
                    }else{
                        $("#"+id+"").css("border-color","red");
                    }
                },
                "json"
            );
        }
    </script>

    <%--这里放属性值编辑框--%>
    <div class="editPropertyValue" id="editPropertyValue">
        <div class="editDiv">
            <c:forEach items="${propertyValues}"  var="pv" varStatus="st">
                <div class="editItem">
                    <div class="propertyName">${pv.property.name}</div>
                    <div><input type="text" class="productValue" name="${pv.id}" id="${pv.id}" value="${pv.value}"></div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
