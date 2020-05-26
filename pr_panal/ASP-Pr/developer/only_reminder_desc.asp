<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("dr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
ddate = now()
srno = request("srno")
%>
<html>
<head>
<title>Developer Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<script language="JavaScript">

function MM_openBrWindow(theURL,winName,features)
{ 
  window.open(theURL,winName,features);
}
</script>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="140" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
            <img src="images/index_03.jpg" width="385" height="78"><br>
          </div></td>
        <td width="69%" colspan="2" valign="bottom" background="images/top-bg.jpg"> 
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
                <td><div align="center"></div></td>
                <td><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
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
		 <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
		  		<tr valign="top" bgcolor="#E6E6E6" class="tb2" >	
					<td class="Tab2" colspan="15" align="left" bgcolor="#CCCCCC">Reminder Description::</td>
				</tr>
		<%	
				call OpenConnection
			dim rsProject
				set rsProject = server.CreateObject("adodb.recordset")
				rsProject.open "SELECT * from tbl_pr_devreminder where srno='" & srno & "'",NewConnection
				if rsProject.eof or rsProject.bof then					
				else
					do while not rsProject.eof
						' define a working variable
						Dim tmpText2
						' populate our working variable
						tmpText2 =  Server.HTMLEncode(rsProject("re_desc"))
						' replace each CR with a line break tag and CR-LF
						tmpText2 = Replace(tmpText2,Chr(13),"<br>" & vbCrLf)
						' replace each TAB character with four non-breaking space tags
						tmpText2 = Replace(tmpText2,Chr(9),"&#xa0;&#xa0;&#xa0;&#xa0;")
						' return the fixed string
						FixForHTML = tmpText2
		%>				
						<tr valign="top" bgcolor="#E6E6E6" class="tb2" >							
        				<td class="Tab3" colspan="15" align="left"><%=FixForHTML%></td>
						</tr>			
		<%				
					rsProject.movenext
					loop
				end if
		%>          
        
		 </table>
		 <br> <br>  
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