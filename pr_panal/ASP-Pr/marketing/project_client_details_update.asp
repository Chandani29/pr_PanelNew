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
dim refno
refno = request("refno")
clientname = request("txt_clientname")
p_referance = request("txt_referance")
clientmobile = request("txt_clientmobile")
clientemail = request("txt_clientemail")
clientcompany = request("txt_clientcompany")
clientadd = request("txt_clientadd")

	call OpenConnection
	
		set rsProject1 = server.CreateObject("adodb.recordset")
		strsql1 = "update tbl_pr_project set clientname='" & clientname & "',proj_source='" & p_referance & "',clientmobile='" & clientmobile & "',clientcompany='" & clientcompany & "',clientemail='" & clientemail & "',clientadd='" & clientadd & "' where srno='"& refno & "'"
		response.Write(strsql1)
		Response.Write("<br>")
		set rsProject1= NewConnection.execute(strsql1)			
		response.Redirect("project_client_details.asp?refno=" & refno & "")
		'response.Write(strsql)
%>