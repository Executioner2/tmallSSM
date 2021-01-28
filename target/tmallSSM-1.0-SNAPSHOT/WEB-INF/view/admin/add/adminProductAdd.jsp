<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
    <script>
        $(function () {
            $("#productAddDiv #addForm").submit(function () {
                if(!checkEmpty("productName","产品名称")){
                    return false;
                }else if(!isNumber("productOrignalPrice","原价格")){
                    return false;
                }else if(!isNumber("productPromotePrice","优惠价格")){
                    return false;
                }else if(!isInteger("productStock","库存")){
                    return false;
                }
                return true;
            });
        });

    </script>
    <div id="productAddDiv" class="panel panel-warning productAddDiv addDiv">
        <div class="panel-heading">新增产品</div>
        <div class="panel-body">
            <form id="addForm" action="admin/product/add" method="post">
                <table class="addTable">
                    <tr>
                        <td>产品名称</td>
                        <td>
                            <input type="text" class="form-control" name="name" id="productName">
                        </td>
                    </tr>
                    <tr>
                        <td>产品小标题</td>
                        <td>
                            <input type="text" class="form-control" name="subTitle" id="productSubTitle">
                        </td>
                    </tr>
                    <tr>
                        <td>原价格</td>
                        <td>
                            <input type="text" class="form-control" name="orignalPrice" id="productOrignalPrice">
                        </td>
                    </tr>
                    <tr>
                        <td>优惠价格</td>
                        <td>
                            <input type="text" class="form-control" name="promotePrice" id="productPromotePrice">
                        </td>
                    </tr>
                    <tr>
                        <td>库存</td>
                        <td>
                            <input type="text" class="form-control" name="stock" id="productStock">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="hidden" name="cid" value="${category.id}">
                            <button type="submit" class="btn btn-success">提交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</body>
</html>
