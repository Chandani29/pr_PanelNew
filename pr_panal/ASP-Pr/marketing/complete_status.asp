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
srno_all = request("srno")
find_srno = instr(srno_all,"_")

srno = mid(srno_all,find_srno+1)
dd_select = mid(srno_all,1,find_srno-1)

'response.Write(srno_all)
'response.Write("<br>")
'response.Write(dd_select)
'response.Write(srno)	
	call OpenConnection
	set rsProject = server.CreateObject("adodb.recordset")
	rsProject.open "select * from tbl_pr_projDetails where proj_id='" & srno & "' and work_by_mark is not null and work_status='0'",NewConnection
	if rsProject.eof or rsProject.bof then
		'response.Write("You Have No Pending Task")
	
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
	else if (document.form1.txt_amount.value != document.form1.txt_htotal.value)
	{
		alert("Your Balance Amount Is Either Lower Or Higher.");
		document.form1.txt_amount.focus();
		return false;
	}
	else if(document.form1.txt_PayType.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_PayType.focus();
		return false;
	}
	
	else if(document.form1.txt_remark.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_remark.focus();
		return false;
	}
	else
	{
		var SetForm=document.form1;		 
		 remark = new String(SetForm.txt_remark.value);		 
		 remark= remark.replace(/'/g,"''");		 
		 SetForm.txt_remark.value=remark;
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
		if rsProject1.eof or rsProject1.bof then
		else
			p_id1 = rsProject1("proj_id")
			p_cost = rsProject1("cost")
			p_name1 = rsProject1("proj_name")
			submeted_on1 = rsProject1("submeted_on")
		end if
		
%>
<table width="400" border="1" cellspacing="2" cellpadding="1">    

<%
	  	call OpenConnection	
		set rspartial = server.CreateObject("adodb.recordset")
		strsql1 = "select * from tbl_pr_partial_payment where proj_id='"& srno & "' order by convert(int,srno) desc"
		rspartial.open strsql1,NewConnection
		if rspartial.eof or rspartial.bof then
		else					
%>
	 <tr align="center">       
    	<td colspan="5" class="txt"> Summary of Payment</td>
    </tr>
	<tr>
	  <td align="center" class="Tab3"><strong>Project&nbsp;Name</strong></td>
	  <td align="center" class="Tab3"><strong>Project&nbsp;ID</strong></td>
	  <td align="center" class="Tab3"><strong>Date</strong></td>
	  <td align="center" class="Tab3"><strong>Paid Ammount INR</strong></td>
	  <td align="center" class="Tab3"><strong>Payment Type</strong></td>      
    </tr>

<%		
		totalp_payment = 0
		do while not rspartial.eof
		
		ddate_us2 = rspartial("ddate")	
		'ddate_In2 = DateAdd("h", 9, ddate_us2) 
		'ddate_india2 = DateAdd("n", 30, ddate_In2)
		ddate_india2 = ddate_us2		
%>	
	
	<tr> 
	  <td align="left" class="Tab3"><%= p_name1 %></td>
      <td align="left" class="Tab3"><%= p_id1 %></td>
	  <td align="left" class="Tab3"><%=ddate_india2%></td>
	  <td align="left" class="Tab3"><%=rspartial("p_payment")%></td>
	  <td align="left" class="Tab3"><%=rspartial("pay_mode")%></td>	  
    </tr> 
<%
	totalp_payment = totalp_payment + rspartial("p_payment")
	rspartial.movenext
	loop
	end if
	totap_balance = p_cost - totalp_payment
%>	
	<tr> 
	  <td align="left" class="Tab3" colspan="3"><strong>Total Partial Payment</strong></td>
      <td align="left" class="Tab3" colspan="2"><strong><%=totalp_payment%></strong></td>	   
    </tr>
    <tr> 
	  <td align="left" class="Tab3" colspan="3"><strong>Project Cost</strong></td>
      <td align="left" class="Tab3" colspan="2"><strong><%=p_cost%></strong></td>	   
    </tr>
    <tr> 
	  <td align="left" class="Tab3" colspan="3"><strong>Balance Amount</strong></td>
      <td align="left" class="Tab3" colspan="2"><strong><%=totap_balance%></strong></td>	   
    </tr>     
  </table>
<form name="form1" method="post" action="complete_status_cal.asp">
  <table width="400" border="1" cellspacing="2" cellpadding="1">
    <tr align="center"> 
      <td colspan="2" class="txt">Note: Make sure payment has been recieved</td>
    </tr>    
    <tr> 
      <td width="199" align="right" class="Tab3"><strong>Project Name</strong></td>
      <td width="185" class="Tab3"><strong><%=p_name1%><input type="hidden" name="txt_htotal" id="txt_htotal" value="<%=totap_balance%>"><input type="hidden" name="txt_date" id="txt_date"></strong></td>
    </tr>    
    <tr> 
      <td width="199" align="right" class="Tab3"><strong>Paid&nbsp;Ammount&nbsp;INR</strong></td>
      <td width="185"><input type="text" name="txt_amount"></td>
    </tr>
	<tr> 
      <td align="right" class="Tab3"><strong>Payment Type</strong></td>
      <td><input type="text" name="txt_PayType">&nbsp;</td>
    </tr>
    <tr> 
      <td align="right" class="Tab3"><strong>Client's Remark</strong></td>
      <td><textarea name="txt_remark" cols="80" rows="10"></textarea></td>
    </tr>
    <input type="hidden" name="h_srno" value='<%=srno%>'>
    <input type="hidden" name="h_dd_status" value='<%=dd_select%>'>
    <tr align="center"> 
      <td colspan="2"><input name="Submit" type="submit" class="Tab2" value="Submit" onClick="return checkLogin();"> 
        &nbsp;&nbsp;&nbsp;&nbsp; <input name="Submit2" type="button" class="Tab2" value="Cancel" onClick="window.location = 'project_report_selected.asp';"> 
      </td>
    </tr>
  </table>
  
</form>
<p>&nbsp;</p>
</body>
</html>
<%
else
%>
<html>
<head>
<title>Marketing Panel</title>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<%
	response.Write("<b><br><br><br><font color=red size=2 face=verdana>This project is still showing some work in pending status, Kindly make it done before completing this project.</font><b>")
call CloseConnection
%>
<br>	
<br>	
<a href="project_report_selected.asp">Back</a>
</center>
</body>
</html>
<%
end if
%>