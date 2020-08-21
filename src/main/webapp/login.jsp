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
<script type="text/javascript" src="<%=path %>/jquery-3.3.1.min.js"></script>
<title>Log in</title>
<style>
.login-form {
	margin: 0 auto;
	margin-top: 40px;
	padding: 30px;
	width: 400px;
	border: 1px solid lightgray;
	border-radius: 8px;
}
</style>
<script type="text/javascript">
	function loginCheck(){
		var username = $("#username").val();
		var password = $("#password").val();
		var args = {username:username,password:password};
		$.ajax({
			async:false,
			url:'<%=path%>/loginCheck',
			type : 'post',
			data :args,
			success:function(data,textStatus){
				if(textStatus=="success") {
					console.log(data);
					if(data == true){
						window.location.href="main";
					} else {
						alert("用户名或密码错误！");
					}
				}
			}
		});
	}
</script>
</head>
<body>

	<script
		src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
		
	<div class="login-form">
		<form class="form-horizontal" id="myForm">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label" style="width: 20%">UserId</label>
				<div class="col-sm-10" style="width: 80%">
					<input type="text" class="form-control" id="username" name="username"
						placeholder="Username">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label" style="width: 20%">Password</label>
				<div class="col-sm-10" style="width: 80%">
					<input type="password" class="form-control" id="password" name="password"
						placeholder="Password">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="checkbox">
						<label> <input type="checkbox"> Remember me
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="button" class="btn btn-default" onclick="loginCheck()">Log in</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>