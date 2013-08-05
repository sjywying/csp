<%@page import="com.taobao.csp.depend.po.hsf.InterfaceSummary"%>
<%@page import="com.taobao.csp.depend.po.hsf.ProvideSiteRating"%>
<%@page import="com.taobao.monitor.common.util.Utlitites"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.taobao.csp.depend.po.hsf.AppSummary"%>
<%@page import="java.util.Set"%>
<%@page import="com.taobao.csp.depend.po.hsf.AppConsumerSummary"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=GB18030"  isELIgnored="false" 
    pageEncoding="GB18030"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache"/>
<meta http-equiv="expires" content="0">
<!-- JQuery��ص�JS����leftmenu.jsp�ж����� -->
<script type="text/javascript" src="<%=request.getContextPath() %>/statics/userjs/mainpage.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath() %>/statics/datePicket/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/statics/js/easyui/themes/gray/easyui.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/statics/css/main.css" type="text/css" />
<link href="<%=request.getContextPath() %>/statics/css/bootstrap.css" rel="stylesheet"/>
<title>����ģ��</title>
<%
Map<String,InterfaceSummary> interfaceMap = (Map<String,InterfaceSummary>)request.getAttribute("interfaceMap");


List<InterfaceSummary> tmpList = new ArrayList<InterfaceSummary>();
for(Map.Entry<String,InterfaceSummary> entry:interfaceMap.entrySet()){
	tmpList.add(entry.getValue());
}
Collections.sort(tmpList);

String opsName = (String)request.getAttribute("opsName");
String consumeName = (String)request.getAttribute("consumeName");
String selectDate = (String)request.getAttribute("selectDate");
Set<String> siteSet = ( Set<String>)request.getAttribute("siteSet");

String preAllSumCall = (String)request.getAttribute("preAllSumCall");
String allSumCall = (String)request.getAttribute("allSumCall");


%>
</head>
<body>
<table  width="100%">
		<tr>
			<td><h3><%=consumeName %>����:<%=opsName %>�ӿڵ���ϸ���</h3></td>
		</tr>
		<tr >				
			<td >
				<table width="100%" class="table table-striped table-bordered table-condensed">
				    <tr>
				    <td width="100" align="center">�ӿ�����</td>
				    <td colspan="2" align="center">������(<%=Utlitites.fromatLong(allSumCall) %>&nbsp;<%=Utlitites.scale(allSumCall,preAllSumCall) %>)</td>
				    <%for(String siteName:siteSet){ %>
				    <td colspan="2" align="center"><%=siteName %></td>
				    <%} %>
				  </tr>   
				  <tr>
				    <td height="20" align="center" ><%=interfaceMap.size() %></td>
				    <td width="130" align="center">��ǰ</td>
				    <td width="130" align="center">����</td>
				 <%for(String siteName:siteSet){ %>
				    <td width="130" align="center">��ǰ</td>
				    <td width="130" align="center">����</td>
				     <%} %>
				  </tr>
				  <% 
				  for(InterfaceSummary appSum: tmpList){
					  if(appSum.getKeyName().indexOf("Exception_") >-1){
							continue;
						}
				  %>
				   <tr>
				    <td><a href="" style="text-decoration: none;" title=""><%=appSum.getKeyName() %></a></td>
				    <td><%=Utlitites.fromatLong(appSum.getCallAllNum()+"") %>(<%=Utlitites.scale(appSum.getCallAllNum(),appSum.getPreCallAllNum()) %>)</td>
				    <td><%=Utlitites.fromatLong(appSum.getPreCallAllNum()+"") %></td>
				     <%
				     for(String siteName:siteSet){ 
				    	 InterfaceSummary siteAppSum = appSum.getSiteMap().get(siteName);
				    	 if(siteAppSum!=null){
				     %>
				   	<td><%=Utlitites.fromatLong(siteAppSum.getCallAllNum()+"") %>(<%=Utlitites.scale(siteAppSum.getCallAllNum(),siteAppSum.getPreCallAllNum()) %>)</td>
				    <td><%=Utlitites.fromatLong(siteAppSum.getPreCallAllNum()+"") %></td>
				     <%}else{
				    %>
				    	<td>&nbsp;&nbsp;</td>
				   		 <td>&nbsp;&nbsp;</td>
				    <% 
				     }} %>
				  </tr>  
				  <%} %> 
				</table>				
			</td>
		</tr>
	</table>
</body>
</html>