<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<html>
<head>
<title>Marketing Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
</script>
</head>
<%
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if
dim srno
srno = request("srno")
%>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
            <img src="images/index_03.jpg" width="385" height="78"><br>
          </div></td>
        <td width="74%" colspan="2" valign="bottom" background="images/top-bg.jpg"> 
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
                <td width="263"><div align="center"><font color="#CCFF00" size="2" face="Verdana, Arial, Helvetica, sans-serif">Welcome 
                    <strong><%=Session("MarketingName")%></strong></font></div></td>
                <td width="168"><div align="right">&nbsp;<span class="red"><strong><a href="change_pass.asp" target="_blank"><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif">Change 
                    Password</font></a></strong></span>&nbsp; </div></td>
                <td width="168"><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
                  </div></td>
              </tr>
            </table>
          </div>
          <div align="right"></div>
          <div align="right"><br>
          </div></td>
      </tr>
    </table>
	
<table width="400" border="1" cellspacing="2" cellpadding="1">
  <%
	  	call OpenConnection	
	  	
		set rsProject = server.CreateObject("adodb.recordset")
		strsql = "select * from tbl_pr_project where srNo='"& srno & "'"
		rsProject.open strsql,NewConnection
		p_id = rsProject("proj_id")
		p_name = rsProject("proj_name")		
		
	  	  	
		set rspartial = server.CreateObject("adodb.recordset")
		strsql1 = "select * from tbl_pr_expenses where proj_id='"& srno & "' order by convert(int,srno) desc"
		rspartial.open strsql1,NewConnection
		if rspartial.eof or rspartial.bof then
		Response.Write("<tr align='center'><td><strong><font color='red'>No Record Found!!</font></strong></td></tr>")
		else
			ddate_us2 = rspartial("ddate")
			'differ = datediff("d",ddate_us2,"03/09/2008")
'			if(differ > 0) then
'				ddate_In2 = DateAdd("h", 9, ddate_us2)  
'				ddate_india2 = DateAdd("n", 30, ddate_In2)
'			else
'				ddate_In2 = DateAdd("h", 9, ddate_us2) 
'				ddate_india2 = DateAdd("n", 30, ddate_In2)			
'			end if
			ddate_india2 = ddate_us2
			
%>
  <tr align="center"> 
    <td colspan="3" class="txt"><p class="Tab2"><strong>[<%= p_id %>]&nbsp;&nbsp;<%= p_name %></strong></p>
      <p> Summary of Expenses</p></td>
  </tr>
  <tr> 
    <td align="center" class="Tab3"><strong>Date</strong></td>
    <td align="center" class="Tab3"><strong>Expense Ammount INR</strong></td>
    <td align="center" class="Tab3"><strong>Expense Name</strong></td>
  </tr>
  <%		
		do while not rspartial.eof
		
%>
  <tr> 
    <td align="left" class="Tab3"><%=ddate_india2%></td>
    <td align="left" class="Tab3"><%= rspartial("proj_exp_cost")%></td>
    <td align="left" class="Tab3"><%=rspartial("exp_name")%></td>
  </tr>
  <%
	rspartial.movenext
	loop
	end if
	call CloseConnection
%>
</table>
  <input name="Submit2" type="button" class="Tab2" value="Back" onClick="history.back();">
  </body>
  </html>