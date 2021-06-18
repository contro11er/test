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

    <script type="text/javascript">
        jQuery(function ($) {
            $("#savebtn").click(function () {
               $("#editform").submit();
            });
        })
    </script>

</head>
<body>

<div style="position:  relative; left: 30px;">
    <h3>修改字典类型</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button id="savebtn" type="button" class="btn btn-primary">更新</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form id="editform" class="form-horizontal" role="form" action="/type/update.do" method="post">

    <div class="form-group">
        <label for="code" class="col-sm-2 control-label">编码<span style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input name="id" type="text" class="form-control" id="code" style="width: 200%;"
                   value="${type.id}" readonly>
        </div>
    </div>

    <div class="form-group">
        <label for="name" class="col-sm-2 control-label">名称</label>
        <div class="col-sm-10" style="width: 300px;">
            <input name="name" type="text" class="form-control" id="name" style="width: 200%;" value="${type.name}">
        </div>
    </div>

    <div class="form-group">
        <label for="describe" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-10" style="width: 300px;">
            <textarea name="description" class="form-control" rows="3" id="describe"
                      style="width: 200%;">${type.description}</textarea>
        </div>
    </div>
</form>

<div style="height: 200px;"></div>
</body>
</html>