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
p_amount = request("txt_amount")
pay_type = request("txt_PayType")

'response.Write(srno)
'response.Write(dd_status)
'response.Write(amount)
'response.Write(remark)

	call OpenConnection
	set rsProject = server.CreateObject("adodb.recordset")
		'strsql = "update tbl_pr_project set workstatus='" & dd_status & "',remark='" & remark & "',payment_received='" & amount &"',payment_type='" & pay_type & "',completed_on='" & ddate &"' where srno='"& srno & "'"
		strsql = "insert into  tbl_pr_partial_payment(proj_id,p_payment,pay_mode,ddate) values('" & srno & "','" & p_amount & "','" & pay_type & "','" & ddate &"')"
		response.Write(strsql)
		set rsProject= NewConnection.execute(strsql)
		response.Redirect("project_report_selected.asp")
		'response.Write(strsql)
%>