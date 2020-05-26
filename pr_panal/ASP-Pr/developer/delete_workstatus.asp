<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
	if Session("dr_username")="" then
		response.Redirect("admin.asp")
	end if
	
	dim strsql
	dim rsproject
    dd_resion = request("del_resion")
	
	call OpenConnection
	proj_id = request("h_id")
	refno=request("refno")
	response.Write(proj_id)
	response.Write(refno)	
	
		set rsProject = server.CreateObject("adodb.recordset")
		strsql = "update tbl_pr_projDetails set del_status='1',delete_remark='" & dd_resion & "' where srno='"& proj_id & "'"
		response.Write(strsql)
		set rsProject= NewConnection.execute(strsql)
		response.Redirect("project_report.asp?refno=" & refno &"")
				
%>