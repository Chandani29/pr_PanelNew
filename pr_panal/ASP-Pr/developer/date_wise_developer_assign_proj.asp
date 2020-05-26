<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
	Session.Timeout=480
Server.ScriptTimeout=2400
if Session("dr_username")="" then
		response.Redirect("admin.asp")
	end if
	session("ErrorMessage") = ""
	
proj_status_type = request("select_type")

text_date_from = request("text_date_from")
txt_date_From1 = dateadd("d",-1,text_date_from)
txt_date_From1 = txt_date_From1 & " " & "13:30:00.000"

text_date_to = request("text_date_to")
txt_date_To1 = dateadd("d",0,text_date_to)
txt_date_To1 = txt_date_To1 & " " & "13:30:00.000"

text_type = request("text_type")
select2_type = request("select2_type")
%>
<html>
<head>
<title>Developer Panel</title>
<title>Developer Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="calender/calendar-win2k-2.css" title="win2k-cold-1" />
<script type="text/javascript" src="calender/calendar.js"></script>
<script type="text/javascript" src="calender/calendar-en.js"></script>
<script type="text/javascript" src="calender/calendar-setup.js"></script>

<script language="JavaScript">
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
function checkLogin1()
{
	if(document.form11.txt_dateFrom1.value=="")
	{
		alert("select date......");
		document.form11.txt_dateFrom1.focus();
		return false;
	}	
	else if(document.form11.txt_dateTo1.value=="")
	{
		alert("select date......");
		document.form11.txt_dateTo1.focus();
		return false;
	}
	else
	{
		return true;
	}
}
function checkdate1()
{
	if(document.form2.select_type.value=="none")
	{
		alert("select project status......");
		document.form2.select_type.focus();
		return false;
	}
	else if(document.form2.text_date_from.value=="")
	{
		alert("select date......");
		document.form2.text_date_from.focus();
		return false;
	}	
	else if(document.form2.text_date_to.value=="")
	{
		alert("select date......");
		document.form2.text_date_to.focus();
		return false;
	}
	else
	{
		return true;
	}
}
function checkdate2()
{
	if(document.form3.select2_type.value=="none")
	{
		alert("select project type......");
		document.form3.select2_type.focus();
		return false;
	}
	else if(document.form3.text_type.value=="")
	{
		alert("Plese enter project ID or Name");
		document.form3.text_type.focus();
		return false;
	}	
	else
	{
		return true;
	}
}
</script>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="87" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
                  <td width="168"><div align="right">&nbsp;<span class="red"><strong><a href="change_pass.asp" target="_blank"><font color="#FFFFFF" size="1" face="Verdana, Arial, Helvetica, sans-serif">Change 
                      Password</font></a></strong></span>&nbsp; </div></td>
                  <td width="314"><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
                    </div></td>
                </tr>
              </table>
            </div></div>
          </td>
        </tr>
      </table></td></tr>
	  </table>
	  <table width="1000" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td width="571" align="center"><form name="form2" method="post" action="date_wise_developer_assign_proj.asp" onSubmit="return checkdate1()">
            <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
              <tr> 
                <td align="center"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td align="center">&nbsp; <select name="select_type" class="Tab2" >
					  <% if(proj_status_type="") then %>					  	  
					  	  <option value="Received">Received</option>
                          <option value="Completed">Completed</option>
                          <option value="Trial Project">Trial Project</option>
                          <option value="Dead">Dead</option>
                          <option value="All">All</option>
                          <option value="none" selected>Select Project Status</option>
					  <% else %>
					  	  <option value='<%=proj_status_type%>' selected><%=proj_status_type%></option> 
                          <option value="Received">Received</option>
                          <option value="Completed">Completed</option>
                          <option value="Trial Project">Trial Project</option>
                          <option value="Dead">Dead</option>
                          <option value="All">All</option>
                          <option value="none">Select Project Status</option>
					  <% end if %>	  
                        </select> <strong class="Tab2">From 
						<% if (text_date_from="") then %>
                        <input name="text_date_from" id="text_date_from" type="text" class="Tab2" size="15" readonly>
						<% else %>
						<input name="text_date_from" id="text_date_from" type="text" class="Tab2" size="15" readonly value='<%=text_date_from%>'>
						<% end if %>
                        <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("text_date_from");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"text_date_from", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                        to 
						<% if (text_date_to="") then %>
                        <input name="text_date_to" id="text_date_to" type="text" class="Tab2" size="15" readonly>
						<% else %>
						<input name="text_date_to" id="text_date_to" type="text" class="Tab2" size="15" readonly value='<%=text_date_to%>'>
						<% end if %>
                        <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("text_date_to");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"text_date_to", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                        </strong><strong class="Tab3"> 
                        <input name="Submit" type="submit" class="Tab2" value="Search">
                        </strong></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
          </form></td>
        <td width="409"><form name="form3" method="post" action="date_wise_developer_assign_proj.asp" onSubmit="return checkdate2()">
            <table width="100%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#CCCC00">
              <tr> 
                <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td><strong class="Tab2">Search By </strong> <select name="select2_type" class="Tab2">
                          <% if (select2_type="") then %>
						  <option value="Project Name">Project Name</option>
						  <option value="Project ID" selected>Project ID</option> 
						  <% else %>    
						  <option value='<%=select2_type%>' selected><%=select2_type%></option> 
						  <option value="Project Name">Project Name</option>
						  <option value="Project ID">Project ID</option> 
						  <% end if %>                     
                        </select>
						 <% if (text_type="") then %>
						 <input name="text_type" type="text" class="Tab2" size="20"> 
						 <% else %>   
						 <input name="text_type" type="text" class="Tab2" size="20" value='<%=text_type%>'>  
						 <% end if %>             
                        <input name="Submit2" type="submit" class="Tab2" value="Search"> 
                      </td>
                    </tr>
                  </table></td>
              </tr>
            </table>            
          </form></td>
      </tr>
    </table>
	<a href="developer_assign_proj.asp" class="Tab2"><font color="#0000FF"><u>Main Page</u></font></a>	 
	 <%
	 	call OpenConnection
		'response.Write(Session("DeveloperName"))
		dim rsInProject
		set rsInProject = server.CreateObject("adodb.recordset")
		'rsInProject.open "SELECT * FROM tbl_pr_project where asigned_per like '%" & trim(Session("DeveloperName")) & "%' and type_proj='InHouse' order by srno desc",NewConnection
		if(text_date_from = "" or text_date_to = "") then
		else
			if(proj_status_type="Received" or proj_status_type="Trial Project") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj='InHouse' and ddate between'" & txt_date_From1 &"' and '" & txt_date_To1 & "' and workstatus='" & proj_status_type &"' order by srNo desc"
			end if
			if(proj_status_type="Dead" or proj_status_type="Completed") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj='InHouse' and completed_on between'" & txt_date_From1 &"' and '" & txt_date_To1 & "' and workstatus='" & proj_status_type &"' order by srNo desc"
			end if
			if(proj_status_type="All") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj='InHouse' and ddate between'" & txt_date_From1 &"' and '" & txt_date_To1 & "' order by srNo desc"
			end if
		end if
		if(text_type="") then
		else
			if(select2_type="Project Name") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj='InHouse' and proj_name like '" & text_type &"%'"
			end if
			if(select2_type="Project ID") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj='InHouse' and proj_id ='" & text_type &"'"
			end if
		end if
		rsInProject.open mainsql,NewConnection		
		if rsInProject.eof or rsInProject.bof then			
		else
	%>		
	<table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
          <td colspan="13" class="Tab2" bgcolor="#CCCCCC"><div align="center"><strong>InHouse 
              Project Only</strong></div></td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
	      <td class="Tab2"><strong>Project Id</strong></td>
		  <td class="Tab2" align="center">&nbsp;Project&nbsp;Name</td>
          <td class="Tab2"><strong>Date</strong></td>
          <td class="Tab2"><strong>Assigned by </strong></td>
          <td class="Tab2"><strong>Project Type</strong></td>
          <!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
          <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;&nbsp;Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
          <td class="Tab2"><strong>Total Hours</strong></td>
          <td class="Tab2"><strong>Hours Spent</strong></td>
          <td><strong class="Tab2"> Balance Hours</strong></td>
          <td class="Tab2"><strong>Delivery date</strong></td>
          <td class="Tab2"><strong>Assigned to</strong></td>
          <!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->
          <td class="Tab2"><strong>Client&nbsp;&nbsp;Remarks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
          <td class="Tab2"><strong>Project Status</strong></td>
          
        </tr>
	<%					
		do while not rsInProject.eof 
						ddate_us2 = rsInProject("ddate")
						'differ = datediff("d",ddate_us2,"03/09/2008")
