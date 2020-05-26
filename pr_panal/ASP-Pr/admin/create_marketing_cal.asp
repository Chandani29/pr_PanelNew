<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
Session.Timeout=480
Server.ScriptTimeout=2400
if(Session("admin")="") then
	 response.Redirect("index.asp")
end if
	txt_name = Request("txt_name")
	Username = Request("Username")
	Password = Request("Password")
	If(Request("txt_name") = "" or Request("Username")="" or Request("Password")="") Then
		response.Redirect("create_marketing.asp")
	else	
	  call OpenConnection
		Set rsUser = NewConnection.Execute("SELECT * FROM tbl_pr_marketingLogin WHERE user_id='" & Username & "'")
		If rsUser.EOF or rsUser.BOF Then
			Set rsUser1 = NewConnection.Execute("insert into tbl_pr_marketingLogin(user_id,user_pass,name) values('" & Username & "','" & Password & "','" & txt_name & "')")
			session("ErrorMessage") = "<P><font color='red'>Thanks for submit data</font></P>"
			rsUser.close
			Set rsUser = Nothing
			Set objConn = Nothing
			response.Redirect("create_marketing.asp")
		Else
			session("ErrorMessage") = "<P><font color='red'>Username already exist</font></P>"
			
			rsUser.close

			Set rsUser = Nothing
			call closeconnection
			response.Redirect("create_marketing.asp")
		

		End If
	End If

%>
