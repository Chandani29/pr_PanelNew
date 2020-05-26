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
dim srno
srno = request("h_srno")
exp_amount = request("txt_amount")
exp_name = request("txt_exp_name")

'response.Write(srno)
'response.Write(dd_status)
'response.Write(amount)
'response.Write(remark)

	call OpenConnection
	set rsProject = server.CreateObject("adodb.recordset")
		'strsql = "update tbl_pr_project set workstatus='" & dd_status & "',remark='" & remark & "',payment_received='" & amount &"',payment_type='" & pay_type & "',completed_on='" & ddate &"' where srno='"& srno & "'"
		strsql = "insert into  tbl_pr_expenses(proj_id,proj_exp_cost,exp_name,ddate) values('" & srno & "','" & exp_amount & "','" & exp_name & "','" & ddate &"')"
		response.Write(strsql)
		set rsProject= NewConnection.execute(strsql)
		response.Redirect("proj_expenses.asp?srno=" & srno & "")
		'response.Write(strsql)
%>