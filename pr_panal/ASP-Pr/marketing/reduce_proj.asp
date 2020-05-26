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
process = request("p")
'response.Write(process)
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
<link rel="stylesheet" type="text/css" media="all" href="calender/calendar-win2k-2.css" title="win2k-cold-1" />
<script type="text/javascript" src="calender/calendar.js"></script>
<script type="text/javascript" src="calender/calendar-en.js"></script>
<script type="text/javascript" src="calender/calendar-setup.js"></script>

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
	else if(document.form1.txt_Delivery.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_Delivery.focus();
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
<form name="form1" method="post" action="reduce_proj_cal.asp">
  <table width="400" border="1" cellspacing="2" cellpadding="1">
    <tr align="center"> 
      <td colspan="2" class="txt">Kindly fill the new requirements :</td>
    </tr>
	<tr> 
      <td align="center" class="Tab3"><strong>Project ID/Name</strong></td>
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
      <td align="center" class="Tab3"><strong>Date</strong></td>
      <td align="left" class="Tab3"><input name="txt_date" type="text" id="txt_date" readonly></td>
    </tr>
    <tr> 
      <td align="center" class="Tab3"><strong>Hour</strong></td>
      <td align="left" class="Tab3"><input type="text" name="txt_totalHour">
        [Hours you want to deduct]</td>
    </tr>
    <tr> 
      <td align="center" class="Tab3"><strong>Cost</strong></td>
      <td align="left" class="Tab3"><input type="text" name="txt_totalcost">
        [Cost you want to deduct]</td>
    </tr>
	<tr> 
      <td align="center" class="Tab3"><strong>Delivery Date</strong></td>
      <td align="left" class="Tab3"><input type="text" name="txt_Delivery" id="txt_Delivery" value='<%=submeted_on%>' readonly>
        [ you can extend/reduce delivery date, if required]</td>
	  <script type="text/javascript">
				function catcalc(cal)
				{
					var date = cal.date;
					var time = date.getTime()
					var field = document.getElementById("txt_Delivery");
					var date2 = new Date(time);
					field.value = date2.print("%m/%d/%Y");
				}
				Calendar.setup({inputField:"txt_Delivery", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
	</script>
    </tr>
    <tr> 
      <td align="center" class="Tab3"><strong>New Description/Remarks</strong></td>
      <td align="left" class="Tab3"><textarea name="txt_remark" cols="80" rows="18"></textarea></td>
    </tr>
    <input type="hidden" name="h_srno" value='<%=srno%>'>
    <input type="hidden" name="h_status" value='<%=process%>'>
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