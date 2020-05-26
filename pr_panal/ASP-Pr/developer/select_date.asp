<!-- #include file="header.inc"-->
<html>
<head>
<title>Developer Panel</title>
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
	if(document.form1.txt_dateFrom.value=="")
	{
		alert("select date......");
		document.form1.txt_dateFrom.focus();
		return false;
	}	
	else if(document.form1.txt_dateTo.value=="")
	{
		alert("select date......");
		document.form1.txt_dateTo.focus();
		return false;
	}
	else
	{
		return true;
	}
}

</script>

</head>

<%
if Session("dr_username")="" then
	response.Redirect("admin.asp")
end if
%>

<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- ImageReady Slices (index.psd) -->
<table id="Table_01" width="100%" height="196" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="78" valign="top" background="images/top-bg.jpg"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
              <img src="images/index_2.jpg" width="385" height="78"><br>
            </div></td>
          <td width="52%" valign="bottom"><table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"></div></td>
                <td valign="bottom"><div align="right"><font color="yellow" size="3" face="Courier New, Courier, mono"></font> 
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
                <td width="87%" valign="middle" background="images/tabl-cor_02.jpg"><strong><font color="#006699" size="2" face="Verdana, Arial, Helvetica, sans-serif">Search 
                  Here</font></strong></td>
                <td width="7%" background="images/tabl-cor_02.jpg"><div align="right"><img src="images/tabl-cor_03.jpg" width="19" height="27"></div></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td height="21" valign="top" bgcolor="#727272"><table width="100%" border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td height="19" bgcolor="#FFFFFF"><form name="form1" ACTION="daily_work.asp" Method="post" onSubmit="return checkLogin()">

                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="3" style="border-collapse: collapse" >
                      <% if ErrorMessage <> "" then %>
                      <tr>
                        <td valign="bottom" colspan="2" height=18><center>
                            <%= ErrorMessage %></center></td>
                      </tr>
                      <% end if %>
                      <tr>
                        <td height="34" width="196"> <p align="left"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Date 
                            From:</b></font></td>
                        <td height="34" width="183"><b><font color="#ffffff">
                          <input name="txt_dateFrom" size="20" type="text" id="txt_dateFrom" readonly>
						  <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("txt_dateFrom");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"txt_dateFrom", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                          </font></b></td>
                      </tr>
                      <tr>
                        <td height="40" width="196"> <div align="left"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Date 
                            To:</b></font></div></td>
                        <td height="40" width="183"><b><font color="#ffffff">
                          <input type="text" name="txt_dateTo" id="txt_dateTo" size="20" readonly>
						  <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("txt_dateTo");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"txt_dateTo", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                          </font></b></td>
                      </tr>
                      <tr>
                        <td  colspan="2"> <p align="center">&nbsp;
                            <input name="Search" type="submit"  value="Search">
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
    <td valign="middle"><table width="100%" border="0" cellpadding="0" cellspacing="0">
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