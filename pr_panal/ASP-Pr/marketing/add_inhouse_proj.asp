<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
	Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
		response.Redirect("admin.asp")
	end if
	
		srno = Request("srno")	
		
	dim ddate
	ddate = now()	
%>

<html>
<head>
<title>Developer Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">

<SCRIPT language=JavaScript>

function checkLogin()
{
    if(document.form1.txt_projInhouse.value=="")
	{
		alert("Please Enter Project Name!!");
		//alert(document.form1.Password.value.length);
		document.form1.txt_projInhouse.focus();
		return false;
	}
	else
	{
		 return true;
	}
}

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
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="localdate();">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
        <img src="images/index_03.jpg" width="385" height="78"><br>
      </div></td>
    <td width="68%" colspan="2" valign="bottom" background="images/top-bg.jpg"> 
      <div align="center"> 
        <table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
          <tr> 
            <td><div align="center"></div></td>
            <td valign="bottom"><div align="right"><font color="yellow" size="3" face="Courier New, Courier, mono"></font> 
              </div></td>
          </tr>
        </table>
        <br>
        <br>
        <br>
        <table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
          <tr> 
            <td width="286"><div align="center"><font color="#CCFF00" size="2" face="Verdana, Arial, Helvetica, sans-serif">Welcome 
                <strong><%=Session("MarketingName")%></strong></font></div></td>
            <td width="168"><div align="right">&nbsp; </div></td>
            <td width="314"><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
              </div></td>
          </tr>
        </table>
      </div>
      <div align="right"></div>
      <div align="right"><br>
      </div></td>
  </tr>
</table>
<br>
<table width="50%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
 <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom"> 
 	<td align="center" class="Tab2">SrNo.</td>
	<td align="center" class="Tab2">Date</td>
 	<td align="center" class="Tab2">InHouse Project </td>
</tr>
<%
call OpenConnection
		Set rsInhouse = server.CreateObject("adodb.recordset")
		rsInhouse.open "SELECT * from tbl_pr_projInhouse where projid='" & srno & "' order by convert(int,srNo) desc",NewConnection
		
		if rsInhouse.eof or rsInhouse.bof then
			Response.Write("<font color=red><strong>no record found</strong></font>")
		else
			do while not rsInhouse.eof
				ddate_us = rsInhouse("ddate")
				'ddate_In = DateAdd("h", 10, ddate_us)  
				'ddate_india = DateAdd("n", 30, ddate_In)
				'response.Write(ddate_india)
				ddate_india = ddate_us
%>		
		<tr align="center" valign="top" > 
			<td align="center" class="Tab3"><%=rsInhouse("srno")%></td>
			
    <td align="center" class="Tab3"><%=ddate_india%></td>
    <td align="center" class="Tab3"><%=rsInhouse("ProjName")%></td>
		</tr>
<%
			rsInhouse.movenext
			loop
		end if
%>
</table>	
<br>
<form name="form1" action="add_inhouse_cal.asp" method="post" onSubmit="return checkLogin()">
<br>			
<table width="50%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
 <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom"> 
	  <td align="center" class="Tab2">Add New InHouse Project </td>
      <td >&nbsp; <input type="text" name="txt_projInhouse"></td>
	</tr>	  
				 
		  <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom"> 
            <td colspan="2">
			  <input type="hidden" name="h_id" value='<%=srno%>'><input type="hidden" name="txt_date" id="txt_date">			  
              <input name="Submit" type="submit" value="Submit" class="Tab2" style="WIDTH: 150px;"> 
              <input name="Submit2" type="Reset" class="Tab2" style="WIDTH: 150px;" value="Reset"> 
            </td>
          </tr>	
	</table>	
</form>	
<br>
<center><input type="button" name="Back" value="Back" class="Tab2" style="WIDTH: 150px;" onClick="history.back()"></center>
<p>&nbsp;</p></body>
</html>