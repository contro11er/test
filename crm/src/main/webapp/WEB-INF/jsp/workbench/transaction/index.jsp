<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/jsp/home/jspproperties.jsp" %>

    <script type="text/javascript">

        jQuery(function ($) {
            $("#searchForm").ajaxForm(function (page) {
                //分页属性设置
                $("#page").bs_pagination({
                    currentPage: page.currentPage,              // 页码
                    rowsPerPage: page.rowsPerPage,              //每页显示的记录条数
                    maxRowsPerPage: page.maxRowsPerPage,        //每页最多显示的记录条数
                    totalPages: page.totalPages,                // 总页数
                    totalRows: page.totalRows,                  // 总记录条数
                    visiblePageLinks: page.visiblePageLinks,   // 显示几个卡片
                    onChangePage: function (event, data) {
                        $("#currentPage").val(data.currentPage);
                        $("#rowsPerPage").val(data.rowsPerPage);
                        //点击之后重新发送表单查询数据
                        $("#searchForm").submit();
                    }
                });
                var arr = [];

                $(page.data).each(function () {
                    arr.push(
                        `<tr>
                            <td><input type="checkbox"/></td>
                            <td><a style="text-decoration: none; cursor: pointer;"
                                   onclick="location='detail.html';">` + this.name + `</a></td>
                            <td>` + this.customer.name + `</td>
                            <td>` + this.stage + `</td>
                            <td>` + this.type + `</td>
                            <td>` + this.owner + `</td>
                            <td>` + this.source + `</td>
                            <td>` + this.contacts.fullName + `</td>
                        </tr>`
                    );
                });

                $("#databody").html(arr.join(""));
            }).submit();

            $("#searchBtn").click(function () {
                $("#currentPage").val("1");
                $("#searchForm").submit();
            });
        });
    </script>
</head>
<body>

<!-- 导入交易的模态窗口 -->
<div class="modal fade" id="importClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入交易</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：
                    <small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input type="file">
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
                <button type="button" class="btn btn-primary" data-dismiss="modal">导入</button>
            </div>
        </div>
    </div>
</div>

<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>交易列表</h3>
        </div>
    </div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form id="searchForm" method="post" action="/transaction/getList.json" class="form-inline" role="form"
                  style="position: relative;top: 8%; left: 5px;">
                <input type="hidden" id="currentPage" name="currentPage">
                <input type="hidden" id="rowsPerPage" name="rowsPerPage">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input name="condition['owner']" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input name="condition['name']" class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">客户名称</div>
                        <input name="condition['customerName']" class="form-control" type="text">
                    </div>
                </div>

                <br>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">阶段</div>
                        <select class="form-control">
                            <option></option>
                            <option>资质审查</option>
                            <option>需求分析</option>
                            <option>价值建议</option>
                            <option>确定决策者</option>
                            <option>提案/报价</option>
                            <option>谈判/复审</option>
                            <option>成交</option>
                            <option>丢失的线索</option>
                            <option>因竞争丢失关闭</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">类型</div>
                        <select class="form-control">
                            <option></option>
                            <option>已有业务</option>
                            <option>新业务</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">来源</div>
                        <select class="form-control" id="create-clueSource">
                            <option></option>
                            <option>广告</option>
                            <option>推销电话</option>
                            <option>员工介绍</option>
                            <option>外部介绍</option>
                            <option>在线商场</option>
                            <option>合作伙伴</option>
                            <option>公开媒介</option>
                            <option>销售邮件</option>
                            <option>合作伙伴研讨会</option>
                            <option>内部研讨会</option>
                            <option>交易会</option>
                            <option>web下载</option>
                            <option>web调研</option>
                            <option>聊天</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">联系人名称</div>
                        <input class="form-control" type="text">
                    </div>
                </div>

                <button id="searchBtn" type="button" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" onclick="window.location.href='save.html';"><span
                        class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default" onclick="window.location.href='edit.html';"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importClueModal"><span
                        class="glyphicon glyphicon-import"></span> 导入
                </button>
                <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 导出
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox"/></td>
                    <td>名称</td>
                    <td>客户名称</td>
                    <td>阶段</td>
                    <td>类型</td>
                    <td>所有者</td>
                    <td>来源</td>
                    <td>联系人名称</td>
                </tr>
                </thead>
                <tbody id="databody">
                </tbody>
            </table>
        </div>

        <div id="page">

        </div>

    </div>

</div>
</body>
</html>