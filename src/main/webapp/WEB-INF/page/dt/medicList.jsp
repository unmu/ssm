<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%
	String path = pageContext.getServletContext().getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>药品处方</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.8.6/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.8.6/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.8.6/demo/demo.css">
<script type="text/javascript" src="<%=path%>/jquery-easyui-1.8.6/jquery.min.js"></script>
<script type="text/javascript" src="<%=path%>/jquery-easyui-1.8.6/jquery.easyui.min.js"></script>
<style type="text/css">
	.info-content {
		color:red;
	}
	.info-title{
		padding-left:5px;
	}
	</style>
<script type="text/javascript">
function onLoadSuccess(){
	$("a[name='removebtn']").linkbutton({
		plain:true,
	    iconCls: 'icon-remove'
	});
}

function formatterBtn(value,row,index){
	var str = '<a href="#" name="removebtn" class="easyui-linkbutton" title="删除药方" onclick="deleteUser(&quot;'+row.perscriptionId+'&quot;);" >删除</a>';
	return str;                                                                      
		
}


function formatterBtn1(value,row,index){
	var str = '<a href="#" name="removebtn" class="easyui-linkbutton" title="添加药方" onclick="addMedic(&quot;'+row.medicineId+'&quot;,'+row.num+');" >添加</a>';
	return str;
		
}

/* function formatterBtn1(value,row,index){
	var str = '<a href="#" name="removebtn" class="easyui-linkbutton" title="添加药方" onclick="addMedic(&quot;'+row.medicineId+'&quot;,'+row.num+'&quot;,'+row.price+');" >添加</a>';
	return str;
		
} */

	
var editIndex = undefined;
function onClickRow(index){
	if (editIndex != index){
		if (endEditing()){
			$('#medic_dg').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#medic_dg').datagrid('selectRow', editIndex);
		}
	}
}


