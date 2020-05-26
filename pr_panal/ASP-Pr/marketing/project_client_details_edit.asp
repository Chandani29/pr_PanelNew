<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if

dim ddate
ddate = now()
%>
<html>
<head>
<title>Marketing Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style_mr {
 background-color: #FF0000;
}
-->
</style>
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function MM_openBrWindow(theURL,winName,features)
{ //v2.0
  window.open(theURL,winName,features);
}
function goclient()
{
	document.client_update.submit();
}
</script>
<style type="text/css">
<!--
.style1 {color: #33FFFF}
-->
</style>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="10" marginwidth="0" marginheight="0">
<%
call OpenConnection
		refno = request("refno")		
		dim rsProject
		set rsProject = server.CreateObject("adodb.recordset")
		rsProject.open "SELECT * from tbl_pr_project where srno='"& refno & "'",NewConnection
		if rsProject.eof or rsProject.bof then
			Response.Write("<strong><font color=red>No Project Found!!</font></strong>")
		else			
			proj_id = rsProject("proj_id")
			proj_name = rsProject("proj_name")
			clientname = rsProject("clientname")
			p_referance = rsProject("proj_source")
			clientmobile = rsProject("clientmobile")
			clientemail = rsProject("clientemail")
			clientcompany = rsProject("clientcompany")
			clientadd = rsProject("clientadd")			
%>	
<form name="client_update" action="project_client_details_update.asp?refno=<%=refno%>" method="post">			
<table width="60%" border="1" cellpadding="4" cellspacing="2" align="center">
<tr>
	<td colspan="2" align="left" bgcolor="#666666"><strong class="Tab2 style1"><strong class="Tab2 style1">Client's Details for <%=proj_name%>&nbsp;( <%=proj_id%> )&nbsp;</strong></strong></td>
</tr>
<tr valign="top"> 
    <td width="28%" align="left" bgcolor="#CCCCCC" class="Tab2"><strong>Client Name</strong></td>
    <td width="72%" align="left" bgcolor="#E6E6E6" class="Tab3"><input type="text" name="txt_clientname" value="<%=clientname%>" size="45"></td>    		  
</tr>
<tr valign="top"> 
    <td align="left" bgcolor="#CCCCCC" class="Tab2"><strong>Referance</strong></td> 
    <td align="left" bgcolor="#E6E6E6" class="Tab3"><input type="text" name="txt_referance" value="<%=p_referance%>" size="45"></td>       	 
</tr>  
<tr valign="top"> 
    <td align="left" bgcolor="#CCCCCC" class="Tab2"><strong>Client Mobile No.</strong></td>       
    <td align="left" bgcolor="#E6E6E6" class="Tab3"><input type="text" name="txt_clientmobile" value="<%=clientmobile%>" size="45"></td>      	 
</tr>  
<tr valign="top"> 
    <td align="left" bgcolor="#CCCCCC" class="Tab2"><strong>Client Email</strong></td>       
    <td align="left" bgcolor="#E6E6E6" class="Tab3"><input type="text" name="txt_clientemail" value="<%=clientemail%>" size="45"></td>      	 
</tr>
<tr valign="top"> 
    <td align="left" bgcolor="#CCCCCC" class="Tab2"><strong>Client Company</strong></td>       
    <td align="left" bgcolor="#E6E6E6" class="Tab3"><input type="text" name="txt_clientcompany" value="<%=clientcompany%>" size="45"></td>      	 
</tr>
<tr valign="top"> 
    <td align="left" bgcolor="#CCCCCC" class="Tab2"><strong>Client Address</strong></td>   
    <td align="left" bgcolor="#E6E6E6" class="Tab3">
    <textarea name="txt_clientadd" cols="34" rows="6" id="txt_clientadd"><%=clientadd%></textarea>
    </td>     	 
</tr>  
<tr>
	<td colspan="2" align="right" bgcolor="#666666"><a href="javascript: goclient();"><strong class="Tab2 style1">Update</strong></a></td>
</tr>                 
</table>
</form>
<%
		end if
%>	
</body>
</html>