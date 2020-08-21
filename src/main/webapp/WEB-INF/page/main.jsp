<%@ page language="java" contentType="text/html; utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = pageContext.getServletContext().getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>医疗门诊管理系统</title>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/jquery-easyui-1.8.6/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/jquery-easyui-1.8.6/themes/icon.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/jquery-easyui-1.8.6/demo/demo.css" />
<script type="text/javascript"
	src="<%=path%>/jquery-easyui-1.8.6/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/jquery-easyui-1.8.6/jquery.easyui.min.js"></script>
<style type="text/css">
a {
	color: #999;
	text-decoration: none;
}

a:hover {
	text-decoration: none;
}

.menu_li li {
	padding: 8px 20px;
	list-style: none;
	border-bottom: 2px solid #AEEEEE;
}
</style>
<script type="text/javascript">
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false"
		style="height: 60px; background: #B3DFDA; padding: 10px">
		你好！<span style="color: red;">${users.userName }</span> <span
			style="float: right">
			<a style="color:#f76722" href='<c:url value="/logout" />'>退出登录</a></span>
	</div>
	<div data-options="region:'west',split:true,title:'菜单栏'"
		style="width: 150px;">
		<div class="easyui-accordion" style="width: 100%; height: 100%;">
			<c:forEach items="${users.role.menuList }" var="menu">
				<div title="${menu.menuName }" style="overflow: auto;"
					class="menu_li">
					<c:forEach items="${menu.childrenMenuList }" var="child">
						<li><a href="${child.menuUrl }" target="mainFrame">${child.menuName }</a></li>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
	</div>
	<div data-options="region:'south',border:false"
		style="height: 50px; background: #A9FACD; padding: 10px; text-align: center;">医疗门诊系统</div>
	<div data-options="region:'center',title:'主页面'">
		<iframe name="mainFrame"
			style="width: 100%; height: 99%; border: none; padding: 10px; overflow: auto;"
			src=""></iframe>
	</div>
</body>
</html>
