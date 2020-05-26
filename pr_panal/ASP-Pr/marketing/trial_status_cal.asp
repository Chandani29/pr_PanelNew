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
dim srno
srno = request("h_srno")
dd_status = request("h_dd_status")
totalHour = request("txt_totalHour")
amount = request("txt_totalcost")
remark = request("txt_remark")

'response.Write(srno)
'response.Write(dd_status)
'response.Write(totalHour)
'response.Write(amount)
'response.Write(remark)

	call OpenConnection
	
		set rsProject = server.CreateObject("adodb.recordset")
		strsql = "select * from tbl_pr_project where srNo='"& srno & "'"
		rsProject.open strsql,NewConnection
		data_hour = rsProject("total_hour")
		data_remark = rsProject("proj_desc")
		response.Write(strsql)
		
		remark = data_remark & " + " & remark
		totalHour = int(data_hour) + int(totalHour)
	
	set rsProject1 = server.CreateObject("adodb.recordset")
		strsql1 = "update tbl_pr_project set workstatus='" & dd_status & "',proj_desc='" & remark & "',cost='" & amount & "',total_hour='" & totalHour & "',trial_status='1' where srno='"& srno & "'"
		response.Write(strsql1)
		set rsProject1= NewConnection.execute(strsql1)
		response.Redirect("project_report_selected.asp")
		'response.Write(strsql)
%>