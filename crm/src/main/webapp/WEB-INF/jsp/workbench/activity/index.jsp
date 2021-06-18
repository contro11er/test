<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/jsp/home/jspproperties.jsp" %>
</head>

<script type="text/javascript">

    $(function () {

        $(":input[date]").datetimepicker({
            minView: "month",
            language: 'zh-CN',
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true
        });

        //加载下拉列表
        $.ajax({
            url: "/user/getList.json",
            success: function (result) {
                $(result).each(function () {
                    $("<option>" + this.loginAct + "(" + this.name + ")" + "</option>").appendTo("#create-marketActivityOwner,#edit-marketActivityOwner");
                });
            }
        });

        //定制字段
        $("#definedColumns > li").click(function (e) {
            //防止下拉菜单消失
            e.stopPropagation();
        });

        $("#searchBtn").click(function () {
            $("#searchForm").submit();
        });

        //ajaxForm
        $("#searchForm").ajaxForm(function (result) {
            html = "";
            $(result).each(function () {
                html += `<tr>
                           <td><input type="checkbox" name="cb" value="` + this.id + `"/></td>
                           <td><a data-target="` + this.id + `" style='text-decoration:none;cursor:pointer;'> ` + this.name + ` </td>
                           <td> ` + this.owner + ` </td>
                           <td> ` + this.startDate + ` </td>
                           <td> ` + this.endDate + ` </td>
                         </tr>`
            });
            $("#tb").html(html);
        }).submit();

        $("#tb").on("click", "a[data-target]", function () {
            location = "/workbench/activity/detail.html?id=" + $(this).data("target");
        });

        $("#clickAll").click(function () {
            $(":checkbox[name=cb]").prop("checked", this.checked);
        });

        $("#tb").on("click", ":checkbox[name=cb]", function () {
            $("#clickAll").prop("checked", $(":checkbox[name=cb]").length == $(":checkbox[name=cb]:checked").length);
        });

        $("#addSubmitBtn").click(function () {
            //  检查是否输入内容....
            $("#addForm").submit();
        });

        $("#updateBtn").click(function () {
            var $checkbox = $(":checkbox[name=cb]:checked");
            if ($checkbox.length != 1) {
                alert("只选一项修改！");
                return;
            }
            $("#editActivityModal").modal("show");
            //数据回显
            $("#updateForm").initForm("/activities/getActivitiesById.json?id=" + $checkbox.val());
        });

        $("#updateSubmitBtn").click(function () {
            //  检查是否输入内容....
            $("#updateForm").submit();
        });

        $("#addForm,#updateForm").ajaxForm(function (result) {
            $("div.modal:visible").modal("hide");
            $("#addForm").get(0).reset();
            $("#searchForm").submit();
            alert(result.msg);
        });

        $("#delBtn").click(function () {
            var $checkbox = $(":checkbox[name=cb]:checked");
            if ($checkbox.length == 0) {
                alert("请选择至少一项删除!");
                return;
            }
            if (!confirm("确定要删除吗?")) return;
            var ids = $(":checkbox[name=cb]:checked").map(function () {
                return this.value;
            }).get().join(",");

            $.ajax({
                url: "/activities/del.do?ids=" + ids,
                success: function (result) {
                    alert(result.success);
                    $("#searchForm").submit();
                }
            });
        });

        //    导出
        $("#exportBtn").click(function () {
            //直接发送请求，下载对应的资源文件
            location = "/activities/export.do";
        });
        //    导入
        $("#importBtn").click(function () {
            //手动创建一个表单
            var data = new FormData();
            //把file的文件加入到表单当中
            var files = $("#uploadBtn").prop("files");
            //虽然只有一个文件，但是它是数组
            data.append("mf", files[0]);
            $.ajax({
                url: "/activities/import.do",
                type: "post",
                //ajax上传必须设置这两个属性
                contentType: false, processData: false,
                data: data,
                success: function (result) {
                    alert(result.msg);
                    $("div.modal:visible").modal("hide");
                    $("#searchForm").submit();
                }
            });
        });

        $("#uploadFileBtn").click(function () {
            location = "/activities/download.do";
        });

    });
</script>

<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="addForm" action="/activities/add.do" method="post" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select name="owner" class="form-control" id="create-marketActivityOwner">
                                <option></option>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="name" type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="startDate" type="text" date class="form-control" id="create-startTime">
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="endDate" type="text" date class="form-control" id="create-endTime">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="cost" type="text" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea name="description" class="form-control" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="addSubmitBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="updateForm" action="/activities/update.do" method="put" class="form-horizontal" role="form">
                    <input type="hidden" name="id">
                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select name="owner" class="form-control" id="edit-marketActivityOwner">
                                <option></option>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="name" type="text" class="form-control" id="edit-marketActivityName"
                            >
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input date name="startDate" type="text" class="form-control" id="edit-startTime">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input date name="endDate" type="text" class="form-control" id="edit-endTime">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="cost" type="text" class="form-control" id="edit-cost">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea name="description" class="form-control" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateSubmitBtn" type="button" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 导入市场活动的模态窗口 -->
<div class="modal fade" id="importActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：
                    <small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input id="uploadBtn" name="mf" type="file">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;">
                    <h3>重要提示</h3>
                    <ul>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>从XLS/XLSX文件中导入全部重复记录之前都会被忽略。</li>
                        <li>复选框值应该是1或者0。</li>
                        <li>日期值必须为MM/dd/yyyy格式。任何其它格式的日期都将被忽略。</li>
                        <li>日期时间必须符合MM/dd/yyyy hh:mm:ss的格式，其它格式的日期时间将被忽略。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="importBtn" type="button" class="btn btn-primary" data-dismiss="modal">导入</button>
            </div>
        </div>
    </div>
</div>

<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form id="searchForm" action="/activities/getList.json" method="post" class="form-inline" role="form"
                  style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input name="name" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input name="owner" class="form-control" type="text">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input name="startDate" date class="form-control" type="text" id="startTime"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input name="endDate" date class="form-control" type="text" id="endTime">
                    </div>
                </div>

                <button id="searchBtn" type="button" class="btn btn-default">查询</button>
                <button type="reset" class="btn btn-default">重置条件</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="createBtn" type="button" class="btn btn-primary" data-toggle="modal"
                        data-target="#createActivityModal">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button id="updateBtn" type="button" class="btn btn-default" data-toggle="modal">
                    <span class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button id="delBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span>
                    删除
                </button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal">
                    <span class="glyphicon glyphicon-import"></span> 导入
                </button>
                <button id="exportBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 导出
                </button>
                <button id="uploadFileBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载测试
                </button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="clickAll"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="tb">
                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">
            <div>
                <button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
            </div>
            <div class="btn-group" style="position: relative;top: -34px; left: 110px;">
                <button type="button" class="btn btn-default" style="cursor: default;">显示</button>
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        10
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">20</a></li>
                        <li><a href="#">30</a></li>
                    </ul>
                </div>
                <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
            </div>
            <div style="position: relative;top: -88px; left: 285px;">
                <nav>
                    <ul class="pagination">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled"><a href="#">上一页</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">下一页</a></li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>

</div>
</body>
</html>