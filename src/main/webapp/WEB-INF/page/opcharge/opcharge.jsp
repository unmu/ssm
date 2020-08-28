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
<title>门诊收费</title>
</head>
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
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/fontawesome/4.1.0/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css" />
<!-- jQuery and Bootstrap JS -->
<script type="text/javascript"
	src="//cdn.jsdelivr.net/jquery/1.11.1/jquery.min.js"></script>
<!-- <script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap/3.2.0/js/bootstrap.min.js"></script> -->
<!-- BootstrapValidator JS -->
<script type="text/javascript"
	src="//cdn.jsdelivr.net/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"></script>



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

<script type="text/javascript">
function checkNeg() {
	var totalPrice = $('#p_total_Price').val();
	var nowPrice = $('#input_actual_money').val();
	if (totalPrice - nowPrice > 0) {
		$("#btn_charge").addClass('disabled');
		$("#btn_charge").prop('disabled', true);
	} else {
		$("#btn_charge").removeClass('disabled');
		$("#btn_charge").prop('disabled', false);
	}
}
</script>
<body>
<script
		src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/i18n/defaults-*.min.js"></script>


<br>
	<!-- 模态框部分 -->
	<!-- 挂号信息Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">病人信息列表</h4>
	      </div>
	      <div class="modal-body">
			<!-- 药品信息表格 -->
			<table id="register_table" class="table table-striped table-hover">
				<caption>收费药品信息</caption>
				<thead>
				  <tr>
				    <th>选项</th>
				    <th>序号</th>
				    <th>姓名</th>
				    <th>挂号单号</th>
				    <th>性别</th>
				    <th>年龄</th>
				    <th>出生日期</th>
				    <th>科室</th>
				    <th>医生</th>
				    <th>类型</th>
				  </tr>
				</thead>
				<tbody>
				</tbody>
			</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="btn_show_detail" data-dismiss="modal">确定</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 挂号信息Modal -->

	<!-- 结算信息Modal -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">找零</h4>
	      </div>
	      	<div class="modal-body">
				<!-- 挂号单信息 -->
				<form class="form-inline">
				  <div class="form-group">
				    <label>应缴金额：</label>
				    <p id="p_pay_should_final" class="form-control-static" style="width:200px"></p>
				  </div>
				  <div class="form-group">
				    <label for="p_actual_money_final">实收金额：</label>
				    <p id="p_actual_money_final" class="form-control-static" style="width:200px"></p>
				  </div>
				  <div class="form-group">	
					<label>支付方式：</label>
					<select class="selectpicker"
						style="width: 200px;">
						<option>支付宝支付</option>
						<option>微信支付</option>
						<option>信用卡支付</option>
						<option>现金支付</option>
					</select>    
				  </div>
				  <div class="form-group">
				    <label>找零：</label>
				    <p id="p_change" class="form-control-static" style="width:200px"></p>
				  </div>
				</form>
	      	</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" id="btn_pay" class="btn btn-primary" data-dismiss="modal">确定</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 结算信息Modal -->


	<!-- 搭建显示页面 -->		
	<!-- 查询输入 -->
	<form class="form-inline">
	  <div class="form-group">
	    <label for="input_search_user_id">身份证号码</label>
	    <input type="text" class="form-control" id="input_search_user_id" placeholder="ID003">
	  </div>
	  <div class="form-group">
	    <label for="input_search_user_name">姓名</label>
	    <input type="text" class="form-control" id="input_search_user_name" placeholder="张三">
	  </div>
	  <button type="button" class="btn btn-primary" id="btn_search" data-toggle="modal" data-target="#myModal">查询</button>
	</form>
		
	<!-- 挂号单信息 -->
	<form class="form-inline" id="register_form">
	  <div class="form-group">
	    <label>姓名</label>
	    <p class="form-control-static" style="width:200px"></p>
	  </div>
	  <div class="form-group">
	    <label>年龄</label>
	    <p class="form-control-static" style="width:200px"></p>
	  </div>
	  <div class="form-group">
	    <label>性别</label>
	    <p class="form-control-static" style="width:200px"></p>
	  </div>
	  <div class="form-group">
	    <label>挂号单号</label>
	    <p class="form-control-static" style="width:172px"></p>
	  </div>
	  <div class="form-group">
	    <label>科室</label>
	    <p class="form-control-static" style="width:200px"></p>
	  </div>
	  <div class="form-group">
	    <label>医生</label>
	    <p class="form-control-static" style="width:200px"></p>
	  </div>
	</form>
		
	<!-- 药品信息表格 -->
	<table id="medicine_table"  class="table table-striped table-hover">
		<caption>收费药品信息</caption>
		<thead>
		  <tr>
		    <th>组号</th>
		    <th>药品名称</th>
		    <th>药品代码</th>
		    <th>规格</th>
		    <th>单价</th>
		    <th>单位</th>
		    <th>数量</th>
		    <th>合计金额</th>
		  </tr>
		</thead>

		<tbody>
		</tbody>
	</table>

	
	<!-- 药品总费用 -->
	<form class="form-inline">
	  <div class="form-group">
	    <label>药费合计：</label>
	    <p id="p_total_Medicine_Price" class="form-control-static" style="width:200px">00.00</p>
	  </div>
	</form>

	
	<!-- 项目信息表格 -->
	<table id="checkItem_table" class="table table-striped table-hover">
		<caption>收费项目信息</caption>
		<thead>
		  <tr>
		    <th>序号</th>
		    <th>项目名称</th>
		    <th>项目代码</th>
		    <th>单价</th>
		    <th>单位</th>
		    <th>数量</th>
		    <th>合计金额</th>
		  </tr>
		</thead>

		<tbody>
		</tbody>
	</table>

	
	<!-- 项目总费用 -->
	<form class="form-inline">
	  <div class="form-group">
	    <label>治疗费合计：</label>
	    <p id="p_total_Item_Price" class="form-control-static" style="width:200px">00.00</p>
	  </div>
	</form>
	
	<!-- 应缴纳总费用 -->
	<form class="form-inline">
	  <div class="form-group">
	    <label>应缴纳费用：</label>
	    <p id="p_total_Price" class="form-control-static" style="width:200px">00.00</p>
	  </div>
	</form>
	
	<!-- 实际收费金额 -->
	<form class="form-inline">
	  <div class="form-group">
	    <label for="input_actual_money">实收金额：</label>
	    <input type="text" class="form-control" id="input_actual_money" placeholder="0.00" onkeyup="checkNeg();">
	  </div>
	  <button type="button" class="btn btn-primary disabled" id="btn_charge" data-toggle="modal" data-target="#myModal2" disabled>缴费</button>
	</form>
	

