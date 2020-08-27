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
<!--  引入静态css -->
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
<!--使用Bootstrap的js插件，必须先调入jQuery-->
<script src="http://libs.baidu.com/jquery/1.9.0/jquery.min.js"></script>
<!-- 包括所有bootstrap的js插件或者可以根据需要使用的js插件调用　-->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script> 
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css"
		rel="stylesheet">
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
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

<body>
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
			<table class="table table-striped table-hover">
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
				<!-- <tbody>
				  <tr>
				  	<td>选项</td>
				    <td>1</td>
				    <td>张三</td>
				    <td>4551351654651</td>
				    <td>男</td>
				    <td>21</td>
				    <td>1999-10-10</td>
				    <td>内科</td>
				    <td>王建</td>
				    <td>自费</td>
				  </tr>
				  <tr>
				    <td>选项</td>
				    <td>1</td>
				    <td>张三</td>
				    <td>4551351654651</td>
				    <td>男</td>
				    <td>21</td>
				    <td>1999-10-10</td>
				    <td>内科</td>
				    <td>王建</td>
				    <td>自费</td>
				  </tr>
				</tbody> -->
				<tbody id="userBody"> 
				</tbody>
			</table>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="confirmRegister()">确实</button>
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
				    <p class="form-control-static" style="width:200px">张三</p>
				  </div>
				  <div class="form-group">
				    <label for="input_actual_money">实收金额：</label>
				    <input type="text" class="form-control" id="input_actual_money">
				  </div>
				  <div class="form-group">	
					<label class="label-std1">支付方式：</label>
					<select class="selectpicker"
						style="width: 100px;">
						<option>自费</option>
						<option>公费</option>
					</select>    
				  </div>
				  <div class="form-group">
				    <label>找零：</label>
				    <p class="form-control-static" style="width:200px">张三</p>
				  </div>
				</form>
	      	</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary">确定</button>
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
	    <input type="text" class="form-control" id="inputSearchCardNum">
	  </div>
	  <div class="form-group">
	    <label for="input_search_user_name">姓名</label>
	    <input type="text" class="form-control" id="inputSearchPatientName">
	  </div>
	  <button type="button" class="btn btn-primary" id="btn_search" data-toggle="modal" data-target="#myModal">查询</button>
	</form>
		
	<!-- 挂号单信息 -->
	<form class="form-inline">
	  <div class="form-group">
	    <label>姓名</label>
	    <p class="form-control-static" style="width:200px" id="pName"></p>
	  </div>
	  <div class="form-group">
	    <label>年龄</label>
	    <p class="form-control-static" style="width:200px" id="pAge"></p>
	  </div>
	  <div class="form-group">
	    <label>性别</label>
	    <p class="form-control-static" style="width:200px" id="pSex"></p>
	  </div>
	  <div class="form-group">
	    <label>挂号单号</label>
	    <p class="form-control-static" style="width:172px" id="pRegistId"></p>
	  </div>
	  <div class="form-group">
	    <label>科室</label>
	    <p class="form-control-static" style="width:200px" id="pDept"></p>
	  </div>
	  <div class="form-group">
	    <label>医生</label>
	    <p class="form-control-static" style="width:200px" id="pDoct"></p>
	  </div>
	</form>
		
	<!-- 药品信息表格 -->
	<table class="table table-striped table-hover">
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
		    <th>退费数量</th>
		    <th>合计金额</th>
		    <th>退费金额</th>
		    <th>操作</th>
		  </tr>
		</thead>

		<tbody id="medicBody">
		</tbody>
	</table>
	
	<!-- 项目信息表格 -->
	<table class="table table-striped table-hover">
		<caption>收费项目信息</caption>
		<thead>
		  <tr>
		    <th>序号</th>
		    <th>项目编号</th>
		    <th>项目名称</th>
		    <th>单价</th>
		    <th>单位</th>
		    <th>数量</th>
		    <th>退费数量</th>
		    <th>合计金额</th>
		    <th>退费金额</th>
		    <th>操作</th>
		  </tr>
		</thead>

		<tbody id="itemBody">
		</tbody>
	</table>