function endEditing(){
	if (editIndex == undefined){return true}
	if ($('#medic_dg').datagrid('validateRow', editIndex)){
		$('#medic_dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}

function searchMedicine(){
	var medicineName = $("#medicineName").textbox("getValue");
	$.post("<%=path %>/dt/searchMedicine",{medicineName:medicineName},function(data,textStatus){
		if(textStatus=="success"){
			$('#medic_dg').datagrid('loadData',{total:'data.length',rows:data});
		}
	
  })
}

function getMedicineSelections(){
	var registerId =$("#registerId").val();
	var rows = $("#medic_dg").datagrid("getSelections");
	for (var i=0;i<rows.length;i++){
		var row = rows[i];
		row.account=1;
		row.money = row.price;
	}
	$('medic_dg').datagrid('locaData',{total:rows.length,rows:rows});
	$('#medicineSelect').window('close');
}

 //添加:registerId写死了:
 function addMedic(medicineId,num){
    
     $.post("<%=path %>/dt/addMedic",{medicineId:medicineId,num:num},function(data,textStatus){
    	 if(textStatus=="success"){
    		 $('#dg').datagrid('loadData',{total:'data.length',rows:data});
    		 window.location.href = "<%=path %>/dt/optPatient";
    	 }
  })
  
  //添加：能动态获取registerId时用这个
  <%-- function addMedic(medicineId,num){
     var registerId =$("#registerId").val();
     $.post("<%=path %>/dt/addMedic",{registerId:registerId,medicineId:medicineId,num:num},function(data,textStatus){
    	 if(textStatus=="success"){
    		 $('#dg').datagrid('loadData',{total:'data.length',rows:data});
    		 window.location.href = "<%=path %>/dt/optPatient";
    	 }
  }) --%>
} 


</script>

</head>
<body>
	<div class="patient-wrapper">
		<table>
			<tr>
				<td style="width:120px;">病历号：<span class="info-content">${registerInfo.registerId }</span></td>
				<td style="width:120px;">姓名：<span class="info-content">${registerInfo.patientInfo.patientName }</span></td>
				<td style="width:120px;">年龄：<span class="info-content">${registerInfo.patientInfo.age }</span></td>
				<td style="width:120px;">身份证号：<span class="info-content">${registerInfo.patientInfo.cardNum }</span></td>
			</tr>
			<tr>
				<td style="width:120px;">挂号科室：<span class="info-content">${registerInfo.deptInfo.deptName }</span></td>
				<td style="width:120px;">就诊医生：<span class="info-content">${registerInfo.doctorInfo.doctorName }</span></td>
			</tr>
		</table>
						  
		
	</div>
	
	<input id="medicineName" class="easyui-textbox" style="width:30%;height:32px">
	<div style="margin: 5px auto; float: left; padding-bottom: 0px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
				style="width: 100px; height: 32px" onclick="searchMedicine();">搜索</a>
	</div>
		
	 <div style="margin: 5px auto; float: left; padding-bottom: 0px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
				style="width: 100px; height: 32px" onclick="addMedicine();">添加药方</a>
	</div>
	
	 <table id="medic_dg" title="查询药" class="easyui-datagrid" style="width:99%;"
		data-options="rownumbers:true,singleSelect:true,onLoadSuccess:onLoadSuccess,onClickRow:onClickRow">
			<thead>
				<tr>
				    <th data-options="field:'medicineId'" width="5%">药品编号</th>
					<th data-options="field:'medicineName',align:'center'" width="15%">药品名称</th>
					<th data-options="field:'dosage',align:'center'" width="15%">剂量</th>
					<th data-options="field:'price',align:'center'" width="10%">单价</th>
				    <th data-options="field:'unit',align:'center'" width="5%">规格</th>
					<th data-options="field:'effectiveDate',align:'center'" width="20%">有效日期</th>					
				<th data-options="field:'num',width:'15%',align:'center',editor:{type:'numberspinner',options:{min:1,increment:1}}">数量</th>
					<th data-options="field:'action',formatter:formatterBtn1" width="10%">操作</th>
				
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${mList }" var="medicine">
				<tr>
				    <td>${medicine.medicineId }</td>
					<td>${medicine.medicineName }</td>
					<td>${medicine.dosage }</td>
					<td>${medicine.price }</td>
					<td>${medicine.unit }</td>					
					<td>${medicine.effectiveDate }</td> 
					<td>${medicine.num }</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
	
	
	<table id="dg" class="easyui-datagrid" title="药品处方" style="width:99%;"
			data-options="rownumbers:true,singleSelect:true,onLoadSuccess:onLoadSuccess,onClickRow:onClickRow">
		<thead>
			<tr>
				<th colspan="2">基本信息</th>
				<th colspan="4">总量</th>
				<th colspan="2">其他</th>
			</tr>
			<tr>
				<th data-options="field:'medicineName',align:'center'" width="15%">药品名称</th>
				<th data-options="field:'dosage',align:'center'" width="15%">剂量</th>
				<th data-options="field:'price',align:'center'" width="10%">单价</th>
				<th data-options="field:'amount'" width="10%">数量</th>
				<th data-options="field:'unit',align:'center'" width="5%">单位</th>
				<th data-options="field:'money',align:'center'" width="10%">金额</th>
				<th data-options="field:'remark',editor:'textbox'" width="15%">医嘱</th>			
				<th data-options="field:'action',formatter:formatterBtn" width="20%">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${mpList }" var="mp">
				<tr>
					<td>${mp.medicineInfo.medicineName }</td>
					<td>${mp.medicineInfo.dosage }</td>
					<td>${mp.medicineInfo.price }</td>
					<td>${mp.amount }</td>
					<td>${mp.medicineInfo.unit }</td>					
					<td>${mp.money }</td>
					<td>${mp.remark }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
		
 	
		
	<div style="padding: 10px 0 10px 93%;display:inline-block;">
		<a href="#" class="easyui-linkbutton" width="50px" title="保存">保存</a>
	</div>
	
	
		
</body>
</html>