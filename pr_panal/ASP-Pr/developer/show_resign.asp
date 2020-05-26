<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("dr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
ddate = date()
%>
<html>
<head>
<title>Developer Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">

</head>

<%
refno = request("refno")
srno = request("srno")
'response.Write(refno)
'response.Write(srno)
call OpenConnection
dim rstRemark
set rstRemark = server.CreateObject("adodb.recordset")
rstRemark.open "SELECT delete_remark from tbl_pr_projDetails where srno='"& srno & "'",NewConnection
if rstRemark.eof or rstRemark.bof then
	Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
else
	del_remark = rstRemark("delete_remark")
end if
%>

<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="100" marginheight="100">

<table width="50%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="50%" class="Tab2">
			Remarks::
		</td>
	</tr>
		<tr>
		<td width="50%" class="Tab3"><%=del_remark%>
		</td>
	</tr>
</table>

</body>
</head>
</html>