<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/jsp/home/jspproperties.jsp" %>
    <script type="text/javascript">
        jQuery(function ($) {
            $("#edibtn").click(function () {
                var $checkbox = $(":checkbox[name=vc]:checked");
                if ($checkbox.length != 1) {
                    alert("选择至少一行");
                    return;
                }

                var $value = $checkbox.map(function () {
                    return this.value
                }).get(0);
                location = "/value/getValueByid.do?id=" + $value;
            });

            $("#delbtn").click(function () {
                var $checkbox = $(":checkbox[name=vc]:checked");
                if ($checkbox.length==0) {
                    alert("选择至少一行");
                    return;
                }

                var $value = $checkbox.map(function () {
                    return this.value
                }).get().join(",");
                location = "/value/del.do?id=" + $value;
            });
        });
    </script>
</head>
<body>

<div>
    <div style="position: relative; left: 30px; top: -10px;">
        <div class="page-header">
            <h3>字典值列表</h3>
        </div>
    </div>
</div>
<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
    <div class="btn-group" style="position: relative; top: 18%;">
        <button type="button" class="btn btn-primary" onclick="window.location.href='/value/save.html'"><span
                class="glyphicon glyphicon-plus"></span> 创建
        </button>
        <button id="edibtn" type="button" class="btn btn-default"><span
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
            <td><input type="checkbox"/></td>
            <td>序号</td>
            <td>字典值</td>
            <td>文本</td>
            <td>排序号</td>
            <td>字典类型编码</td>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${valueList}" var="list" varStatus="l">
            <tr>
                <td><input name="vc" type="checkbox" value="${list.id}"/></td>
                <td>${l.count}</td>
                <td>${list.value}</td>
                <td>${list.text}</td>
                <td>${list.orderNo}</td>
                <td>${list.tid}</td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>

</body>
</html>