<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
	Session.Timeout=480
	Server.ScriptTimeout=2400 
	Username = Request("uid")
	'Password = Request("Password")
	name1 = request("uname")
	Session("pr_username") = trim(Username)	
	Session("MarketingName") = trim(name1)
	Session("adminlogin") = "yes"
	
	response.write Session("pr_username")
	response.write Session("DeveloperName")
	response.write Session("adminlogin")
	Response.redirect "../marketing/project_report_selected.asp"
	'response.end

%>