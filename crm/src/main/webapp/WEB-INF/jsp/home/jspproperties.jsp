<%@page contentType="text/html; charset=utf-8" %>
<meta charset="UTF-8">

<meta charset="UTF-8">
<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css?v=${version}" type="text/css" rel="stylesheet"/>
<link href="/static/jquery/zTree_v3-master/css/zTreeStyle/zTreeStyle.css?v=${version}" type="text/css" rel="stylesheet"/>
<link href="/static/jquery/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css?v=${version}" type="text/css"
      rel="stylesheet"/>
<link href="/static/jquery/bs_pagination/jquery.bs_pagination.min.css?v=${version}" type="text/css" rel="stylesheet"/>

<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js?v=${version}"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js?v=${version}"></script>
<script type="text/javascript" src="/static/jquery/zTree_v3-master/js/jquery.ztree.all.min.js?v=${version}"></script>
<script type="text/javascript" src="/static/jquery/md5.js?v=${version}"></script>
<%--ajax的全局配置，dataFilter，注意：返回值先要经过处理--%>
<script type="text/javascript" src="/static/jquery/ajaxtTmeOut.js?v=${version}"></script>

<%--日期--%>
<script type="text/javascript" src="/static/jquery/jquery-form.js?v=${version}"></script>
<script type="text/javascript" src="/static/jquery/jquery.form.extend.js?v=${version}"></script>
<script type="text/javascript" src="/static/jquery/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js?v=${version}"></script>
<script type="text/javascript"
        src="/static/jquery/bootstrap-datetimepicker/locale/bootstrap-datetimepicker.zh-CN.js?v=${version}"></script>

<%--分页--%>
<script type="text/javascript" src="/static/jquery/bs_pagination/en.js?v=${version}"></script>
<script type="text/javascript" src="/static/jquery/bs_pagination/jquery.bs_pagination.min.js?v=${version}"></script>

<%--自动补全--%>
<script type="text/javascript" src="/static/jquery/bs_typeahead/bootstrap3-typeahead.min.js?v=${version}"></script>

<%--echarts图--%>
<script type="text/javascript" src="/static/jquery/echarts.min.js?v=${version}"></script>

<script type="text/javascript">
    jQuery(function ($) {

        //导航中所有文本颜色为黑色
        $(".liClass > a").css("color", "black");

        //默认选中导航菜单中的第一个菜单项
        $(".liClass:first").addClass("active");

        //第一个菜单项的文字变成白色
        $(".liClass:first > a").css("color", "white");

        //给所有的菜单项注册鼠标单击事件
        $(".liClass").click(function () {
            //移除所有菜单项的激活状态
            $(".liClass").removeClass("active");
            //导航中所有文本颜色为黑色
            $(".liClass > a").css("color", "black");
            //当前项目被选中
            $(this).addClass("active");
            //当前项目颜色变成白色
            $(this).children("a").css("color", "white");
        });


        $("#pwdbtn").click(function () {
            var input_oldPwd = $("#oldPwd").val();
            var input_newPwd = $("#newPwd").val();
            var input_confirmPwd = $("#confirmPwd").val();
            if (input_oldPwd == '') {
                alert("请输入旧密码");
                return;
            }
            if (input_newPwd == '') {
                alert("请输入新密码");
                return;
            }
            if (input_confirmPwd == '') {
                alert("请输入确认密码");
                return;
            }

            var md5 = $.md5(input_oldPwd);
            if (md5 != '${loginUser.loginPwd}') {
                alert("旧密码不对");
                return;
            }
            if ($("#confirmPwd").val() != $("#newPwd").val()) {
                alert("新密码和确认密码不一致");
                return
            }
            // $.ajax({});
            //data-dismiss="modal"
        });
    });
</script>

