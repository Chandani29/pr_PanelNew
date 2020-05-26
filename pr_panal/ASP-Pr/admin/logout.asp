<!-- #include file="header.inc"-->
<html>

<%

	Session("admin")=""

	'Session.Abandon()
%>
<head>
<script language="javascript">

	function callme()
	{
		parent.location.href = "index.asp" ;
	}

</script>
</head>

<body onLoad="callme();">

</body>
</html>