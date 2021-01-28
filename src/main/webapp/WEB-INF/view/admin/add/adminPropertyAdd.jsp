<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
    <script>
        $(function () {
            $("#addForm").submit(isEmpty);
        });

        function isEmpty() {
            if(!checkEmpty("propertyName", "属性名称")){
                return false;
            }
            return true;
        }
    </script>
    <div id="propertyAddDiv" class="panel panel-warning propertyAddDiv addDiv">
        <div class="panel-heading">新增属性</div>
        <div class="panel-body">
            <form id="addForm" method="post" action="admin/property/add">
                <table class="addTable">
                    <tr>
                        <td>属性名称</td>
                        <td><input type="text" class="form-control" name="name" id="propertyName"></td>
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
