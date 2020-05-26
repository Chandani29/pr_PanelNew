<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if

dim ddate
ddate = now()
%>
<html>
<head>
<title>Marketing Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" media="all" href="calender/calendar-win2k-2.css" title="win2k-cold-1" />
<script type="text/javascript" src="calender/calendar.js"></script>
<script type="text/javascript" src="calender/calendar-en.js"></script>
<script type="text/javascript" src="calender/calendar-setup.js"></script>
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
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
            <td width="274"><div align="center"><font color="#CCFF00" size="2" face="Verdana, Arial, Helvetica, sans-serif">Welcome 
                <strong><%=Session("MarketingName")%></strong></font></div></td>
            <td width="326"><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
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
<%
call OpenConnection
refno = request("srno")
'response.Write(refno)
dim  rst_details
dim rst_subname
	set rst_subname = server.CreateObject("adodb.recordset")
	if rst_subname.state then rst_subname.close
		if rst_subname.state then rst_subname.close
		sql_sub = "SELECT * from tbl_pr_projInhouse where srno='" & refno & "'"
		set rst_subname= NewConnection.execute(sql_sub)
		if rst_subname.bof or rst_subname.eof then
			sub_proj = ""
		else
			sub_proj = trim(rst_subname("projname"))
		end if			
	
	set rst_details = server.CreateObject("adodb.recordset")
	if rst_details.state then rst_details.close
		sql_details = "SELECT * from tbl_pr_projDetails where inhouse_id='"& refno & "' and (work_by_mark is null or work_by_mark ='') and del_status='0' order by working_per"
		set rst_details= NewConnection.execute(sql_details)
		if rst_details.bof or rst_details.eof then
		response.Write("<center><font color=red>No Record Found</font></center>")
		else		
%>
		<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#CCCCCC" class="bottom" > 
				<td colspan="4" align="center" class="Tab2" bgcolor="#CCCCCC"><font color="#0000FF"><%=sub_proj%></font>&nbsp;&nbsp;Details.....</td>				
			</tr>
			<tr valign="top" bgcolor="#CCCCCC" class="bottom">          		
				<td class="Tab2">&nbsp;Developer&nbsp;Name</td>							
				<td class="Tab2">&nbsp;Total&nbsp;Hour&nbsp;Spent</td>							
				<td class="Tab2">Cost&nbsp;</td>
				<td class="Tab2">Task&nbsp;Done&nbsp;</td>				
			</tr>
				<%
				do while not rst_details.eof
				
					if isnull(rst_details("hourspend")) or rst_details("hourspend")="" then
						hourspend_inhouse = 0
					else
						hourspend_inhouse = rst_details("hourspend")
					end if
					if isnull(rst_details("dev_cost")) or rst_details("dev_cost")="" then
						dev_cost_inhouse = 0
					else
						dev_cost_inhouse = rst_details("dev_cost")
					end if
					all_hourspend_inhouse = all_hourspend_inhouse + hourspend_inhouse
					all_dev_cost_inhouse = all_dev_cost_inhouse + dev_cost_inhouse					
					%>			
					<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
					<%
						if(trim(working_per) = trim(rst_details("working_per"))) then 					
					%>				
						<td class="Tab3">&nbsp;</td>
					<% 
						else 
						working_per = rst_details("working_per")
					%>
						<td class="Tab2"><%=rst_details("working_per")%>&nbsp;</td>
					<% end if %>	
						<td class="Tab3">&nbsp;<%=hourspend_inhouse%></td>
						<td class="Tab3">&nbsp;<%=dev_cost_inhouse%></td>
					<%	
						proj_Remark = rst_details("work_remark")
						Remark_len = len(proj_Remark)
						if (Remark_len>50) then
							Remark_100 = mid(proj_Remark,1,50)
							Remarklen_100 = len(Remark_100)
					%>	
					  <td class="Tab3"><%=Remark_100%>&nbsp;<a href="only_work_done.asp?srno=<%=rst_details("srno")%>" target="_blank">more...</a>&nbsp;</td>
					<%
						else
					%>
						<td class="Tab3"><%=rst_details("work_remark")%>&nbsp;</td>	  
					<%
						end if
					%>   				
					</tr>
<%
					rst_details.movenext
				loop
%>		
			<tr valign="top" bgcolor="#CCCCCC" class="bottom" > 				
				<td class="Tab2" align="right">&nbsp;Total</td>
				<td class="Tab2">&nbsp;<%=all_hourspend_inhouse%></td>
				<td class="Tab2">&nbsp;<%=all_dev_cost_inhouse%></td>
				<td class="Tab2">&nbsp;</td>				
			</tr>
			</table>

<%		
		end if

%>
<br><br><br><br>
<p>&nbsp;</p>
<table align="center">
<tr>
<td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--><p align="center">&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site Empowered by AKS India Web Solutions </font></strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">.</font></p>
  </td>
</tr>
  </table>
 <% call closeconnection %>
<p>&nbsp;</p>
</body>
</html>