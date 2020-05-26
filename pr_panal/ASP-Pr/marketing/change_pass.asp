<!-- #include file="header.inc"-->
<%
	if(Session("pr_username") = "") then
		response.Redirect("admin.asp")
	end if
	'response.Write(Session("pr_username"))
	ErrorMessage = session("ErrorMessage")
%>
<html>
<head>
<title>Marketing Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

	if(document.form1.txt_oldpass.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.txt_oldpass.focus();
		return false;
	}
	else if(document.form1.txt_newpass.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.txt_newpass.focus();
		return false;
	}
	else if(document.form1.txt_newpass.value.length < 6)
	{
		alert("Password Should be greater than six Characters");
		document.form1.txt_newpass.focus();
		return false;
	}
	else if(document.form1.txt_repass.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_repass.focus();
		return false;
	}
	else if(document.form1.txt_repass.value.length < 6)
	{
		alert("Password Should be greater than six Characters");
		document.form1.txt_repass.focus();
		return false;
	}
	else if (document.form1.txt_newpass.value != document.form1.txt_repass.value)
	{
		alert("Passwords do not match.");
		document.form1.txt_repass.focus();
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
	//else if(document.form1.password.value.length < 6)
	//{
	//	alert("Password Should be greater than six Characters");
	//	document.form1.password.focus();
	//	return false;
	//}
	//else if (!isNaN(document.form1.password.value))
	//{
	//	alert("Please Enter Only Alphabets for Password.");
	//	document.form1.password.focus();
	//	return false;}

	else
	{
		return true;
	}
}

</script>

</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- ImageReady Slices (index.psd) -->
<table id="Table_01" width="100%" height="196" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="78" valign="top" background="images/top-bg.jpg"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="39%" height="53"><div align="left"><img src="images/index_03.jpg" width="385" height="78"></div></td>
          <td width="52%" valign="bottom"><table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <td width="217"><div align="center"><font color="#CCFF00" size="2" face="Verdana, Arial, Helvetica, sans-serif">Welcome 
                    <strong><%=Session("MarketingName")%></strong></font></div></td>
                <td width="383" valign="bottom"><div align="right"><font color="yellow" size="3" face="Courier New, Courier, mono"></font>
                  </div></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td> <p>&nbsp;</p>
      <p>&nbsp;</p>
      <table width="38%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <td width="6%" background="images/tabl-cor_02.jpg"><div align="left"><img src="images/tabl-cor_01.jpg" width="16" height="27"></div></td>
                <td width="87%" valign="middle" background="images/tabl-cor_02.jpg"><strong><font color="#006699" size="2" face="Verdana, Arial, Helvetica, sans-serif">Change 
                  Password Form</font></strong></td>
                <td width="7%" background="images/tabl-cor_02.jpg"><div align="right"><img src="images/tabl-cor_03.jpg" width="19" height="27"></div></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="21" valign="top" bgcolor="#727272"><table width="100%" border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td height="19" bgcolor="#FFFFFF"><form name="form1" ACTION="change_pass_cal.asp" Method="post" onSubmit="return checkLogin()">

                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="3" style="border-collapse: collapse" >
                      <% if ErrorMessage <> "" then %>
                      <tr> 
                        <td valign="bottom" colspan="2" height=18><center>
                            <%= ErrorMessage %></center></td>
                      </tr>
                      <% end if %>
                      <tr> 
                        <td height="34"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b> 
                          Old Password</b></font>:</td>
                        <td height="34"><b><font color="#ffffff">
                          <input name="txt_oldpass" size="20" type="text">
                          </font></b></td>
                      </tr>
                      <tr> 
                        <td height="34" width="196"> <p align="left"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b> 
                            New Password:</b></font></td>
                        <td height="34" width="183"><b><font color="#ffffff"> 
                          <input name="txt_newpass" size="20" type="password">
                          </font></b></td>
                      </tr>
                      <tr> 
                        <td height="40" width="196"> <div align="left"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Confirm 
                            Password:</b></font></div></td>
                        <td height="40" width="183"><b><font color="#ffffff"> 
                          <input type="password" name="txt_repass" size="20" >
                          </font></b></td>
                      </tr>
                      <tr> 
                        <td  colspan="2"> <p align="center">&nbsp; 
                            <input name="Submit" type="submit"  value="Submit">
                        </td>
                      </tr>
                    </table>
                   </form></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td valign="middle"><div align="center">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
 <tr><td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--></td></tr>
  <tr>
    <td valign="middle"><div align="center">
        <p>&nbsp;&nbsp;&nbsp;&nbsp;<STRONG><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site
          Empowered by AKS India Web Solutions </font></STRONG></p>
        </div></td>
  </tr>
</table></td>
  </tr>
</table>

</body>
</html>