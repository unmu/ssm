<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<% String path = pageContext.getServletContext().getContextPath();%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>用户管理</title>
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/demo/demo.css">
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
	<script type="text/javascript">
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
		var str = '<a href="#" name="editbtn" class="easyui-linkbutton" title="修改用户信息" onclick="editUser(&quot;'+row.userId+'&quot;,'+index+');">修改</a> &nbsp;&nbsp;'
		  +'<a href="#" name="removebtn" class="easyui-linkbutton" title="删除用户信息" onclick="deleteUser(&quot;'+row.userId+'&quot;,&quot;'+row.userName+'&quot;);" >删除</a>';
		return str;
			
	}
		function addUser(){
			var userId = $("#userId").val();
			var userName = $("#userName").val();
			var roleId = $("#roleId").val();
			var roleName = $("#roleId").find("option:selected").text();
			$.ajax({
				url:"<%=path %>/users/insertUser",
				data:$("#addForm").serialize(),
				success:function(data,textStatus){
					if(textStatus=="success") {
						if(data==true ||data==null) {
							alert("添加成功");
							$('#dg').datagrid('appendRow',{
								userId: userId,
								userName: userName,
								roleName:roleName
								});
							onLoadSuccess();
							$("#add").window("close");
						}
					}
				},
				error:function(data,textStatus) {
					//alert("error: "+textStatus)
					alert("该用户名已被使用，请更换用户名")
				}
			})
			
		}
		function deleteUser(id, userName){
			var args={deleteId:id};
			   if(confirm("确定删除用户”" + id + "--" + userName + "“吗？")){
				   $.ajax({
		               url:'<%=path%>/users/deleteUser',
		               data: args,
		               success:function(data){
		                   alert("刪除成功");
		                   window.location.href = "<%=path%>/users/userList";
		               }
		           });
			   }
		}

		
		function editUser(userId,index) {
			$("#edit").window("open");
			if(userId!=""){
				$.get("<%=path %>/users/getUserByUserId",{userId:userId},function(data,textStatus){
					$("#editUserId").textbox("setValue",data.userId);
					$("#editUserName").textbox("setValue",data.userName);
					$("#editRoleId").combobox("setValue",data.role.roleId);
					$("#editIndex").val(index);
				})
			}
		}
		
		function saveUser(){
			var userId = $("#editUserId").textbox("getValue");
			var userName = $("#editUserName").textbox("getValue");
			var roleId = $("#editRoleId").combobox("getValue");
			var roleName = $("#editRoleId").find("option:selected").text();
			var index = $("#editIndex").val();
			$.post("<%=path %>/users/updateUser",{userId:userId,userName:userName,roleId:roleId},function(data,textStatus){
					if(data==true) {
						alert("修改成功");
						/* $('#dg').datagrid('updateRow',{
							index:index,
							row: {
								userId: userId,
								userName: userName,
								roleName:roleName
							}
							
						}); */
						onLoadSuccess();
						$("#edit").window("close");
						window.location.href = "<%=path%>/users/userList";
					}
			})
			
		}
		
		function searchUser(){
			var realName = $("#searchRealName").textbox("getValue");
			var roleId = $("#searchRoleId").textbox("getValue");
			var pageSize = $('#pg').pagination('options').pageSize;
			var pageNumber = $('#pg').pagination('options').pageNumber;
			console.log(pageSize);
			$.post("<%=path %>/users/searchUsers",{realName:realName,roleId:roleId,pageNumber:pageNumber,pageSize:pageSize},function(data,textStatus){
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
/* 		$(function(){
			$('#dg').datagrid('getPager').pagination({
				onSelectPage:function(pageNumber, pageSize){
					searchUser();
				}
			});
		}) */
		
		function onSelectPage(pageNumber, pageSize){
			var realName = $("#searchRealName").textbox("getValue");
			var roleId = $("#searchRoleId").textbox("getValue");
			$.post("<%=path %>/users/searchUsers",{realName:realName,roleId:roleId,pageNumber:pageNumber,pageSize:pageSize},function(data,textStatus){
					if(textStatus=="success") {
						$.each(data.list,function(index,result){
							result.roleName=result.role.roleName
						})
						$('#dg').datagrid('loadData',{'total':data.total, rows:data.list });
					}
			})
			
		}
	</script>
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
					<input class="easyui-textbox" id="userId" name="userId"
						style="width: 100%; height: 25px">
				</div>
				<div style="margin: 5px auto;">
					<div>真实姓名:</div>
					<input class="easyui-textbox" id="userName" name="userName"
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
				<input id="editIndex" type="hidden"> 
				<input class="easyui-textbox" id="editUserId" readonly="readonly"
					style="width: 100%; height: 25px">
			</div>
			<div style="margin: 5px auto;">
				<div>真实姓名:</div>
				<input class="easyui-textbox" id="editUserName"
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
</html>