<!-- #include file="header.inc"-->
<html>

<%
if Session("pr_username")="" then
		response.Redirect("admin.asp")
	end if

	Session("pr_username") = ""
	Session("MarketingName") = ""
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