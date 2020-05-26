
<%
call OpenConnection
		Set rsAdimMsg = NewConnection.Execute("select top 1 * from tbl_pr_admin_msg order by srno desc")
		If rsAdimMsg.EOF or rsAdimMsg.BOF Then
			str_admin_msg = ""
		Else
			str_admin_msg = rsAdimMsg("admin_msg")
		End If
%>
<style type="text/css">
<!--
.admin_msg {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color: #FF0000;
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
	
<div align="center"><marquee><span class="admin_msg"><%=str_admin_msg%>&nbsp;</span></marquee></div>

