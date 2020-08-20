<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String path = request.getContextPath(); 
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>用戶信息</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/css/main.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/demo/demo.css" />
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.8.6/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.8.6/jquery.easyui.min.js"></script>
	<style type="text/css">
	#header {
		width:90%;
		margin:0 auto;
		overflow: hidden;
	}
	#content{
		width:90%;
		margin:0 auto;
	}
	</style>
</head>
<body>
	<div id="header">
		<div style="margin: 5px auto; float: left; width: 25%">
			<div>真实姓名:</div>
			<input class="easyui-textbox" id="searchRealName" style="width: 90%; height: 25px">
		</div>
		<div style="margin: 5px auto; float: left; width: 25%">
			<div>角色:</div>
			<select class="easyui-combobox" id="searchRoleId" name="roleId"
				style="width: 90%; height: 25px">
				<option value="">---请选择----</option>
				<c:forEach items="${roleList }" var="role">
					<option value="${role.roleId }"
						<c:if test="${role.roleId==roleId }"  >selected="selected"</c:if>>${role.roleName }</option>
				</c:forEach>
			</select>
		</div>
		<div style="margin: 5px auto; float: left; padding-bottom: 0px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
				style="width: 100px; height: 32px" onclick="searchUser();">搜索</a>
		</div>
	</div>
	<div id="content">
		<div style="padding: 10px 0;">
			<a href="#" class="easyui-linkbutton" title="添加用户信息"
				data-options="iconCls:'icon-add'" onclick="$('#add').window('open')">添加用户信息</a>
		</div>
		<table id="dg" class="easyui-datagrid" style="width: 100%" data-options="onLoadSuccess:onLoadSuccess,rownumbers:true">
			<thead>
				<tr>
					<th field="userId" width="25%">用户名</th>
					<th data-options="field:'userName'" width="25%">真实姓名</th>
					<th data-options="field:'roleName'" width="25%">所属角色</th>
					<th data-options="field:'action',formatter:formatterBtn" width="25%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.list }" var="users">
					<tr>
						<td>${users.userId }</td>
						<td>${users.userName }</td>
						<td>${users.role.roleName }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="pg" class="easyui-pagination"
			data-options="total:${page.total},pageSize:${page.pageSize },pageList:[${page.pageSize},${page.pageSize*2},${page.pageSize*4}],onSelectPage:onSelectPage">
		</div>
	</div>
	<div id="add" class="easyui-window" title="添加用户信息"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width: 500px; height: 300px; padding: 10px;">
		<div style="margin: 0 auto; width: 60%;">
			<form id="addForm">
				<div style="margin: 5px auto;">
					<div>用户名:</div>
					<input class="easyui-textbox" id="userName" name="username"
						style="width: 100%; height: 25px">
				</div>
				<div style="margin: 5px auto;">
					<div>真实姓名:</div>
					<input class="easyui-textbox" id="realName" name="realName"
						style="width: 100%; height: 25px">
				</div>
				<div style="margin: 5px auto;">
					<div>角色:</div>
					<select class="easyui-combobox" id="roleId" name="role.roleId"
						style="width: 100%; height: 25px">
						<c:forEach items="${roleList }" var="role">
							<option value="${role.roleId }">${role.roleName }</option>
						</c:forEach>
					</select>
				</div>

				<div style="margin-top: 10px">
					<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
						style="width: 100%; height: 32px" onclick="addUser();">添加</a>
				</div>
			</form>
		</div>
	</div>
	<div id="edit" class="easyui-window" title="修改用户信息"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width: 500px; height: 300px; padding: 10px;">
		<div style="margin: 0 auto; width: 60%;">
			<div style="margin: 5px auto;">
				<div>用户名:</div>
				<input id="editIndex" type="hidden"> <input
					class="easyui-textbox" id="editUserName" readonly="readonly"
					style="width: 100%; height: 25px">
			</div>
			<div style="margin: 5px auto;">
				<div>真实姓名:</div>
				<input class="easyui-textbox" id="editRealName"
					style="width: 100%; height: 25px">
			</div>
			<div style="margin: 5px auto;">
				<div>角色:</div>
				<select class="easyui-combobox" id="editRoleId" name="roleId"
					style="width: 100%; height: 25px">
					<c:forEach items="${roleList }" var="role">
						<option value="${role.roleId }"
							<c:if test="${role.roleId==roleId }"  >selected="selected"</c:if>>${role.roleName }</option>
					</c:forEach>
				</select>
			</div>

			<div style="margin-top: 10px">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
					style="width: 100%; height: 32px" onclick="saveUser();">修改</a>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		findAll();
		$("#closeUpdate").click(function(){ 
			$("#update-wrapper").css("display","none");
		});
	});
	function onLoadSuccess(){
		$("a[name='editbtn']").linkbutton({
			plain:true,
		    iconCls: 'icon-edit'
		});
		$("a[name='removebtn']").linkbutton({
			plain:true,
		    iconCls: 'icon-remove'
		});
	}
	function formatterBtn(value,row,index){
		var str = '<a href="#" name="editbtn" class="easyui-linkbutton" title="修改用户信息" onclick="editUser(&quot;'+row.username+'&quot;,'+index+');">修改</a> &nbsp;&nbsp;'
		  +'<a href="#" name="removebtn" class="easyui-linkbutton" title="删除用户信息" onclick="deleteUser(&quot;'+row.username+'&quot;,'+index+');" >删除</a>';
		return str;
			
	}
	var updateId;
	function onSelectPage(pageNumber, pageSize){
		var userId = $("#searchRealName").textbox("getValue");
		var roleId = $("#searchRoleId").textbox("getValue");
        var args = {userId:userId,roleId:roleId,pageNumber:pageNumber,pageSize:pageSize};
		$.ajax({
			url:'<%=path%>/users/searchUsers',
			type : 'post',
			data :args,
			success:function(data,textStatus){
				if(textStatus=="success") {
					console.log(data.list);
					$.each(data.list,function(index,result){
						console.log(result);
						result.roleName=result.role.roleName
					})
					$('#dg').datagrid('loadData',{'total':data.total, rows:data.list });
				}
			}
		});
		
	}
	function searchUser(){
		var userName = $("#searchRealName").textbox("getValue");
		var roleId = $("#searchRoleId").textbox("getValue");
		var pageSize = $('#pg').pagination('options').pageSize;
		var pageNumber = $('#pg').pagination('options').pageNumber;
		console.log(pageSize);
		$.post("<%=path %>/users/searchUsers",{userName:userName,roleId:roleId,pageNumber:pageNumber,pageSize:pageSize},function(data,textStatus){
				if(textStatus=="success") {
					$.each(data.list,function(index,result){
						result.roleName=result.role.roleName
					})
					$('#dg').datagrid('loadData',data.list);
					$("#pg").pagination('refresh',{
						total:data.total
					});
				}
		})
		
	}
	function findAll(){
		$.ajax({
			url: '<%=path%>/getAll',
			success:function(data){
				$("#userBody").html("");
				for(var i = 0;i<data.length;i++){
					var tr = '<tr class="tableContent">'+
					'<td>'+data[i].userId+'</td>'+
					'<td>'+data[i].userName+'</td>'+
					'<td>'+data[i].password+'</td>'+
					'<td>'+data[i].phone+'</td>'+
					'<td><button onclick="showUpdate(\''+data[i].userId+'\')">修改</button>|<button onclick="Delete(\''+data[i].userId+'\')">删除</button></td>'+
					'</tr>';
					$("#userBody").append(tr);
				}
			},
			dataType:"json"
		});
	}
	function Check(){
		var searchInput = $("#searchInput").val();
		var args={searchInput:searchInput};
		$.ajax({
			url:'<%=path%>/checkUser',
			data: args,
			success:function(data){
				$("#userBody").html("");
				for(var i = 0;i<data.length;i++){
					var tr = '<tr class="tableContent">'+
					'<td>'+data[i].userId+'</td>'+
					'<td>'+data[i].userName+'</td>'+
    				'<td>'+data[i].password+'</td>'+
					'<td>'+data[i].phone+'</td>'+
					'<td><button onclick="showUpdate(\''+data[i].userId+'\')">修改</button>|<button onclick="Delete(\''+data[i].userId+'\')">删除</button></td>'+
					'</tr>';
					$("#userBody").append(tr);
				}
			},
			dataType:"json"
		});
	}
	function add(){
		var addId = $("#addId").val();
		var addName = $("#addName").val();
		var addPass = $("#addPass").val();
		var addPhone = $("#addPhone").val();
		var args = {addId:addId,addName:addName,addPass:addPass,addPhone:addPhone};
		$.ajax({
			url:'<%=path%>/users/addUser',
			type : 'post',
			data :args,
			success:function(data){
				findAll();
				alert("添加成功");
				console.log(data);
			}
		});
	}
	function Delete(id){
		updateId = id;
		var args={updateId:updateId};
		$.ajax({
			url:'<%=path%>/deleteUser',
			data: args,
			success:function(data){
				findAll();	
				alert("刪除成功");
				console.log(data);
			}
		});
	}
	function showUpdate(id){
		updateId = id;
		var args={updateId:updateId};
		$.ajax({
			url:'<%=path%>/showUpdate',
			data: args,
			success:function(data){
				// 吧数据显示在弹窗中
				$("#updateId").val(data.userId);
				$("#updateName").val(data.userName);
				$("#updatePass").val(data.password);
				$("#updatePhone").val(data.phone);
			    $("#update-wrapper").css("display","inline");
			    console.log(data);
			}
		});
	}

	function update(){
		var updateId = $("#updateId").val();
		var updateName = $("#updateName").val();
		var updatePass = $("#updatePass").val();
		var updatePhone = $("#updatePhone").val();
		var args = {updateId:updateId,updateName:updateName,updatePass:updatePass,updatePhone:updatePhone};
		$.ajax({
			url:'<%=path%>/updateUser',
			type : 'post',
			data :args,
			success:function(data){
				$("#update-wrapper").css("display","none");
				findAll();
				alert("修改成功");
				console.log(data);
			}
		});
	}
</script>
</html>