<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript" src="<%=path%>/jquery-3.3.1.min.js"></script>
<title>登录</title>
<style>
.login-form {
	margin: 0 auto;
	margin-top: 180px;
	padding: 30px;
	width: 400px;
	border: 1px solid lightgray;
	border-radius: 8px;
	background-color: rgba(255, 255, 255, 0.72);
}

.background-img {
	background: center no-repeat url(image/hosp-img.jpg);
	background-size: cover;
	width: 1300px;
	margin: 0 auto;
}
</style>
<script type="text/javascript">
	function loginCheck(){
		var username = $("#username").val();
		var password = $("#password").val();
		if (username.length == 0 || password.length == 0) {
			alert("请输入用户名和密码");
		} else {
			var args = {username:username,password:password};
			$.ajax({
				async:false,
				url:'<%=path%>/loginCheck',
				type : 'post',
				data : args,
				success : function(data, textStatus) {
					if (textStatus == "success") {
						console.log(data);
						if (data == true) {
							window.location.href = "main";
						} else {
							alert("用户名或密码错误！");
						}
					}
				}
			});
		}
	}
</script>
</head>
<body class="background-img">
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>

	<div class="login-form">
		<form class="form-horizontal" id="myForm">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label"
					style="width: 20%">用户名</label>
				<div class="col-sm-10" style="width: 80%">
					<input type="text" class="form-control" id="username"
						name="username" placeholder="用户名">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label"
					style="width: 20%">密码</label>
				<div class="col-sm-10" style="width: 80%">
					<input type="password" class="form-control" id="password"
						name="password" placeholder="密码">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="checkbox">
						<label> <input type="checkbox"> 记住我
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="btn btn-default"
						onclick="loginCheck()">登录</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>