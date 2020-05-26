<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if(Session("admin")="") then
	 response.Redirect("index.asp")
end if
ErrorMessage = session("ErrorMessage")
%>
<html>
<head>
<title>Admin Panel</title>
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

	if(document.form1.txt_name.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.txt_name.focus();
		return false;
	}
	else if(document.form1.Username.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.Username.focus();
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
	else if(document.form1.Password.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.Password.focus();
		return false;
	}
	
	else if(document.form1.txt_jobprofile.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.txt_jobprofile.focus();
		return false;
	}
	else if(document.form1.txt_PerCost.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.txt_PerCost.focus();
		return false;
	}
	else if (isNaN(document.form1.txt_PerCost.value))
	{
		alert("Please enter valid Amount [0-9]!!");
		document.form1.txt_PerCost.select();
		return false;
	}
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
<%
	call OpenConnection
		Set rsUser = NewConnection.Execute("select max(id) as id from tbl_pr_developerLogin")
		if( isnull(rsUser("id")) or rsUser("id") = "" ) then
			id=1
		else
			id = rsUser("id") + 1			
		end if
		
		if(int(len(id))=1) then
			id = "0" & id
		else
			id = id
		end if
		
		'response.Write(id)
	
%>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- ImageReady Slices (index.psd) -->
<table id="Table_01" width="100%" height="196" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="78" valign="top" background="images/top-bg.jpg"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
              <img src="images/index_01.jpg" width="385" height="78"><br>
            </div></td>
          <td width="52%" valign="bottom"><table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"></div></td>
                <td valign="bottom"> <table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><div align="center"></div></td>
                      <td><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
                        </div></td>
                    </tr>
                  </table></td>
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
                <td width="87%" valign="middle" background="images/tabl-cor_02.jpg"><strong><font color="#006699" size="2" face="Verdana, Arial, Helvetica, sans-serif">Developer 
                  Entry Form</font></strong></td>
                <td width="7%" background="images/tabl-cor_02.jpg"><div align="right"><img src="images/tabl-cor_03.jpg" width="19" height="27"></div></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="21" valign="top" bgcolor="#727272"><table width="100%" border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td height="19" bgcolor="#FFFFFF"><form name="form1" ACTION="create_developer_cal.asp" Method="post" onSubmit="return checkLogin()">

                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="3" style="border-collapse: collapse" >
                      <% if ErrorMessage <> "" then %>
                      <tr> 
                        <td valign="bottom" colspan="2" height=18><center>
                            <%= ErrorMessage %></center></td>
                      </tr>
                      <% end if %>
                      <tr> 
                        <td height="34"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b> 
                          NAME</b></font>:</td>
                        <td height="34"><b><font color="#ffffff"> 
                          <input name="txt_name" size="20" type="text">
                          </font></b></td>
                      </tr>
                      <tr> 
                        <td height="34" width="196"> <p align="left"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>USER 
                            NAME:</b></font></td>
                        <td height="34" width="183"><b><font color="#ffffff"> 
                          <input name="Username" size="20" type="text" value='d<%=id%>' readonly>
                          </font></b></td>
                      </tr>
                      <tr> 
                        <td height="40"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>PASSWORD:</b></font></td>
                        <td height="40"><b><font color="#ffffff">
                          <input type="password" name="Password" size="20" >
                          </font></b></td>
                      </tr>
                      <tr> 
                        <td height="40" width="196"> <div align="left"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Job 
                            Profile:</b></font></div></td>
                        <td height="40" width="183"><b><font color="#ffffff">
							<input name="txt_jobprofile" size="20" >
                          </font></b></td>
					  </tr>
                      <tr> 
						  <td height="40" width="196"> <div align="left"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Developer 
                            Cost:</b></font></div></td>
						<td height="40" width="183"><b><font color="#ffffff">
							<input name="txt_PerCost" size="20" >
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
        <p>&nbsp;</p>
        <p align="center">&nbsp;</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;<STRONG><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site
          Empowered by AKS India Web Solutions </font></STRONG></p>
      </div></td>
  </tr>
</table>

</body>
</html>