<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
	user_id = request("txt_id")
	txt_oldpass = Request("txt_old_pass")
	txt_newpass = Request("txt_pass")
	txt_name = Request("txt_name")
	If(Request("txt_old_pass") = "" or Request("txt_pass")="" or Request("txt_id")="") Then
		response.Redirect("edit_marketing.asp?uid=" & user_id & "")
	else	
	  call OpenConnection
		Set rsUser = NewConnection.Execute("SELECT * FROM tbl_pr_marketingLogin WHERE user_id='" & user_id & "' and user_pass='" & txt_oldpass &"'")
		If rsUser.EOF or rsUser.BOF Then
			
			session("ErrorMessage") = "<P><font color='red'>plz enter correct password</font></P>"
			rsUser.close
			Set rsUser = Nothing
			Set objConn = Nothing
			response.Redirect("edit_marketing.asp?uid=" & user_id & "")
		Else
			
			Set rsUser1 = NewConnection.Execute("update tbl_pr_marketingLogin set user_pass='" & txt_newpass & "',name='" & txt_name & "' WHERE user_id='" & user_id & "'")
			session("ErrorMessage") = "<P><font color='red'>Record Updated</font></P>"
			
			rsUser.close

			Set rsUser = Nothing
			call closeconnection
			response.Redirect("adminmain.asp")	

		End If
	End If

%>
