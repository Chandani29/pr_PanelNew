<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("dr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
ddate = now()
dim srno

%>
<html>
<head>
<title>Developer Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="calender/calendar-win2k-2.css" title="win2k-cold-1" />
<script type="text/javascript" src="calender/calendar.js"></script>
<script type="text/javascript" src="calender/calendar-en.js"></script>
<script type="text/javascript" src="calender/calendar-setup.js"></script>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
	  	call OpenConnection	
		set rsProject1 = server.CreateObject("adodb.recordset")
		strsql1 = "select * from tbl_pr_devreminder where re_status='Yes' and dev_id='" & trim(session("DeveloperName")) & "' order by srno desc"
		rsProject1.open strsql1,NewConnection
		if rsProject1.EOF or rsProject1.BOF then
			re_sub = ""
			re_desc = ""
			re_date = ""
			re_status = ""
			done_remark = ""
			done_date = ""
			
		else
%>
<table width="800" border="1" cellspacing="2" cellpadding="1"> 
  <tr align="center"> 
    <td colspan="6" class="txt"><strong class="Tab2">&nbsp;</strong><br>
      Done Reminders (<%=trim(session("DeveloperName"))%>)</td>
  </tr>
  <tr> 
    <td align="center" class="Tab3"><strong>Reminder Subject</strong></td>
    <td align="center" class="Tab3"><strong>Reminder Description</strong></td>    
	<td align="center" class="Tab3"><strong>Reminder Date</strong></td>  
	<td align="center" class="Tab3"><strong>Reminder Status</strong></td>   
	<td align="center" class="Tab3"><strong>Reminder Remark</strong></td>   
	<td align="center" class="Tab3"><strong>Reminder Done</strong></td>    
  </tr>  
  <%		
		do while not rsProject1.eof
			re_sub = rsProject1("re_sub")
			re_desc = rsProject1("re_desc")
			re_date = rsProject1("re_date")
			re_status = rsProject1("re_status")
			done_remark = rsProject1("done_remark")
			done_date = rsProject1("done_date")	
%>
  <tr> 
    <td align="left" class="Tab3"><%=re_sub%>&nbsp;</td>
    <td align="left" class="Tab3"><%=re_desc%>&nbsp;</td>
	 <td align="left" class="Tab3"><%=re_date%>&nbsp;</td> 
	 <td align="left" class="Tab3"><%=re_status%>&nbsp;</td>
	 <td align="left" class="Tab3"><%=done_remark%>&nbsp;</td>
	 <td align="left" class="Tab3"><%=done_date%>&nbsp;</td>   
  </tr>  

<% 
      rsProject1.movenext
	  loop
	  end if		
		call CloseConnection
%>
</table>
<p>&nbsp;</p>
</body>
</html>