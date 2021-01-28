<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
</head>
<body>
    <div id="searchBoxDiv">
    <a href="#">
        <img class="logo" src="static/img/site/logo.gif" height="130" width="290" id="logo"/>
    </a>
    <div class="searchRightDiv">
        <form action="search">
            <input type="text" placeholder="时尚男鞋 太阳镜" name="keyword">
            <button type="submit" class="searchButton">搜索</button>
        </form>
        <div class="searchBelow">
            <span><a href="classify?id=39">平衡车</a><span>|</span></span>
            <span><a href="classify?id=40">扫地机器人</a><span>|</span></span>
            <span><a href="classify?id=41">原汁机</a><span>|</span></span>
            <span><a href="classify?id=42">冰箱</a></span>
        </div>
    </div>
</div>
</body>
</html>