<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = pageContext.getServletContext().getContextPath();
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

    <link href="<%=path%>/bootstrap/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link href="<%=path%>/bootstrap/bootstrap-3.3.7-dist/css/bashboard.css"
          rel="stylesheet">
    <link href="<%=path%>/bootstrap/bootstrap-validator/dist/css/bootstrapValidator.min.css"
          rel="stylesheet">


    <style type="text/css">
        .div_panel {
            font-size: 14px;
            color: #fefefe;
            text-align: center;
            width: 100px;
            background-color: #96CDCD;
            border: 1px solid #e5e5e5;
            border-radius: 5px 5px 0 0;
        }

        a:hover {
            text-decoration: none;
        }
    </style>


    <!-- 药品处方 start-->
    <script type="text/javascript">
        function onLoadSuccess() {
            $("a[name='removebtn']").linkbutton({
                plain: true,
                iconCls: 'icon-remove'
            });
        }


        function formatterBtn1(value, row, index) {
            var str = '<a href="#" name="removebtn" class="easyui-linkbutton" title="添加药方" onclick="addMedic(&quot;' + row.medicineId + '&quot;,&quot;'+row.num+ '&quot;,&quot;'+row.price+'&quot;);" >添加</a>';
            return str;

        }

        var editIndex = undefined;
        function onClickRow(index) {
            if (editIndex != index) {
                if (endEditing()) {
                    $('#medic_dg').datagrid('selectRow', index)
                        .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#medic_dg').datagrid('selectRow', editIndex);
                }
            }
        }


        function endEditing() {
            if (editIndex == undefined) { return true }
            if ($('#medic_dg').datagrid('validateRow', editIndex)) {
                $('#medic_dg').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }

        function searchMedicine() {
            var medicineName = $("#medicineName").textbox("getValue");
            $.post("<%=path%>/dt/searchMedicine", { medicineName: medicineName }, function (data, textStatus) {
                if (textStatus == "success") {
                    $('#medic_dg').datagrid('loadData', { total: 'data.length', rows: data });
                }

            })
        }

        function getMedicineSelections() {
            var registerId = $("#registerId").val();
            var rows = $("#medic_dg").datagrid("getSelections");
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                row.account = 1;
                row.money = row.price;
            }
            $('medic_dg').datagrid('locaData', { total: rows.length, rows: rows });
            $('#medicineSelect').window('close');
        }

        <%-- //添加:registerId写死了:
        function addMedic(medicineId, num) {

            $.post("<%=path%>/dt/addMedic", { medicineId: medicineId, num: num }, function (data, textStatus) {
                if (textStatus == "success") {
                    $('#dg').datagrid('loadData', { total: 'data.length', rows: data });
                    window.location.href = "<%=path%>/dt/optPatient";
                }
            }) --%>

      //添加：能动态获取registerId时用这个
      function addMedic(medicineId, num, price) {
    	  var money=num*price;
                    var registerId = $("#registerId").val();
                    $.post("<%=path%>/dt/addMedic", { registerId: registerId, medicineId: medicineId, num: num, money: money }, function (data, textStatus) {
                        if (textStatus == "success") {
                            $('#dg').datagrid('loadData', { total: 'data.length', rows: data });
                            window.location.href = "<%=path%>/dt/patientPerscription?registerId=" + registerId;
                        }
                    })

}
      function searchMedicine(){
      	var medicineName = $("#medicineName").textbox("getValue");
      	$.post("<%=path %>/dt/searchMedicine",{medicineName:medicineName},function(data,textStatus){
      		if(textStatus=="success"){
      			$('#medic_dg').datagrid('loadData',{total:'data.length',rows:data});
      		}

        })
      }

      function deleteMedicinePerscriptionByPerscriptionId(perscriptionId, index){
     	 $.post("<%=path %>/dt/deleteMedicinePerscriptionByPerscriptionId",{perscriptionId:perscriptionId},function(data,textStatus){
         	 if(textStatus=="success"){
         		 //$('#dg').datagrid('loadData',{total:'data.length',rows:data});
         		$('#dg_list').datagrid('deleteRow', index);
         		 <%-- window.location.href = "<%=path %>/dt/chufangList"; --%>
         	 }
       })
     }
      


    </script>
    <!-- 药品处方- end -->
    <!-- 检查项目 start -->
    <script type="text/javascript">

function formatterBtn(value,row,index){
	var str = '<a href="#" name="removebtn" class="easyui-linkbutton" title="删除药方" onclick="deleteMedicinePerscriptionByPerscriptionId(&quot;'+row.perscriptionId + '&quot;,&quot;' + index +'&quot;);" >删除</a>';
	return str;
}

        function getSelections() {
            var mpList = [];
            var registerId = $("#registerId").val();
            alert(registerId);
            var rows = $('#dg_medicine').datagrid('getSelections');
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                var arg = { medicineId: row.medicineId, registerId: registerId, amount: 1, flag: 0, money: row.price };
                mpList.push(arg);
            }

            alert(mpList);
            $.ajax({
                url: "<%=path%>/dt/insertMpList",
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(mpList),
                type: 'post',
                success: function (data, textStatus) {
                    $('#dg_mp').datagrid('loadData', { total: data.length, rows: data });
                    $('#medicineSelect').window('close');
                },
                error: function (data, textStatus) {
                    alert("error: " + textStatus)
                }
            })

        }


    <!--项目表格编辑 -->
            function onClickItemRow(index) {
                debugger
                /*	if (editIndex != index){
                        if (endEditing()){
                            $('#dg_chk').datagrid('selectRow', index)
                                    .datagrid('beginEdit', index);
                            editIndex = index;
                        } else {
                            $('#dg_chk').datagrid('selectRow', editIndex);
                        }
                    }*/
            }

        var editIndex = undefined;
        function onAfterItemEdit() {
            if (editIndex == undefined) { return true }
            if ($('#dg_chk').datagrid('validateRow', editIndex)) {
                $('#dg_chk').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }


        function searchItem() {
            var itemName = $("#searchItemName").textbox("getValue");
            $.post("<%=path%>/dt/searchItemInfoList", { itemName: itemName },
            		function (data, textStatus) {
                if (textStatus == "success") {
						if (data != null) {
							$('#dg_item').datagrid('loadData', { total: data.length, rows: data });
						} else {
							alert("未查到的项目");
						}

                }
            })
        }


        //选择
        function getItemSelections() {

            var registerId = $("#registerId").val();
            var rows = $('#dg_item').datagrid('getSelections');
            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                row.amount = 1;
                row.money = row.price;
            }

            $('#dg_chk').datagrid('loadData', { total: rows.length, rows: rows });
            $('#itemSelect').window('close');
        }


    <%-- <% --保存检查项目 --%>
           <%--  function updateCheckItem() {
                debugger
                console.log("保存");
                var mpList = [];
                var registerId = $("#registerId").val();
                //  dg_medicine dg_chk
                //alert(registerId);
                var rows = $('#dg_chk').datagrid('getRows');
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    var arg = { registerID: registerId, amount: 1, flag: 0, money: row.price };
                    mpList.push(arg);
                    alert(mpList[0]);
                }

                $.ajax({
                    url: "<%=path%>/dt/insertCheckItem",
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify(mpList),
                    type: 'post',
                    success: function (data, textStatus) {
                        alert("保存成功");
                        // $('#dg_mp').datagrid('loadData',{total:data.length,rows:data});
                        // $('#medicineSelect').window('close');
                    },
                    error: function (data, textStatus) {
                        alert("error: " + textStatus)
                    }
                })
            }
 --%>
 function updateCheckItem(){
     var registerId=$("#registerId").val();
     addFlag = 0;
     endFlag = 0;
     var rows = $('#dg_chk').datagrid('getRows');
     for(var i=0; i<rows.length; i++){
         var row = rows[i];
         var money =row.price;
         var itemId = row.itemId;
         addFlag ++;
         $.ajax({
             url:"<%=path%>/dt/insertCheckItem",
             data: {
                 "registerID":registerId,
                 "itemID":itemId,
                 "amount":1,
                 "money":money,
                 "flag":0
             },
             type : 'post',
             dataType: "json",
             success:function(data,textStatus){
                 fn_endFlag();
             },
             error:function(data,textStatus) {
                 alert("error: "+textStatus)
             }
         })
     }
 }
 function fn_endFlag(){
     endFlag ++ ;
     if(addFlag==endFlag){
         alert("保存成功")
		}
	}

        function formatterItemBtn2(value, row, index) {
            debugger
            var str = '<a href="#" name="removebtn" class="easyui-linkbutton" style="padding:2px 10px;background: #006699;color: #fefefe" title="删除检查信息"  onclick="deleteChk(&quot;' + row.itemId + '&quot;,' + index + ');" >删除</a>';
            return str;

        }


        function editChk(itemId) {
            debugger
            alert("编辑" + itemId);

        }

        function deleteChk(checkId, index){
        	alert(checkId);
   		 <%-- $.post("<%=path %>/dt/removeCheckFromRecipe",{checkID:checkId}, --%>
   				$.post("<%=path %>/dt/removeCheckFromRecipe?checkId=" + checkId,
   				 function(data,textStatus){
   			if(textStatus=="success"){
   			//alert(data);
					//if (data == true) {
						$('#dg').datagrid('loadData',{total:'data.length',rows:data});
		   				$('#dg_chk').datagrid('deleteRow', index);
				//	} else {
					//	alert("删除失败");
					//}

   			}
   		 })

   	}


        function savehMedicine(){
       	 $('#dg_list').datagrid('hideColumn','action');
        }
    </script>
    <!-- 检查项目 end -->

</head>
<body style="padding: 0px">
    <div class="easyui-tabs" style="width: 98%; min-height: 99%;">
        <input type="hidden" name="registerInfo.registerId" id="registerId"
               value="${registerInfo.registerId }">

        <!-- 诊断信息 -->
        <div title="诊断信息" style="padding: 10px">
            <div style="margin-left: 10px; float: left; line-height: 32px; width: 200px; font-weight: bold;">
                病历号：<span style="color: red;">
                    ${registerInfo.patientInfo.patientCard}
                </span>
            </div>
            <div style="float: left; line-height: 32px; width: 150px; font-weight: bold;">
                姓名： <span style="color: red;">${registerInfo.patientInfo.patientName}</span>
            </div>
            <div style="float: left; line-height: 32px; width: 120px; font-weight: bold;">
                年龄： <span style="color: red;">
                    ${registerInfo.patientInfo.age}
                </span>
            </div>
            <div style="float: left; line-height: 32px; width: 300px; font-weight: bold;">
                身份证号： <span style="color: red;">${registerInfo.patientInfo.cardNum}</span>
            </div>
            <div style="clear: both;"></div>
            <div style="margin-left: 10px; float: left; line-height: 32px; width: 200px; font-weight: bold;">
                挂号科室： <span style="color: red;">${registerInfo.deptInfo.deptName}</span>
            </div>
            <div style="float: left; line-height: 32px; width: 200px; font-weight: bold;">
                就诊医生： <span style="color: red;">${registerInfo.doctorInfo.doctorName}</span>
            </div>

            <div style="clear: both;"></div>
            <!-- 主观资料 -->

            <div style="margin-top: 10px; line-height: 30px; font-weight: bold; border-bottom: 1px solid #e5e5e5;">
                <div class="div_panel">主观资料</div>
            </div>
            <div style="clear: both;"></div>
            <div style="float: left; padding: 10px;">
                <div style="float: left; width: 100px;">发病日期：</div>
                <input class="easyui-datebox" name="onsetDate"
                       value="${diagnosisInfo.onsetDate }" disabled="disabled"
                       style="width: 200px;">
            </div>
            <div style="clear: both;"></div>
            <div style="float: left; padding: 10px;">
                <div style="float: left; width: 100px;">主诉：</div>
                <input class="easyui-textbox" data-options="multiline:true"
                       name="narration" value="${diagnosisInfo.narration }"
                       disabled="disabled" style="width: 600px; height: 200px">
            </div>
            <div style="clear: both;"></div>
            <div style="float: left; padding: 10px;">
                <div style="float: left; width: 100px;">现病史：</div>
                <input class="easyui-textbox" data-options="multiline:true"
                       name="hpi" value="${diagnosisInfo.hpi }" disabled="disabled"
                       style="width: 150px; height: 50px">
            </div>
            <div style="float: left; padding: 10px;">
                <div style="float: left; width: 100px;">既往史：</div>
                <input class="easyui-textbox" data-options="multiline:true"
                       name="pmp" value="${diagnosisInfo.pmp }" disabled="disabled"
                       style="width: 150px; height: 50px">
            </div>
            <div style="float: left; padding: 10px;">
                <div style="float: left; width: 100px;">过敏史：</div>
                <input class="easyui-textbox" data-options="multiline:true"
                       name="allergyHistory" value="${diagnosisInfo.allergyHistory }"
                       disabled="disabled" style="width: 150px; height: 50px">
            </div>

            <div style="clear: both;"></div>
            <!-- 问题评估 -->

            <div style="margin-top: 10px; line-height: 30px; font-weight: bold; border-bottom: 1px solid #e5e5e5;">
                <div class="div_panel">问题评估</div>
            </div>
            <div style="float: left; padding: 10px;">
                <div style="float: left; width: 100px;">诊断：</div>
                <input type="text" class="easyui-textbox" name="diagContent"
                       value="${diagnosisInfo.diagContent }" disabled="disabled"
                       style="width: 400px">
            </div>
            <div style="clear: both;"></div>
            <div style="float: left; padding: 10px;">
                <div style="float: left; width: 100px;">诊断备注：</div>
                <input type="text" class="easyui-textbox" name="diagRemarks"
                       value="${diagnosisInfo.diagRemarks }" disabled="disabled"
                       style="width: 400px">
            </div>
            <div style="clear: both;"></div>
            <!-- 处置计划-->

            <div style="margin-top: 10px; line-height: 30px; font-weight: bold; border-bottom: 1px solid #e5e5e5;">
                <div class="div_panel">处置计划</div>
            </div>

            <div style="float: left; padding: 10px;">
                <div style="float: left; width: 100px;">处置计划：</div>
                <input class="easyui-textbox" data-options="multiline:true"
                       name="disposalPlan" value="${diagnosisInfo.disposalPlan }"
                       disabled="disabled" style="width: 600px; height: 150px">
            </div>
        </div>

        <!--  药品信息 -->
        <div title="药品处方" style="padding: 10px">
            <div class="patient-wrapper">
                <table>
                    <tr>
                        <td style="width: 120px;">病历号：<span class="info-content">${registerInfo.registerId }</span></td>
                        <td style="width: 120px;">姓名：<span class="info-content">${registerInfo.patientInfo.patientName }</span></td>
                        <td style="width: 120px;">年龄：<span class="info-content">${registerInfo.patientInfo.age }</span></td>
                        <td style="width: 120px;">身份证号：<span class="info-content">${registerInfo.patientInfo.cardNum }</span></td>
                    </tr>
                    <tr>
                        <td style="width: 120px;">挂号科室：<span class="info-content">${registerInfo.deptInfo.deptName }</span></td>
                        <td style="width: 120px;">就诊医生：<span class="info-content">${registerInfo.doctorInfo.doctorName }</span></td>
                    </tr>
                </table>


            </div>

            <input id="medicineName" class="easyui-textbox"
                   style="width: 30%; height: 32px">
            <div style="margin: 5px auto; float: left; padding-bottom: 0px">
                <a href="#" class="easyui-linkbutton" iconCls="icon-ok"
                   style="width: 100px; height: 32px" onclick="searchMedicine();">搜索</a>
            </div>

            <table id="medic_dg" title="查询药" class="easyui-datagrid"
                   style="width: 99%;"
                   data-options="rownumbers:true,singleSelect:true,onLoadSuccess:onLoadSuccess,onClickRow:onClickRow">
                <thead>
                    <tr>
                        <th data-options="field:'medicineId'" width="5%">药品编号</th>
                        <th data-options="field:'medicineName',align:'center'" width="15%">药品名称</th>
                        <th data-options="field:'dosage',align:'center'" width="15%">剂量</th>
                        <th data-options="field:'price',align:'center'" width="10%">单价</th>
                        <th data-options="field:'unit',align:'center'" width="5%">规格</th>
                        <th data-options="field:'effectiveDate',align:'center'"
                            width="20%">有效日期</th>
                        <th data-options="field:'num',width:'15%',align:'center',editor:{type:'numberspinner',options:{min:1,increment:1}}">数量</th>
                        <th data-options="field:'action',formatter:formatterBtn1"
                            width="10%">操作</th>

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


            <table id="dg" class="easyui-datagrid" title="药品处方"
                   style="width: 99%;"
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
                        <!-- <th data-options="field:'action',formatter:formatterBtn"
                            width="20%">操作</th> -->
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



<!-- 
            <div style="padding: 10px 0 10px 93%; display: inline-block;">
                <a href="#" class="easyui-linkbutton" width="50px" title="保存">保存</a>
            </div>
 -->

        </div>



        <!-- 检查项目 -->
        <div title="检查项目" style="padding: 10px">

            <div style="margin-left: 10px; float: left; line-height: 32px; width: 200px; font-weight: bold;">
                病历号：<span style="color: red;">
                    ${registerInfo.patientInfo.patientCard}
                </span>
            </div>
            <div style="float: left; line-height: 32px; width: 150px; font-weight: bold;">
                姓名： <span style="color: red;">${registerInfo.patientInfo.patientName}</span>
            </div>
            <div style="float: left; line-height: 32px; width: 120px; font-weight: bold;">
                年龄： <span style="color: red;">
                    ${registerInfo.patientInfo.age}
                </span>
            </div>
            <div style="float: left; line-height: 32px; width: 300px; font-weight: bold;">
                身份证号： <span style="color: red;">${registerInfo.patientInfo.cardNum}</span>
            </div>
            <div style="clear: both;"></div>
            <div style="margin-left: 10px; float: left; line-height: 32px; width: 200px; font-weight: bold;">
                挂号科室： <span style="color: red;">${registerInfo.deptInfo.deptName}</span>
            </div>
            <div style="float: left; line-height: 32px; width: 200px; font-weight: bold;">
                就诊医生： <span style="color: red;">${registerInfo.doctorInfo.doctorName}</span>
            </div>

            <div style="clear: both;"></div>


            <div style="float: right; padding-right: 50px; padding-bottom: 20px;">
                <a href="#" class="easyui-linkbutton"
                   style="padding: 2px 10px; background: #006699; color: #fefefe"
                   onclick="$('#itemSelect').window('open')">选择检查项</a>
            </div>


            <!-- ? -->
            <table id="dg_chk" class="easyui-datagrid" style="width: 99%;"
                   data-options="rownumbers:true,singleSelect:true,onClickRow:onClickItemRow,onAfterEdit:onAfterItemEdit">
                <thead>
                    <tr>
                        <th colspan="3">基本信息</th>

                        <th colspan="4">总量</th>

                        <th colspan="2">其他</th>
                    </tr>
                    <tr>
                        <th data-options="field:'checkId',hidden:true" width="1%"></th>
                        <th data-options="field:'itemName',width:'10%',align:'center'">项目名称</th>
                        <th data-options="field:'deptment',width:'15%',align:'center'">执行科室</th>
                        <th data-options="field:'price',width:'8%',align:'center'">单价</th>
                        <th data-options="field:'amount',width:'13%',align:'center',editor:{type:'numberspinner',options:{min:1,increment:1}}">数量</th>
                        <th data-options="field:'unit',width:'8%',align:'center'">单位</th>
                        <th data-options="field:'money',width:'10%',align:'center'">金额</th>
                        <th data-options="field:'remark',width:'15%',editor:{type:'textbox',options:{multiline:true}}">医嘱</th>
                        <th data-options="field:'action',width:'20%',formatter:formatterItemBtn2,align:'center'">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${registerInfo.checkList }" var="chk"
                               varStatus="status">
                        <tr>
                            <td>${chk.checkId }</td>
                            <td>${chk.inspectionItem.itemName }</td>
                            <td>${chk.inspectionItem.deptment }</td>
                            <td>${chk.inspectionItem.price }</td>
                            <td>${chk.amount}</td>
                            <td>${chk.inspectionItem.unit }</td>
                            <td>${chk.money }</td>
                            <td>${chk.remark}</td>

                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </table>

            <div style="float: right; padding-right: 50px; padding-bottom: 20px;">
                <a href="#" class="easyui-linkbutton"
                   style="padding: 2px 10px; background: #006699; color: #fefefe"
                   onclick="updateCheckItem()">保存</a>
            </div>

            <!-- 检查项目信息 -->
            <div id="itemSelect" class="easyui-window" title="检查项目信息"
                 data-options="modal:true,closed:true,iconCls:'icon-save'"
                 style="width: 800px; height: 400px; padding: 10px;">
                <div id="header">
                    <div style="margin: 5px auto; float: left; width: 50%">
                        <div style="float: left; line-height: 32px; font-weight: bold;">
                            项目名称： <input class="easyui-textbox" id="searchItemName"
                                         style="width: 80%; height: 25px">
                        </div>
                    </div>
                    <div style="margin: 5px auto; float: left; padding-bottom: 0px">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-ok"
                           style="width: 100px; height: 32px" onclick="searchItem();">搜索</a>
                    </div>
                </div>

                <table id="dg_item" class="easyui-datagrid" style="width: 100%"
                       data-options="rownumbers:true">
                    <thead>
                        <tr>
                            <th data-options="field:'itemId',checkbox:true"></th>
                            <th data-options="field:'itemName',width:'20%',align:'center'">项目名称</th>
                            <th data-options="field:'deptment',width:'25%',align:'center'">执行科室</th>
                            <th data-options="field:'price',width:'10%',align:'center'">单价</th>
                            <th data-options="field:'unit',width:'10%',align:'center'">单位</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>

                <div style="margin: 20px 0;">
                    <a href="#" class="easyui-linkbutton"
                       style="padding: 2px 10px; background: #006699; color: #fefefe"
                       onclick="getItemSelections()">选择</a>
                </div>
            </div>

        </div>



        <!-- 处方列表 -->
        <div title="处方列表" style="padding: 10px">
            处方列表
            <table id="dg_list" class="easyui-datagrid" title="药品处方"
                   style="width: 99%;"
                   data-options="rownumbers:true,singleSelect:true,onLoadSuccess:onLoadSuccess,onClickRow:onClickRow">
                <thead>

                    <tr>
                        <th data-options="field:'perscriptionId',align:'center'"
                            width="10%">挂号单号</th>
                        <th data-options="field:'medicineName',align:'center'" width="20%">药品名称</th>
                        <th data-options="field:'dosage',align:'center'" width="15%">剂量</th>
                        <th data-options="field:'price',align:'center'" width="15%">单价</th>
                        <th data-options="field:'amount'" width="10%">数量</th>
                        <th data-options="field:'unit',align:'center'" width="10%">单位</th>
                        <th data-options="field:'action',formatter:formatterBtn"
                            width="15%">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${mpList }" var="mp">
                        <tr>
                            <td>${mp.perscriptionId }</td>
                            <td>${mp.medicineInfo.medicineName }</td>
                            <td>${mp.medicineInfo.dosage }</td>
                            <td>${mp.medicineInfo.price }</td>
                            <td>${mp.amount }</td>
                            <td>${mp.medicineInfo.unit }</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
<!-- 
            <div style="padding: 10px 0 10px 93%; display: inline-block;">
                <a href="#" class="easyui-linkbutton" iconCls="icon-ok"
                   style="width: 100px; height: 32px" onclick="savehMedicine();">保存</a>
            </div>
 -->
        </div>



    </div>
</body>
</html>