'						if(differ > 0) then
'							ddate_In2 = DateAdd("h", 9, ddate_us2)  
'							ddate_india2 = DateAdd("n", 30, ddate_In2)
'						else
'							ddate_In2 = DateAdd("h", 9, ddate_us2)    
'							ddate_india2 = DateAdd("n", 30, ddate_In2)
'						end if 
						ddate_india2 = ddate_us2
			
				if (trim(rsInProject("workstatus"))="Received") then
					coror1="blue"
				end if
				if (trim(rsInProject("workstatus"))="Trial Project") then
					coror1="brown"
				end if
				if (trim(rsInProject("workstatus"))="Dead") then
					coror1="red"
				end if
				if (trim(rsInProject("workstatus"))="Completed") then
					coror1="green"
				end if
	  %>
        <tr valign="top" bgcolor="#E6E6E6" class="tb2" > 
          <td class="Tab3"><font color='<%=coror1%>'><%=rsInProject("proj_id")%></font></td>
		  <td class="Tab3" align="center">&nbsp;<a href="inhouse_project_report.asp?refno=<%=rsInProject("srno")%>" target="_blank"><font color='<%=coror1%>'><%=rsInProject("proj_name")%></font></a></td>
          <td class="Tab3"><%=ddate_india2%>&nbsp;</td>
          <td class="Tab3"><%=rsInProject("mp_id")%>&nbsp;</td>
          <td class="Tab3"><%=rsInProject("type_proj")%>&nbsp;</td>
          <!--td class="Tab3"><%'=rsProject("proj_name")%></td-->
     <%
			proj_desc = rsInProject("proj_desc")
			desc_len = len(proj_desc)
			if(desc_len>100) then
			desc_100 = mid(proj_desc,1,100)
			len_100 = len(desc_100)
	%>	  
          <td class="Tab3"><%=desc_100%>&nbsp;<a href="only_Proj_desc.asp?srno=<%=rsInProject("srno")%>&proj_id=<%=rsInProject("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
	<%
			else
	%>
		<td class="Tab3"><%=rsInProject("proj_desc")%>&nbsp;</td>	  
	<%
			end if
	%>
          <td class="Tab3"><%=round(rsInProject("total_hour"),2)%>&nbsp;</td>
          <%
				hour_exp1 =0
				dim rsProjectDetailsIn
				set rsProjectDetailsIn = server.CreateObject("adodb.recordset")
				rsProjectDetailsIn.open "SELECT hourspend,work_by_mark from tbl_pr_projDetails where proj_id='" & rsInProject("srno") &"' and del_status='0'",NewConnection
				if rsProjectDetailsIn.eof or rsProjectDetailsIn.bof then
					hour_exp1 = 0
				else
					do while not rsProjectDetailsIn.eof
						if(isnull(rsProjectDetailsIn("work_by_mark")) or rsProjectDetailsIn("work_by_mark")="") then
							hour_exp1 = hour_exp1 + round(rsProjectDetailsIn("hourspend"),2)
						end if
					rsProjectDetailsIn.movenext
					loop
					total_hour_exp1_dev_in = total_hour_exp1_dev_in + hour_exp1
				end if				
	
	%>
          <td class="Tab3"><%=hour_exp1%>&nbsp;</td>
          <td class="Tab3"><%=round((rsInProject("total_hour") - hour_exp1),2)%>&nbsp;</td>
          <td class="Tab3"><%=rsInProject("submeted_on")%>&nbsp;</td>
          <td class="Tab3"><%=rsInProject("asigned_per")%>&nbsp;</td>
          <!--td class="Tab3"><%'=rsProject("cost")%></td-->
        <%
			proj_Remark = rsInProject("Remark")
			Remark_len = len(proj_Remark)
			if (Remark_len>100) then
				Remark_100 = mid(proj_Remark,1,100)
				Remarklen_100 = len(Remark_100)
		%>	  
			  <td class="Tab3"><%=Remark_100%>&nbsp;<a href="only_proj_remark.asp?srno=<%=rsInProject("srno")%>&proj_id=<%=rsInProject("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
		<%
			else
		%>
			<td class="Tab3"><%=rsInProject("Remark")%>&nbsp;</td>	  
		<%
			end if
		%>          
          <td class="Tab2"><font color='<%=coror1%>'><%=rsInProject("workstatus")%>&nbsp;</font></td>
          
        </tr>
        <%
				total_hour_proj_in = total_hour_proj_in + rsInProject("total_hour")
				rsInProject.movenext
			loop	
		%>
	<% ''''''''''''''''''''''''''''''total printing''''''''''''''''''''''''''''' %>
		<tr valign="top" class="tb2" > 
          <td colspan="6" align="right" bgcolor="#E6E6E6" class="Tab2"><strong>Total</strong>&nbsp;</td>
          <td  align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=round(total_hour_proj_in,2)%></strong>&nbsp;</td>          
          <td  align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=round(total_hour_exp1_dev_in,2)%>&nbsp;</strong></td>
          <td  align="left" bgcolor="#E6E6E6" class="Tab2"><%=round((total_hour_proj_in-total_hour_exp1_dev_in),2)%>&nbsp;</td>		  
		  <td colspan="4" align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>           		  
        </tr>
		<% ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' %>
      </table>
	  <br>        
        <% end if %>
        <%	
		dim rsProject
		set rsProject = server.CreateObject("adodb.recordset")
		'rsProject.open "SELECT * FROM tbl_pr_project where asigned_per like '%" & trim(Session("DeveloperName")) & "%'  and type_proj<>'InHouse' order by srno desc",NewConnection
		
		if(text_date_from = "" or text_date_to = "") then
		else
			if(proj_status_type="Received" or proj_status_type="Trial Project") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj<>'InHouse' and ddate between'" & txt_date_From1 &"' and '" & txt_date_To1 & "' and workstatus='" & proj_status_type &"' order by srNo desc"
			end if
			if(proj_status_type="Dead" or proj_status_type="Completed") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj<>'InHouse' and completed_on between'" & txt_date_From1 &"' and '" & txt_date_To1 & "' and workstatus='" & proj_status_type &"' order by srNo desc"
			end if
			if(proj_status_type="All") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj<>'InHouse' and ddate between'" & txt_date_From1 &"' and '" & txt_date_To1 & "' order by srNo desc"
			end if
		end if
		if(text_type="") then
		else
			if(select2_type="Project Name") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj<>'InHouse' and proj_name like '" & text_type &"%'"
			end if
			if(select2_type="Project ID") then
				mainsql = "SELECT * from tbl_pr_project where asigned_per like '%"& trim(session("DeveloperName")) & "%' and type_proj<>'InHouse' and proj_id ='" & text_type &"'"
			end if
		end if
		
		rsProject.open mainsql,NewConnection
		
		if rsProject.eof or rsProject.bof then
			
		else		
	 %>
      </p>
      <table width="70%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
          <td colspan="13" class="Tab2" bgcolor="#CCCCCC"><div align="center"><strong>Project 
              List</strong></div></td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
	      <td class="Tab2"><strong>Project Id</strong></td>
		  <td class="Tab2" align="center">&nbsp;Project&nbsp;Name</td>
          <td class="Tab2"><strong>Date</strong></td>
          <td class="Tab2"><strong>Assigned by </strong></td>
          <td class="Tab2"><strong>Project Type</strong></td>
          <!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
          <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;&nbsp;Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
          <td class="Tab2"><strong>Total Hours</strong></td>
          <td class="Tab2"><strong>Hours Spent</strong></td>
          <td><strong class="Tab2"> Balance Hours</strong></td>
          <td class="Tab2"><strong>Delivery date</strong></td>
          <td class="Tab2"><strong>Assigned to</strong></td>
          <!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->
          <td class="Tab2"><strong>Client&nbsp;&nbsp;Remarks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
          <td class="Tab2"><strong>Project Status</strong></td>
          
        </tr>
        <%
			do while not rsProject.eof 
						ddate_us2 = rsProject("ddate")
						'differ = datediff("d",ddate_us2,"03/09/2008")
'						if(differ > 0) then
'							ddate_In2 = DateAdd("h", 9, ddate_us2)  
'							ddate_india2 = DateAdd("n", 30, ddate_In2) 
'						else
'							ddate_In2 = DateAdd("h", 9, ddate_us2)    
'							ddate_india2 = DateAdd("n", 30, ddate_In2) 
'						end if

						ddate_india2 = ddate_us2
			
				if (trim(rsProject("workstatus"))="Received") then
					coror1="blue"
				end if
				if (trim(rsProject("workstatus"))="Trial Project") then
					coror1="brown"
				end if
				if (trim(rsProject("workstatus"))="Dead") then
					coror1="red"
				end if
				if (trim(rsProject("workstatus"))="Completed") then
					coror1="green"
				end if
	  %>
        <tr valign="top" bgcolor="#E6E6E6" class="tb2" > 
          <td class="Tab3"><font color='<%=coror1%>'><%=rsProject("proj_id")%></font></td>
		  <td class="Tab3" align="center">&nbsp;<a href="project_report.asp?refno=<%=rsProject("srno")%>" target="_blank"><font color='<%=coror1%>'><%=rsProject("proj_name")%></font></a></td>
          <td class="Tab3"><%=ddate_india2%>&nbsp;</td>
          <td class="Tab3"><%=rsProject("mp_id")%>&nbsp;</td>
          <td class="Tab3"><%=rsProject("type_proj")%>&nbsp;</td>
          <!--td class="Tab3"><%'=rsProject("proj_name")%></td-->
     <%
			proj_desc = rsProject("proj_desc")
			desc_len = len(proj_desc)
			if(desc_len>100) then
			desc_100 = mid(proj_desc,1,100)
			len_100 = len(desc_100)
	%>	  
          <td class="Tab3"><%=desc_100%>&nbsp;<a href="only_Proj_desc.asp?srno=<%=rsProject("srno")%>&proj_id=<%=rsProject("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
	<%
			else
	%>
		<td class="Tab3"><%=rsProject("proj_desc")%>&nbsp;</td>	  
	<%
			end if
	%>
          <td class="Tab3"><%=round(rsProject("total_hour"),2)%>&nbsp;</td>
          <%
				hour_exp1 =0
				dim rsProjectDetails1
				set rsProjectDetails1 = server.CreateObject("adodb.recordset")
				rsProjectDetails1.open "SELECT hourspend,work_by_mark from tbl_pr_projDetails where proj_id='" & rsProject("srno") &"' and del_status='0'",NewConnection
				if rsProjectDetails1.eof or rsProjectDetails1.bof then
					hour_exp1 = 0
				else
					do while not rsProjectDetails1.eof
						if(isnull(rsProjectDetails1("work_by_mark")) or rsProjectDetails1("work_by_mark")="") then
							hour_exp1 = hour_exp1 + round(rsProjectDetails1("hourspend"),2)
						end if
					rsProjectDetails1.movenext
					loop
					total_hour_exp1_dev = total_hour_exp1_dev + hour_exp1
				end if				
	
	%>
          <td class="Tab3"><%=hour_exp1%>&nbsp;</td>
          <td class="Tab3"><%=round((rsProject("total_hour") - hour_exp1),2)%>&nbsp;</td>
          <td class="Tab3"><%=rsProject("submeted_on")%>&nbsp;</td>
          <td class="Tab3"><%=rsProject("asigned_per")%>&nbsp;</td>
          <!--td class="Tab3"><%'=rsProject("cost")%></td-->
        <%
			proj_Remark = rsProject("Remark")
			Remark_len = len(proj_Remark)
			if (Remark_len>100) then
				Remark_100 = mid(proj_Remark,1,100)
				Remarklen_100 = len(Remark_100)
		%>	  
			  <td class="Tab3"><%=Remark_100%>&nbsp;<a href="only_proj_remark.asp?srno=<%=rsProject("srno")%>&proj_id=<%=rsProject("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
		<%
			else
		%>
			<td class="Tab3"><%=rsProject("Remark")%>&nbsp;</td>	  
		<%
			end if
		%>          
          <td class="Tab2"><font color='<%=coror1%>'><%=rsProject("workstatus")%>&nbsp;</font></td>
          
        </tr>
        <%
				total_hour_proj = total_hour_proj + rsProject("total_hour")
				rsProject.movenext
			loop	
	%>
		<% ''''''''''''''''''''''''''''''total printing''''''''''''''''''''''''''''' %>
		<tr valign="top" class="tb2"> 
          <td colspan="6" align="right" bgcolor="#E6E6E6" class="Tab2"><strong>Total</strong>&nbsp;</td>
          <td  align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=round(total_hour_proj,2)%></strong>&nbsp;</td>          
          <td  align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=round(total_hour_exp1_dev,2)%>&nbsp;</strong></td>
          <td  align="left" bgcolor="#E6E6E6" class="Tab2"><%=round((total_hour_proj-total_hour_exp1_dev),2)%>&nbsp;</td>		  
		  <td colspan="4" align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>           		  
        </tr>
		<% ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' %>
      </table>
    <% end if %>
     </td>
  </tr>
</table>
<p>
  <%  
	dv_name = trim(Session("DeveloperName"))
%>
</p>		
		<p>&nbsp;</p><table width="100%" border="0" cellpadding="0" cellspacing="0">
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