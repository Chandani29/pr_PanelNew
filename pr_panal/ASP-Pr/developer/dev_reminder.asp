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
<script language="JavaScript">
function checkLogin()
{	
	if(document.re_form.txt_re_sub.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.re_form.txt_re_sub.focus();
		return false;
	}
	else if(document.re_form.txt_re_desc.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.re_form.txt_re_desc.focus();
		return false;
	}
	else if(document.re_form.txt_re_date.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.re_form.txt_re_date.focus();
		return false;
	}
	else
	{
		var SetForm=document.re_form;
		 //alert("hello");
		 remark = new String(SetForm.txt_re_desc.value);
		 //alert(remark);
		 remark= remark.replace(/'/g,"''");
		 //alert(remark);
		 SetForm.txt_re_desc.value=remark;
		return true;
	}
}	
</script>
<script lan language="javascript" type="text/javascript">

function localdate()
{
	var currentTime = new Date()
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate()
	var year = currentTime.getFullYear()
	if (day < 10)
	{
		day = "0" + day
	}
	if (month < 10)
	{
		month = "0" + month
	}
	var ddate = month + "/" + day + "/" + year
	
	var hours = currentTime.getHours()
	var minutes = currentTime.getMinutes()
	var seconds = currentTime.getSeconds()
	if (hours < 10)
	{
		hours = "0" + hours
	}
	if (minutes < 10)
	{
		minutes = "0" + minutes
	}
	if (seconds < 10)
	{
		seconds = "0" + seconds
	}
	dtime = hours + ":" + minutes + ":" + seconds
	//if(hours > 11)
//	{
//		dtime = dtime + "PM"
//	} 
//	else 
//	{
//		dtime = dtime + "AM"
//	}
	dttime = ddate + " " + dtime
	
	document.re_form.txt_date.value = dttime;
}

</script>

</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="localdate();">
<%
	  	call OpenConnection	
		set rsProject1 = server.CreateObject("adodb.recordset")
		strsql1 = "select * from tbl_pr_devreminder where re_status='No' and dev_id='" & trim(session("DeveloperName")) & "' order by srno desc"
		rsProject1.open strsql1,NewConnection
		if rsProject1.EOF or rsProject1.BOF then
			re_sub = ""
			re_desc = ""
			re_date = ""
		else
%>
<table width="400" border="1" cellspacing="2" cellpadding="1"> 
  <tr align="center"> 
    <td colspan="3" class="txt"><strong class="Tab2">&nbsp;</strong><br>
      Old Reminders</td>
  </tr>
  <tr> 
    <td align="center" class="Tab3"><strong>Reminder Subject</strong></td>
    <td align="center" class="Tab3"><strong>Reminder Description</strong></td>    
	<td align="center" class="Tab3"><strong>Reminder Date</strong></td>    
  </tr>  
  <%		
		do while not rsProject1.eof
			re_sub = rsProject1("re_sub")
			re_desc = rsProject1("re_desc")
			re_date = rsProject1("re_date")
		
%>
  <tr> 
    <td align="left" class="Tab3"><%=re_sub%>&nbsp;</td>
    <td align="left" class="Tab3"><%=re_desc%>&nbsp;</td>
	 <td align="left" class="Tab3"><%=re_date%>&nbsp;</td>    
  </tr>  

<% 
      rsProject1.movenext
	  loop
	  end if		
		call CloseConnection
%>
</table>
<form name="re_form" method="post" action="dev_reminder_cal.asp">
  <table width="400" border="1" cellspacing="2" cellpadding="1">
    <tr align="center"> 
      <td colspan="2" class="txt">Reminder  Entry Form</td>
    </tr>
    <tr> 
      <td width="199" align="right" class="Tab3"><strong>Date</strong></td>
      <td width="185"><input name="txt_date" type="text" id="txt_date" size="30" readonly></td>
    </tr>
	<tr> 
      <td align="right" class="Tab3"><strong>Reminder Subject</strong></td>
      <td><input type="text" name="txt_re_sub" id="txt_re_sub">
       &nbsp;</td>
    </tr>   
    <tr> 
      <td align="right" class="Tab3"><strong>Reminder Description</strong></td>
      <td><textarea name="txt_re_desc" cols="50" rows="4" id="txt_re_desc"></textarea>
       &nbsp;</td>
    </tr> 
	<tr> 
      <td align="right" class="Tab3"><strong>Reminder Date</strong></td>
      <td><input type="text" name="txt_re_date" id="txt_re_date" value="<%=date()%>" readonly=""><script type="text/javascript">
			function catcalc(cal)
			{
				var date = cal.date;
				var time = date.getTime()
				var field = document.getElementById("txt_re_date");
				var date2 = new Date(time);
				field.value = date2.print("%m/%d/%Y");
			}
			Calendar.setup({inputField:"txt_re_date", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
		</script>
       &nbsp;</td>
    </tr>   
    <tr align="center"> 
      <td colspan="2"><input name="Submit" type="submit" class="Tab2" value="Submit" onClick="return checkLogin();"> 
        </td>
    </tr>
  </table>
  
</form>
<p>&nbsp;</p>
</body>
</html>