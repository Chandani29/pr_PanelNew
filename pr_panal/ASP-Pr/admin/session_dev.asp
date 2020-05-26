<!-- #include file="header.inc"-->
<%

	Session.Timeout=480
	Server.ScriptTimeout=2400 
	Username = Request("uid")
	'Password = Request("Password")
	name1 = request("uname")
	Session("dr_username") = trim(Username)	
	Session("DeveloperName") = trim(name1)
	Session("adminlogin") = "yes"
	
	response.write Session("dr_username")
	response.write Session("DeveloperName")
	response.write Session("adminlogin")	
	Response.redirect "../developer/developer_assign_proj.asp"	
			
%>