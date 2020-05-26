<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
	Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
		response.Redirect("admin.asp")
	end if
	
		srno = Request("srno")
		proj_id = Request("proj_id")
		
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
    if(document.form1.dd_developer.value=="none")
	{
		alert("Please select assign person!!");
		//alert(document.form1.Password.value.length);
		document.form1.dd_developer.focus();
		return false;
	}
	else
	{
		 return true;
	}
}

</SCRIPT>

</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
<form name="form1" action="add_new_dev_cal.asp" method="post" onSubmit="return checkLogin()">
<%
		call OpenConnection
		Set rsProject = server.CreateObject("adodb.recordset")
		rsProject.open "SELECT * from tbl_pr_project where srNo='" & srno &"'",NewConnection
		
		if rsProject.eof or rsProject.bof then
			Response.Write("no record found")
		else
				ddate_us2 = rsProject("ddate")
				'ddate_In2 = DateAdd("h", 9, ddate_us2)  
				'ddate_india2 = DateAdd("n", 30, ddate_In2)
				ddate_india2 = ddate_us2		
%>
<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
            	<td colspan="14" class="tdrow5" bgcolor="#CCCCCC"><div align="center"><strong><%=rsProject("proj_name")%>&nbsp;&nbsp;&nbsp;&nbsp;(<%=rsProject("proj_id")%>) 
          </strong></div></td>
            </tr>
			<tr valign="top" bgcolor="#E6E6E6"> 				
				<td class="Tab2"><strong>Date</strong></td>                
				<td class="Tab2"><strong>Project Type</strong></td>				
				<td class="Tab2"><strong>Delivery date</strong></td>				
        		<td class="Tab2"><strong>Assigned to</strong></td>		
			</tr>
			<tr valign="top" bgcolor="#E6E6E6"> 				
				<td class="Tab3"><%=ddate_india2%></strong></td>                
				<td class="Tab3"><%=rsProject("type_proj")%></td>				
				<td class="Tab3"><%=rsProject("submeted_on")%></td>				
        		<td class="Tab3"><%=rsProject("asigned_per")%></td>		
			</tr>
</table>
<br>			
<table width="50%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
 <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom"> 
	<%
			
				Set rsUser = server.CreateObject("adodb.recordset")
				rsUser.open "SELECT name,user_id from tbl_pr_developerLogin order by name asc",NewConnection
				if rsUser.eof or rsUser.bof then			
					Response.Write("no record found")
				else			
	%>
			
      <td align="center" class="Tab2">Add New Assign Person </td>
            <td >&nbsp; <select name="dd_developer" id="dd_developer">
                       <option value="none" selected>Select Developer</option>
	<%
			do while not rsUser.eof					
	%>	
					<option value='<%=rsUser("name")%>'><%=rsUser("name")%></option>
									
	<%	
					rsUser.movenext
			  loop
			  end if
   %>
		  
				  </select>	
			</td>
	</tr>	  
				 
		  <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom"> 
            <td colspan="2">
			  <input type="hidden" name="h_id" value='<%=srno%>'>
			  <input type="hidden" name="proj_id" value='<%=proj_id%>'>
              <input name="Submit" type="submit" value="Submit" class="Tab2" style="WIDTH: 150px;"> 
              <input name="Submit2" type="Reset" class="Tab2" style="WIDTH: 150px;" value="Reset"> 
            </td>
          </tr>	
	</table>
<%
	end if
%>	
</form>	
<br>
<center><input type="button" name="Back" value="Back" class="Tab2" style="WIDTH: 150px;" onClick="history.back()"></center>
<p>&nbsp;</p></body>
</html>