<!-- #include file="header.inc"-->
<%

%>
<html>
<head>
<title>Developer Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
//function validateform()
//{  //reloads the window if Nav4 resized

   //var SetForm=document.form1;
   //remark = new String(SetForm.ccode.value);
   //contact = new String(SetForm.contact.value);
   
   //remark= remark.replace(/'/g,"''");
   //contact = contact.replace(/'/g,"''");
   
   //SetForm.ccode.value=ccode;
   //SetForm.contact.value=contact;
   
  // alert("hello");
   //return true;
//}

function checkLogin()
{	
	if(document.form1.txt_ths.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_ths.focus();
		return false;
	}
	else if (isNaN(document.form1.txt_ths.value))
	{
		alert("Please Enter Only Digits between 1 to 9.");
		document.form1.txt_ths.select();
		return false;
	}
	//else if(document.form1.txt_ths.value.indexOf(".")>0)
	//{
		//alert("Please Enter Only integer value.");
		//document.form1.txt_ths.select();
		//return false;
	//}
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
		 //alert("hello");
		 remark = new String(SetForm.txt_remark.value);
		 //alert(remark);
		 remark= remark.replace(/'/g,"''");
		 //alert(remark);
		 SetForm.txt_remark.value=remark;
		 //alert(SetForm.txt_remark.value);
		 return true;
	}
}	
</script>
<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</SCRIPT>
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
<%
if Session("dr_username")="" then
		response.Redirect("admin.asp")
	end if
	
refno = request("refno")
h_id = request("h_id")
sub_id = request("sub_id")
'response.Write(refno)
'response.Write(h_id)
'response.Write(sub_id)
%>

<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="localdate();">
<form action="inhouse_entry_cal.asp" method="post" name="form1" onSubmit="return validateform()"> 
		<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr bgcolor="#E6E6E6" class="bottom" > 
				
      <td colspan="4" align="center" valign="top" class="Tab2" bgcolor="#CCCCCC">InHouse 
        Reply Form.....</td>				
			</tr>
			<tr bgcolor="#E6E6E6" class="bottom" > 
				<td colspan="2" align="center" valign="top" class="Tab2">&nbsp;Date</td>
				<td colspan="2" valign="top" class="Tab3"> <font color="#FF0000">&nbsp; 
				  <input name="txt_date" type="text" id="txt_date" size="30" readonly>
				  </font></td>
			</tr>
			<tr bgcolor="#E6E6E6" class="bottom" > 
				
          <td colspan="2" align="center" valign="top" class="Tab2">Total Hr. Spent</td>
				
      <td colspan="2" valign="top" class="Tab3"> <font color="#FF0000">&nbsp; 
        <input name="txt_ths" type="text" id="txt_ths" size="20">
        <strong>Hr </strong>(Don't put minute, if requires then put in hour format, 
        for Ex. 15 min=0.25, 30 minute=0.5, 45 min=0.75, 1Hour and 15 min=1.25) 
        </font></td>
			  </tr>
			  <tr bgcolor="#E6E6E6" class="bottom" > 
				<td colspan="2" align="center" valign="top" class="Tab2">Project Remark</td>
				<td colspan="2" valign="top" class="Tab3"><font color="#FF0000">&nbsp; 
				  <textarea name="txt_remark" cols="80" rows="18" id="txt_remark"></textarea>
				  </font></td>
			  </tr>
			  <input type="hidden" name="h_id" id="h_id" value="<%=h_id%>">
			  <input type="hidden" name="h_ref" id="h_ref" value="<%=refno%>">
			  <input type="hidden" name="h_subid" id="h_subid" value="<%=sub_id%>">
          <tr align="center" bgcolor="#E6E6E6" class="bottom"> 
            <td colspan="4" valign="top"> <input name="Submit" type="submit" class="Tab2" style="WIDTH: 150px;" value="Reply" onClick="return checkLogin();">
        <input name="Submit2" type="button" class="Tab2" value="Cancel" style="WIDTH: 150px;" onClick="window.location = 'project_report.asp?refno=<%=refno%>';"> 
      </td>
          </tr>
		  </table>
	 </form>
	 <p>&nbsp;</p></body>
</html>