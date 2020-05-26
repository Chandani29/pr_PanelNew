<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
ddate = now()
dim srno
srno = request("srno")
'response.Write(srno_all)
'response.Write("<br>")
'response.Write(dd_select)
'response.Write(srno)	

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
	if(document.form1.txt_amount.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_amount.focus();
		return false;
	}
	else if (isNaN(document.form1.txt_amount.value))
	{
		alert("Please Enter Only Digits between 1 to 9.");
		document.form1.txt_amount.focus();
		return false;
	}
	else if(document.form1.txt_exp_name.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_exp_name.focus();
		return false;
	}
	else
	{
		var SetForm=document.form1;
		 //alert("hello");
		 remark = new String(SetForm.txt_exp_name.value);
		 //alert(remark);
		 remark= remark.replace(/'/g,"''");
		 //alert(remark);
		 SetForm.txt_exp_name.value=remark;
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
		strsql1 = "select * from tbl_pr_project where srNo='"& srno & "'"
		rsProject1.open strsql1,NewConnection
		p_id1 = rsProject1("proj_id")
		p_name1 = rsProject1("proj_name")
		submeted_on1 = rsProject1("submeted_on")
		call CloseConnection
%>
<table width="400" border="1" cellspacing="2" cellpadding="1">
  <%
	  	call OpenConnection	
		set rspartial = server.CreateObject("adodb.recordset")
		strsql1 = "select * from tbl_pr_expenses where proj_id='"& srno & "' order by convert(int,srno) desc"
		rspartial.open strsql1,NewConnection
		if rspartial.eof or rspartial.bof then
		else
			ddate_us2 = rspartial("ddate")
			'ddate_In2 = DateAdd("h", 9, ddate_us2)  
			'ddate_india2 = DateAdd("n", 30, ddate_In2)	
			ddate_india2 = ddate_us2		
%>
  <tr align="center"> 
    <td colspan="3" class="txt"><strong class="Tab2">[<%= p_id1 %>] &nbsp;<%= p_name1 %></strong><br>
      Summary of Expenses</td>
  </tr>
  <tr> 
    <td align="center" class="Tab3"><strong>Date</strong></td>
    <td align="center" class="Tab3"><strong>Expense Name</strong></td>
    <td align="center" class="Tab3"><strong>Expense Ammount INR</strong></td>
  </tr>
  <%		
		do while not rspartial.eof
		
%>
  <tr> 
    <td align="left" class="Tab3"><%=ddate_india2%>&nbsp;</td>
    <td align="left" class="Tab3"><%=rspartial("exp_name")%>&nbsp;</td>
    <td align="left" class="Tab3"><%= rspartial("proj_exp_cost")%>&nbsp;</td>
  </tr>
  <%
	rspartial.movenext
	loop
	end if
	call CloseConnection
%>
</table>




<form name="form1" method="post" action="proj_expenses_cal.asp">
  <table width="400" border="1" cellspacing="2" cellpadding="1">
    <tr align="center"> 
      <td colspan="2" class="txt">Expense Entry Form</td>
    </tr>
    <tr> 
      <td align="right" class="Tab3"><strong>Project ID/Name</strong></td>
      <%
	  	call OpenConnection	
		set rsProject = server.CreateObject("adodb.recordset")
		strsql = "select * from tbl_pr_project where srNo='"& srno & "'"
		rsProject.open strsql,NewConnection
		p_id = rsProject("proj_id")
		p_name = rsProject("proj_name")
		submeted_on = rsProject("submeted_on")
		call CloseConnection
	  %>
      <td align="left" class="Tab2"><%= p_name %> - <%= p_id %></td>
    </tr>
    <tr> 
      <td align="right" class="Tab3"><strong>Date</strong></td>
      <td align="left" class="Tab3"><input name="txt_date" type="text" id="txt_date" readonly></td>
    </tr>
    <tr> 
      <td align="right" class="Tab3"><strong>Expense Name</strong></td>
      <td><input type="text" name="txt_exp_name"> &nbsp;</td>
    </tr>
    <tr> 
      <td width="199" align="right" class="Tab3"><strong>Expense Ammount INR</strong></td>
      <td width="185"><input type="text" name="txt_amount"></td>
    </tr>
    <input type="hidden" name="h_srno" value='<%=srno%>'>
    <input type="hidden" name="h_dd_status" value='<%=dd_select%>'>
    <tr align="center"> 
      <td colspan="2"><input name="Submit" type="submit" class="Tab2" value="Submit" onClick="return checkLogin();"> 
        &nbsp;&nbsp;&nbsp;&nbsp; <input name="Submit2" type="button" class="Tab2" value="Back" onClick="window.location = 'project_report_selected.asp';"> 
      </td>
    </tr>
  </table>
  
</form>
<p>&nbsp;</p>
</body>
</html>