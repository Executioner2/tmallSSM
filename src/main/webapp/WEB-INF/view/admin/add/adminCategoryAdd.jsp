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
            if(!checkEmpty("categoryName", "分类名称")){
                return false;
            }
            if(!checkEmpty("image", "分类图片")){
                return false;
            }
            return true;
        }
    </script>
    <div id="categoryAddDiv" class="panel panel-warning categoryAddDiv addDiv">
        <div class="panel-heading">新增分类</div>
        <div class="panel-body">
            <form id="addForm" action="admin/category/add" method="post" enctype="multipart/form-data">
                <table class="addTable">
                    <tr>
                        <td>分类名称</td>
                        <td><input type="text" class="form-control" name="name" id="categoryName"></td>
                    </tr>
                    <tr>
                        <td>分类图片</td>
                        <td>
                            <input type="file" id="image" name="image" accept="image/*">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit" class="btn btn-success">提交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</body>
</html>
