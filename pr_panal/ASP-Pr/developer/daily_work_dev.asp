<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("dr_username")="" then
	response.Redirect("admin.asp")
end if

	txt_dateFrom = Request("txt_dateFrom1")
	txt_dateTo = Request("txt_dateTo1")
	txt_dateTo1 = dateadd("d",1,txt_dateTo)
	'response.Write(txt_dateFrom)
	'response.Write(txt_dateTo)	

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
<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</SCRIPT>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
        <img src="images/index_2.jpg" width="385" height="78"><br>
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
                <strong><%=Session("DeveloperName")%></strong></font></div></td>
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
<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
  <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
    <td colspan="14" class="tdrow5" bgcolor="#CCCCCC"><div align="center"><strong>Work&nbsp;Report&nbsp;&nbsp;From::<%=txt_dateFrom%> 
        &nbsp;&nbsp;&nbsp;To::<%=txt_dateTo%></strong></div></td>
  </tr>
  <%
			call OpenConnection
			'refno = request("refno") 
			dim ass_work_per
			ass_work_per = trim(Session("DeveloperName"))
			dim rsDeveloper1
			set rsDeveloper1 = server.CreateObject("adodb.recordset")			
				if rsDeveloper1.state then rsDeveloper1.close
				rsDeveloper1.open "SELECT * from tbl_pr_projDetails where working_per='" & ass_work_per & "' and ddate between '" & txt_dateFrom & "' and '" & txt_dateTo1 & "' order by srno desc",NewConnection
				if rsDeveloper1.eof or rsDeveloper1.bof then
					Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else				
	   %>
  <tr valign="top" bgcolor="#E6E6E6" class="Tab2" > 
    <td><strong>Date</strong></td>
	<td><strong>Project Name</strong></td>
    <td><strong>Assigned by </strong></td>
    <!--td><strong>&nbsp;&nbsp;&nbsp;&nbsp;Assigned&nbsp;&nbsp;Task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> </td-->
    <td><strong>Spent Hours</strong></td>
    <!--td><strong>To be Submmited by</strong></td--> 
    <td><strong>&nbsp;Developers</strong></td>
    <td><strong>&nbsp;&nbsp;&nbsp;Task&nbsp;Done&nbsp;by&nbsp;Developer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
    <!--td><strong>Task Status</strong></td-->
    <!--td class="Tab2"><strong>SrNo.</strong></td-->
    <!--td class="Tab2"><strong>Project&nbsp;Type</strong></td-->
    <!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
    <!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->    
  </tr>
  <%
				do while not rsDeveloper1.eof
						ddate_us = rsDeveloper1("ddate")
						'differ = datediff("d",ddate_us,"03/09/2008")
