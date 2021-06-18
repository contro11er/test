<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/jsp/home/jspproperties.jsp" %>
</head>

<script type="text/javascript">
    jQuery(function ($) {
        //加载页面数据
        function load() {
            $.ajax({
                url: "/dept/getAll.json",
                success: function (result) {
                    var html = "";
                    $(result).each(function () {
                        html += '<tr>';
                        html += '<td><input name="cb" type="checkbox" value="' + this.id + '"/></td>';
                        html += '<td>' + this.no + '</td>';
                        html += '<td>' + this.name + '</td>';
                        html += '<td>' + this.manager + '</td>';
                        html += '<td>' + this.phone + '</td>';
                        html += '<td>' + this.description + '</td>';
                        html += '</tr>';
                    });
                    //别忘记了要把拼接的元素加到对应的地方那里！！
                    $("#databody").html(html);
                }
            });
        }

        load();

        //创建
        $("#savebtn").click(function () {
            var val = $("#createcode").val();
            if (val == '') {
                alert("请输入编号");
                return;
            }
            if (!/^\d{4}$/.test(val)) {
                alert("请检查编号格式");
                return;
            }
            //手动提交表单,普通的提交，不是ajax方式
            $("#saveForm").submit();

            //以ajax的方式立即提交
            // $("#saveForm").ajaxSubmit({
            //     success: function (result) {
            //         if (result){
            //             alert("添加成功!");
            //             load();
            //         }
            //     }
            // });
        });

        // 监听表单的提交事件(此时不会提交)：提交时，以ajax的方式来提交
        $("#saveForm").ajaxForm(function (result) {
            if (result) {
                alert("操作成功!");
                $("div.modal").modal("hide");
                $("#saveForm").get(0).reset();
                load();
            }
        });

        // //全选/不选
        $("#allbtn").click(function () {
            $(":checkbox[name=cb]").prop("checked", this.checked);
        });

        $("#databody").on("click", ":checkbox[name=cb]", function () {
            $("#allbtn").prop("checked", $(":checkbox[name=cb]").length == $(":checkbox[name=cb]:checked").length);
        });

        $("#editBtn").click(function () {
            if ($(":checkbox[name=cb]:checked").length != 1) {
                alert("请选择一行编辑!");
                return;
            }
            var $val = $(":checkbox[name=cb]:checked").val();
            //发送ajax数据回显
            $("#updateForm").initForm("/dept/getDeptById.json?id=" + $val);
            // $.ajax({
            //     url: "/dept/getDeptById.json?id=" + $val,
            //     success: function (result) {
            //         $("#input[name=id]").val(result.id);
            //         $(":input[name=no]").val(result.no);
            //         $(":input[name=name]").val(result.name);
            //         $(":input[name=manager]").val(result.manager);
            //         $(":input[name=description]").val(result.description);
            //         $(":input[name=phone]").val(result.phone);
            //
            //         $(":input[name]").each(function () {
            //             $(":input[name="+this.name +"]").val(result[this.name]);
            //         });
            //     }
            // });
            $("#editDeptModal").modal("show");
        });

        $("#updateBtn").click(function () {
            //判断是否非空等条件
            $("#updateForm").submit();
        });

        $("#updateForm").ajaxForm({
            type: "post",
            success: function (result) {
                load();
            }
        });

        $("#delBtn").click(function () {
            var $checkbox = $(":checkbox[name=cb]:checked");
            if ($checkbox.length == 0) {
                alert("请选择至少一个删除");
                return;
            }
            var ids = $checkbox.map(function () {
                return this.value
            }).get().join(",");

            $.ajax({
                url: "/dept/del.json?ids=" + ids,
                type: "post",
                success: function (result) {
                    load();
                    alert("ok");
                }
            });

        });

    });
</script>

<body>

<!-- 我的资料 -->
<div class="modal fade" id="myInformation" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">我的资料</h4>
            </div>
            <div class="modal-body">
                <div style="position: relative; left: 40px;">
                    姓名：<b>张三</b><br><br>
                    登录帐号：<b>zhangsan</b><br><br>
                    组织机构：<b>1005，市场部，二级部门</b><br><br>
                    邮箱：<b>zhangsan@bjpowernode.com</b><br><br>
                    失效时间：<b>2017-02-14 10:10:10</b><br><br>
                    允许访问IP：<b>127.0.0.1,192.168.100.2</b>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改密码的模态窗口 -->
