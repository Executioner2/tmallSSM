function checkEmpty(id, name){
    var val = $("#"+id).val().trim();
    if(val == ""){
        alert(name + "不能为空");
        return false;
    }
    return true;
}

function passwordCheck() {
    var password = $("#password").val().trim();
    var confirmPassword = $("#confirmPassword").val().trim();
    if(confirmPassword == ""){
        $(".confirmPasswordError").text("确认密码不能为空");
        $(".confirmPasswordError").show();
        passwordFlag = false;
        return passwordFlag;
    }
    if(password == confirmPassword){
        passwordFlag = password;
        return true;
    }else{
        $(".passwordError").hide();
    }
    $(".confirmPasswordError").text("两次密码不一致");
    $(".confirmPasswordError").show();
    passwordFlag = false;
    return passwordFlag;
}

function registerKeyCheck(){
    var registerKey = $("#registerKey").val().trim();
    var regExp = /^[A-Za-z0-9]+$/;
    if(registerKey.length < 6){
        $(".registerKeyError").text("注册码长度不足");
        $(".registerKeyError").show();
        registerKeyFlag = false;
        return registerKeyFlag;
    }
    if(regExp.test(registerKey)){
        registerKeyFlag = registerKey;
        registerKeyCheckRequest(registerKeyFlag);  //要改为同步请求，不然后面的registerKeyFlay有可能来不及更新值
        if(registerKeyFlag.id == null){
            $(".registerKeyError").text("注册码不存在");
            $(".registerKeyError").show();
            registerKeyFlag = false;
            return registerKeyFlag;
        }else{
            return true;
        }
    }
    $(".registerKeyError").text("注册码格式错误");
    $(".registerKeyError").show();
    registerKeyFlag = false;
    return registerKeyFlag;
}

function registerKeyCheckRequest(key){
    $.ajax({
        url:"admin/adminUser/checkKey",
        data:{key:key},
        type:"post",
        async:false,  //改为同步
        success:function (resp) {
            registerKeyFlag = resp;
        }
    });
}

function registerRequest() {
    if(registerKeyFlag != false && passwordFlag != false && userNameFlag != false){
        $.ajax({
            url:"admin/user/add",
            data:{password:passwordFlag, name:userNameFlag, uid:registerKeyFlag.id},
            type:"post",
            success:function (resp) {
                if(resp){
                    alert("注册成功");
                    window.location.href = "admin/loginPage";
                }else{
                    alert("注册失败");
                    window.location.href = "admin/register";
                }

            }
        });
    }
}

function userNameCheck() {
    var name = $(this).val().trim();
    if(name == "") {
        $(".userNameError").text("用户名不能为空");
        $(".userNameError").show();
        userNameFlag = false;
        return userNameFlag;
    }
    nameRepetitionCheck(name);
    if(!userNameFlag){
        userNameFlag = name;
    }else{
        $(".userNameError").text("用户名已被使用");
        $(".userNameError").show();
        userNameFlag = false;
    }
}

function nameRepetitionCheck(name) {
    $.ajax({
        url:"admin/name/check",
        data:{name:name},
        type:"post",
        async:false,
        success:function (resp) {
            userNameFlag = resp;
        }
    });
}