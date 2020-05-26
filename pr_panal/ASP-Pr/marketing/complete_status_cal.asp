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
dd_status = request("h_dd_status")
amount = request("txt_amount")
pay_type = request("txt_PayType")
remark = request("txt_remark")

'response.Write(srno)
'response.Write(dd_status)
'response.Write(amount)
'response.Write(remark)

	call OpenConnection
	set rsProject = server.CreateObject("adodb.recordset")
		strsql = "update tbl_pr_project set workstatus='" & dd_status & "',remark='" & remark & "',payment_received='" & amount &"',payment_type='" & pay_type & "',completed_on='" & ddate &"' where srno='"& srno & "'"
		'response.Write(strsql)
		set rsProject= NewConnection.execute(strsql)
		
	''''''''''''''''''' inserting into partial table ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	set rsPartial = server.CreateObject("adodb.recordset")
		'strsql = "update tbl_pr_project set workstatus='" & dd_status & "',remark='" & remark & "',payment_received='" & amount &"',payment_type='" & pay_type & "',completed_on='" & ddate &"' where srno='"& srno & "'"
		strsql1 = "insert into  tbl_pr_partial_payment(proj_id,p_payment,pay_mode,ddate) values('" & srno & "','" & amount & "','" & pay_type & "','" & ddate &"')"
		response.Write(strsql1)
		set rsPartial= NewConnection.execute(strsql1)		
			
		response.Redirect("project_report_selected.asp")
		'response.Write(strsql)
%>