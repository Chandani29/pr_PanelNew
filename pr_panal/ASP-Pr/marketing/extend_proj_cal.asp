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
process = request("h_status")
totalHour = request("txt_totalHour")
amount = request("txt_totalcost")
delivery_date = request("txt_Delivery")
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
		proj_cost = rsProject("cost")
		'response.Write(strsql)
		bal_amount = amount + proj_cost
		remark = data_remark & " + " & remark
		totalHour = int(data_hour) + int(totalHour)
		submitiond_date = ddate
	
	set rsProject1 = server.CreateObject("adodb.recordset")
		strsql1 = "update tbl_pr_project set submeted_on='" & delivery_date & "',proj_desc='" & remark & "',cost='" & bal_amount & "',total_hour='" & totalHour & "' where srno='"& srno & "'"
		response.Write(strsql1)
		Response.Write("<br>")
		set rsProject1= NewConnection.execute(strsql1)
	set rscost = server.CreateObject("adodb.recordset")
		strsqcost = "insert into tbl_pr_cost_history (proj_id,bal_cost,process,P_cost,ddate) values('" & srno & "','"& proj_cost & "','" & process & "','" & amount & "','" & ddate & "')"
		response.Write(strsqcost)
		set rscost= NewConnection.execute(strsqcost)			
		response.Redirect("project_report_selected.asp")
		
%>