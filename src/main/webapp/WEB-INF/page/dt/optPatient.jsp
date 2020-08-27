<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>	
<%
	String path = pageContext.getServletContext().getContextPath();
%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>医院管理系统</title>
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
<script type="text/javascript">
		function check(index,name){
			$("a[id^=id_]").removeClass("clicka");
			$("#id_"+index).addClass("clicka");
			$("#main_id").panel({"title":name});
		}
	</script>
	<style type="text/css">
		a{ color:#999; text-decoration:none;}
		a:hover{ text-decoration:underline;}
		.menu_li{
			padding: 8px 20px;
			list-style:none;
			
		}
		.clicka{
			font-weight:bold;
			font-size:large;
			
		}
	</style>
</head>
<body>
<div class="easyui-layout" style="width:1100px;height:520px;">
        <div region="west" split="true" title="我的病人" style="width:150px;">
            <c:forEach items="${diagList }" var="reg" varStatus="status">
				<li class="menu_li">
					<c:choose>
						<c:when test="${reg.flag==1}">
							<a style="color: #008B8B;" onclick="check(${status.index},'${reg.patientInfo.patientName}');" id="id_${status.index }" href="<%=path %>/dt/patientPerscription?registerId=${reg.registerId }" target="diagFrame" >${reg.patientInfo.patientName }(已就诊)</a>
						</c:when>
						<c:otherwise>
							<a style="color: #CD5C5C;" onclick="check(${status.index},'${reg.patientInfo.patientName}');" id="id_${status.index }" href="<%=path %>/dt/dtInfoAdd?registerId=${reg.registerId }" target="diagFrame" >${reg.patientInfo.patientName }</a>
						</c:otherwise>
					</c:choose>
				</li>		
			</c:forEach>
        
        </div>
        <div id="content" region="center" title="就诊" style="padding:5px;">
        
        
    <div region="center" style="height: 470px;width:950px; background: #B3DFDA; padding: 10px" >
		<iframe name="diagFrame"  style="width:950px;min-height: 100%;border: none;" 
			src=""></iframe>
     </div>
        
</div>
</div>


</body>
</html>