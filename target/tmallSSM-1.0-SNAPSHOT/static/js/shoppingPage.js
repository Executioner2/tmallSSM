/*全选*/
function fullSelect() {
    var cartPullSelectrctSrc = $(".cartPullSelect").attr("src");
    var productNumberSum = 0;
    if(cartPullSelectrctSrc.indexOf("cartSelected.png") == -1){  /*如果没选中*/
        $(".cartPullSelect").attr("src","static/img/site/cartSelected.png");
        $(".cartSelect").attr("src","static/img/site/cartSelected.png");
        var tableBody= $("#orderItemContentTable .tableBody");
        tableBody.each(function (index) {
            $(this).css("background-color","#FFF8E1");
            totalAmount += parseFloat($(".tableBody :eq("+index+")").attr("productMoney"));
            productNumberSum += parseInt(parseFloat($(".tableBody :eq("+index+") .productNumber").val()));
        });
        $("input.orderItems").attr("name","orderItems");
    }else{
        $(".cartPullSelect").attr("src","static/img/site/cartNotSelected.png");
        $(".cartSelect").attr("src","static/img/site/cartNotSelected.png");
        var tableBody= $("#orderItemContentTable .tableBody");
        tableBody.each(function () {
            $(this).css("background-color","white");
        });
        $("input.orderItems").removeAttr("name");
    }
    var totalAmount = totalPriceSum();
    if(totalAmount != 0){
        $(".settleAccountBtn").attr("disabled",false);
        $(".settleAccountBtn").css("background-color","#C40000");
    }else{
        $(".settleAccountBtn").attr("disabled",true);
        $(".settleAccountBtn").css("background-color","#AAAAAA");
    }
    $("#settieAccountsButton .totalAmount").attr("totalAmount", totalAmount);
    totalAmount = moneyFormatting(totalAmount);
    $("#settieAccountsButton .totalAmount").text("￥" + totalAmount);
    $("#settieAccountsButton .productNumberSum").text(productNumberSum);
}

/*单选*/
function multipleChoice(){
    var trNum = $("#orderItemContentTable tr").length - 1;
    var selectedNum = 0;
    var tr = this.parentNode.parentNode.parentNode;
    var productNumber = parseInt($("#orderItemContentTable tr:eq("+tr.rowIndex+") .productNumber").val());
    var productNumberSum = parseInt($("#settieAccountsButton .productNumberSum").text());
    var oiid = $(this).attr("oiid");
    if($(this).attr("src").indexOf("cartSelected.png") == -1){
        $(this).attr("src","static/img/site/cartSelected.png");
        tr.style.backgroundColor = "#FFF8E1";
        productNumberSum += productNumber;
        $("#input"+oiid+"").attr("name","orderItems");
    }else{
        $(this).attr("src","static/img/site/cartNotSelected.png");
        $(".cartPullSelect").attr("src","static/img/site/cartNotSelected.png");
        tr.style.backgroundColor = "white";
        productNumberSum -= productNumber;
        $("#input"+oiid+"").removeAttr("name");
    }
    var totalAmount = totalPriceSum();
    if(totalAmount != 0){
        $(".settleAccountBtn").attr("disabled",false);
        $(".settleAccountBtn").css("background-color","#C40000");
    }else{
        $(".settleAccountBtn").attr("disabled",true);
        $(".settleAccountBtn").css("background-color","#AAAAAA");
    }
    $("#settieAccountsButton .totalAmount").attr("totalAmount", totalAmount);
    totalAmount = moneyFormatting(totalAmount);
    $("#settieAccountsButton .totalAmount").text("￥" + totalAmount);
    $("#settieAccountsButton .productNumberSum").text(productNumberSum);

    for (var i = 0; i < trNum; i++) {
        if($("#orderItemContentTable tr:eq("+(i+1)+") .cartSelect").attr("src").indexOf("cartNotSelected.png") == -1){
            selectedNum++;
        }
    }
    if(selectedNum == 0){
    }else if(selectedNum == trNum){
        $(".cartPullSelect").attr("src","static/img/site/cartSelected.png");
    }
}

/*遍历计算总金额*/
function totalPriceSum() {
    var productNumberSum = 0;
    $(".tableBody").each(function (index) {
        if($(".tableBody:eq("+index+") .cartSelect").attr("src").indexOf("cartNotSelected.png") == -1){
            var productNumber = parseFloat($(".tableBody:eq("+index+")").attr("productMoney"));
            productNumberSum += productNumber;
        }
    });
    return productNumberSum.toFixed(2);
}

/*计算金额*/
function initProductMoney(){
    var tr = $("#orderItemContentTable tr");
    tr.each(function (index) {
        if(index > 0) {
            var price = $("#orderItemContent tr:eq("+index+")").attr("price");
            var number = $("#orderItemContent tr:eq("+index+") .productNumber").val();
            var money = price * number;
            money = money.toFixed(2);
            $("#orderItemContent tr:eq("+index+")").attr("productMoney",money);
            money = moneyFormatting(money);
            $("#orderItemContent tr:eq("+index+") .productMoney").text(money);
        }
    })
}

/*输入产品数量*/
function productNumberFun(){
    var index = this.parentNode.parentNode.parentNode.parentNode.rowIndex;
    var inventory = parseInt($("#orderItemContentTable tr:eq("+index+")").attr("inventory"));
    $(this).val(parseInt($(this).val()));
    if(isNaN($(this).val()) || $(this).val() == "" || $(this).val() == 0){
        $(this).val(1);
    }else if($(this).val() > inventory){
        $(this).val(inventory);
    }
    initProductMoney();
}

/*产品数量+1*/
function productNumberAdd(){
    var index = this.parentNode.parentNode.parentNode.rowIndex;
    var inventory = parseInt($("#orderItemContentTable tr:eq("+index+")").attr("inventory"));
    var tr = $("#orderItemContentTable tr:eq("+index+") .productNumber");
    var oiid = $(this).attr("oiid");
    if(parseInt(tr.val()) <= inventory){
        tr.val(parseInt(tr.val())+1);
    }
    numberUpdate(oiid);
    initProductMoney();
}

/*产品数量—1*/
function productNumberSub(){
    var index = this.parentNode.parentNode.parentNode.rowIndex;
    var tr = $("#orderItemContentTable tr:eq("+index+") .productNumber");
    var oiid = $(this).attr("oiid");
    if(parseInt(tr.val()) > 1){
        tr.val(parseInt(tr.val())-1);
    }
    numberUpdate(oiid);
    initProductMoney();
}

/*产品数量更新*/
function numberUpdate(oiid){
    var number = $("#number"+oiid+"").val();
    $.post(
        "user/orderItem/update",
        {id:oiid,number:number},
        function (resp) {

        },
        "json"
    );
}

/*删除当前产品项*/
function deleteProductItem() {
    var oiid = $(this).attr("oiid");

    if(confirm("确定要删除？")){
        $.post(
            "user/orderItem/delete",
            {id:oiid},
            function (resp) {
                if(resp){
                    window.location.reload();
                }else{
                    alert("删除订单失败");
                }
            },
            "json"
        );
    }
}