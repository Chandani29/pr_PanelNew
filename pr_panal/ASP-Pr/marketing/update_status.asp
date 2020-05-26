<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
ddate = date()
dim srno
srno_all = request("srno")
find_srno = instr(srno_all,"_")

srno = mid(srno_all,find_srno+1)
dd_select = mid(srno_all,1,find_srno-1)

'response.Write(srno_all)
response.Write("<br>")
'response.Write(dd_select)
'response.Write(srno)
	call OpenConnection
	set rsProject = server.CreateObject("adodb.recordset")
		strsql = "update tbl_pr_project set workstatus='" & dd_select &"' where srno='"& srno & "'"
		'response.Write(strsql)
		set rsProject= NewConnection.execute(strsql)
		response.Redirect("project_report_selected.asp")
		'response.Write("Data updated!!")

%>
<html>
<head>
<title>Marketing Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
</SCRIPT>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<p>&nbsp;</p></body>
</html>