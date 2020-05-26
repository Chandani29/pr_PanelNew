<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
	Session.Timeout=480
	Server.ScriptTimeout=2400
	if Session("dr_username")="" then
		response.Redirect("admin.asp")
	end if

	user_id = Session("dr_username")
	txt_oldpass = Request("txt_oldpass")
	txt_newpass = Request("txt_newpass")
	txt_repass = Request("txt_repass")
	If(Request("txt_oldpass") = "" or Request("txt_newpass")="" or Request("txt_repass")="") Then
		response.Redirect("change_pass.asp")
	else	
	  call OpenConnection
		Set rsUser = NewConnection.Execute("SELECT * FROM tbl_pr_developerLogin WHERE user_id='" & user_id & "' and user_pass='" & txt_oldpass &"'")
		If rsUser.EOF or rsUser.BOF Then
			
			session("ErrorMessage") = "<P><font color='red'>plz enter correct password</font></P>"
			rsUser.close
			Set rsUser = Nothing
			Set objConn = Nothing
			response.Redirect("change_pass.asp")
		Else
			
			Set rsUser1 = NewConnection.Execute("update tbl_pr_developerLogin set user_pass='" & txt_newpass & "' WHERE user_id='" & user_id & "'")
			session("ErrorMessage") = "<P><font color='red'>password Changed</font></P>"
			
			rsUser.close

			Set rsUser = Nothing
			call closeconnection
			response.Redirect("change_pass.asp")	

		End If
	End If

%>