</body>


<script type="text/javascript">
	//1.点击查询按钮，通过身份证号码和姓名查询挂号信息
    document.querySelector('#btn_search').onclick = function () {
    	var inputSearchCardNum = $("#inputSearchCardNum").val();
		var inputSearchPatientName = $("#inputSearchPatientName").val();
		if(inputSearchCardNum=="" || inputSearchPatientName==""){
			alert("身份证号和姓名不能为空！");
		}
        $.ajax({
            url:'<%=path%>/opcharge/searchRegisterOpre',
            data:{cardNum:inputSearchCardNum,patientName:inputSearchPatientName},
            success:function(data){
            	if(data[0] == undefined){
            		$("#userBody").html("");
            		var tr = '<tr>'+
    				'<td colspan="10">'+'没有相关挂号单，请检查身份证或姓名是否输入错误！'+'</td>'+
    				'</tr>';
    				$("#userBody").append(tr);	
            	} else {
            		$("#userBody").html("");
                    var payType="自费";
                    var sexName="男";
                    for(var i = 0;i<data.length;i++){
                    	var n=i+1;
                    	if(data[i].expensesType==0){
                    		payType="自费";
                    	}
                    	else if(data[i].expensesType==1){
                    		payType="公费";
                    	}
                    	if(data[i].patientInfo.sex==0){
                    		sexName="男";
                    	}
                    	else if(data[i].patientInfo.sex==1){
                    		sexName="女";
                    	}
        				var tr = '<tr>'+
        				'<td><label><input type="radio" value="'+data[i].registerId+'" name="registerInfo"></label></td>'+
    				    '<td>'+ n +'</td>'+
        				'<td>'+data[i].patientInfo.patientName+'</td>'+
        				'<td>'+data[i].registerId+'</td>'+
        				'<td>'+sexName+'</td>'+
        				'<td>'+data[i].patientInfo.age+'</td>'+
        				'<td>'+data[i].patientInfo.birthday+'</td>'+
        				'<td>'+data[i].deptInfo.deptType+'</td>'+
        				'<td>'+data[i].doctorInfo.doctorName+'</td>'+
        				'<td>'+payType+'</td>'+
        				'</tr>';
        				$("#userBody").append(tr);
        			}
            	}
            }
        });
    };
    function confirmRegister(){
    	var registerId = $(':radio[name=registerInfo]:checked').val();
    	if(registerId != null){
    		$.ajax({
                url:'<%=path%>/opcharge/searchRegisterInfoRefund',
                data:{registerId:registerId},
                success:function(data){
                	var payType="自费";
                    var sexName="男";
                    if(data.expensesType==0){
                		payType="自费";
                	}
                	else if(data.expensesType==1){
                		payType="公费";
                	}
                	if(data.patientInfo.sex==0){
                		sexName="男";
                	}
                	else if(data.patientInfo.sex==1){
                		sexName="女";
                	}
                	$("#pName").text(data.patientInfo.patientName);
                	$("#pAge").text(data.patientInfo.age);
                	$("#pSex").text(sexName);
                	$("#pRegistId").text(data.registerId);
                	$("#pDept").text(data.deptInfo.deptType);
                	$("#pDoct").text(data.doctorInfo.doctorName);
                }
            });
    		$.ajax({
                url:'<%=path%>/opcharge/searchMpListRefund',
                data:{registerId:registerId},
                success:function(data){
                	console.log(data);
                	if(data[0] == undefined){
                		$("#medicBody").html("");
                		var tr = '<tr>'+
        				'<td colspan="11">'+'该挂号单没有药品处方已缴费记录！'+'</td>'+
        				'</tr>';
        				$("#medicBody").append(tr);	
                	} else {
                		$("#medicBody").html("");
                    	for(var i = 0;i<data.length;i++){
                    		var refundMoney=0;
                    		if(data[i].returnMoney!=null){
                    			refundMoney=data[i].returnMoney;
                    		}
                    		var n=i+1;
            				var tr = '<tr>'+
            				'<td>'+ n +'</td>'+
            				'<td>'+data[i].medicineInfo.medicineName+'</td>'+
            				'<td>'+data[i].medicineInfo.medicineNo+'</td>'+
            				'<td>'+data[i].medicineInfo.dosage+'</td>'+
            				'<td>'+data[i].medicineInfo.price+'</td>'+
            				'<td>'+data[i].medicineInfo.unit+'</td>'+
            				'<td>'+data[i].amount+'</td>'+
            				'<td><input type="text" id="'+ data[i].medicineInfo.medicineName +'"></td>'+
            				'<td>'+data[i].money+'</td>'+
            				'<td>'+refundMoney+'</td>'+
            				'<td><button class="btn btn-primary" onclick="refundMedic('+data[i].registerId+','+data[i].perscriptionId+','+data[i].medicineInfo.stockQuantity+','+data[i].medicineInfo.medicineId+','+ data[i].medicineInfo.medicineName +','+ data[i].returnAmount +','+ data[i].returnMoney +','+ data[i].money +','+ data[i].amount +','+ data[i].medicineInfo.price +')">退费</button></td>'+
            				'</tr>';
            				$("#medicBody").append(tr);
            			}
                	}	
                }
            });
    		$.ajax({
                url:'<%=path%>/opcharge/searchItemListRefund',
                data:{registerId:registerId},
                success:function(data){
                	console.log(data);
                	if(data[0] == undefined){
                		$("#itemBody").html("");
                		var tr = '<tr>'+
        				'<td colspan="10">'+'该挂号单没有项目处方已缴费记录！'+'</td>'+
        				'</tr>';
        				$("#itemBody").append(tr);	
                	} else {
                		$("#itemBody").html("");
                    	for(var i = 0;i<data.length;i++){
                    		var refundMoney=0;
                    		if(data[i].returnMoney!=null){
                    			refundMoney=data[i].returnMoney;
                    		}
                    		var n=i+1;
            				var tr = '<tr>'+
            				'<td>'+ n +'</td>'+
            				'<td>'+data[i].inspectionItem.itemId+'</td>'+
            				'<td>'+data[i].inspectionItem.itemName+'</td>'+
            				'<td>'+data[i].inspectionItem.price+'</td>'+
            				'<td>'+data[i].inspectionItem.unit+'</td>'+
            				'<td>'+data[i].amount+'</td>'+
            				'<td><input type="text" id="'+ data[i].inspectionItem.itemName +'"></td>'+
            				'<td>'+data[i].money+'</td>'+
            				'<td>'+refundMoney+'</td>'+
            				'<td><button class="btn btn-primary" onclick="refundItem('+data[i].registerID+','+data[i].checkID+','+ data[i].inspectionItem.itemName +','+ data[i].returnAmount +','+ data[i].returnMoney +','+ data[i].money +','+ data[i].amount +','+ data[i].inspectionItem.price +')">退费</button></td>'+
            				'</tr>';
            				$("#itemBody").append(tr);
            			}
                	}
                }
            });
    	}
    }
    function refundMedic(registerId,perscriptionId,stockQuantity,medicineId,id,returnAmount,returnMoney,money,amount,price){
    	var refundNum=id.value;
    	if(returnAmount==null){
    		returnAmount=0;
    	}
    	if(returnMoney== null){
    		returnMoney=0;
    	}
    	if(refundNum>amount) {
    		alert("药品处方退费数量超过总数量！");
    	} else if (refundNum == ""){
    		alert("请输入该处方退费数量！");
    	} else {
    		$.ajax({
                url:'<%=path%>/opcharge/returnMedic',
                data:{registerId:registerId,perscriptionId:perscriptionId,stockQuantity:stockQuantity,medicineId:medicineId,refundNum:refundNum,returnAmount:returnAmount,returnMoney:returnMoney,money:money,amount:amount,price:price},
                success:function(data){
                	var args=data;
                	$.ajax({
                        url:'<%=path%>/opcharge/searchMpListRefund',
                        data:{registerId:args},
                        success:function(data){
                        	alert("该药品处方退费成功！");
                       		$("#medicBody").html("");
                       		for(var i = 0;i<data.length;i++){
                        		var refundMoney=0;
                        		if(data[i].returnMoney!=null){
                        			refundMoney=data[i].returnMoney;
                        		}
                        		var n=i+1;
                				var tr = '<tr>'+
                				'<td>'+ n +'</td>'+
                				'<td>'+data[i].medicineInfo.medicineName+'</td>'+
                				'<td>'+data[i].medicineInfo.medicineNo+'</td>'+
                				'<td>'+data[i].medicineInfo.dosage+'</td>'+
                				'<td>'+data[i].medicineInfo.price+'</td>'+
                				'<td>'+data[i].medicineInfo.unit+'</td>'+
                				'<td>'+data[i].amount+'</td>'+
                				'<td><input type="text" id="'+ data[i].medicineInfo.medicineName +'"></td>'+
                				'<td>'+data[i].money+'</td>'+
                				'<td>'+refundMoney+'</td>'+
                				'<td><button class="btn btn-primary" onclick="refundMedic('+data[i].registerId+','+data[i].perscriptionId+','+data[i].medicineInfo.stockQuantity+','+data[i].medicineInfo.medicineId+','+ data[i].medicineInfo.medicineName +','+ data[i].returnAmount +','+ data[i].returnMoney +','+ data[i].money +','+ data[i].amount +','+ data[i].medicineInfo.price +')">退费</button></td>'+
                				'</tr>';
                				$("#medicBody").append(tr);
                			}
                        }
                    });
                }
            });
    	}	
    }

    function refundItem(registerID,checkID,id,returnAmount,returnMoney,money,amount,price){
    	var refundNum=id.value;
    	if(returnAmount==null){
    		returnAmount=0;
    	}
    	if(returnMoney== null){
    		returnMoney=0;
    	}
    	if(refundNum>amount) {
    		alert("项目处方退费数量超过总数量！");
    	} else if (refundNum == ""){
    		alert("请输入该处方退费数量！");
    	} else {
    		$.ajax({
                url:'<%=path%>/opcharge/returnItem',
                data:{registerID:registerID,checkID:checkID,refundNum:refundNum,returnAmount:returnAmount,returnMoney:returnMoney,money:money,amount:amount,price:price},
                success:function(data){
                	var args=data;
                	$.ajax({
                        url:'<%=path%>/opcharge/searchItemListRefund',
                        data:{registerId:args},
                        success:function(data){
                        	alert("该项目处方退费成功！");
                        	$("#itemBody").html("");
                        	for(var i = 0;i<data.length;i++){
                        		var refundMoney=0;
                        		if(data[i].returnMoney!=null){
                        			refundMoney=data[i].returnMoney;
                        		}
                        		var n=i+1;
                				var tr = '<tr>'+
                				'<td>'+ n +'</td>'+
                				'<td>'+data[i].inspectionItem.itemId+'</td>'+
                				'<td>'+data[i].inspectionItem.itemName+'</td>'+
                				'<td>'+data[i].inspectionItem.price+'</td>'+
                				'<td>'+data[i].inspectionItem.unit+'</td>'+
                				'<td>'+data[i].amount+'</td>'+
                				'<td><input type="text" id="'+ data[i].inspectionItem.itemName +'"></td>'+
                				'<td>'+data[i].money+'</td>'+
                				'<td>'+refundMoney+'</td>'+
                				'<td><button class="btn btn-primary" onclick="refundItem('+data[i].registerID+','+data[i].checkID+','+ data[i].inspectionItem.itemName +','+ data[i].returnAmount +','+ data[i].returnMoney +','+ data[i].money +','+ data[i].amount +','+ data[i].inspectionItem.price +')">退费</button></td>'+
                				'</tr>';
                				$("#itemBody").append(tr);
                			}
                        }
                    });
                }
            });
    	}
    }
</script>


</html>