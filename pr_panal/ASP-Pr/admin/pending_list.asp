<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if(Session("admin")="") then
	 response.Redirect("index.asp")
end if

dim ddate
ddate = now()
	'dv_name = request("dv_name")
%>
<html>
<head>
<title>Admin Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="refresh" content="60">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="78" valign="top"> 
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
              <img src="images/index_01.jpg" width="385" height="78"><br>
            </div></td>
          <td width="62%" colspan="2" valign="bottom" background="images/top-bg.jpg"> 
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
                  <td width="261"><div align="center"><font color="#CCFF00" size="2" face="Verdana, Arial, Helvetica, sans-serif">Welcome 
                      Admin </font></div></td>
                  <td width="339"><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
                    </div></td>
                </tr>
              </table>
            </div>
            <div align="right"></div>
            <div align="right"></div></td>
        </tr>
      </table>
	  </td>
	  </tr>
	  </table>
	 <br>
	 <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
	 <tr valign="top" bgcolor="#999999" class="bottom" > 
				<!--td class="Tab2"><strong>SrNo.</strong></td-->
				
				<td class="Tab2"><strong>Project&nbsp;Id</strong></td>
				<td class="Tab2"><strong>Project Name</strong></td>
				<td class="Tab2"><strong>Date</strong></td>				
          		<td class="Tab2"><strong>Assigned by </strong></td>				
				<!--td class="Tab2"><strong>Total&nbsp;Hour</strong></td-->
				<td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Assigned&nbsp;&nbsp;Task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td-->
				<td class="Tab2"><strong>Assigned Hours</strong></td>				
          		<td class="Tab2"><strong>To be Submmited &nbsp;by</strong></td-->
				<!--td class="Tab2"><strong>&nbsp;Developers</strong></td-->								
          		<!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->          		
				<!--td class="Tab2"><strong>Task&nbsp;Done&nbsp;by&nbsp;Developer</strong></td-->
				<td class="Tab2"><strong>Work&nbsp;Status</strong></td>				
	 </tr>
	<%
	 		call OpenConnection
	 		dim rsDeveloperList
				set rsDeveloperList = server.CreateObject("adodb.recordset")
				rsDeveloperList.open "SELECT * from tbl_pr_developerLogin order by name asc",NewConnection
				if rsDeveloperList.eof or rsDeveloperList.bof then					
				else
					do while not rsDeveloperList.eof
						dv_name = rsDeveloperList("name")
	%>
	 
		
	<%	
				
				dim rsDevelopers
				set rsDevelopers = server.CreateObject("adodb.recordset")
				rsDevelopers.open "SELECT * from tbl_pr_projDetails where working_per='" & dv_name & "' and work_status='0' and (work_by_mark <> '' or work_by_mark is not null) order by convert(int,proj_id) desc,ddate desc",NewConnection
				if rsDevelopers.eof or rsDevelopers.bof then
					
				else
				
	%>
					<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
						 <!--table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
						 <tr valign="top" bgcolor="#E6E6E6" class="bottom" --> 				
							<td class="Tab2" colspan="8" bgcolor="#CCCCCC"><strong>Pending&nbsp;task&nbsp;of&nbsp;<font color="blue"><%=dv_name%></font>::</strong></td>
						 </tr>
	<%			
								
					do while not rsDevelopers.eof
						ddate_us = rsDevelopers("ddate")
						'differ = datediff("d",ddate_us,"03/09/2008")
'						if(differ > 0) then
'							ddate_In = DateAdd("h", 10, ddate_us)  
'							ddate_india = DateAdd("n", 30, ddate_In) 
'						else
'							ddate_In = DateAdd("h", 9, ddate_us)  
'							ddate_india = DateAdd("n", 30, ddate_In) 
'						end if
						ddate_india = ddate_us
							if isnull(rsDevelopers("work_by_mark")) or rsDevelopers("work_by_mark") = "" then
							else
								dim rsProjectss
								set rsProjectss = server.CreateObject("adodb.recordset")
								rsProjectss.open "SELECT * from tbl_pr_project where srNo='" & rsDevelopers("proj_id") & "'",NewConnection
								if rsProjectss.eof or rsProjectss.bof then
								else
								
									proj_id = rsProjectss("proj_id")
									ddate = rsProjectss("ddate")
									total_hour = rsProjectss("total_hour")
								end if
	%>				
					
						<tr valign="top" bgcolor="#E6E6E6" class="tb2" >	
							<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
							<!--td class="Tab2"><strong>SrNo.</strong></td-->
							
							<td class="Tab3"><%=proj_id%>&nbsp;</td>
							<% if (isnull(rsDevelopers("inhouse_id")) or rsDevelopers("inhouse_id") = "") then %>
							<td class="txt"><%=rsDevelopers("proj_name")%>&nbsp;</td>
							<% 
								else 
								inhouse_id = rsDevelopers("inhouse_id")
								Set rsInhouse = server.CreateObject("adodb.recordset")
								rsInhouse.open "SELECT * from tbl_pr_projInhouse where srno='" & inhouse_id &"'",NewConnection								
							%>
							<td class="txt"><%=rsDevelopers("proj_name")%><br>(<%=rsInhouse("ProjName")%>)&nbsp;</td>
							<% end if %>							
							<td class="Tab3"><%=ddate_india%>&nbsp;</td>				
							<td class="Tab3"><%=rsDevelopers("asignedby")%>&nbsp;</td>
							<!--td class="Tab2"><strong>Project&nbsp;Type</strong></td-->
							<!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
							<!--td class="Tab3"><%'=total_hour%>&nbsp;</td-->
							
			<%
					work_by_mark = rsDevelopers("work_by_mark")
					work_by_mark_len = len(work_by_mark)
				if(work_by_mark_len>100) then
					work_by_mark_100 = mid(work_by_mark,1,100)
					len_work_by_mark_100 = len(work_by_mark_100)
			%>	
							<td class="Tab3"><%=Server.HTMLEncode(work_by_mark_100)%>&nbsp;<a href="only_work_by_mark.asp?srno=<%=rsDevelopers("srno")%>&proj_id=<%=rsDevelopers("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
			<% else %>
							<td class="Tab3"><%=rsDevelopers("work_by_mark")%>&nbsp;</td>
			<% end if %>	
							<td class="Tab3"><%=rsDevelopers("hourspend")%>&nbsp;</td>				
							<td class="Tab2"><strong><%=rsDevelopers("ur_date")%>&nbsp;</strong></td-->
							<!--td class="Tab3"><%'=rsDevelopers("working_per")%>&nbsp;</td-->								
							<!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->          		
							<!--td class="Tab3"><%'=rsDevelopers("work_remark")%>&nbsp;</td-->											
							<td class="Tab3"><font color="#FF0000"><strong>Pending</strong></font>&nbsp;</td>							
						</tr>									
		<%				
							end if		
					rsDevelopers.movenext
					loop
				end if
		%>    
		<!--/table-->
	<%
			rsDeveloperList.movenext
			loop
		end if	
	%>
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
</table>
</body>
</html>