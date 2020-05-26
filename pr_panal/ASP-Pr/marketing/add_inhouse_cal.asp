<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
	ddate = request("txt_date")
	
	srno = Request("h_id")
	proj_id = Request("proj_id")
	txt_projInhouse = request("txt_projInhouse")
response.Write(srno)
response.Write(proj_id)
call OpenConnection

			strsql = "insert tbl_pr_projInhouse(ProjId,ProjName,ddate) values('" & srno & "','" & txt_projInhouse & "','" & ddate & "')"
			response.Write(strsql)
			set rsUPProject= NewConnection.execute(strsql)
			response.Redirect("add_inhouse_proj.asp?srno=" & srno & "")
			'response.Write("Data updated!!")
		
%>