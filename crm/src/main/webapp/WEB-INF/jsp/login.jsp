<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        jQuery(function ($) {
            $("#dlbtn").click(function () {
                var account = $("#account").val();
                var pwd = $("#pwd").val();
                if (account == "") {
                    alert("请输入账号!")
                    return;
                }
                if (pwd == "") {
                    alert("请输入密码!")
                    return;
                }

                $.ajax({
                    url: "/user/login.do",
                    data: {
                        loginAct: account,
                        loginPwd: pwd,
                        checked: $("#mdl").prop("checked")
                    },
                    dataType: "json",
                    type: "post",
                    success: function (result) {
                        if (result.success) {
                            if (${not empty param.redirectUrl}) {
                                //decodeURIComponentUrl  还原处理过的url
                                location = decodeURIComponent("${param.redirectUrl}");
                            } else {
                                location = "/workbench/index.html";
                            }
                        }
                        if (result.msg) {
                            alert(result.msg);
                        }
                    }
                });
            });
        });
    </script>

</head>
<body>
<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
    <img src="/static/image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form id="dl" class="form-horizontal" role="form">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input id="account" class="form-control" type="text" name="loginAct" value="10086"
                           placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input id="pwd" class="form-control" type="password" name="loginPwd" value="123" placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;">
                    <label>
                        <input type="checkbox" id="mdl"> 十天内免登录
                    </label>
                </div>
                <button id="dlbtn" type="button" class="btn btn-primary btn-lg btn-block"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>