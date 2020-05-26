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
	m_id = trim(mid(Session("pr_username"),2))
	count2 = request("count2")
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
<script language="JavaScript" type="text/JavaScript">
<!--
	function MM_goToURL()
	{ //v3.0
	  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
	  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
	}
//-->
</script>

<script language="JavaScript">

function checkLogin()
{
		//sa = new String(document.form1.username.value);
		//getsa=sa.lastIndexOf(' ');
	//var regexpression=new RegExp('^([1-9]{1}[0-9]{0,}(\.[0-9]{0,2})?|0(\.[0-9]{0,2})?|\.[0-9]{1,2})$');
	if(document.form1.txt_srno.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.1");
		document.form1.txt_srno.focus();
		return false;
	}
	//else if(getsa>-1)
	//{
	//	alert("Blank space is not allowed in the Username");
		//alert(getsa);
		//alert(document.form1.username.value.length);
	//	document.form1.username.focus();
	//	return false;
	//}
	//else if(document.form1.username.value.length < 6)
	//{
	//	alert("UserName Should be greater than six Characters");
	//	document.form1.username.focus();
	//	return false;
	//}
	else if(document.form1.txt_date.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.2");
		//alert(document.form1.Password.value.length);
		document.form1.txt_date.focus();
		return false;
	}
	else if(document.form1.txt_uid.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.3");
		document.form1.txt_uid.focus();
		return false;
	}
	else if(document.form1.txt_clientname.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.3");
		document.form1.txt_clientname.focus();
		return false;
	}	
	else if(document.form1.txt_referance.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.3");
		document.form1.txt_referance.focus();
		return false;
	}	
	else if(document.form1.dd_type.value=="none")
	{
		alert("Please select type of project!!");
		//alert(document.form1.Password.value.length);
		document.form1.dd_type.focus();
		return false;
	}
	else if(document.form1.txt_proj.value=="")
	{
		alert("Please enter project name!!");
		//alert(document.form1.Password.value.length);
		document.form1.txt_proj.focus();
		return false;
	}	
	else if(document.form1.txt_desc.value=="")
	{
		alert("Please enter project description!!");
		//alert(document.form1.Password.value.length);
		document.form1.txt_desc.focus();
		return false;
	}
	else if (document.form1.txt_hour.value=="")
	{
	 alert("Please enter total hour in digit!!");
	 document.form1.txt_hour.focus();
	 return false;
	 }
	 else if (isNaN(document.form1.txt_hour.value))
	{
		alert("Please Enter Only Digits between 1 to 9.");
		document.form1.txt_hour.select();
		return false;
	}
	//else if(document.form1.txt_hour.value.indexOf(".")>0)
	//{
		//alert("Please Enter Only integer value.");
		//document.form1.txt_hour.select();
		//return false;
	//}
	else if(document.form1.txt_submitedon.value=="")
	{
		alert("Please select submition date!!");
		//alert(document.form1.Password.value.length);
		document.form1.txt_submitedon.select();
		return false;
	}
	else if(document.form1.dd_developer.value=="none")
	{
		alert("Please select assign person!!");
		//alert(document.form1.Password.value.length);
		document.form1.dd_developer.focus();
		return false;
	}
	
//	if(!isNumber(sell_books.price.value)) 
  else if(document.form1.txt_cost.value=="")
	{
		alert("Please enter valid Amount [0-9]!!");
		document.form1.txt_cost.focus();
		return false;
	}
	 else if (isNaN(document.form1.txt_cost.value))
	{
		alert("Please enter valid Amount [0-9]!!");
		document.form1.txt_cost.select();
		return false;
	}
	else if(document.form1.txt_cost.value.indexOf(".")>0)
	{
		alert("Please enter valid Amount [0-9]!!");
		document.form1.txt_cost.select();
		return false;
	}	
	else if(document.form1.dd_status.value=="none")
	{
		alert("Please enter status of project.");
		//alert(document.form1.Password.value.length);
		document.form1.dd_status.focus();
		return false;
	}
	
	//else if (!isNaN(document.form1.password.value))
	//{
	//	alert("Please Enter Only Alphabets for Password.");
	//	document.form1.password.focus();
	//	return false;}

	else
	{
		 var SetForm=document.form1;		 
		 remark = new String(SetForm.txt_desc.value);		 
		 remark= remark.replace(/'/g,"''");		 
		 SetForm.txt_desc.value=remark;
		 return true;
	}
}
</script>

</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="localdate();">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="140" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
                  <td width="246"><div align="center"><font color="#CCFF00" size="2" face="Verdana, Arial, Helvetica, sans-serif">Welcome 
                      <strong><%=Session("MarketingName")%></strong></font></div></td>
                  <td width="354"><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
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
	 <%
	 	call OpenConnection
		dim rsProject
		set rsProject = server.CreateObject("adodb.recordset")
		Set rsProject = NewConnection.Execute("SELECT max(srno) as maxid FROM tbl_pr_project")
		if isnull(rsProject("maxid")) then
			srno = 1
		else
			srno = rsProject("maxid")+1
		end if
			p_id = trim(m_id) & "-" & trim(count2+1) & "-" & trim(srno)
			'response.Write(p_id)
	 %>
	 <form action="market_entry_cal.asp" method="post" name="form1" onSubmit="return checkLogin()">
	    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
          <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
            <td colspan="4" class="Tab2" bgcolor="#CCCCCC"><div align="center"><strong>Project 
                Detail Form For Marketing Dept. </strong></div></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">&nbsp;</td>
            <td width="37%" colspan="1" align="right"><font color="#FF0000">&nbsp;<a href="project_report_selected.asp">View 
              Report</a></font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">SrNo</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_srno" type="text" id="txt_srno" size="30" value="P-<%=srno%>" readonly>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Date</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_date" type="text" id="txt_date" size="30" readonly>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Marketing Id </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_uid" type="text" id="txt_uid" size="30" value='<%=session("MarketingName")%>' readonly>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Client&nbsp;Name</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_clientname" type="text" id="txt_clientname" size="45" >
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Referance </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_referance" type="text" id="txt_referance" size="45" >
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Client&nbsp;Mobile&nbsp;No.</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_clientmobile" type="text" id="txt_clientmobile" size="45" >
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Client&nbsp;Email</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_clientemail" type="text" id="txt_clientemail" size="45" >
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Client&nbsp;Company</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_clientcompany" type="text" id="txt_clientcompany" size="45" >
              </font></td>
          </tr>
		  <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Client&nbsp;Address</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_clientadd" type="text" id="txt_clientadd" size="45" >
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Type</td>
            <% if(Trim(Session("pr_username"))="m01") then %>
			<td colspan="2">&nbsp; <select name="dd_type" id="dd_type">
                <option value="none" selected>Select Type</option>
                <option value="ERP">ERP</option> 
				<option value="SEO">SEO</option>
				<option value="WEB">WEB</option>				             
				<option value="InHouse">InHouse</option>
              </select></td>
			<% else %>
			<td width="17%" colspan="2">&nbsp; <select name="dd_type" id="dd_type">
                <option value="none" selected>Select Type</option>
                <option value="ERP">ERP</option> 
				<option value="SEO">SEO</option>
				<option value="WEB">WEB</option>
            </select></td>
			<% end if %> 
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Name </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_proj" type="text" id="txt_proj" size="45" maxlength="45">
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Description </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <textarea name="txt_desc" cols="70" rows="12" id="textarea"></textarea>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Total Hours </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_hour" type="text" id="txt_hour" size="20">
              Hr </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Must be Submmited on </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_submitedon" type="text" id="txt_submitedon" size="20" readonly>
              </font> </td>
            <script type="text/javascript">
				function catcalc(cal)
				{
					var date = cal.date;
					var time = date.getTime()
					var field = document.getElementById("txt_submitedon");
					var date2 = new Date(time);
					field.value = date2.print("%m/%d/%Y");
				}
				Calendar.setup({inputField:"txt_submitedon", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
			</script>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Assign Person </td>
            <td colspan="2">&nbsp; <select name="dd_developer" id="dd_developer" multiple size="3">
                <!--select name="dd_developer" id="dd_developer" multiple size="3"-->
                <option value="none" selected>Select Developer</option>
                <% 
				Set rsUser = server.CreateObject("adodb.recordset")
				rsUser.open "SELECT name,user_id from tbl_pr_developerLogin order by name asc",NewConnection
				if rsUser.eof or rsUser.bof then
					name = ""
				else
					do while not rsUser.eof
						name = rsUser("name")	
			%>
                <option value="<%=trim(name)%>"><%=trim(name)%></option>
                <%
					 	rsUser.movenext
					loop
				end if
			%>
              </select> <font color="#FF0000">&nbsp;</font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Cost Of Project </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_cost" type="text" id="txt_cost" size="20">
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Status</td>
            <td colspan="2">&nbsp; <select name="dd_status" id="dd_status">
                <option value="none">Select Status</option>
                <option value="Trial Project">Trial Project</option>
                <option value="Received">Received</option>
              </select></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">&nbsp;</td>
            <td colspan="2"> <font color="#FF0000">&nbsp;</font></td>
          </tr>
          <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom"> 
            <td colspan="4"><input type="hidden" name="h_id" value='<%=p_id%>'>
              <input name="Submit" type="submit" class="Tab2" style="WIDTH: 150px;" value="Submit" onClick="return checkLogin();"> 
              <input name="Submit2" type="Reset" class="Tab2" style="WIDTH: 150px;" value="Reset"> 
            </td>
          </tr>
        </table>
     </form>
     </td>
  </tr>
</table>
<p>&nbsp;</p>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
 <tr><td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--></td></tr>
  <tr>
    <td valign="middle"><div align="center">
        <p>&nbsp;&nbsp;&nbsp;&nbsp;<STRONG><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site
          Empowered by AKS India Web Solutions </font></STRONG></p>
        </div></td>
  </tr>
</table></div></table>
<p>&nbsp;</p></body>
</html>