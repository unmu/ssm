<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<% String path = pageContext.getServletContext().getContextPath();%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>角色管理</title>
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.8.6/demo/demo.css">
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.8.6/jquery.min.js"></script>
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.8.6/jquery.easyui.min.js"></script>
	<style type="text/css">
	#content{
		width:90%;
		padding:10px;
		margin:0 auto;
	}
	</style>
	<script type="text/javascript">
	
	function onLoadSuccess(){
		$("a[name='menubtn']").linkbutton({
			iconCls:''
		});
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
		var str = '<a href="#" class="easyui-linkbutton" title="菜单权限信息增删改" onclick="showMenu(&quot;'+row.roleId+'&quot;,'+index+');">权限菜单</a> &nbsp;&nbsp;'
		  +'<a href="#" name="editbtn" class="easyui-linkbutton" title="修改角色信息" onclick="editRole(&quot;'+row.roleId+'&quot;,&quot;'+row.roleName+'&quot;,'+index+');">修改</a> &nbsp;&nbsp;'
		  +'<a href="#" name="removebtn" class="easyui-linkbutton" title="删除角色信息" onclick="deleteRole(&quot;'+row.roleId+'&quot;,&quot;'+row.roleName+'&quot;,'+index+');" >删除</a>';
		return str;
			
	}
		function addRole(){
			var roleName = $("#roleName").val();
			$.ajax({
				url:"<%=path%>/role/insertRole",
				data:{roleName:roleName},
				//SSM的ResponseBody底层过来的数据为json对象
				success:function(data,textStatus){
					if(textStatus=="success") {
						if(data!=null) {
							alert("添加成功");
							$('#dg').datagrid('appendRow',{
								roleId:data.roleId, 
								roleName:data.roleName
								});
							onLoadSuccess();
							$("#add").window("close");
						}
					}
				},
				error:function(data,textStatus) {
					alert("error: "+textStatus)
				}
			})
			
		}
		function deleteRole(roleId,roleName,index) {
			if (confirm("确认删除角色“"+ roleName + "”吗？")) {
				$.ajax({
					url:"<%=path%>/role/deleteRole",
					data:{roleId:roleId},
					success:function(data,textStatus){
						if(textStatus=="success") {
							if(data == 1) {
								alert("删除成功");
								$('#dg').datagrid('deleteRow',index);
								var rows = $("#dg").datagrid("getRows");
								 $("#dg").datagrid("loadData",rows);
							} else if (data == 2) {
								alert("删除失败");
							} else {
								alert("该角色尚在使用中，不能删除");
							}
						}
					},
					error:function(data,textStatus) {
						alert("error: "+textStatus)
					}
				})
			}
			
		}
		function editRole(roleId,roleName,index) {
			$("#edit").window("open");
			if(roleId!=""){
					$("#editRoleId").val(roleId);
					$("#editRoleName").textbox("setValue",roleName);
					$("#editIndex").val(index);
			}
		}
		
		function saveRole(){
			var roleName = $("#editRoleName").textbox("getValue");
			var roleId = $("#editRoleId").val();
			var index = $("#editIndex").val();
			$.ajax({
				url:"<%=path%>/role/updateRole",
				data:{roleId:roleId,roleName:roleName},
				success:function(data,textStatus){
					if(textStatus=="success") {
						if(data==true) {
							alert("修改成功");
							$("#edit").window("close");
							/* $('#dg').datagrid('updateRow',{
								index: index,
								row: {
									roleId: data.roleId,
									roleName: data.roleName
								}
							}); */
							//onLoadSuccess();
							window.location.href = "<%=path%>/role/roleList";
						}
					}
				},
				error:function(data,textStatus) {
					alert("error: "+textStatus)
				}
			})
		}
		
		function showMenu(roleId,index){
			$("#menu").window("open");
			$("#menuRoleId").val(roleId);
			var menuNodes = $('#tt').tree('getChecked', ['checked','unchecked']);
			//清空所有打钩的menu，设置为为勾选
			for(var i=0; i<menuNodes.length; i++) {
				$('#tt').tree('uncheck', menuNodes[i].target);
			}
			//重新获取所有menu
			var menus = $("#tt").tree("getChecked","unchecked");
			$.ajax({
				url:"<%=path%>/role/getMenuListByRoleId",
				data:{roleId:roleId},
				success:function(data,textStatus){
					if(textStatus=="success") {
						$.each(data,function(index,result){
							$.each(result.childrenMenuList,function(index,child){
								for(var i=0; i<menus.length; i++) {
									console.log(menus[i]);
									if (child.parentId != 0) {
										if(menus[i].id==child.menuId) {
											$('#tt').tree('check', menus[i].target);
										}
									}
								}
							})
						})
					}
				},
				error:function(data,textStatus) {
					alert("error: "+textStatus)
				}
			})
		}
		
		function addRoleMenu(){
			var roleId=$("#menuRoleId").val();
			var checkNodes = $('#tt').tree('getChecked', ['checked','indeterminate']);
			var menus="";
			for(var i=0;i<checkNodes.length;i++) {
				menus=menus+checkNodes[i].id+"|";
			}
			alert(menus);
			$.ajax({
				url:"<%=path%>/role/editRoleMenu",
				data:{roleId:roleId,menus:menus},
				success:function(data,textStatus){
					if(textStatus=="success") {
						alert("权限变更成功");
						$("#menu").window("close");
					}
				},
				error:function(data,textStatus) {
					alert("error: "+textStatus)
				}
			});
		}
	</script>
