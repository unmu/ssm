<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>	
<%
	String path = pageContext.getServletContext().getContextPath();
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>病人诊断信息</title>
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
</head>
<body style="padding:0px">
<div class="easyui-tabs" style="width:98%;min-height:99%;">
			<input type="hidden" name="registerInfo.registerId" id="registerId" value="${registerInfo.registerId }">
	  <div title="诊断信息" style="padding:10px">
			<div style="margin-left: 10px; float: left; line-height: 32px; width: 200px;font-weight: bold;">病历号：<span style="color: #008B8B;">
				${registerInfo.patientInfo.patientCard}</span></div>
			<div style="float: left; line-height: 32px; width: 150px;font-weight: bold;">姓名：
					<span style="color: #008B8B;">${registerInfo.patientInfo.patientName}</span></div>
			<div style="float: left; line-height: 32px; width: 120px;font-weight: bold;">年龄：
					<span style="color: #008B8B;"> ${registerInfo.patientInfo.age}</span></div>
			<div style="float: left; line-height: 32px; width: 300px;font-weight: bold;">身份证号：
					<span style="color: #008B8B;">${registerInfo.patientInfo.cardNum}</span></div>
			<div style="clear: both;"></div>
			<div style="margin-left: 10px; float: left; line-height: 32px;width: 200px;font-weight: bold;">挂号科室：
					<span style="color: #008B8B;">${registerInfo.deptInfo.deptName}</span></div>
			<div style="float: left; line-height: 32px;width: 200px;font-weight: bold;">就诊医生：
					<span style="color: #008B8B;">${registerInfo.doctorInfo.doctorName}</span></div>

			<div style="clear: both;"></div>
			<!-- 主观资料 -->
			
				<div style="margin-top:10px;line-height:30px; font-weight: bold;border-bottom:1px solid #e5e5e5;  ">
				<div class="div_panel">主观资料</div>
				</div>
				<div style="clear: both;"></div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">发病日期：</div>
					<input class="easyui-datebox" name="onsetDate" value="${registerInfo.diagnosisInfo.onsetDate }" disabled="disabled" style="width:200px;">
				</div>
				<div style="clear: both;"></div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">主诉：</div>
					<input class="easyui-textbox" data-options="multiline:true" name="narration" value="${registerInfo.diagnosisInfo.narration }" disabled="disabled" style="width:700px;height:100px">
				</div>
				<div style="clear: both;"></div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">现病史：</div>
					<input class="easyui-textbox" data-options="multiline:true" name="hpi" value="${registerInfo.diagnosisInfo.hpi }" disabled="disabled"  style="width:150px;height:50px">
				</div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">既往史：</div>
					<input class="easyui-textbox" data-options="multiline:true" name="pmp" value="${registerInfo.diagnosisInfo.pmp }" disabled="disabled" style="width:150px;height:50px">
				</div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">过敏史：</div>
					<input class="easyui-textbox" data-options="multiline:true" name="allergyHistory" value="${registerInfo.diagnosisInfo.allergyHistory }" disabled="disabled" style="width:150px;height:50px">
				</div>

				<div style="clear: both;"></div>
				<!-- 问题评估 -->
				
				<div style="margin-top:10px;line-height:30px; font-weight: bold;border-bottom:1px solid #e5e5e5;  ">
				<div class="div_panel">问题评估</div>
				</div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">诊断：</div>
					<input type="text" class="easyui-textbox" name="diagContent" value="${registerInfo.diagnosisInfo.diagContent }" disabled="disabled"  style="width:400px;height:50px">
				</div>
				<div style="clear: both;"></div>
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">诊断备注：</div>
					<input type="text" class="easyui-textbox" name="diagRemarks" value="${registerInfo.diagnosisInfo.diagRemarks }" disabled="disabled" style="width:400px;height:50px">
				</div>
				<div style="clear: both;"></div>
			<!-- 处置计划-->
			
				<div style="margin-top:10px;line-height:30px; font-weight: bold;border-bottom:1px solid #e5e5e5;  ">
				<div class="div_panel">处置计划</div>
				</div>
				
				<div style="float: left; padding: 10px;">
					<div style="float: left; width:100px;">处置计划：</div>
					<input class="easyui-textbox" data-options="multiline:true" name="disposalPlan" value="${registerInfo.diagnosisInfo.disposalPlan }" disabled="disabled" style="width:700px;height:100px">
				</div>
		</div>
		<!--  药品处方 -->
		<div title="药品处方" style="padding:10px">		
		药品处方
		</div>
		<!-- 检查项目 -->
		<div title="检查项目" style="padding:10px">
		检查项目
		</div>
		<!-- 处方列表 -->
		<div title="处方列表" style="padding:10px">
		处方列表
		</div>
	</div>
</body>
</html>
