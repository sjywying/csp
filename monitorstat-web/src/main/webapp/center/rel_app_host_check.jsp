<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.taobao.monitor.web.ao.MonitorUserAo"%>
<%@page import="com.taobao.monitor.web.vo.LoginUserPo"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>


<%@page import="com.taobao.monitor.common.po.*"%>
<%@page import="com.taobao.monitor.common.ao.center.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>核心监控-用户管理</title>
<link type="text/css" href="<%=request.getContextPath() %>/statics/css/themes/base/ui.all.css" rel="stylesheet" />
<link href="<%=request.getContextPath() %>/statics/css/axurerppage.css" type="text/css" rel="stylesheet">
<script type="text/javascript"	src="<%=request.getContextPath() %>/statics/js/jquery.min.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/statics/js/ui/ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/statics/js/ui/ui.draggable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/statics/js/ui/ui.resizable.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/statics/js/ui/ui.dialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/statics/js/jquery.bgiframe.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/statics/js/ui/ui.accordion.js"></script>

<style type="text/css">
body {
	font-size: 62.5%;
}

table {
	margin: 1em 0;
	border-collapse: collapse;
	width: 100%;
	font-size: 12px;
	margin: 0px 0;
}

table td {
font-size: 12px;
}

.ui-button {
	outline: 0;
	margin: 0;
	padding: .4em 1em .5em;
	text-decoration: none; ! important;
	cursor: pointer;
	position: relative;
	text-align: center;
}

.ui-dialog .ui-state-highlight,.ui-dialog .ui-state-error {
	padding: .3em;
}

.headcon {
	font-family: "宋体";
	font-size: 12px;
	font-weight: bold;
	text-indent: 3px;
	border-color: #316cb2;
	/*text-transform: uppercase;*/
	background: url(<%=request.getContextPath () %>/statics/images/4_17.gif);
}
img {
cursor:pointer;
}
.report_on{background:#bce774;}
</style>

<%

String appId = request.getParameter("appId");
String action = request.getParameter("action");
String appType = request.getParameter("appType");
String appName = request.getParameter("appName");
String opsName = request.getParameter("opsName");

%>
<script type="text/javascript">

function goToCenter(){
	
	var url = "<%=request.getContextPath () %>/center/app_info_center.jsp";
	location.href=url;
}
function goToAdd(){
	
	var url = "<%=request.getContextPath () %>/center/rel_app_host_add.jsp?&appId=<%=appId%>&appName=<%=appName%>&opsName=<%=opsName%>";
	location.href=url;
}

function checkAlarm(){
	var objs=document.getElementsByName('selectId');
	var isSel = false;
	for(var i=0;i<objs.length;i++)
	{
	  if(objs[i].checked==true)
	   {
	    isSel=true;
	    break;
	   }
	}
	if(isSel==false){
		alert("对不起!您没有选择任何的主机!"); 
		return false;
	}else{
		return true;
	} 
	
}


function ck(b)
{
	var input = document.getElementsByTagName("input");

    for (var i=0;i<input.length ;i++ )
    {
        if(input[i].type=="checkbox")
            input[i].checked = b;
    }
}

$(function(){

	// 用另一个复选框来控制全选/全不选
		$("#chkAll").click(function(){
	  
			if(this.checked){     //如果当前点击的多选框被选中
		   		$('input[type=checkbox][name=selectId]').attr("checked", true );
		 	}else{        
		   	   	$('input[type=checkbox][name=selectId]').attr("checked", false );
		 	}
		})
})

</script>


</head>
<body>



<%

request.setCharacterEncoding("gbk");
/*
if(!UserPermissionCheck.check(request,"adduser","")){
	out.print("你没有权限操作!");
	return;
}
*/
%>
<jsp:include page="../head.jsp"></jsp:include>

<form action="./rel_app_host_check.jsp" onsubmit="return checkAlarm()" method="post" name="myform" 	id="myform">


<%
if("delete".equals(action)){
	String[] deleteId = request.getParameterValues("selectId");
	HostAo.get().deleteHostList(deleteId);
}


AppInfoPo appInfoPo = AppInfoAo.get().findAppWithHostListByAppId(Integer.parseInt(appId));

%>
<div class="ui-dialog ui-widget ui-widget-content ui-corner-all " style="width: 100%;">
<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">关联主机   : 共 <%=(appInfoPo.getHostList() == null) ? 0 : appInfoPo.getHostList().size() %> 台
<a href="./app_info_center.jsp">返回到应用列表</a>
</div>
<div id="dialog" class="ui-dialog-content ui-widget-content">
<%

	if(appInfoPo.getHostList() != null && appInfoPo.getHostList().size() != 0) {

%>
<table align="center" width="400" border="1" class="ui-widget ui-widget-content">
	<tr>
		<td width="50" align="center">
		<input name='chkAll' type='checkbox' id='chkAll'  value='checkbox'></td>
		
		<td align="center">应用名</td>
		<td align="center">主机名</td>
		<td align="center">主机IP</td>
		<td align="center">机房</td>
		<td align="center">临时表</td>
		<td align="center">持久表</td>
	</tr>
	<%
		for(HostPo po : appInfoPo.getHostList()) {
	%>
	<tr>
		<td align="center"><input type="checkbox" id='selectId' name="selectId" onclick="unselectall()" value="<%=po.getHostId() %>"></td>
		<td align="center"><%=appName %></td>
		<td align="center"><%=po.getHostName()%></td>
		<td align="center"><%=po.getHostIp() %></td>
		<td align="center"><%=po.getHostSite() %></td>
		<td align="center"><%=((po.getSavedata().charAt(0)) == '1') ? "是" : "否"  %></td>
		<td align="center"><%=((po.getSavedata().charAt(1)) == '1') ? "是" : "否"  %></td>
	</tr>
	
	<%
		}
	%>
		
</table>

<%
	}//end if
	else {
%>
<table align="center" width="400" border="1" class="ui-widget ui-widget-content">

	<tr>
	<td align="center" >
		<a href="./rel_app_host_add.jsp?appId=<%=appId %>&appName=<%=appName %>&opsName=<%=opsName %>"><font size="5">还没有关联的主机，请添加关联</font></a>
	</td>
	</tr>
		<%
	}
		%>
</table>
</div>
</div>
<table width="100%">
	<tr>
	
		<td align="center"><input type="button" value="添加" onclick="goToAdd()">
		<input type="button" value="返回" onclick="goToCenter()">
		<input type="hidden" name="appType" value="<%=appType %>">
		<input type="hidden" name="opsName" value="<%=opsName %>">
		<input type="hidden" name="appName" value="<%=appName %>">
		<input type="hidden" name="appId" value="<%=appId %>">
		<input type="hidden" name="action" value="delete">
		<input type="button" onclick="ck(true)" value="全选">
		<input type="button" onclick="ck(false)" value="取消全选">
		<input type="submit" value="删除"></td>
	</tr>
</table>

</form>
<jsp:include page="../buttom.jsp"></jsp:include>
</body>
</html>