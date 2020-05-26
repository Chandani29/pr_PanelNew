<!-- #include file="header.inc"-->
<%
if Session("pr_username")="" then
		response.Redirect("admin.asp")
	end if
response.Write("hello")
%>