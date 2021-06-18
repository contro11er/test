<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script>
        jQuery(function ($) {

            //失去焦点时，发送ajax请求，判断用户是否存在，存在则保存按键不可用
            $("#code").blur(function () {
                var code = $("#code").val();
                if (code != '') {
                    $.ajax({
                        url: "/type/isExist.do?id=" + code,
                        success: function (result) {
                            if (result) {
                                alert("该用户名已存在，换一个");
                            }
                            $("#savebtn").prop('disabled', result);
                        }
                    });
                }
            });

            $("#savebtn").click(function () {
                var $code = $("#code").val();
                var $name = $("#name").val();
                if (!$code) {
                    alert("编码不能为空");
                    return;
                }
                if (/[\u4e00-\u9fa5]/.test($code)) {
                    alert("编码作为主键，不能是中文");
                    return;
                }
                if (!$name) {
                    alert("名称不能为空");
                    return;
                }
                $("#ediform").submit();
                // $.ajax({
                //     url: "/type/save.do",
                //     type: "post",
                //     // async:false,
                //     data: $("#ediform").serialize(),
                //     success: function (result) {
                //     }
                // });
            });
        });


    </script>
</head>
<body>

<div style="position:  relative; left: 30px;">
    <h3>新增字典类型</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button id="savebtn" type="button" class="btn btn-primary">保存</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form id="ediform" action="/type/save.do" method="post" class="form-horizontal" role="form">
    <div class="form-group">
        <label for="code" class="col-sm-2 control-label">编码<span style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input name="id" type="text" class="form-control" id="code" style="width: 200%;" placeholder="编码作为主键，不能是中文">
        </div>
    </div>
    <div class="form-group">
        <label for="name" class="col-sm-2 control-label">名称</label>
        <div class="col-sm-10" style="width: 300px;">
            <input name="name" type="text" class="form-control" id="name" style="width: 200%;">
        </div>
    </div>
    <div class="form-group">
        <label for="describe" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-10" style="width: 300px;">
            <textarea name="description" class="form-control" rows="3" id="describe" style="width: 200%;"></textarea>
        </div>
    </div>
</form>

<div style="height: 200px;"></div>
</body>
</html>