'						if(differ > 0) then
'							ddate_In = DateAdd("h", 10, ddate_us)  
'							ddate_india = DateAdd("n", 30, ddate_In) 
'						else
'							ddate_In = DateAdd("h", 9, ddate_us)  
'							ddate_india = DateAdd("n", 30, ddate_In) 
'						end if
						ddate_india = ddate_us
					
					if isnull(rsDeveloper1("work_by_mark")) or rsDeveloper1("work_by_mark")="" then						
						
		%>
  <tr valign="top" bgcolor="#E6E6E6" class="tb2" > 
    <!--td class='<%'=class1%>'><font color='<%'=coror1%>'><%'=rsDeveloper1("srno")%></font></td-->
    <td class="Tab3"><%=ddate_india%>&nbsp;</td>
	<% if (isnull(rsDeveloper1("inhouse_id")) or rsDeveloper1("inhouse_id") = "") then %>
	<td class="txt"><%=rsDeveloper1("proj_name")%>&nbsp;</td>
	<% 
		else 
		inhouse_id = rsDeveloper1("inhouse_id")
		Set rsInhouse = server.CreateObject("adodb.recordset")
		rsInhouse.open "SELECT * from tbl_pr_projInhouse where srno='" & inhouse_id &"'",NewConnection								
	%>
	<td class="txt"><%=rsDeveloper1("proj_name")%><br>(<%=rsInhouse("ProjName")%>)&nbsp;</td>
	<% end if %>	
    <td class="Tab3"><%=rsDeveloper1("asignedby")%>&nbsp;</td>
    <!--td class='<%'=class1%>'><%'=rsDeveloper1("type_proj")%>&nbsp;</td-->
    <!--td class='<%'=class1%>'><%'=rsDeveloper1("proj_name")%>&nbsp;</td-->
    <%
					'work_by_mark1 = rsDeveloper1("work_by_mark")
					'work_by_mark1_len = len(work_by_mark1)
				'if(work_by_mark1_len>100) then
					'work_by_mark1_100 = mid(work_by_mark1,1,100)
					'len_work_by_mark1_100 = len(work_by_mark1_100)
			%>
    <!--td class="Tab3"><%'=work_by_mark1_100%>&nbsp;<a href="only_work_by_mark.asp?srno=<%'=rsDeveloper1("srno")%>&proj_id=<%'=rsDeveloper1("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
    <%
				'else
			%>
    <td class="Tab3"><%'=rsDeveloper1("work_by_mark")%>&nbsp;</td-->
    <%
				'end if
			%>
    <!--td class='<%'=class1%>'><%'=rsDeveloper1("work_by_mark")%>&nbsp;</td-->
    <td class="Tab3" align="right"><%=round(rsDeveloper1("hourspend"),2)%>&nbsp;</td>
    <!--td class="Tab3"><%'=rsDeveloper1("ur_date")%>&nbsp;</td-->
    <td class="Tab3"><%=rsDeveloper1("working_per")%>&nbsp;</td>
    <!--td class='<%'=class1%>'><%'=rsDeveloper1("cost")%></td-->
    <%
					work_remark1 = rsDeveloper1("work_remark")
					work_remark1_len = len(work_remark1)
				if(work_remark1_len>100) then
					work_remark1_100 = mid(work_remark1,1,100)
					len_work_remark1_100 = len(work_remark1_100)
			%>
    <td class="Tab3"><%=work_remark1_100%>&nbsp;<a href="only_work_remark.asp?srno=<%=rsDeveloper1("srno")%>&proj_id=<%=rsDeveloper1("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
    <%
				else
			%>
   					   <td class="Tab3"><%=rsDeveloper1("work_remark")%>&nbsp;</td>
    <%
				end if
	
				'if isnull(rsDeveloper1("work_by_mark")) or rsDeveloper1("work_by_mark")="" then
	%>
    					<!--td class="Tab3">&nbsp;</td>
    <%
				'else
					'if isnull(rsDeveloper1("work_status")) or rsDeveloper1("work_status")="" then
	%>
    					<td class="Tab3">&nbsp;</td>
    <%				
					'else
						'if rsDeveloper1("work_status") = 0 then
							'if(trim(rsDeveloper1("working_per")) = trim(Session("DeveloperName"))) then
	%>
         				<td class="Tab3"><font color="#FF0000">Pending</font></td>
    <%
							'else
	%>
    						<td class="Tab3">Pending</td>
    <%					
							'end if				
						'else
	%>
    						<td class="Tab3">Done</td-->
    <%					
						'end if
					'end if
				'end if
	%>			
  </tr>
    <%	
			if(rsDeveloper1("hourspend")="")then
				hourspend = 0
			else
				hourspend = round(rsDeveloper1("hourspend"),2)
				total_hourspend = round((total_hourspend + hourspend),2)
			end if
			else		
			end if
			rsDeveloper1.movenext			
			loop
	%>
	<tr valign="top" bgcolor="#E6E6E6" class="tb2" > 
		<td colspan="3" align="right" class="Tab2">Total&nbsp;</td>
		<td class="Tab3" align="right"><%=round(total_hourspend,2)%>&nbsp;</td>
		<td colspan="2" align="right" class="Tab3">&nbsp;</td>
	</tr>
	<%		
		end if
				 		
	%>
</table>
<br>
<center><input type="button" name="Back" value="Back" class="Tab2" style="WIDTH: 150px;" onClick="history.back()"></center>
<p>&nbsp;</p></body>
</html>
