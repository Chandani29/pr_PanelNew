<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
	Session.Timeout=480
	Server.ScriptTimeout=2400
	if Session("pr_username")="" then
		response.Redirect("admin.asp")
	end if
	txt_re_sub = Request("txt_re_sub")
	txt_re_desc = Request("txt_re_desc")
	txt_re_date = Request("txt_re_date")
	s_date = request("txt_date")
	
	  call OpenConnection
		
		Set rsUser1 = NewConnection.Execute("insert into tbl_pr_mpreminder(mp_id,re_sub,re_desc,re_date,s_date,re_status) values('" & trim(session("MarketingName")) & "','" & txt_re_sub & "','" & txt_re_desc & "','" & txt_re_date & "','" & s_date &  "','No')")
			call closeconnection
			response.Redirect("mr_reminder.asp")		

%>
