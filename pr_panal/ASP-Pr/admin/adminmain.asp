<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<html>
<head>
<title>Admin Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="calender/calendar-win2k-2.css" title="win2k-cold-1" />
<script type="text/javascript" src="calender/calendar.js"></script>
<script type="text/javascript" src="calender/calendar-en.js"></script>
<script type="text/javascript" src="calender/calendar-setup.js"></script>

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_goToURL()
{ //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
function checkLogin()
{
		//sa = new String(document.form1.username.value);
		//getsa=sa.lastIndexOf(' ');

	if(document.form1.Username.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.Username.focus();
		return false;
	}
	else if(document.form1.Password.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.Password.focus();
		return false;
	}
	else
	{
		return true;
	}
}
function checkdate3()
{
	if(document.form4.text_date_from24.value=="")
	{
		alert("select date......");
		document.form4.text_date_from24.focus();
		return false;
	}
	else if(document.form4.text_date_to24.value=="")
	{
		alert("select date......");
		document.form4.text_date_to24.focus();
		return false;
	}
	else
	{
		return true;
	}
}
</script>

</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="80" valign="top" background="images/top-bg.jpg"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left">
              <img src="images/index_01.jpg" width="385" height="78"><br>
            </div></td>
          <td width="52%" valign="bottom"><table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <td><div align="center"></div></td>
                <td valign="bottom"> <table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="246"><div align="center"><font color="#CCFF00" size="2" face="Verdana, Arial, Helvetica, sans-serif">Welcome
                          Admin</font></div></td>
                      <td width="354"><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp;
                        </div></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
 </table>
 <br>
 <table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="middle" class="Tab2" bgcolor="#CCCCCC"><a href="create_developer.asp" target="_blank">Create Developer&nbsp;</a></td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC"><a href="create_marketing.asp" target="_blank">Create Marketing&nbsp;</a></td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC"><a href="admin_msg.asp" target="_blank">Create New Message&nbsp;</a></td>
  </tr>
</table>
<br>
 <table width="100%" border="1" cellpadding="0" cellspacing="0">
 <tr>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">Developers::&nbsp;</td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">User&nbsp;Id::&nbsp;</td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">User&nbsp;Password::&nbsp;</td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">Cost (INR Per Hr)::&nbsp;</td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">Edit::&nbsp;</td>
</tr>
 <%
 	  Session.Timeout=480
	  Server.ScriptTimeout=2400
	  
	  if(trim(request("h_ad"))="") then
	  	Session("admin") = Session("admin")
	  else
	  	Session("admin") = request("h_ad")
	  end if
	  	   
	if(Session("admin")="") then
	 	response.Redirect("index.asp")
	 end if
	 call OpenConnection
	 Set rsDeveloperLogin = NewConnection.Execute("SELECT user_id,user_pass,name,per_cost FROM tbl_pr_developerLogin order by name")

		If rsDeveloperLogin.EOF or rsDeveloperLogin.BOF Then
			ErrorMessage = "<P><font color='red'>Invalid Username or Password</font></P>"
			rsDeveloperLogin.close
			Set rsDeveloperLogin = Nothing
			Set objConn = Nothing
		Else
			do while not rsDeveloperLogin.eof
	%>
			<tr>
				<td valign="middle" class="Tab3"><a href="session_dev.asp?uid=<%=trim(rsDeveloperLogin("user_id"))%>&uname=<%=trim(rsDeveloperLogin("name"))%>" target="_blank"><%=rsDeveloperLogin("name")%>&nbsp;</a></td>
				<td valign="middle" class="Tab3"><%=rsDeveloperLogin("user_id")%>&nbsp;</td>
				<td valign="middle" class="Tab3"><%=rsDeveloperLogin("user_pass")%>&nbsp;</td>
				<td valign="middle" class="Tab3"><%=round(rsDeveloperLogin("per_cost"),2)%>&nbsp;</td>
				<td valign="middle" class="Tab3"><a href="edit_developer.asp?uid=<%=trim(rsDeveloperLogin("user_id"))%>&uname=<%=trim(rsDeveloperLogin("name"))%>">Edit</a>&nbsp;</td>
			</tr>
	<%
			rsDeveloperLogin.movenext
			loop
			rsDeveloperLogin.close

			Set rsDeveloperLogin = Nothing
			call closeconnection
		'Response.redirect "admin.asp"

		End If
				
    %>

 </table>
 <br>
 <table width="100%" border="1" cellpadding="0" cellspacing="0">
 <tr>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">Marketing::&nbsp;</td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">User&nbsp;Id::&nbsp;</td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">User&nbsp;Password::&nbsp;</td>
	<td valign="middle" class="Tab2" bgcolor="#CCCCCC">Edit::&nbsp;</td>
</tr>
 <%
	 call OpenConnection
	 Set rsMarketingLogin = NewConnection.Execute("SELECT user_id,user_pass,name FROM tbl_pr_marketingLogin order by name")

		If rsMarketingLogin.EOF or rsMarketingLogin.BOF Then
			ErrorMessage = "<P><font color='red'>Invalid Username or Password</font></P>"
			rsMarketingLogin.close
			Set rsMarketingLogin = Nothing
			Set objConn = Nothing
		Else
			do while not rsMarketingLogin.eof
%>
			<tr>
				<td valign="middle" class="Tab3"><a href="session_mark.asp?uid=<%=trim(rsMarketingLogin("user_id"))%>&uname=<%=trim(rsMarketingLogin("name"))%>" target="_blank"><%=rsMarketingLogin("name")%>&nbsp;</a></td>
				<td valign="middle" class="Tab3"><%=rsMarketingLogin("user_id")%>&nbsp;</td>
				<td valign="middle" class="Tab3"><%=rsMarketingLogin("user_pass")%>&nbsp;</td>
				<td valign="middle" class="Tab3"><a href="edit_marketing.asp?uid=<%=trim(rsMarketingLogin("user_id"))%>&uname=<%=trim(rsMarketingLogin("name"))%>">Edit</a>&nbsp;</td>
			</tr>
<%
			rsMarketingLogin.movenext
			loop
			rsMarketingLogin.close

			Set rsDeveloperLogin = Nothing
			call closeconnection
		'Response.redirect "admin.asp"

		End If
 %>

 </table>
<br>
<table width="100%" border="1" cellpadding="0" cellspacing="0">
 <tr>
	<td valign="middle" class="Tab2" colspan="3" bgcolor="#CCCCCC"><a href="pending_list.asp" target="_blank">Pending&nbsp;List::&nbsp;</a></td>
</tr>
</table>
<br>
<form name="form4" method="post" action="datewise_pay_received_all.asp" onSubmit="return checkdate3()">
      <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center"><table width="500" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
              <tr>
                <td align="center"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr>
                      <td align="center" bgcolor="#E7C84E"><strong class="Tab2">Received
                        Payment</strong><strong class="Tab3"> </strong></td>
                      <td align="center"><strong class="Tab2">From
					  <% if (text_date_from="") then %>
                        <input name="text_date_from24" id="text_date_from24" type="text" class="Tab2" size="15" readonly>
					<% else %>
						<input name="text_date_from24" id="text_date_from24" type="text" class="Tab2" size="15" value='<%=text_date_from%>' readonly>
					<% end if %>
                        <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("text_date_from24");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"text_date_from24", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                        to
						<% if (text_date_to="") then %>
                        <input name="text_date_to24" id="text_date_to24" type="text" class="Tab2" size="15" readonly>
						<% else %>
						  <input name="text_date_to24" id="text_date_to24" type="text" class="Tab2" size="15" value='<%=text_date_to%>' readonly>
						 <% end if %>
                        <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("text_date_to24");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"text_date_to24", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                        </strong><strong class="Tab3">
                        <input name="Submit3" type="submit" class="Tab2" value="Search">
                        </strong></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
	<br>
 <table width="100%" border="0" cellpadding="0" cellspacing="0">
 <tr><td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--></td></tr>
  <tr>
    <td valign="middle"><div align="center">
        <p>&nbsp;&nbsp;&nbsp;&nbsp;<STRONG><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site
          Empowered by AKS India Web Solutions </font></STRONG></p>
        </div></td>
  </tr>
</table>
</body>
</html>