</head>
<body>
<div id="content">
<table id="dg" class="easyui-datagrid" style="width: 100%;" data-options="onLoadSuccess:onLoadSuccess" >
    <thead>
		<tr>
			<th data-options="field:'roleId',hidden:true" width="5%"></th>
			<th data-options="field:'roleName'" width="45%">角色名称</th>
			<th data-options="field:'action',formatter:formatterBtn" width="50%">操作</th>
		</tr>
    </thead>
    <tbody>
    <c:forEach items="${roleList }" var="role">
    	<tr>
			<td>${role.roleId }</td>
			<td>${role.roleName }</td>
		</tr>
	</c:forEach>
		
	</tbody>
</table>
	<div style="padding:20px 0;">
		<a href="#" class="easyui-linkbutton" title="添加角色信息"  data-options="iconCls:'icon-add'" onclick="$('#add').window('open')">添加角色信息</a>
	</div>
</div>
<div id="add" class="easyui-window" title="添加角色信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px;">
		<div style="margin:0 auto;width:60%;">
			<div style="margin:5px auto;">
				<div>角色名称:</div>
				<input class="easyui-textbox" id="roleName" style="width:100%;height:25px">
			</div>
			<div style="margin-top:10px">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px" onclick="addRole();">添加</a>
			</div>
		
		</div>
</div>

<div id="edit" class="easyui-window" title="修改角色信息" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:500px;height:300px;padding:10px;">
		<div style="margin:0 auto;width:60%;">
			
			<div style="margin:5px auto;">
				<div>角色名称:</div>
				<input id="editRoleId" type="hidden">
				<input class="easyui-textbox" id="editRoleName" style="width:100%;height:25px">
			</div>
			
			<div style="margin-top:10px">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px" onclick="saveRole();">修改</a>
			</div>
		
		</div>
</div>

<div id="menu" class="easyui-window" title="菜单权限" data-options="modal:true,closed:true,iconCls:'icon-save'" style="width:300px;height:450px;padding:10px;">
		<div style="margin:0 auto;width:70%;">
			<div style="margin:5px auto;">
				<input id="menuRoleId" type="hidden">
				<ul id="tt" class="easyui-tree" data-options="animate:true,checkbox:true">
					<c:forEach items="${menuList }" var="menu">
					<li data-options="id:${menu.menuId },state:'closed'">
					<span>${menu.menuName }</span>
					<ul>
						<c:forEach items="${menu.childrenMenuList }" var="children">
							<li data-options="id:${children.menuId }"><span>${children.menuName }</span></li>
						</c:forEach>
					</ul>
					</li>
					</c:forEach>
				</ul>
			</div>
			<div style="margin-top:30px">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px" onclick="addRoleMenu();">保存</a>
			</div>
		
		</div>
</div>

</body>
</html>