<div class="modal fade" id="editPwdModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 70%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改密码</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="oldPwd" class="col-sm-2 control-label">原密码</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="oldPwd" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="newPwd" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal"
                        onclick="window.location.href='../login.html';">更新
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 退出系统的模态窗口 -->
<div class="modal fade" id="exitModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">离开</h4>
            </div>
            <div class="modal-body">
                <p>您确定要退出系统吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal"
                        onclick="window.location.href='../../login.jsp';">确定
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 顶部 -->
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
    <div style="position: absolute; top: 15px; right: 15px;">
        <ul>
            <li class="dropdown user-dropdown">
                <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle"
                   data-toggle="dropdown">
                    <span class="glyphicon glyphicon-user"></span> zhangsan <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="../../workbench/index.jsp"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
                    <li><a href="../index.html"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span
                            class="glyphicon glyphicon-file"></span> 我的资料</a></li>
                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span
                            class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
                    <li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span
                            class="glyphicon glyphicon-off"></span> 退出</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>

<!-- 创建部门的模态窗口 -->
<div class="modal fade" id="createDeptModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增部门</h4>
            </div>
            <div class="modal-body">

                <form id="saveForm" action="/dept/save.json" method="post" class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="createcode" class="col-sm-2 control-label">编号<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="no" type="text" class="form-control" id="createcode" style="width: 200%;"
                                   placeholder="编号为四位数字，不能为空，具有唯一性">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="createname" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="name" type="text" class="form-control" id="createname" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="createmanager" class="col-sm-2 control-label">负责人</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="manager" type="text" class="form-control" id="createmanager"
                                   style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="createphone" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="phone" type="text" class="form-control" id="createphone" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="createdescribe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 55%;">
                            <textarea name="description" class="form-control" rows="3" id="createdescribe"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="savebtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改部门的模态窗口 -->
<div class="modal fade" id="editDeptModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabe2"><span class="glyphicon glyphicon-edit"></span> 编辑部门</h4>
            </div>
            <div class="modal-body">

                <form id="updateForm" action="/dept/update.json" class="form-horizontal" role="form">
                    <input type="hidden" name="id">
                    <div class="form-group">
                        <label for="create-code" class="col-sm-2 control-label">编号<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="no" type="text" class="form-control" id="create-code" style="width: 200%;"
                                   placeholder="编号为四位数字，不能为空，具有唯一性">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-name" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="name" type="text" class="form-control" id="create-name" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-manager" class="col-sm-2 control-label">负责人</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="manager" type="text" class="form-control" id="create-manager"
                                   style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-phone" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="phone" type="text" class="form-control" id="create-phone" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 55%;">
                            <textarea name="description" class="form-control" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateBtn" type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>

<div style="width: 95%">
    <div>
        <div style="position: relative; left: 30px; top: -10px;">
            <div class="page-header">
                <h3>部门列表</h3>
            </div>
        </div>
    </div>
    <div class="btn-toolbar" role="toolbar"
         style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
        <div class="btn-group" style="position: relative; top: 18%;">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span
                    class="glyphicon glyphicon-plus"></span> 创建
            </button>
            <button id="editBtn" type="button" class="btn btn-default" data-toggle="modal"><span
                    class="glyphicon glyphicon-edit"></span> 编辑
            </button>
            <button id="delBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除
            </button>
        </div>
    </div>
    <div style="position: relative; left: 30px; top: -10px;">
        <table class="table table-hover">
            <thead>
            <tr style="color: #B3B3B3;">
                <td><input type="checkbox" id="allbtn"/></td>
                <td>编号</td>
                <td>名称</td>
                <td>负责人</td>
                <td>电话</td>
                <td>描述</td>
            </tr>
            </thead>
            <tbody id="databody">
            </tbody>
        </table>
    </div>

    <div style="height: 50px; position: relative;top: 0px; left:30px;">
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
                    <li><a href="#">下一页</a></li>
                    <li class="disabled"><a href="#">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>

</div>

</body>
</html>