<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("dr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
ddate = date()
dim refno
refno=request("refno")
dim total_id
total_id=request("total_id")
%>
<html>
<head>
<title>Developer Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
	function MM_goToURL()
	{ //v3.0
	  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
	  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
	}
//-->
</script>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="140" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
            <img src="images/index_2.jpg" width="385" height="78"><br>
          </div></td>
        <td width="73%" colspan="2" valign="bottom" background="images/top-bg.jpg"> 
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
      <tr bgcolor="#006699"> 
        <td colspan="3"> <div align="left"> 
            <table width="1000" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td><div align="center"> 
                    <input name="Login32" type="submit" class="Tab2" style="WIDTH: 150px;" onClick="MM_goToURL('parent','marketing_entry.asp');return document.MM_returnValue" value="Project Entry">
                    <input name="Login322" type="submit" class="Tab2" style="WIDTH: 150px;" onClick="MM_goToURL('parent','project_report_selected.asp');return document.MM_returnValue"   value="Project Status">
                    <input name="Login223" type="submit" class="Tab2" style="WIDTH: 150px;" onClick="MM_goToURL('parent','developer_assign_proj.asp');return document.MM_returnValue"  value="Developer Entry">
                    <input name="Login224" type="submit" class="Tab2" style="WIDTH: 150px;" onClick="MM_goToURL('parent','project_report_all.asp');return document.MM_returnValue"  value="Project Status(all)">
                    <input name="Login225" type="submit" class="Tab2" style="WIDTH: 150px;" onClick="MM_goToURL('parent','contactus_report_us.asp');return document.MM_returnValue"  value="Contactsus Report">
                  </div></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
	 <br>
	 <%
	 	call OpenConnection	
		dim rsDetails
		set rsDetails = server.CreateObject("adodb.recordset")
		rsDetails.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' order by ddate desc",NewConnection
		if rsDetails.eof or rsDetails.bof then
			Response.Write("<strong><font color=red>No Record Found!!</font></strong>")
		else
				proj_name = rsDetails("proj_name")
				proj_id = rsDetails("proj_id")
				asigned_by = rsDetails("asignedby")							
	 %>
	 <form action="market_entry_cal.asp" method="post" name="form1">
	    
        <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
            	<td colspan="14" class="tdrow5"><div align="center"><strong>Project&nbsp;Detail&nbsp;.&nbsp;&nbsp;<%=proj_name%>(<%=total_id%>)&nbsp;&nbsp;Asigned by(<%=asigned_by%>)</strong></div></td>
            </tr>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<!--td class="Tab2"><strong>SrNo.</strong></td-->
				<td class="Tab2"><strong>Date</strong></td>				
          		<!--td class="Tab2"><strong>Asigned&nbsp;by </strong></td-->
				<!--td class="Tab2"><strong>Project&nbsp;Type</strong></td-->
				<!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
				<td class="Tab2"><strong>Project&nbsp;Description</strong></td>
				<td class="Tab2"><strong>Total&nbsp;Hours</strong></td>				
          		<!--td class="Tab2"><strong>Submmited&nbsp;on</strong></td-->
				<td class="Tab2"><strong>working&nbsp;Person</strong></td>								
          		<!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->          		
				<td class="Tab2"><strong>Work&nbsp;Done</strong></td>
				<!--td class="Tab2"><strong>Status</strong></td-->
			</tr>
	<%
			do while not rsDetails.eof
				'if (trim(rsDetails("workstatus"))="Recieved") then
					'coror1="blue"
				'end if
				'if (trim(rsDetails("workstatus"))="Trial Project") then
					'coror1="brown"
				'end if
				'if (trim(rsDetails("workstatus"))="Dead") then
					'coror1="red"
				'end if
				'if (trim(rsDetails("workstatus"))="Completed") then
					'coror1="green"
				'end if
					color1="black"
	%>		
			<tr valign="top" bgcolor="#E6E6E6" class="tb2" > 				
				<!--td class="Tab3"><font color='<%'=coror1%>'></font></td-->
				<td class="Tab3"><%=rsDetails("ddate")%></td>
				<!--td class="Tab3"><%'=rsDetails("asignedby")%></td-->
				<!--td class="Tab3"><%'=rsDetails("type_proj")%></td-->
				<!--td class="Tab3"><%'=rsDetails("proj_name")%></td-->
				<td class="Tab3"><%=rsDetails("work_by_mark")%></td>
				<td class="Tab3"><%=rsDetails("hourspend")%></td>
				<!--td class="Tab3"><%'=rsDetails("duration")%></td-->
				<td class="Tab3"><%=rsDetails("working_per")%></td>				
				<!--td class="Tab3"><%'=rsDetails("cost")%></td-->				
				<td class="Tab3"><%=rsDetails("work_remark")%></td>
				<!--td class="Tab3"><%'=rsDetails("workstatus")%></td-->
			</tr>
		<%
					rsDetails.movenext
				loop
		%>	
		</table>  
		</form>
		<% end if %>      
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
 <tr><td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--></td></tr>
  <tr>
    <td valign="middle"><div align="center">
        <p>&nbsp;&nbsp;&nbsp;&nbsp;<STRONG><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site
          Empowered by AKS India Web Solutions </font></STRONG></p>
        </div></td>
  </tr>
</table>
</table>
<p>&nbsp;</p></body>
</html>