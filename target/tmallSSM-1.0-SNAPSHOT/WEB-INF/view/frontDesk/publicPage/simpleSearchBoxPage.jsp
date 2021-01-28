<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
</head>
<body>
    <div class="simpleSearchBox" id="simpleSearchBox">
    <a href="#">
        <img class="logo" id="simpelLogo" src="static/img/site/simpleLogo.png"/>
    </a>
    <div class="pull-right">
        <form action="search">
            <div class="searchDiv">
                <input type="text" name="keyword" placeholder="平衡车 原汁机">
                <button type="submit" class="searchButton">搜天猫</button>
            </div>
        </form>
        <div class="searchBelow">
            <span><a href="classify?id=42">冰箱</a><span>|</span></span>
            <span><a href="classify?id=43">空调</a><span>|</span></span>
            <span><a href="classify?id=44">女表</a><span>|</span></span>
            <span><a href="classify?id=45">男表</a></span>
        </div>
    </div>
</div>
</body>
</html>