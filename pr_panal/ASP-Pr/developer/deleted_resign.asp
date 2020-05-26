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
<script language="JavaScript">
function checkLogin()
{

	if(document.del_form.del_resion.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.1");
		document.del_form.del_resion.focus();
		return false;
	}
	else
	{
		return true;
	}
}
</script>
</head>

<%
refno = request("refno")
srno = request("h_id")
'response.Write(refno)
'response.Write(srno)
%>

<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="100" marginheight="100">
<form name="del_form" action="delete_workstatus.asp" method="post">
<table width="50%" border="0" cellpadding="0" cellspacing="0">
<tr valign="top" bgcolor="#E6E6E6" class="tdrow3">
<td width="50%" class="Tab2">
Remarks::
</td>
</tr>
<tr valign="top" bgcolor="#E6E6E6" class="tdrow3">
<td width="50%" class="Tab3">
<textarea name="del_resion" id="del_resion" cols="35" rows="5"></textarea>
</td>
</tr>
<input type="hidden" name="h_id" id="h_id" value='<%=srno%>'>
<input type="hidden" name="refno" id="refno" value='<%=refno%>'>
<tr valign="top" bgcolor="#E6E6E6" class="tdrow3">
<td width="50%" class="Tab2">
<input type="submit" name="submit" value="submit" class="Tab2" style="WIDTH: 150px;" onClick="return checkLogin();">
<input name="Submit2" type="button" class="Tab2" value="Cancel" style="WIDTH: 150px;" onClick="window.location = 'project_report.asp?refno=<%=refno%>';">
</td>
</tr>
</table>
</form>
</body>
</head>
</html>