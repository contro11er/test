<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            $("#all").click(function () {
                $(":checkbox[name=tid]").prop("checked", this.checked);
            });

            $(":checkbox[name=tid]").click(function () {
                $("#all").prop("checked", $(":checkbox[name=tid]:checked").length == $(":checkbox[name=tid]").length);
            });

            $("#editbtn").click(function () {
                if ($(":checkbox[name=tid]:checked").length != 1) {
                    alert("请选择一行编辑");
                    return;
                }
                var $prop = $(":checkbox[name=tid]:checked").map(function (value) {
                    return this.value;
                }).get();

                location = "/type/getTypeById.do?id=" + $prop[0];

            });

            $("#delbtn").click(function () {
                if ($(":checkbox[name=tid]:checked").length == 0) {
                    alert("请选择至少一行");
                    return;
                }
                if (!confirm("确定删除吗？")) return;
                //map方法用于弄成数组
                //jq数组对象转换成js用get()
                //join方法把数组合在一起，用指定符号分割
                var $prop = $(":checkbox[name=tid]:checked").map(function () {
                    return this.value;
                }).get().join(",");

                location = "/type/delType.do?ids=" + $prop;
                // $.ajax({
                //     url: "/type/delType.do?ids=" + $prop
                // });
            });
        });

    </script>

</head>
<body>

<div>
    <div style="position: relative; left: 30px; top: -10px;">
        <div class="page-header">
            <h3>字典类型列表</h3>
        </div>
    </div>
</div>
<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
    <div class="btn-group" style="position: relative; top: 18%;">
        <button type="button" class="btn btn-primary"
                onclick="window.location.href='/settings/dictionary/type/save.html'"><span
                class="glyphicon glyphicon-plus"></span> 创建
        </button>
        <button id="editbtn" type="button" class="btn btn-default"><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button id="delbtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>
<div style="position: relative; left: 30px; top: 20px;">
    <table class="table table-hover">
        <thead>
        <tr style="color: #B3B3B3;">
            <td><input id="all" type="checkbox"/></td>
            <td>序号</td>
            <td>编码</td>
            <td>名称</td>
            <td>描述</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${type}" var="t" varStatus="tt">
            <tr>
                <td><input name="tid" type="checkbox" value="${t.id}"/></td>
                <td>${tt.count}</td>
                <td>${t.id}</td>
                <td>${t.name}</td>
                <td>${t.description}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>