<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="/WEB-INF/jsp/home/jspproperties.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/jsp/home/bodyJS.jsp" %>
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">

		<!-- 导航 -->
		<div id="navigation" style="left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;">

			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="/type/index.do" target="workareaFrame"><span class="glyphicon glyphicon-book"></span> 字典类型</a></li>
				<li class="liClass"><a href="/value/index.html" target="workareaFrame"><span class="glyphicon glyphicon-list"></span> 字典值</a></li>
			</ul>

			<!-- 分割线 -->
			<div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
		</div>

		<!-- 工作区 -->
		<div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
			<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
		</div>

	</div>

	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>

	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>

</body>

<script>
	//展示市场活动页面
	window.open("/type/index.do","workareaFrame");
</script>
</html>