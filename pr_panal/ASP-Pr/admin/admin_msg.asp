<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if(Session("admin")="") then
	response.Redirect("index.asp")
end if
dim ddate
ddate = now()
dim srno

%>
<html>
<head>
<title>Marketing Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function checkLogin()
{	
	if(document.form1.txt_admin_msg.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_admin_msg.focus();
		return false;
	}
	else
	{
		var SetForm=document.form1;
		 //alert("hello");
		 remark = new String(SetForm.txt_admin_msg.value);
		 //alert(remark);
		 remark= remark.replace(/'/g,"''");
		 //alert(remark);
		 SetForm.txt_admin_msg.value=remark;
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
	
	document.form1.txt_date.value = dttime;
}

</script>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="localdate();">
<%
	  	call OpenConnection	
		set rsProject1 = server.CreateObject("adodb.recordset")
		strsql1 = "select top 1 * from tbl_pr_admin_msg order by srno desc"
		rsProject1.open strsql1,NewConnection
		if rsProject1.EOF or rsProject1.BOF then
			a_msg = ""
			submeted_on = ""
		else
			a_msg = rsProject1("admin_msg")
			submeted_on = rsProject1("s_date")
		end if		
		call CloseConnection
%>
<table width="400" border="1" cellspacing="2" cellpadding="1"> 
  <tr align="center"> 
    <td colspan="3" class="txt"><strong class="Tab2">&nbsp;</strong><br>
      Admin Message</td>
  </tr>
  <tr> 
    <td align="center" class="Tab3"><strong>Date</strong></td>
    <td align="center" class="Tab3"><strong>New Message</strong></td>    
  </tr>  
  <tr> 
    <td align="left" class="Tab3"><%=submeted_on%>&nbsp;</td>
    <td align="left" class="Tab3"><%=a_msg%>&nbsp;</td>    
  </tr>  
</table>




<form name="form1" method="post" action="admin_msg_cal.asp">
  <table width="400" border="1" cellspacing="2" cellpadding="1">
    <tr align="center"> 
      <td colspan="2" class="txt">Admin Message  Entry Form</td>
    </tr>
    <tr> 
      <td width="199" align="right" class="Tab3"><strong>Date</strong></td>
      <td width="185" align="left" class="Tab3"><input name="txt_date" type="text" id="txt_date" size="20" readonly></td>
    </tr>
    <tr> 
      <td align="right" class="Tab3"><strong>New Message</strong></td>
      <td><textarea name="txt_admin_msg" cols="50" rows="4" id="txt_admin_msg"></textarea>
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