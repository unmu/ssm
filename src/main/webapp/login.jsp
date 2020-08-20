<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
</head>
<body>

	<script
		src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
		
	<div class="login-form">
		<form class="form-horizontal" method="post" action="login">
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-2 control-label" style="width: 20%">Username</label>
				<div class="col-sm-10" style="width: 80%">
					<input type="text" class="form-control" id="inputEmail3" name="username"
						placeholder="Username">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-2 control-label" style="width: 20%">Password</label>
				<div class="col-sm-10" style="width: 80%">
					<input type="password" class="form-control" id="inputPassword3" name="password"
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
					<button type="submit" class="btn btn-default">Log in</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>