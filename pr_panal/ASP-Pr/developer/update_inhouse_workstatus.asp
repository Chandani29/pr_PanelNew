<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
	dim strsql
	dim rsproject
	Session.Timeout=480
	Server.ScriptTimeout=2400
	if Session("dr_username")="" then
		response.Redirect("admin.asp")
	end if
	call OpenConnection
	proj_id = request("h_id")
	refno=request("refno")
	response.Write(proj_id)
	response.Write(refno)	
	
		set rsProject = server.CreateObject("adodb.recordset")
		strsql = "update tbl_pr_projDetails set work_status='1' where srno='"& proj_id & "'"
		response.Write(strsql)
		set rsProject= NewConnection.execute(strsql)
		response.Redirect("inhouse_project_report.asp?refno=" & refno &"")
				
%>