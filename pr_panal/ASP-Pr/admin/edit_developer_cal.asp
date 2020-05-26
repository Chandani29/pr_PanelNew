<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
	user_id = Request("txt_userid")
	user_name = Request("txt_name")
	txt_oldpass = Request("txt_old_pass")
	txt_newpass = Request("txt_pass")
	txt_jobprofile = Request("txt_jobprofile")
	txt_PerCost = Request("txt_PerCost")
	response.Write(user_id)
	response.Write(user_name)
	response.Write(txt_oldpass)
	response.Write(txt_newpass)
	If(Request("txt_userid") = "" or Request("txt_name") = "" or Request("txt_old_pass") = "") Then
		response.Redirect("edit_developer.asp?uid=" & user_id & "")
	else	
	  call OpenConnection
		Set rsUser = NewConnection.Execute("SELECT * FROM tbl_pr_developerLogin WHERE user_id='" & user_id & "' and user_pass='" & txt_oldpass &"'")
		If rsUser.EOF or rsUser.BOF Then
			
			session("ErrorMessage") = "<P><font color='red'>plz enter correct password</font></P>"
			rsUser.close
			Set rsUser = Nothing
			Set objConn = Nothing
			response.Redirect("edit_developer.asp?uid=" & user_id & "")
		Else
			
			Set rsUser1 = NewConnection.Execute("update tbl_pr_developerLogin set user_pass='" & txt_newpass & "',name='" & user_name &"',job_profile='" & txt_jobprofile &"',per_cost='" & round(txt_PerCost,2) &"' WHERE user_id='" & user_id & "'")
			session("ErrorMessage") = "<P><font color='red'>Record Updated</font></P>"			
			rsUser.close

			Set rsUser = Nothing
			call closeconnection
			response.Redirect("adminmain.asp")	

		End If
	End If

%>
