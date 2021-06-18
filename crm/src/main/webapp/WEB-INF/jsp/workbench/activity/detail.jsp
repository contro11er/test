<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;
        jQuery(function ($) {
            $("#remark").focus(function () {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function () {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });

            //移入移出时，出现编辑和删除案件
            $("#bz").on("mouseover mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").toggle();
            });
            //移入移出时，按钮显红
            $("#bz").on("mouseover mouseout", ".myHref", function () {
                $(this).children("span").css("color", function (index, value) {
                    return value == "rgb(230, 230, 230)" ? "rgb(255, 0, 0)" : "rgb(230, 230, 230)";
                });
            });

            let id;

            //发送请求，获取活动详情列表
            function load() {
                $.ajax({
                    url: "/activities/getActivitiesById.json?id=${param.id}",
                    success: function (data) {
                        act = data;
                        $("[result]").text(function () {
                            //data[属性名]
                            return data[$(this).attr("result")] || "";
                            // return data[this.getAttribute("result")];
                        });
                    }
                }).done(plLoad);
            }

            //发送请求，获取评论列表
            function plLoad() {
                $.ajax({
                    url: "/activities/getARListById.json?id=${param.id}",
                    success: function (data) {
                        html = "";
                        $(data).each(function () {
                            html += `<div class="remarkDiv" style="height: 60px;">
                                    <img title="#" src="/static/image/user-thumbnail.png" style="width: 30px; height:30px;">
                                    <div style="position: relative; top: -40px; left: 40px;">
                                        <h5>` + this.noteContent + `</h5>
                                        <font color="gray">市场活动</font> <font color="gray">-</font> <b>` + act.name + `</b>
                                        <small style="color: gray;"> ` + this.noteTime + `</small>
                                        <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                                             <a edi data-id="` + this.id + `" class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                                                 &nbsp;&nbsp;&nbsp;&nbsp;
                                                <a del data-id="` + this.id + `" class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"  style="font-size: 20px; color: #E6E6E6;"></span></a>
                                        </div>
                                    </div>
                                </div>`
                        });
                        $("#bz").html(html);
                    }
                });
            }

            load();

            //回显数据,siblings用于筛选同辈元素的表达式
            $("#bz").on("click", "a[edi]", function () {
                var edi = $(this).parents().siblings("h5").text();
                $("#remark").val(edi);
                //    把这里id的值赋予全局变量的id
                id = $(this).data("id");
            });

            $("#cancelBtn").click(function () {
                //点击取消则清空文本框
                $("#remark").val("");
            });

            $("#bz").on("click", "a[del]", function () {
                if (!confirm("确定删除吗？")) return;
                var $this = this;
                $.ajax({
                    url: "/activities/delAR.do?id=" + $(this).data("id"),
                    success: function (data) {
                        //    方法1：重新加载界面
                        //    方法2：closest(有弊端,读脏数据)
                        // closest:从当前元素逐步往祖先元素进行匹配，匹配成功则返回，不再继续匹配
                        $($this).closest(".remarkDiv").remove();
                    }
                });
            });

            $("#addOrEditBtn").click(function () {
                $.ajax({
                    url: "/activities/addOrEdit.do",
                    data: {
                        noteContent: $("#remark").val(),
                        marketingActivitiesId: "${param.id}",
                        id
                    },
                    type: "post",
                    success: function (data) {
                        alert(data.msg);
                        //    重新加载
                        plLoad();
                        //把全局变量的值清空，不影响下次操作
                        id = undefined;
                        $("#cancelBtn").click();
                    }
                });
            });


        });
    </script>

</head>
<body>


<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>市场活动-<span result="name"></span>
            <small><span result="startDate"></span> ~ <span result="endDate"></span></small>
        </h3>
    </div>
    <div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
        <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
    </div>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b result="owner"></b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b result="name"></b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>

    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">开始日期</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b result="startDate"></b>
        </div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b result="endDate"></b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">成本</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b result="cost"></b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b result="createBy">&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;" result="createTime"></small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b result="editBy">&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;" result="editTime"></small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b result="description">
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div style="position: relative; top: 30px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>
    <span id="bz">

    </span>

    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button id="addOrEditBtn" type="button" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>