</body>


<script type="text/javascript">

	var currentRegisterID;

	//1.点击查询按钮，通过身份证号码和姓名查询挂号信息
    $('#btn_search').click(function () {
		
		var searchUserID = $("#input_search_user_id").val();
		var searchUserName = $("#input_search_user_name").val();

        $.ajax({
        	url:"<%=path %>/opcharge/searchRegisterUnpaid",
        	data:{userID:searchUserID,userName:searchUserName},
        	success:function(data,textStatus){
        		console.log(data);
        		build_register_table(data);
			},
			error:function(data,textStatus) {
				//alert("error: "+textStatus)
				alert("该用户没有挂号记录！")
			}
        });
    });
	
	//创建挂号单表格
	function build_register_table(data){
		//清空table表格
		$("#register_table tbody").empty();
		var number = 0;
		$.each(data,function(index,item){
			var checkBoxTd = $("<td><input type='radio' class='check_item' name='registerRadio'/></td>");
			var numberTd = $("<td></td>").append(++number);
			var nameTd = $("<td></td>").append(item.patientInfo.patientName);
			var registerIdTd = $("<td></td>").append(item.registerId);
			var sexTd = $("<td></td>").append(item.patientInfo.sex==0?"男":"女");
			var ageTd = $("<td></td>").append(item.patientInfo.age);
			var birthdayTd = $("<td></td>").append(item.patientInfo.birthday);
			var deptNameTd = $("<td></td>").append(item.deptInfo.deptType);
			var doctorTd = $("<td></td>").append(item.doctorInfo.doctorName);
			var expensesTypeTd = $("<td></td>").append(item.expensesType==0?"自费":"公费");

			//append方法执行完成以后还是返回原来的元素
			$("<tr></tr>").append(checkBoxTd)
				.append(numberTd)
				.append(nameTd)
				.append(registerIdTd)
				.append(sexTd)
				.append(ageTd)
				.append(birthdayTd)
				.append(deptNameTd)
				.append(doctorTd)
				.append(expensesTypeTd)
				.appendTo("#register_table tbody");
		});
	}
	
	
	
	$('#btn_show_detail').click(function () {
		
		var selectedItem = $('input[name="registerRadio"]:checked');
		
		//保存已选挂号单
		currentRegisterID = $(selectedItem).parents("tr").find("td:eq(3)").text();
		
	    //显示挂号单信息
		$("#register_form").find("p:eq(0)").html($(selectedItem).parents("tr").find("td:eq(2)").text());//赋值姓名
		$("#register_form").find("p:eq(1)").html($(selectedItem).parents("tr").find("td:eq(5)").text());//赋值年龄
		$("#register_form").find("p:eq(2)").html($(selectedItem).parents("tr").find("td:eq(4)").text());//赋值性别
		$("#register_form").find("p:eq(3)").html($(selectedItem).parents("tr").find("td:eq(3)").text());//赋值挂号单号
		$("#register_form").find("p:eq(4)").html($(selectedItem).parents("tr").find("td:eq(7)").text());//赋值科室
		$("#register_form").find("p:eq(5)").html($(selectedItem).parents("tr").find("td:eq(8)").text());//赋值医生
		
		
		var totalMedicinePrice = 0;
		var totalItemPrice = 0;
		
		//填充药费表信息		
		$.ajax({
        	url:"<%=path %>/opcharge/searchMedicineListUnpaid",
        	data:{RegisterId:currentRegisterID},
        	success:function(data,textStatus){
        		console.log(data);
        		totalMedicinePrice = build_medicine_table(data);
			},
			error:function(data,textStatus) {
				//alert("error: "+textStatus)
				alert("发生错误！")
			},
			complete:function(){
				//填充项目费表信息	
				$.ajax({
		        	url:"<%=path %>/opcharge/searchItemListUnpaid",
		        	data:{RegisterId:currentRegisterID},
		        	success:function(data,textStatus){
		        		console.log(data);
		        		totalItemPrice = build_checkItem_table(data);
					},
					error:function(data,textStatus) {
						//alert("error: "+textStatus)
						alert("发生错误！")
					},
					complete:function(){
						var totalPrice = totalMedicinePrice + totalItemPrice;
						//设置应缴金额
						set_should_pay(totalPrice);
					}
		        })
			}	
			
        });
		

	  });
	
	//设置应缴金额
	function set_should_pay(totalPrice){
		
		$("#p_total_Price").html(totalPrice);
		$("#p_total_Price").val(totalPrice);
		$("#p_pay_should_final").html(totalPrice);
	};

	//创建药费表格  并返回药品总费用
	function build_medicine_table(data){
		//清空table表格
		$("#medicine_table tbody").empty();
		var number = 0;
		var totalMedicinePrice = 0;
		$.each(data,function(index,item){
			var numberTd = $("<td></td>").append(++number);
			var nameTd = $("<td></td>").append(item.medicineInfo.medicineName);
			var codeTd = $("<td></td>").append(item.medicineInfo.medicineNo);
			var dosageTd = $("<td></td>").append(item.medicineInfo.dosage);			
			var priceTd = $("<td></td>").append(item.medicineInfo.price);
			var unitTd = $("<td></td>").append(item.medicineInfo.unit);
			var amountTd = $("<td></td>").append(item.amount);
			var sumPriceTd = $("<td></td>").append(item.medicineInfo.price*item.amount);
			totalMedicinePrice += item.medicineInfo.price*item.amount;
			
			//append方法执行完成以后还是返回原来的元素
			$("<tr></tr>").append(numberTd)				
				.append(nameTd)
				.append(codeTd)
				.append(dosageTd)
				.append(priceTd)
				.append(unitTd)
				.append(amountTd)
				.append(sumPriceTd)
				.appendTo("#medicine_table tbody");
		});
		
		$("#p_total_Medicine_Price").html(totalMedicinePrice);
		return totalMedicinePrice;
	};
	
	//创建项目费表格  并返回项目总费用
	function build_checkItem_table(data){
		//清空table表格
		$("#checkItem_table tbody").empty();
		var number = 0;
		var totalItemPrice = 0;
		$.each(data,function(index,item){
			var numberTd = $("<td></td>").append(++number);
			var nameTd = $("<td></td>").append(item.inspectionItem.itemName);
			var codeTd = $("<td></td>").append(item.inspectionItem.itemId);
			var priceTd = $("<td></td>").append(item.inspectionItem.price);
			var unitTd = $("<td></td>").append(item.inspectionItem.unit);
			var amountTd = $("<td></td>").append(item.amount);
			var sumPriceTd = $("<td></td>").append(item.inspectionItem.price*item.amount);
			totalItemPrice += item.inspectionItem.price*item.amount;
			
			//append方法执行完成以后还是返回原来的元素
			$("<tr></tr>").append(numberTd)				
				.append(nameTd)
				.append(codeTd)
				.append(priceTd)
				.append(unitTd)
				.append(amountTd)
				.append(sumPriceTd)
				.appendTo("#checkItem_table tbody");
		});
		
		$("#p_total_Item_Price").html(totalItemPrice);
		return totalItemPrice;
	};
	
	
	//点击缴费按钮，弹出模态框，并把一些数据传进去
	$('#btn_charge').click(function () {
		
		var input_actual_value = $("#input_actual_money").val();
		var totalPrice = $("#p_total_Price").val();
		
		$("#p_actual_money_final").html(input_actual_value);
		$("#p_change").html(input_actual_value-totalPrice);
		
    });
	
	//点击确认按钮 将信息同步到数据库中
	$('#btn_pay').click(function () {
		
		$.ajax({
        	url:"<%=path %>/opcharge/pay",
        	data:{RegisterId:currentRegisterID},
        	success:function(data,textStatus){
        		alert("付款成功！")
        		window.location.href = "<%=path%>/opcharge/opcharge";
			},
			error:function(data,textStatus) {
				//alert("error: "+textStatus)
				alert("发生错误！")
			}
        });
		
    });
	
	
	
</script>


</html>