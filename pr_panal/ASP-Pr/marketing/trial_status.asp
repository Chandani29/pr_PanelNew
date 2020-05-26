<!-- #include file="header.inc"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
ddate = date()
dim srno
srno_all = request("srno")
find_srno = instr(srno_all,"_")

srno = mid(srno_all,find_srno+1)
dd_select = mid(srno_all,1,find_srno-1)

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
	if(document.form1.txt_totalHour.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_totalHour.focus();
		return false;
	}
	else if (isNaN(document.form1.txt_totalHour.value))
	{
		alert("Please Enter Only Digits between 1 to 9.");
		document.form1.txt_totalHour.select();
		return false;
	}
	else if(document.form1.txt_totalcost.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_totalcost.focus();
		return false;
	}
	else if (isNaN(document.form1.txt_totalcost.value))
	{
		alert("Please Enter Only D1gits between 1 to 9.");
		document.form1.txt_totalcost.select();
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
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="form1" method="post" action="trial_status_cal.asp">
  <table width="400" border="1" cellspacing="2" cellpadding="1">
    <tr align="center"> 
      <td colspan="2" class="txt">Kindly fill the new requirements :</td>
    </tr>
    <tr> 
      <td align="center" class="Tab3"><strong>Total Hours</strong></td>
      <td align="center" class="Tab3"><input type="text" name="txt_totalHour"></td>
    </tr>
    <tr> 
      <td align="center" class="Tab3"><strong>Total Cost</strong></td>
      <td align="center" class="Tab3"><input type="text" name="txt_totalcost"></td>
    </tr>
    <tr> 
      <td align="center" class="Tab3"><strong>New Description</strong></td>
      <td align="center" class="Tab3"><textarea name="txt_remark" cols="80" rows="18"></textarea></td>
    </tr>
    <input type="hidden" name="h_srno" value='<%=srno%>'>
    <input type="hidden" name="h_dd_status" value='<%=dd_select%>'>
    <tr align="center"> 
      <td colspan="2"> &nbsp;&nbsp;&nbsp;&nbsp; <input name="Submit" type="submit" class="Tab2" value="Submit" onClick="return checkLogin();">
        &nbsp;&nbsp;&nbsp; 
        <input name="Submit2" type="button" class="Tab2" value="Cancel" onClick="window.location = 'project_report_selected.asp';"></td>
    </tr>
  </table>
  
</form>
<p>&nbsp;</p>
</body>
</html>