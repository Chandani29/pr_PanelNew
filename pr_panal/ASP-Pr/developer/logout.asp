<!-- #include file="header.inc"-->
<html>

<%
if Session("dr_username")="" then
		response.Redirect("admin.asp")
	end if

	Session("dr_username") = ""
	Session("DeveloperName") = ""
	Session("adminlogin") = ""

	'Session.Abandon()
%>
<head>
<script language="javascript">

	function callme()
	{
		parent.location.href = "admin.asp" ;
	}

</script>
</head>

<body onLoad="callme();">

</body>
</html>