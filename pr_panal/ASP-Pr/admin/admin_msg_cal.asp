<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
Session.Timeout=480
Server.ScriptTimeout=2400
if(Session("admin")="") then
	 response.Redirect("index.asp")
end if
	txt_msg = Request("txt_admin_msg")
	s_date = request("txt_date")
	
	  call OpenConnection
		
		Set rsUser1 = NewConnection.Execute("insert into tbl_pr_admin_msg(admin_msg,s_date) values('" & txt_msg & "','" & s_date &  "')")
			call closeconnection
			response.Redirect("admin_msg.asp")		

%>
