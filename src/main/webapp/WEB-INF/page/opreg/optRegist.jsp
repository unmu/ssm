<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = pageContext.getServletContext().getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.radius-box {
	margin: 10px;
	padding: 8px;
	border: 1px solid lightgray;
	border-radius: 8px;
}

.label-std1 {
	width: 60px;
	text-align: right;
}

.bottom-button {
	width: 320px;
	margin: 0 auto;
	margin-top: 20px;
}

.bottom-button button {
	margin: 10px;
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="<%=path%>/jquery-easyui-1.8.6/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
<!-- <link rel="stylesheet" href="//cdn.jsdelivr.net/jquery.bootstrapvalidator/0.5.2/css/bootstrapValidator.min.css"/>
<script type="text/javascript" 
		src="https://cdn.jsdelivr.net/jquery.bootstrapvalidator/0.5.2/js/bootstrapValidator.min.js"></script>
	 -->
<!-- <link rel="stylesheet"
	href="//cdn.jsdelivr.net/fontawesome/4.1.0/css/font-awesome.min.css" /> -->
<!-- <link rel="stylesheet"
	href="//cdn.jsdelivr.net/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css" />
jQuery and Bootstrap JS
<script type="text/javascript"
	src="//cdn.jsdelivr.net/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap/3.2.0/js/bootstrap.min.js"></script>
BootstrapValidator JS
<script type="text/javascript"
	src="//cdn.jsdelivr.net/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"></script> -->

<script type="text/javascript">
$(document).ready(function () { 
	// 页面加载后，初始化科室基本信息
    getDeptInfoList();
});
//获取科室信息
function getDeptInfoList() {
    $.ajax({
        url:'<%=path%>/opreg/getDeptInfoList',
        // data: args,
        success:function(data){
			// console.log(data)
            $.each(data,function(i,o){
				$("#deptId").append("<option value=\""+o.deptId+"\">"+o.deptName+" | "+o.deptType+"</option>")
            })
            $('#deptId').selectpicker('refresh');
            $('#deptId').selectpicker('render');
        }
    });
}

//根据科室，获取医生信息
function getDoctInfoListByDeptId(deptId) {
    $.ajax({
        url:'<%=path%>/opreg/getDoctInfoListByDeptId',
        data: {deptId:deptId},
        success:function(data){
            // console.log(data)
            $.each(data,function(i,o){
                // console.log(i+"|----|"+o.doctorId+"|"+o.doctorName+"|"+o.workAge+"|");
                $("#doctorId").append("<option value=\""+o.doctorId+"\">"+o.doctorName+"</option>")
            })
            $('#doctorId').selectpicker('refresh');
            $('#doctorId').selectpicker('render');
        }
    });
}
//修改科室时，清掉原有医生，重新获取医生信息
function changeDeptId() {
    $("#doctorId option").remove();
    $("#doctorId").append("<option value=\"\">--请选择--</option>")
    getDoctInfoListByDeptId($('#deptId').val())
}

//提交挂号信息
function submitRegister() {
    var patientCard = $("#ptCard").text();//就诊卡号-取td中的值
    //alert(patientCard);
    var deptId = $("#deptId").val();//科室id
    var doctorId = $("#doctorId").val();//医生id
    var expensesType = $("#expensesType").val();//费别，0---自费，1-公费
    var diagnosisType = $("#diagnosisType").val();//初复诊（0--初诊，1-复诊）
    var registerType = $("#registerType").val();//挂号类别（0-普通号，1-专家号）
    var money = $("#money").val();
	
    var args = {
            patientCard : patientCard,
            deptId : deptId,
            doctorId : doctorId,
            expensesType: expensesType,
            diagnosisType: diagnosisType,
            registerType: registerType,
            money: money
        }
        $.ajax({
            url:'<%=path%>/opreg/addRegisterInfo',
            data: args,
            success:function(data){
                if(data == true){
                    alert("挂号成功！")
                    $('#payModal').modal('toggle');
                    $('#payModal').on(
                    		'hidden.bs.modal',
                    		function(data) {
							//alert(data);
				
                    		});
                    window.location.href = "<%=path%>/opreg/loadOptRegistPage";
                }
            }
        });
    
}
// 获取应付金额
function changeMoney() {
    $("#money2").val( $("#money").val());
}
// 点击“保存”按钮进入结算模态框
function saveInfo() {
	var patientCard = $("#ptCard").text();//就诊卡号-取td中的值
    var deptId = $("#deptId").val();//科室id
    var doctorId = $("#doctorId").val();//医生id
    var errMsg = "";

	if(!patientCard) errMsg += " ● 未选择挂号病人！\n";
	if(!deptId) errMsg += " ● 未选择科室！\n";
	if(!doctorId) errMsg += " ● 未选择医生！\n";
	
	if(errMsg != ""){
        alert("抱歉，填写数据有异常： \n"+errMsg);
        return false;
    }
	
	$('#payModal').modal('toggle');
	$('#payModal').on(
			'show.bs.modal',
			function(data) {
				//alert(data);
				
			})
	
	$("#diffMoney").val("");
    $("#trueMoney").val("");
    $("#payFinishedBtn").addClass('disabled');
	$("#payFinishedBtn").prop('disabled', true);
}
function changeTrueMoney() {
    var diff = $("#trueMoney").val()*1 - $("#money").val()*1;
    $("#diffMoney").val(diff.toFixed(2));
    //alert(diff);
    if (diff < 0) {
    	$("#payFinishedBtn").addClass('disabled');
    	$("#payFinishedBtn").prop('disabled', true);
    } else {
    	$("#payFinishedBtn").removeClass('disabled');
    	$("#payFinishedBtn").prop('disabled', false);
    }
}

//查找病人
function searchPatient(){
	var patientName = $("#searchPatientName").val();
	var cardNum = $("#searchCardNum").val();
	$.post("<%=path%>/opreg/searchPatient", {
			patientName : patientName,
			cardNum : cardNum
		}, function(data, textStatus) {
			if (textStatus == "success") {
				//alert("查找到病人：" + data.length);
				if (data.length == 1) {//查找到一条病人信息
					$(data).each(
							function(index, item) {
								var pSex;
								if (item.sex == 0) {
									pSex = '男';
								} else {
									pSex = '女';
								}
								$('#selectedPatient tbody').empty();
								$('#selectedPatient tbody').append(
										'<tr><td id="ptCard">' + item.patientCard 
												+ '</th><td id="ptName">' + item.patientName
												+ '</td><td id="ptSex">' + pSex
												+ '</td><td id="ptAge">' + item.age
												+ '</td><td id="ptBirth">' + item.cardNum
												+ '</td></tr>');
							});
				} else if (data.length == 0) {//查不到病人信息
					//alert("查不到病人信息");
					//$('#addPatientModal').empty();
					$('#addPatientModal').modal('toggle');
					$('#addPatientModal').on(
							'show.bs.modal',
							function(data) {
								//alert(data);
								
							})
				} else {//查到多人，则选择该需要挂号的病人
					$('#findPatients tbody').empty();
					$(data).each(
							function(index, item) {
								$('#findPatients tbody').append(
										'<tr><th>' + (index + 1)
												+ '</th><td>' + item.patientCard
												+ '</td><td>' + item.patientName
												+ '</td><td>' + item.cardNum
												+ '</td><td>' + item.tel
												+ '</td><td>'
												+ '<button type="button" class="btn btn-primary btn-sm" onclick="selectPatientBtn(&quot;' + item.patientCard + '&quot;,' + index +');"> 选择 </button>'
												+ '</td></tr>');
							});
					$('#patientListModal').modal('toggle');
					$('#patientListModal').on(
							'show.bs.modal',
							function(e) {
								//alert(e);
								
							})
				}
			}
		})

	}
//选择病人
function selectPatientBtn(patientCard, index){
	$.ajax({
        url: "<%=path%>/opreg/getPatientByPatientCard",
        data: {patientCard : patientCard},
        success: function (data, textStatus) {
            if (textStatus == "success") {
            	//alert(data.patientName);
            	var pSex;
				if (data.sex == 0) {
					pSex = '男';
				} else {
					pSex = '女';
				}
				$('#selectedPatient tbody').empty();
            	$('#selectedPatient tbody').append(
						'<tr><td id="ptCard">' + data.patientCard 
								+ '</th><td id="ptName">' + data.patientName
								+ '</td><td id="ptSex">' + pSex
								+ '</td><td id="ptAge">' + data.age
								+ '</td><td id="ptBirth">' + data.cardNum
								+ '</td></tr>');
            	$('#patientListModal').modal('toggle');
            	$('#patientListModal').on(
						'hidden.bs.modal',
						function(e) {
							//alert(e);
							
						})
            }
        },
		error:function(data,textStatus) {
			alert("error: "+textStatus);
		}
	})
}
//添加病人信息
function insertPatient() {
	var ptName = $('#addPtName').val();
	var ptSex = $('#addPtSex').val();
	var ptAge = $('#addPtAge').val();
	var cardNum = $('#addCardNum').val();
	//alert(cardNum);
	var tel = $('#addTel').val();
	var address = $('#addAddress').val();
	var nationality = $('#addNationality').val();
	var nation = $('#addNation').val();
	var edu = $('#addEdu').val();
	var pro = $('#addPro').val();
	var blood = $('#addBlood').val();
	var marriage = $('#addMarriage').val();
	if (ptName == "" || cardNum == "" || tel == "") {
		alert("姓名、身份证号、电话号码不能为空");
	} else {
	var args = {patientName: ptName, sex: ptSex, age: ptAge, cardNum: cardNum, tel: tel, address: address, 
			nationality: nationality, nation: nation, education: edu, profession: pro, blood: blood, marriage: marriage};
	$.ajax({
		url:"<%=path%>/opreg/insertPatient",
		data:args,
		success:function(data,textStatus){
			if(textStatus=="success") {
				//alert(data);
				$('#addPatientModal').modal('toggle');
				$('#addPatientModal').on(
						'hidden.bs.modal',
						function(data) {
							//alert(data);
							
						});
				<%-- window.location.href = "<%=path%>/opreg/loadOptRegistPage"; --%>
				var pSex;
				if (data.sex == 0) {
					pSex = '男';
				} else {
					pSex = '女';
				}
				$('#selectedPatient tbody').empty();
				$('#selectedPatient tbody').append(
						'<tr><td id="ptCard">' + data.patientCard 
								+ '</th><td id="ptName">' + data.patientName
								+ '</td><td id="ptSex">' + pSex
								+ '</td><td id="ptAge">' + data.age
								+ '</td><td id="ptBirth">' + data.cardNum
								+ '</td></tr>');
			}
		},
		error:function(data,textStatus) {
			alert("error: "+textStatus)
		}
	})
	}
}

//取消 按钮
function refreshPage() {
	window.location.href = "<%=path%>/opreg/loadOptRegistPage";
}
</script>
</head>
<body>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/i18n/defaults-*.min.js"></script>

	<!-- 添加病人信息-模态框 start -->
	<div class="modal fade" id="addPatientModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">病人基本信息</h4>
				</div>
				<div class="modal-body">
					<!-- 模态框主内容 -->

					<form class="form-horizontal" method="post" id="addPtForm">
						<!-- 卡号 UUID 生成 -->
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">姓名</label>
							<input type="text" class="form-control col-sm-7"
								style="width: 70%" placeholder="姓名" id="addPtName">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">性别</label>
							<select class="selectpicker" id="addPtSex">
								<option value="0">男</option>
								<option value="1">女</option>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">年龄</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="年龄" id="addPtAge">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">身份证号</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="身份证号" id="addCardNum">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">电话号码</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="电话号码" id="addTel">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">居住地址</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="居住地址" id="addAddress">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">国籍</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="国籍" id="addNationality">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">民族</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="民族" id="addNation">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">文化程度</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="文化程度" id="addEdu">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">职业</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="职业" id="addPro">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">血型</label>
							<input type="text" class="form-control col-sm-8"
								style="width: 70%" placeholder="血型" id="addBlood">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">婚姻状况</label>
							<select class="selectpicker" id="addMarriage">
								<option value="0">未婚</option>
								<option value="1">已婚</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="submit" class="btn btn-primary"
						onclick="insertPatient();">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 添加病人信息-模态框 end -->

	<!-- 病人列表-模态框 start -->
	<div class="modal fade" id="patientListModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">病人列表</h4>
				</div>
				<div class="modal-body">
					<!-- 模态框主内容 -->

					<table class="table table-hover" id="findPatients">
						<thead>
							<tr>
								<th>#</th>
								<th>病人卡号</th>
								<th>病人姓名</th>
								<th>身份证号</th>
								<th>电话</th>
								<th>-</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 病人列表-模态框 end -->

	<!-- 结算-模态框 start -->
	<div class="modal fade" id="payModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">挂号结算</h4>
				</div>
				<div class="modal-body">
					<!-- 模态框主内容 -->
					<form class="form-horizontal" action="" method="post">

						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">总金额</label>
							<input type="number" class="form-control col-sm-8"
								style="width: 70%" placeholder="0.00" id="money2" disabled>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">付费金额</label>
							<input type="number" class="form-control col-sm-8"
								style="width: 70%" placeholder="0.00" id="trueMoney"
								onkeyup="changeTrueMoney()">
						</div>
						<div class="form-group">
							<label class="control-label col-sm-2" style="width: 20%">找零</label>
							<input type="number" class="form-control col-sm-8"
								style="width: 70%" placeholder="0.00" id="diffMoney">
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary disabled"
						id="payFinishedBtn" onclick="submitRegister()" disabled>结算</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 结算-模态框 end -->

	<!-- 基础界面 -->
	<form class="form-inline radius-box" style="border: none">
		<div class="form-group">
			<label for="exampleInputName2" class="label-std1">姓名</label> <input
				type="text" class="form-control" id="searchPatientName"
				placeholder="姓名">
		</div>
		<div class="form-group">
			<label for="exampleInputEmail2" class="label-std1">身份证号</label> <input
				type="text" class="form-control" id="searchCardNum"
				placeholder="身份证号">
		</div>
		<button type="button" class="btn btn-primary"
			onclick="searchPatient();">查询</button>
		<!-- data-toggle="modal"
			data-target="#patientListModal" -->

		<button type="button" class="btn btn-primary"
			style="margin-left: 20px;" data-toggle="modal"
			data-target="#addPatientModal">添加病人信息</button>
	</form>

	<div class="radius-box" style="border: none">
		<div style="margin: 8px">
			<label class="label-std1">费别</label> <select id="expensesType"
				class="selectpicker">
				<option value="0">自费</option>
				<option value="1">公费</option>
			</select> <label class="label-std1">初复诊</label> <select id="diagnosisType"
				class="selectpicker">
				<option value="0">初诊</option>
				<option value="1">复诊</option>
			</select> <label class="label-std1">挂号类型</label> <select id="registerType"
				class="selectpicker">
				<option value="0">普通号</option>
				<option value="1">专家号</option>
			</select>
		</div>
		<div style="margin: 8px">
			<label class="label-std1">科室选择</label> <select id="deptId"
				class="selectpicker" onchange="changeDeptId()">
				<option value="">--请选择--</option>
			</select> <label class="label-std1">医生</label> <select id="doctorId"
				class="selectpicker">
				<option value="">--请选择--</option>
			</select>
		</div>
	</div>
	<div class="radius-box">
		<table class="table table-hover" id="selectedPatient">
			<thead>
				<tr>
					<th>卡号</th>
					<th>姓名</th>
					<th>性别</th>
					<th>年龄</th>
					<th>身份证号</th>
				</tr>
			</thead>
			<tbody>
				<!-- <tr>
					<th scope="row">1</th>
					<td>病人卡号</td>
					<td>姓名</td>
					<td>性别</td>
					<td>年龄</td>
					<td>出生日期</td>
				</tr> -->
			</tbody>
		</table>
	</div>
	<form class="form-inline radius-box" style="border: none">
		<div class="form-group">
			<label for="exampleInputEmail2" class="label-std1">金额</label> <input
				type="number" class="form-control" id="money"
				onkeyup="changeMoney()" placeholder="0.00">
		</div>
		<div class="bottom-button">
			<button type="button" class="btn btn-success" onclick="saveInfo();">保存</button>
			<button type="button" class="btn btn-warning" onclick="refreshPage();">取消</button>
		</div>
	</form>


</body>
</html>