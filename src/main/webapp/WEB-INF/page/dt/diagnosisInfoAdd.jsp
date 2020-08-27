<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = pageContext.getServletContext().getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>病人诊断信息</title>

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
	<style type="text/css">
		.div_panel{
			font-size: 14px;
			color:#fefefe;
			text-align:center;
			width: 100px;
			background-color:#96CDCD; 
			border: 1px solid #e5e5e5;
			border-radius: 5px 5px 0 0 ;
		}
	</style>
	
	<script type="text/javascript">
	function saveDiagnosisInfo(){
		var items=  $("#diagnosisForm").serialize();
        $.ajax({
           url:"<%=path%>/dt/saveDiagnosisInfo",
           type:"post",
           data:items,
           success:function(data,textStatus){   
              if(data) {
            	  alert("诊断完成，前往处方页面。");
            	  window.location.href="<%=path%>/dt/patientPerscription"
              }
           } ,
           error:function(){
             alert("诊断失败！");
           }
        }); 

    }
	
	function cancleSave(){
		$("#div1").datebox('setValue', '');
		$("#div2").textbox('setValue', '');
		$("#div3").textbox('setValue', '');
		$("#div4").textbox('setValue', '');
		$("#div5").textbox('setValue', '');
		$("#div6").textbox('setValue', '');
		$("#div7").textbox('setValue', '');
		$("#div8").textbox('setValue', '');
    }
</script>

</head>

<body style="padding:0px">
	  <div class="easyui-tabs" style="width:98%;min-height:99%;">
		<div title="诊断信息" style="padding:10px">
		<form class="form-inline" id="diagnosisForm" >
			<input type="hidden" name="registerInfo.registerId" value="${registerInfo.registerId }">
			<div style="margin-left: 10px; float: left; line-height: 32px; width: 200px;font-weight: bold;">病历号：<span style="color: #CD5C5C;">
				${registerInfo.patientInfo.patientCard}</span></div>
			<div style="float: left; line-height: 32px; width: 150px;font-weight: bold;">姓名：
					<span style="color: #CD5C5C;">${registerInfo.patientInfo.patientName}</span></div>
			<div style="float: left; line-height: 32px; width: 120px;font-weight: bold;">年龄：
					<span style="color: #CD5C5C;"> ${registerInfo.patientInfo.age}</span></div>
			<div style="float: left; line-height: 32px; width: 300px;font-weight: bold;">身份证号：
					<span style="color: #CD5C5C;">${registerInfo.patientInfo.cardNum}</span></div>
			<div style="clear: both;"></div>
			<div style="margin-left: 10px; float: left; line-height: 32px;width: 200px;font-weight: bold;">挂号科室：
					<span style="color: #CD5C5C;">${registerInfo.deptInfo.deptName}</span></div>
			<div style="float: left; line-height: 32px;width: 200px;font-weight: bold;">就诊医生：
					<span style="color: #CD5C5C;">${registerInfo.doctorInfo.doctorName}</span></div>

			<div style="clear: both;"></div>
			<!-- 主观资料 -->
			
				<div style="margin-top:10px;line-height:30px; font-weight: bold;border-bottom:1px solid #e5e5e5;  ">
				<div class="div_panel">主观资料</div>
				</div>
				<div style="clear: both;"></div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">发病日期：</div>
					<input id="div1" class="easyui-datebox" name="onsetDate" style="width:200px;">
				</div>
				<div style="clear: both;"></div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">主诉：</div>
					<input id="div2" type="text" class="easyui-textbox" data-options="multiline:true" name="narration" style="width:700px;height:100px">
				</div>
				<div style="clear: both;"></div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">现病史：</div>
					<input id="div3" type="text" class="easyui-textbox" data-options="multiline:true" name="hpi" style="width:150px;height:50px">
				</div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">既往史：</div>
					<input id="div4" type="text" class="easyui-textbox" data-options="multiline:true" name="pmp" style="width:150px;height:50px">
				</div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">过敏史：</div>
					<input id="div5" type="text" class="easyui-textbox" data-options="multiline:true" name="allergyHistory" style="width:150px;height:50px">
				</div>

				<div style="clear: both;"></div>
				<!-- 问题评估 -->
				
				<div style="margin-top:10px;line-height:30px; font-weight: bold;border-bottom:1px solid #e5e5e5;  ">
				<div class="div_panel">问题评估</div>
				</div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">诊断：</div>
					<input id="div6" type="text" class="easyui-textbox" name="diagContent" style="width:400px;height:50px">
				</div>
				<div style="clear: both;"></div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">诊断备注：</div>
					<input id="div7" type="text" class="easyui-textbox" name="diagRemarks" style="width:400px;height:50px">
				</div>
				<div style="clear: both;"></div>
			<!-- 处置计划-->
			
				<div style="margin-top:10px;line-height:30px; font-weight: bold;border-bottom:1px solid #e5e5e5;  ">
				<div class="div_panel">处置计划</div>
				</div>
				
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">处置计划：</div>
					<input id="div8" type="text" class="easyui-textbox" data-options="multiline:true" name="disposalPlan" style="width:700px;height:100px">
				</div>

			<div style="clear: both;"></div>
			<div style="float: left;padding-left:300px;">	
				<a href="#" class="easyui-linkbutton"  style="padding:2px 10px;background: #5cb85c;color: #fff;border-color: #4cae4c" onclick="saveDiagnosisInfo()">保存</a>
			</div>
			<div style="float: left;padding-left:20px;">	
				<a href="#" class="easyui-linkbutton"  style="padding:2px 10px;background: #f0ad4e;color: #fff;border-color: #eea236" onclick="cancleSave()">重置</a>
			</div>
		</form>
		</div>
	</div>
</body>
</html>
