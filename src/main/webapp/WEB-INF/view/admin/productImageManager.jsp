<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>产品图片管理</title>
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
    <%@include file="public/adminHeader.jsp"%>

    <%--这里放面包屑导航--%>
    <div class="breadcrumb">
        <span><a href="admin/category/list">所有分类</a></span>
        <span class="gaySpan">/</span>
        <span><a href="admin/product/list?id=${product.category.id}">${product.category.name}</a></span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">${product.name}</span>
        <span class="gaySpan">/</span>
        <span class="gaySpanText">产品图片管理</span>
    </div>

    <%--这里放添加框和图片显示的table--%>
    <script>
        $(function () {
           $("#productImageManager #productImageAddLeft #addFormLeft").submit(function () {
               if(!checkEmpty("singleImageFile", "单个图片")){
                   return false;
               }
               return true;
           });

            $("#productImageManager #productImageAddRight #addFormRight").submit(function () {
                if(!checkEmpty("categoryImageFile", "详情图片")){
                    return false;
                }
                return true;
            });

            $("td.delete a").click(deleteRequest);
        });

        function deleteRequest() {
            var piid;

            if(confirm("确认要删除图片？")){
                piid = $(this).attr("piid");
                $.ajax({
                    url:"admin/productImage/delete",
                    data:{id:piid},
                    type:"post",
                    success:function (resp) {
                        alert(resp);
                        window.location.reload();
                    }
                });
            }
        }
    </script>
    <div id="productImageManager">
        <div id="productImageAddLeft" class="addDiv">
            <div class="panel panel-warning productImageAdd">
                <div class="panel-heading">新增产品
                    <b class="text-primary">单个</b>
                    图片
                </div>
                <form id="addFormLeft" class="addForm" action="admin/productImage/add" enctype="multipart/form-data" method="post">
                    <div class="hint">请选择本地图片 尺寸400X400 为佳</div>
                    <input type="hidden" name="type" value="singleImage">
                    <input type="hidden" name="pid" value="${product.id}">
                    <input id="singleImageFile" type="file" multiple="multiple" accept="image/*" name="images">
                    <button type="submit" class="btn btn-success">提交</button>
                </form>
            </div>
            <div id="productImageManagerLeft">
                <table class="table table-striped table-bordered table-hover  table-condensed">
                    <tr class="tableHead">
                        <th>ID</th>
                        <th>产品单个图片缩略图</th>
                        <th>删除</th>
                    </tr>
                    <c:forEach items="${productImageMap['singleImage']}" var="productImage" varStatus="st">
                        <tr class="productImageItem">
                            <td class="categoryId"><c:out value="${productImage.id}"></c:out></td>
                            <td class="categoryImage">
                                <img class="productSingleImage" height="50px" src="img/product/${product.id}/${productImage.type}/${productImage.id}.jpg"/>
                            </td>
                            <td class="delete"><a piid="${productImage.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>

        <div id="productImageAddRight" class="addDiv">
            <div class="panel panel-warning productImageAdd">
                <div class="panel-heading">新增产品
                    <b class="text-primary">详情</b>
                    图片
                </div>
                <form id="addFormRight" class="addForm" action="admin/productImage/add" enctype="multipart/form-data" method="post">
                    <div class="hint">请选择本地图片 宽度790 为佳</div>
                    <input type="hidden" name="type" value="detailsImage">
                    <input type="hidden" name="pid" value="${product.id}">
                    <input id="categoryImageFile" type="file" multiple="multiple" accept="image/*" name="images">
                    <button type="submit" class="btn btn-success">提交</button>
                </form>
            </div>
            <div id="productImageManagerRight">
                <table class="table table-striped table-bordered table-hover  table-condensed">
                    <tr class="tableHead">
                        <th>ID</th>
                        <th>产品单个图片缩略图</th>
                        <th>删除</th>
                    </tr>
                    <c:forEach items="${productImageMap['detailsImage']}" var="productImage" varStatus="st">
                        <tr class="productImageItem">
                            <td class="categoryId"><c:out value="${productImage.id}"></c:out></td>
                            <td class="categoryImage">
                                <img class="productDetailsImage" height="50px" src="img/product/${product.id}/${productImage.type}/${productImage.id}.jpg"/>
                            </td>
                            <td class="delete"><a piid="${productImage.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
