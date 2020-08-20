<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%
	String path = pageContext.getServletContext().getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>菜单管理</title>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/jquery-easyui-1.8.6/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/jquery-easyui-1.8.6/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/jquery-easyui-1.8.6/demo/demo.css">
<script type="text/javascript"
	src="<%=path%>/jquery-easyui-1.8.6/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/jquery-easyui-1.8.6/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/jquery-easyui-1.8.6/datagrid-detailview.js"></script>
<style type="text/css">
#content {
	width: 90%;
	padding: 10px;
	margin: 0 auto;
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
		var str = '<a href="#" name="editbtn" class="easyui-linkbutton" title="修改菜单信息" onclick="editMenu(&quot;'+row.menuId+'&quot;,'+index+');">修改</a> &nbsp;&nbsp;'
		  +'<a href="#" name="removebtn" class="easyui-linkbutton" title="删除菜单信息" onclick="deleteMenu(&quot;'+row.menuId+'&quot;,'+index+');" >删除</a>';
		return str;
			
	}
	$(function(){
		$('#dg').datagrid({
			view: detailview,
			detailFormatter:function(index,row){
				return '<div style="padding:2px"><table class="ddv" id="dg_'+row.menuId+'"></table></div>';
			},
			onExpandRow: function(index,row){
				var ddv = $(this).datagrid('getRowDetail',index).find('table.ddv');
				ddv.datagrid({
					url:'<%=path%>/menu/getChildMenusByParentId?parentId='+row.menuId,
					fitColumns:true,
					singleSelect:true,
					rownumbers:true,
					loadMsg:'',
					height:'auto',
					columns:[[
						{field:'menuId',hidden:true,title:'',width:5},
						{field:'menuName',title:'菜单名称',width:100},
						{field:'menuUrl',title:'URL路径',width:100},
						{field:'action',formatter: function(value,row,index){
							var str = '<a href="#" name="editbtn" class="easyui-linkbutton" title="修改菜单信息" onclick="editMenu(&quot;'+row.menuId+'&quot;,'+index+');">修改</a> &nbsp;&nbsp;'
							  +'<a href="#" name="removebtn" class="easyui-linkbutton" title="删除菜单信息" onclick="deleteMenu(&quot;'+row.menuId+'&quot;,'+index+');" >删除</a>';
							return str;
						},title:'操作',width:100}
					]],
					onResize:function(){
						$('#dg').datagrid('fixDetailRowHeight',index);
					},
					onLoadSuccess:function(){
						setTimeout(function(){
							$('#dg').datagrid('fixDetailRowHeight',index);
						},0);
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
				});
				$('#dg').datagrid('fixDetailRowHeight',index);
			}
		});	
	})
	
	function addMenu(){
		var menuName = $("#menuName").val();
		var menuUrl = $("#menuUrl").val();
		var parentId = $("#parentId").val();
		var parentName = $("#parentId").find("option:selected").text();
		$.ajax({
			url:"<%=path%>/menu/insertMenu",
			data:{parentId:parentId,menuName:menuName,menuUrl:menuUrl},
			success:function(data,textStatus){
				if(textStatus=="success") {
					if(data!=null) {
						alert("添加成功");
						if(data.parentId==0) {
							$('#dg').datagrid('appendRow',{
								menuId: data.menuId, 
								menuName:data.menuName,
								menuUrl:data.menuUrl
								});
							
						} else {
							$('#dg'+data.parentId).datagrid('appendRow',{
								menuId: data.menuId, 
								menuName:data.menuName,
								menuUrl:data.menuUrl
								});
							
						}
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
	function editMenu(menuId,index) {
		$("#edit").window("open");
		if(menuId!=""){
			$.get("<%=path%>/menu/getMenuById",{menuId:menuId},function(data,textStatus){
				$("#editMenuName").textbox("setValue",data.menuName);
				$("#editMenuUrl").textbox("setValue",data.menuUrl);
				$("#editParentId").combobox("setValue",data.parentId);
				$("#editIndex").val(index);
				$("#editMenuId").val(menuId);
				if (data.parentId == 0) {
					$("editMenuUrl").textbox("disabled", true);
				}
			})
		}
	}
	
	function saveMenu(){
		var menuName = $("#editMenuName").textbox("getValue");
		var menuUrl = $("#editMenuUrl").textbox("getValue");
		var parentId = $("#editParentId").combobox("getValue");
		var parentName = $("#editParentId").find("option:selected").text();
		var index = $("#editIndex").val();
		var menuId = $("#editMenuId").val();
		$.post("<%=path%>/menu/updateMenu",{menuId:menuId,menuName:menuName,menuUrl:menuUrl,parentId:parentId},function(data,textStatus){
				if(data==true) {
					alert("修改成功");
					if(data.parentId=="") {
						$('#dg').datagrid('updateRow',{
							index:index,
							row:{
								menuId: data.menuId, 
								menuName:data.menuName,
								menuUrl:data.menuUrl
							}
						});
						
					} else {
						$('#dg'+data.parentId).datagrid('updateRow',{
							index:index,
							row:{
								menuId: data.menuId, 
								menuName:data.menuName,
								menuUrl:data.menuUrl
							}
							
						});
						
					}
					onLoadSuccess();
					$("#edit").window("close");
				}
		})
		
	}
	
	function deleteMenu(menuId,index) {
		$.ajax({
			url:"<%=path%>/menu/deleteMenu",
			data : {
				menuId : menuId
			},
			success : function(data, textStatus) {
				if (textStatus == "success") {
					if (data == true) {
						alert("删除成功");
						$('#dg').datagrid('deleteRow', index);
						var rows = $("#dg").datagrid("getRows");
						$("#dg").datagrid("loadData", rows);
					}
				}
			},
			error : function(data, textStatus) {
				alert("error: " + textStatus)
			}
		})
	}
</script>
</head>
<body>
	<div id="content">
		<table id="dg" class="easyui-datagrid" style="width: 100%;"
			singleSelect="true" fitColumns="true"
			data-options="onLoadSuccess:onLoadSuccess">
			<thead>
				<tr>
					<th field="menuId" hidden="true" width="5%"></th>
					<th field="menuName" width="30%">菜单名称</th>
					<th field="menuUrl" width="30%">URL路径</th>
					<th data-options="field:'action',formatter:formatterBtn"
						width="30%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${menuList }" var="menu">
					<tr>
						<td>${menu.menuId }</td>
						<td>${menu.menuName }</td>
						<td>${menu.menuUrl }</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
		<div style="padding: 20px 0;">
			<a href="#" class="easyui-linkbutton" title="添加菜单信息"
				data-options="iconCls:'icon-add'" onclick="$('#add').window('open')">添加菜单信息</a>
		</div>
	</div>
	<div id="add" class="easyui-window" title="添加菜单信息"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width: 500px; height: 300px; padding: 10px;">
		<div style="margin: 0 auto; width: 60%;">
			<div style="margin: 5px auto;">
				<div>父类菜单:</div>
				<select class="easyui-combobox" id="parentId" name="parentId"
					style="width: 90%; height: 25px">
					<option value="">---请选择----</option>
					<c:forEach items="${menuList }" var="menu">
						<option value="${menu.menuId }">${menu.menuName }</option>
					</c:forEach>
				</select>
			</div>
			<div style="margin: 5px auto;">
				<div>菜单名称:</div>
				<input class="easyui-textbox" id="menuName" name="menuName"
					style="width: 100%; height: 25px">

				<div>URL路径:</div>
				<input class="easyui-textbox" id="menuUrl" name="menuUrl"
					style="width: 100%; height: 25px">


			</div>
			<div style="margin-top: 10px">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
					style="width: 100%; height: 32px" onclick="addMenu();">添加</a>
			</div>

		</div>
	</div>

	<div id="edit" class="easyui-window" title="修改菜单信息"
		data-options="modal:true,closed:true,iconCls:'icon-save'"
		style="width: 500px; height: 300px; padding: 10px;">
		<div style="margin: 0 auto; width: 60%;">
			<div style="margin: 5px auto;">
				<input id="editMenuId" name="menuId" type="hidden"
					style="width: 100%; height: 25px"> <input id="editIndex"
					type="hidden" style="width: 100%; height: 25px">
				<div>父类菜单:</div>
				<select class="easyui-combobox" id="editParentId" name="parentId" disabled="disabled"
					style="width: 90%; height: 25px">
					<option value="">---请选择----</option>
					<c:forEach items="${menuList }" var="menu">
						<option value="${menu.menuId }"
							<c:if test="${menu.menuId==parentId }"  >selected="selected"</c:if>>${menu.menuName }</option>
					</c:forEach>
				</select>
			</div>
			<div style="margin: 5px auto;">
				<div>菜单名称:</div>
				<input class="easyui-textbox" id="editMenuName" name="menuName"
					style="width: 100%; height: 25px">

				<div>URL路径:</div>
				<input class="easyui-textbox" id="editMenuUrl" name="menuUrl"
					style="width: 100%; height: 25px">


			</div>
			<div style="margin-top: 10px">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
					style="width: 100%; height: 32px" onclick="saveMenu();">修改</a>
			</div>

		</div>
	</div>

</body>
</html>