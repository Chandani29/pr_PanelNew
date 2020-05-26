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
<script language="JavaScript">
function checkLogin()
{	
	
	if(document.form1.dd_Workper.value=="none")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.dd_Workper.focus();
		return false;
	}
	else if(document.form1.txt_ths.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_ths.focus();
		return false;
	}
	else if (isNaN(document.form1.txt_ths.value))
	{
		alert("Please Enter Only Digits between 1 to 9.");
		document.form1.txt_ths.select();
		return false;
	}
	//else if(document.form1.txt_ths.value.indexOf(".")>0)
	//{
		//alert("Please Enter Only integer value.");
		//document.form1.txt_ths.select();
		//return false;
	//}
	else if(document.form1.txt_ur.value=="")
	{
		alert("Please select date.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_ur.select();
		return false;
	}
	else if(document.form1.dd_time.value=="")
	{
		alert("TPlease select time(Hr).");
		//alert(document.form1.Password.value.length);
		document.form1.dd_time.focus();
		return false;
	}
	
	else if(document.form1.txt_remark.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_remark.focus();
		return false;
	}
	else
	{
		 var SetForm=document.form1;
		 //alert("hello");
		 remark = new String(SetForm.txt_remark.value);
		 //alert(remark);
		 remark= remark.replace(/'/g,"''");
		 //alert(remark);
		 SetForm.txt_remark.value=remark;
		 //alert(SetForm.txt_remark.value);
		return true;
	}
}	
</script>
<script lan language="javascript" type="text/javascript">

function localdate()
{
	var currentTime = new Date()
	var month = currentTime.getMonth() + 1
	var day = currentTime.getDate()
	var year = currentTime.getFullYear()
	if (day < 10)
	{
		day = "0" + day
	}
	if (month < 10)
	{
		month = "0" + month
	}
	var ddate = month + "/" + day + "/" + year
	
	var hours = currentTime.getHours()
	var minutes = currentTime.getMinutes()
	var seconds = currentTime.getSeconds()
	if (hours < 10)
	{
		hours = "0" + hours
	}
	if (minutes < 10)
	{
		minutes = "0" + minutes
	}
	if (seconds < 10)
	{
		seconds = "0" + seconds
	}
	dtime = hours + ":" + minutes + ":" + seconds
	//if(hours > 11)
//	{
//		dtime = dtime + "PM"
//	} 
//	else 
//	{
//		dtime = dtime + "AM"
//	}
	dttime = ddate + " " + dtime
	
	document.form1.txt_date.value = dttime;
}

</script>
<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</SCRIPT>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="localdate();">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="140" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
	 
    <%
	 	call OpenConnection
		refno = request("refno")
		'response.Write(refno)
		'response.Write(Session("DeveloperName"))
		dim project_type
		project_type=""
		dim rsProject
		set rsProject = server.CreateObject("adodb.recordset")
		rsProject.open "SELECT * from tbl_pr_project where srno='"& refno & "'",NewConnection
		if rsProject.eof or rsProject.bof then
			Response.Write("<strong><font color=red>No Project Found!!</font></strong>")
		else
				ddate_us2 = rsProject("ddate")
				'differ = datediff("d",ddate_us2,"03/09/2008")
'				if(differ > 0) then
'					ddate_In2 = DateAdd("h", 9, ddate_us2)  
'					ddate_india2 = DateAdd("n", 30, ddate_In2)
'				else
'					ddate_In2 = DateAdd("h", 9, ddate_us2) 
'					ddate_india2 = DateAdd("n", 30, ddate_In2)
'				end if
				
				ddate_india2 = ddate_us2
				
				if isnull(rsProject("type_proj")) or rsProject("type_proj")="" then
					project_type = ""
				else
					project_type = trim(rsProject("type_proj"))
				end if				
	 %>
	 <br>
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
            	<td colspan="14" class="tdrow5" bgcolor="#CCCCCC"><div align="center"><strong>Project 
                Detail ...<%=rsProject("proj_name")%>(<%=rsProject("proj_id")%>) </strong></div></td>
            </tr>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<!--td class="Tab2"><strong>SrNo.</strong></td-->
				<td class="Tab2"><strong>Date</strong></td>				
          		
        <td class="Tab2"><strong>Assigned by </strong></td>
				<td class="Tab2"><strong>Project Type</strong></td>
				<!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
				<td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
				<td class="Tab2"><strong>Total Hours</strong></td>
				
        <td class="Tab2"><strong>Hours spent</strong></td>				
          		<td class="Tab2"><strong>Delivery date</strong></td>
				
        <td class="Tab2"><strong>Assigned to</strong></td>								
          		<td class="Tab2"><strong>Cost&nbsp;</strong></td> 
				<td class="Tab2"><strong>Dev. Cost&nbsp;</strong></td>   
				<td class="Tab2"><strong>Expenses&nbsp;</strong></td>          		
				<td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;Remark&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
				<td class="Tab2"><strong>Project&nbsp;Status</strong></td>
			</tr>
	<%
			
				if (trim(rsProject("workstatus"))="Recieved") then
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
				total_id = Session("pr_username") & "-" & count1 & "-" & rsProject("srno")
	%>		
			<tr valign="top" bgcolor="#E6E6E6" class="tb2" > 				
				<!--td class="Tab3"><font color='<%'=coror1%>'><%'=rsProject("proj_id")%></font></td-->
				<td class="Tab3"><%=ddate_india2%>&nbsp;</td>
				<td class="Tab3"><%=rsProject("mp_id")%>&nbsp;</td>
				<td class="Tab3"><%=rsProject("type_proj")%>&nbsp;</td>
				<!--td class="Tab3"><%'=rsProject("proj_name")%>&nbsp;</td-->
	<%
			proj_desc = rsProject("proj_desc")
			desc_len = len(proj_desc)
			if(desc_len>100) then
			desc_100 = mid(proj_desc,1,100)
			len_100 = len(desc_100)
	%>	  
          <td class="Tab3"><%=desc_100%>&nbsp;<a href="only_Proj_desc.asp?srno=<%=rsProject("srno")%>&proj_id=<%=rsProject("proj_id")%>" target="_blank">more...</a>&nbsp;</td>
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
				end if				
	
	%>				
				<td class="Tab3"><%=round(hour_exp1,2)%>&nbsp;</td>				
				<td class="Tab3"><%=rsProject("submeted_on")%>&nbsp;</td>
				<td class="Tab3"><%=rsProject("asigned_per")%>&nbsp;</td>
				
	<%
				''''''''''''''''''' calculating developer cost in upper table '''''''''''''''''''''''''
						
		assigned_per_all_upper = rsProject("asigned_per")
		assigned_per_all_bal_upper = instr(assigned_per_all_upper,",")
		if(assigned_per_all_bal_upper > 0) then
				a=1
			dim rsDeveloper_bal_upper
			set rsDeveloper_bal_upper = server.CreateObject("adodb.recordset")
			dim ass_work_per_bal_upper
			alpha_bal_upper = rsProject("asigned_per")
			ass_per_bal_upper=split(alpha_bal_upper,",")
			ass_limit_bal_upper = ubound(ass_per_bal_upper)
					
			for i=0 to ass_limit_bal_upper
				ass_work_per_bal_upper = ass_per_bal_upper(i)
				total_hour_bal_upper = 0
				total_cost_bal_upper = 0
				
				if rsDeveloper_bal_upper.state then rsDeveloper_bal_upper.close
				rsDeveloper_bal_upper.open "SELECT * from tbl_pr_projDetails where proj_id='"& rsProject("srno") & "' and working_per='" & trim(ass_work_per_bal_upper) & "' and del_status='0' order by srno desc",NewConnection
				if rsDeveloper_bal_upper.eof or rsDeveloper_bal_upper.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else	   
				do while not rsDeveloper_bal_upper.eof						
								
					if (isnull(rsDeveloper_bal_upper("work_by_mark")) or rsDeveloper_bal_upper("work_by_mark")="") then						
						if isnull(rsDeveloper_bal_upper("hourspend")) or rsDeveloper_bal_upper("hourspend")="" then
							tioaltime_bal_upper = 0
							Devcost_upper = 0
						else							
							tioaltime_bal_upper = round(rsDeveloper_bal_upper("hourspend"),2)
							Devcost_upper = round(rsDeveloper_bal_upper("dev_cost"),2)
						end if
						total_hour_bal_upper = round((total_hour_bal_upper + tioaltime_bal_upper),2)
						total_cost_bal_upper = round((total_cost_bal_upper + Devcost_upper),2)
						all_total_cast_upper = all_total_cast_upper + round(Devcost_upper,2)						
						all_total_hour_upper = all_total_hour_upper + tioaltime_bal_upper
					end if	
				rsDeveloper_bal_upper.movenext
				loop		
	
	  		end if					
		  next
		  	
	else			
				dim ass_work_per1_bal_upper			
				ass_work_per_bal_upper = rsProject("asigned_per")
				total_hour_bal_upper = 0
				set rsDevcost_upper = server.CreateObject("adodb.recordset")						
				
				set rsDeveloper1_bal_upper = server.CreateObject("adodb.recordset")
				if rsDeveloper1_bal_upper.state then rsDeveloper1_bal_upper.close
				rsDeveloper1_bal_upper.open "SELECT * from tbl_pr_projDetails where proj_id='"& rsProject("srno") & "' and working_per='" & ass_work_per_bal_upper & "' and del_status='0' order by working_per asc,srno desc",NewConnection
				if rsDeveloper1_bal_upper.eof or rsDeveloper1_bal_upper.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else				
	  
					do while not rsDeveloper1_bal_upper.eof							
					
						if (isnull(rsDeveloper1_bal_upper("work_by_mark")) or rsDeveloper1_bal_upper("work_by_mark")="") then						
							if isnull(rsDeveloper1_bal_upper("hourspend")) or rsDeveloper1_bal_upper("hourspend")="" then
								tioaltime_bal_upper = 0
								Devcost_upper = 0
							else							
								tioaltime_bal_upper = round(rsDeveloper1_bal_upper("hourspend"),2)
								Devcost_upper = round(rsDeveloper1_bal_upper("dev_cost"),2)
							end if
							total_hour_bal_upper = round((total_hour_bal_upper + tioaltime_bal_upper),2)
							total_cost_bal_upper = round((total_cost_bal_upper + Devcost_upper),2)
							all_total_cast_upper = all_total_cast_upper + round(Devcost_upper,2)						
							all_total_hour_upper = all_total_hour_upper + tioaltime_bal_upper
						end if	
				rsDeveloper1_bal_upper.movenext
			loop			
		end if
				  	
	end if	
	
				''''''''''''''''''''''''' end calculation of upper table ''''''''''''''''''''''''''''''
		%>							
				<td class="Tab3"><%=rsProject("cost")%>&nbsp;</td>
				<td class="Tab3"><%=all_total_cast_upper%>&nbsp;<br><font color="#FF0099"><%=round(all_total_cast_upper - (all_total_cast_upper * 20/100),2)%></font></td>
				<%
					''''''''''''''''''''''' calculation of project expenses '''''''''''''''''''''''''''''''''
					set rsexpenses_up = server.CreateObject("adodb.recordset")
					sqlexp_up = "select sum(proj_exp_cost) as sum_exp from tbl_pr_expenses where proj_id='"& rsProject("srno") & "'"
					set rsexpenses_up= NewConnection.execute(sqlexp_up)
					if isnull(rsexpenses_up("sum_exp")) then
						sum_expenses_up = 0 
					else
						sum_expenses_up = round(rsexpenses_up("sum_exp"),2)
					end if
					total_expenses_up = round((total_expenses_up + sum_expenses_up),2)
					
					''''''''''''''''''''''' End of calculation of expenses '''''''''''''''''''''''''''''''''
				%>
				
				<td class="Tab3"><%=sum_expenses_up%>&nbsp;</td>				
		<%
			proj_Remark = rsProject("Remark")
			Remark_len = len(proj_Remark)
			if (Remark_len>100) then
				Remark_100 = mid(proj_Remark,1,100)
				Remarklen_100 = len(Remark_100)
		%>	  
			  <td class="Tab3"><%=Remark_100%>&nbsp;<a href="only_proj_remark.asp?srno=<%=rsProject("srno")%>&proj_id=<%=rsProject("proj_id")%>" target="_blank">more...</a>&nbsp;</td>
		<%
			else
		%>
			<td class="Tab3"><%=rsProject("Remark")%>&nbsp;</td>	  
		<%
			end if
		%>          
				<td class="Tab2"><font color='<%=coror1%>'><%=rsProject("workstatus")%>&nbsp;</font></td>				
			</tr>
			<td colspan="4" align="right" class="Tab2" bgcolor="#CCCCCC">Balance Hours&nbsp;</td>
				<td colspan="2" align="right" bgcolor="#CCCCCC" class="Tab2"><%=round((rsProject("total_hour") - hour_exp1),2)%>&nbsp;</td>
				<td colspan="2" class="Tab2" bgcolor="#CCCCCC" align="right">Balance Cost&nbsp;</td>
				<% if (round((rsProject("cost") - total_expenses_up - all_total_cast_upper),2) < 0 ) then %>
								<% if (round(all_total_cast_upper - (rsProject("cost") - total_expenses_up),2) < (all_total_cast_upper - (all_total_cast_upper - (all_total_cast_upper * 20/100))) ) then %>
				<td colspan="3" align="right" bgcolor="yellow" class="Tab2"><%=round((rsProject("cost") - total_expenses_up - all_total_cast_upper),2) %>&nbsp;</td>
								<% else %>		
				<td colspan="3" align="right" bgcolor="red" class="Tab2"><%=round((rsProject("cost") - total_expenses_up - all_total_cast_upper),2)%>&nbsp;</td>						
								<% end if %>
				<% else %>
				<td colspan="3" align="right" bgcolor="#25B311" class="Tab2"><%=round((rsProject("cost") - total_expenses_up - all_total_cast_upper),2)%>&nbsp;</td>
				<% end if %>
				<td colspan="2" class="Tab2" bgcolor="#CCCCCC">&nbsp;</td>				
			</tr>			
		</table>
		<br>
		<%	''''''''''''''''''''''''''''''''''Start of Time Calculation developer sec -------------------------------  %>
	
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
      <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
        <td colspan="14" class="tdrow5" bgcolor="#CCCCCC"><div align="center"><strong>Developer 
            Cost/Hour Calculation</strong></div></td>
      </tr>
      <% 
					assigned_per_all_bal = rsProject("asigned_per")
					assigned_per_all_bal = instr(assigned_per_all_bal,",")
					'response.Write(assigned_per_all)
					dim ass_limit_bal
					ass_limit_bal =0
					dim apha_bal					
					if isnull(rsProject("total_hour")) or rsProject("total_hour")="" then
						tioaltime1_bal = 0
					else
						tioaltime1_bal = round(rsProject("total_hour"),2)
					end if
					total_hour_ass_bal = tioaltime1_bal
				
		%>
      <%
			'call OpenConnection
			'refno = request("refno")
	if(assigned_per_all_bal > 0) then
				
			'dim rsDeveloper_bal
			set rsDeveloper_bal = server.CreateObject("adodb.recordset")
			'dim ass_work_per_bal
			alpha_bal = rsProject("asigned_per")
			ass_per_bal=split(alpha_bal,",")
			ass_limit_bal = ubound(ass_per_bal)
		%>
      <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
	  	<td class="Tab2"><strong>&nbsp;Developer Name</strong></td>
        <td class="Tab2"><strong>Total Hour Spent</strong></td>		
		<td class="Tab2"><strong>Total Cost[INR]</strong></td>
		<!--td class="Tab2"><strong>Cost Per Hr.</strong></td-->              
      </tr>
      <%			
			all_total_cost = 0
			all_total_hour = 0
			for i=0 to ass_limit_bal
				ass_work_per_bal = ass_per_bal(i)
				total_hour_bal = 0
				total_cost_bal = 0								
				if rsDeveloper_bal.state then rsDeveloper_bal.close
				rsDeveloper_bal.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' and working_per='" & trim(ass_work_per_bal) & "' and del_status='0' order by srno desc",NewConnection
				if rsDeveloper_bal.eof or rsDeveloper_bal.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else	   
				do while not rsDeveloper_bal.eof						
								
					if (isnull(rsDeveloper_bal("work_by_mark")) or rsDeveloper_bal("work_by_mark")="") then						
						if isnull(rsDeveloper_bal("hourspend")) or rsDeveloper_bal("hourspend")="" then
							tioaltime_bal = 0
							Devcost = 0 
						else							
							tioaltime_bal = round(rsDeveloper_bal("hourspend"),2)
							Devcost = round(rsDeveloper_bal("dev_cost"),2)
						end if
						total_hour_bal = round((total_hour_bal + tioaltime_bal),2)
						total_cost_bal  = round((total_cost_bal + Devcost),2)
						all_total_cast = all_total_cast + round(Devcost,2)						
						all_total_hour = all_total_hour + tioaltime_bal
					end if	
				rsDeveloper_bal.movenext
				loop		
	%>
		<tr valign="top" bgcolor="#E6E6E6" class="tb2" >                
        <!--td class='<%'=class1%>'><%'=rsDeveloper("work_by_mark")%>&nbsp;</td-->
        <td class='Tab3'><%=ass_work_per_bal%></td>     
		<td class='Tab3'><%=round(total_hour_bal,2)%>&nbsp;</td>		
		<td class='Tab3'><%=round(total_cost_bal,2)%>&nbsp;</td>
		<!--td class='Tab3'><%'=round(Devcost,2)%>&nbsp;</td-->              
        <!--td class='<%'=class1%>'><%'=rsDeveloper("work_remark")%>&nbsp;</td-->
        </tr>
      
      <%
	  		end if					
		  next
	%>
		<tr valign="top" bgcolor="#E6E6E6" class="tb2">
			<td class='Tab2' align="right" bgcolor="#CCCCCC">Total&nbsp;</td>
			<td class='Tab2' bgcolor="#CCCCCC"><%=all_total_hour%>&nbsp;</td>
			<td class='Tab2' bgcolor="#CCCCCC"><%=all_total_cast%>&nbsp;</td>
			<!--td class='Tab2' bgcolor="#CCCCCC">&nbsp;</td-->
		</tr>
	<%	  	
	else
			
				'dim ass_work_per1_bal
				all_total_cost = 0
				all_total_hour = 0			
				ass_work_per_bal = rsProject("asigned_per")
				total_hour_bal = 0
				total_cost_bal = 0
				set rsDeveloper1_bal = server.CreateObject("adodb.recordset")
				if rsDeveloper1_bal.state then rsDeveloper1_bal.close
				rsDeveloper1_bal.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' and working_per='" & ass_work_per_bal & "' and del_status='0' order by working_per asc,srno desc",NewConnection
				if rsDeveloper1_bal.eof or rsDeveloper1_bal.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else								
	   %>
					  <tr valign="top" bgcolor="#E6E6E6" class="bottom" >  
						<td class="Tab2"><strong>Developers&nbsp;</strong></td>     
						<td class="Tab2"><strong>Hour Spent</strong></td>  
						
        <td class="Tab2"><strong>Total Cost Per Hr.</strong></td>
        <!--td class="Tab2"><strong>Cost Per Hr.</strong></td-->   
								
					  </tr>
      <%
					do while not rsDeveloper1_bal.eof							
					
						if (isnull(rsDeveloper1_bal("work_by_mark")) or rsDeveloper1_bal("work_by_mark")="") then						
							if isnull(rsDeveloper1_bal("hourspend")) or rsDeveloper1_bal("hourspend")="" then
								tioaltime_bal = 0
								Devcost = 0
							else							
								tioaltime_bal = round(rsDeveloper1_bal("hourspend"),2)
								Devcost = round(rsDeveloper1_bal("dev_cost"),2)
							end if
							total_hour_bal = round((total_hour_bal + tioaltime_bal),2)
							total_cost_bal = round((total_cost_bal + Devcost),2)
							all_total_cast = all_total_cast + Devcost						
							all_total_hour = all_total_hour + tioaltime_bal
						end if	
				rsDeveloper1_bal.movenext
			loop
		%>
			 <tr valign="top" bgcolor="#E6E6E6" class="tb2" >                
				<!--td class='<%'=class1%>'><%'=rsDeveloper("work_by_mark")%>&nbsp;</td-->
				<td class='Tab3'><%=ass_work_per_bal%></td>     
				<td class='Tab3'><%=round(total_hour_bal,2)%>&nbsp;</td>       
        		<td class='Tab3'>&nbsp;<%=round(total_cost_bal,2)%></td>
				<!--td class='Tab3'><%'=round(Devcost,2)%></td-->             
				<!--td class='<%'=class1%>'><%'=rsDeveloper("work_remark")%>&nbsp;</td-->
			</tr>
		<%	
		end if
	%>
			<tr valign="top" bgcolor="#E6E6E6" class="tb2">
				<td class='Tab2' align="right" bgcolor="#CCCCCC">Total&nbsp;</td>
				<td class='Tab2' bgcolor="#CCCCCC"><%=all_total_hour%>&nbsp;</td>
				<td class='Tab2' bgcolor="#CCCCCC"><%=all_total_cast%>&nbsp;</td>
				<!--td class='Tab2' bgcolor="#CCCCCC">&nbsp;</td-->
			</tr>
	<%			  	
	end if	
	%>
    </table>
	<br>
	<%
		''''''''''''''''''' start working on sub projects ''''''''''''''''''''''''''''''''''''''''''''
	%>
			<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
				<tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
					<td colspan="4" class="tdrow5" bgcolor="#CCCCCC"><div align="center"><strong>Sub Projects ...</strong></div></td>
				</tr>				
	<%
				dim rst_inhouse
				dim rst_subproj
				set rst_inhouse = server.CreateObject("adodb.recordset")
				if rst_inhouse.state then rst_inhouse.close
				inhouse_sql = "select * from tbl_pr_projInhouse where projid='" & trim(refno) & "'"
				rst_inhouse.open inhouse_sql,NewConnection
				if rst_inhouse.eof or rst_inhousebof then
				else
	%>			
				<tr valign="top" bgcolor="#E6E6E6" class="tb2">
					<td class='Tab2' bgcolor="#CCCCCC">Sub&nbsp;Project&nbsp;Name</td>
					<td class='Tab2' bgcolor="#CCCCCC">Hour&nbsp;Spent&nbsp;</td>
					<td class='Tab2' bgcolor="#CCCCCC">Total&nbsp;Cost&nbsp;</td>
					<td class='Tab2' bgcolor="#CCCCCC">Details&nbsp;</td>
				</tr>				
	<%
					do while not rst_inhouse.eof 
						set rst_subproj = server.CreateObject("adodb.recordset")
						if rst_subproj.state then rst_subproj.close
						subproj_sql = "select sum(hourspend) as hourspend_inhouse,sum(dev_cost) as dev_cost_inhouse from tbl_pr_projDetails where inhouse_id='" & trim(rst_inhouse("srno")) & "' and (work_by_mark is null or work_by_mark ='') and del_status='0'"
						rst_subproj.open subproj_sql,NewConnection
						if isnull(rst_subproj("hourspend_inhouse")) or rst_subproj("hourspend_inhouse")="" then
							hourspend_inhouse = 0
						else
							hourspend_inhouse = rst_subproj("hourspend_inhouse")
						end if
						if isnull(rst_subproj("dev_cost_inhouse")) or rst_subproj("dev_cost_inhouse")="" then
							dev_cost_inhouse = 0
						else
							dev_cost_inhouse = rst_subproj("dev_cost_inhouse")
						end if
						all_hourspend_inhouse = all_hourspend_inhouse + hourspend_inhouse
						all_dev_cost_inhouse = all_dev_cost_inhouse + dev_cost_inhouse					
	%>
				<tr valign="top" bgcolor="#E6E6E6" class="tb2">
					<td class='Tab3'><%=rst_inhouse("ProjName")%></td>
					<td class='Tab3'><%=round(hourspend_inhouse,2)%>&nbsp;</td>
					<td class='Tab3'><%=round(dev_cost_inhouse,2)%>&nbsp;</td>
					<td class='Tab3'><a href="sub_project_details.asp?srno=<%=trim(rst_inhouse("srno"))%>" target="_blank">Details</a>&nbsp;</td>
				</tr>				
	<%								
					rst_inhouse.movenext
					loop
	%>
				<tr valign="top" bgcolor="#E6E6E6" class="tb2">
					<td class='Tab2' align="right" bgcolor="#CCCCCC">Total&nbsp;</td>
					<td class='Tab2' bgcolor="#CCCCCC"><%=all_hourspend_inhouse%>&nbsp;</td>
					<td class='Tab2' bgcolor="#CCCCCC"><%=all_dev_cost_inhouse%>&nbsp;</td>
					<td class='Tab2' bgcolor="#CCCCCC">&nbsp;</td>
			    </tr>
	<%
					end if
	%>				
			</table>
	<%					
		'''''''''''''''''''''''''''''''''' end working on sub projects ''''''''''''''''''''''''''''''''''''''''''''''	
	%>
	<br>	
	<% '''''''''''''''''''''''''''''''End if Time Calculation Developer section'''''''''''''''''''''''''''''' %>
	
	<% 
					assigned_per_all = rsProject("asigned_per")
					assigned_per_all = instr(assigned_per_all,",")
					'response.Write(assigned_per_all)
					dim ass_limit
					ass_limit =0
					dim apha					
					if isnull(rsProject("total_hour")) or rsProject("total_hour")="" then
						tioaltime1 = 0
					else
						tioaltime1 = int(rsProject("total_hour"))
					end if
					total_hour_ass = tioaltime1
				end if 
	%>	
		<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
            	<td colspan="14" class="tdrow5" bgcolor="#CCCCCC"><div align="center"><strong>Task Done/Assigned By Developers/Marketing ...</strong></div></td>
            </tr>  
    <%
			'call OpenConnection
			'refno = request("refno")
			if(assigned_per_all > 0) then
				
			dim rsDeveloper
			set rsDeveloper = server.CreateObject("adodb.recordset")
			dim ass_work_per
			alpha = rsProject("asigned_per")
			ass_per=split(alpha,",")
			ass_limit = ubound(ass_per)
						
			for i=0 to ass_limit
				ass_work_per = trim(ass_per(i))
				if rsDeveloper.state then rsDeveloper.close
				rsDeveloper.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' and working_per='" & trim(ass_work_per) & "' order by working_per asc,srno desc",NewConnection
				if rsDeveloper.eof or rsDeveloper.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else				
	   %>
   			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<!--td class="Tab2"><strong>SrNo.</strong></td-->
				<td class="Tab2"><strong>Date</strong></td>
				<td class="Tab2"><strong>Proj.&nbsp;Name</strong></td>				
          		<td class="Tab2"><strong>Assigned by </strong></td>
				<!--td class="Tab2"><strong>Project&nbsp;Type</strong></td-->
				<!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
				<td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Assigned&nbsp;&nbsp;Task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td-->
				
        <td class="Tab2"><strong>Assigned/Spent<br>
          Hour </strong></td>				
          		<td class="Tab2"><strong>To be Submmited by</strong></td>
				<td class="Tab2"><strong>&nbsp;Developers</strong></td>								
          		<!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->          		
				<td class="Tab2"><strong>Task&nbsp;Done&nbsp;by&nbsp;Developer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
				<td class="Tab2"><strong>Work Status</strong></td>
				<td class="Tab2"><strong>&nbsp;</strong></td>
			</tr>
		<%
				do while not rsDeveloper.eof
							ddate_us1 = rsDeveloper("ddate")
							'differ = datediff("d",ddate_us1,"03/09/2008")
'							if(differ > 0) then
'								ddate_In1 = DateAdd("h", 10, ddate_us1)  
'								ddate_india1 = DateAdd("n", 30, ddate_In1)
'							else
'								ddate_In1 = DateAdd("h", 9, ddate_us1)  
'								ddate_india1 = DateAdd("n", 30, ddate_In1)
'							end if
							ddate_india1 = ddate_us1
					if isnull(rsDeveloper("work_by_mark")) or rsDeveloper("work_by_mark")="" then
						if(int(rsDeveloper("del_status"))=0) then
							class1 = "Tab3"
						else
							class1 = "txtdel"
						end if	
					else
						if(int(rsDeveloper("work_status"))=0) then							
								class1 = "txt"							
						else
							class1 = "txtpink"							
						end if						
					end if
					
					if (trim(rsDeveloper("asignedby")) = trim(rsDeveloper("working_per"))) then
						
					else
						
						if isnull(rsDeveloper("hourspend")) or rsDeveloper("hourspend")="" then
							tioaltime = 0
						else
							tioaltime = round(rsDeveloper("hourspend"),2)
						end if
						total_hour = round((total_hour + tioaltime),2)
						'response.Write(total_hour)
					end if	
		%>
			<tr valign="top" bgcolor="#E6E6E6" class="tb2" > 				
				<!--td class='<%'=class1%>'><font color='<%'=coror1%>'><%'=rsDeveloper("srno")%></font></td-->
				<td class='<%=class1%>'><%=ddate_india1%>&nbsp;</td>
				<% if(isnull(rsDeveloper("inhouse_id")) or rsDeveloper("inhouse_id")="") then %> 
				<td class='<%=class1%>'><%=rsProject("proj_name")%>&nbsp;</td>
				<% 
				else 			
					set rsInhouse = server.CreateObject("adodb.recordset")
					if rsInhouse.state then rsInhouse.close
					rsInhouse.open "SELECT * from tbl_pr_projInhouse where srno='"& rsDeveloper("inhouse_id") & "'",NewConnection
					if rsInhouse.eof or rsInhouse.bof then
						inhouse_project = ""
					else
						inhouse_project = rsInhouse("ProjName")
					end if
				%>
				<td class='<%=class1%>'><%=rsProject("proj_name")%><br>(<%=inhouse_project%>)&nbsp;</td>
				<% end if %>
				<td class='<%=class1%>'><%=rsDeveloper("asignedby")%>&nbsp;</td>
				<!--td class='<%'=class1%>'><%'=rsDeveloper("type_proj")%></td-->
				<!--td class='<%'=class1%>'><%'=rsDeveloper("proj_name")%></td-->
			<%
					work_by_mark = rsDeveloper("work_by_mark")
					work_by_mark_len = len(work_by_mark)
				if(work_by_mark_len>100) then
					work_by_mark_100 = mid(work_by_mark,1,100)
					len_work_by_mark_100 = len(work_by_mark_100)
			%>	  
				  <td class='<%=class1%>'><%= Server.HTMLEncode(work_by_mark_100)%>&nbsp;<a href="only_work_by_mark.asp?srno=<%=rsDeveloper("srno")%>&proj_id=<%=rsDeveloper("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
			<%
				else
			%>
				<td class='<%=class1%>'><%= rsDeveloper("work_by_mark")%>&nbsp;</td>	  
			<%
				end if
			%>
				<!--td class='<%'=class1%>'><%'=rsDeveloper("work_by_mark")%>&nbsp;</td-->
				<td class='<%=class1%>'><%=round(rsDeveloper("hourspend"),2)%>&nbsp;</td>
				<td class='<%=class1%>'><%=rsDeveloper("ur_date")%>&nbsp;</td>
				<td class='<%=class1%>'><%=rsDeveloper("working_per")%></td>				
				<!--td class='<%'=class1%>'><%'=rsDeveloper("cost")%></td-->
			<%
					work_remark = rsDeveloper("work_remark")
					work_remark_len = len(work_remark)
				if(work_remark_len>100) then
					work_remark_100 = mid(work_remark,1,100)
					len_work_remark_100 = len(work_remark_100)
			%>	  
				  <td class='<%=class1%>'><%=work_remark_100%>&nbsp;<a href="only_work_remark.asp?srno=<%=rsDeveloper("srno")%>&proj_id=<%=rsDeveloper("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
			<%
				else
			%>
				<td class='<%=class1%>'><%=rsDeveloper("work_remark")%>&nbsp;</td>	  
			<%
				end if
			%>				
				<!--td class='<%'=class1%>'><%'=rsDeveloper("work_remark")%>&nbsp;</td-->
	<% if int(rsDeveloper("work_status")) = 1 then %>				
				<td class='<%=class1%>'>Done&nbsp;</td>
	<% else %>
    	<%	if isnull(rsDeveloper("work_by_mark")) or rsDeveloper("work_by_mark") = "" then %>
				<td class='<%=class1%>'>&nbsp;</td>
		<% else %>
				<td class='<%=class1%>'>Pending&nbsp;</td>
		<% end if %>				
	<% end if %>
	<% if int(rsDeveloper("del_status")) = 1 then %>
				<td class='<%=class1%>'><a href="#" onClick="MM_openBrWindow('show_resign.asp?srno=<%=rsDeveloper("srno")%>&refno=<%=refno%>','','width=200,height=200')"><strong><font color="#999999"><u>Deleted</u></font></strong></a></td>
	<% else %>
				<td class='<%=class1%>'>&nbsp;</td>
	<% end if %>
			</tr>			
	<%
			rsDeveloper.movenext
			loop
			end if
	%>
			<tr valign="top" bgcolor="#9999CC" > 				
				<td colspan="9">&nbsp;</td>				
			</tr>	
	<%					
		  next	
	else
			dim rsDeveloper1
			set rsDeveloper1 = server.CreateObject("adodb.recordset")
			dim ass_work_per1			
				ass_work_per = rsProject("asigned_per")
				if rsDeveloper1.state then rsDeveloper1.close
				rsDeveloper1.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' and working_per='" & trim(ass_work_per) & "' order by working_per asc,srno desc",NewConnection
				if rsDeveloper1.eof or rsDeveloper1.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else				
	   %>    			
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<!--td class="Tab2"><strong>SrNo.</strong></td-->
				<td class="Tab2"><strong>Date</strong></td>
				<td class="Tab2"><strong>Proj.&nbsp;Name</strong></td>				
          		<td class="Tab2"><strong>Assigned by </strong></td>
				<!--td class="Tab2"><strong>Project&nbsp;Type</strong></td-->
				<!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
				<td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Assigned&nbsp;&nbsp;Task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td-->
				
        <td class="Tab2"><strong>Assigned/Spent <br>
          Hour</strong></td>				
          		<td class="Tab2"><strong>To be Submmited by</strong></td>
				<td class="Tab2"><strong>Developers&nbsp;</strong></td>								
          		<!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->          		
				<td class="Tab2"><strong>Task&nbsp;Done&nbsp;by&nbsp;Developer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
				<td class="Tab2"><strong>Task Status</strong></td>
				<td class="Tab2"><strong>&nbsp;</strong></td>
			</tr>
		<%
				do while not rsDeveloper1.eof
							ddate_us = rsDeveloper1("ddate")
							'differ = datediff("d",ddate_us,"03/09/2008")
'							if(differ > 0) then
'								ddate_In = DateAdd("h", 10, ddate_us)  
'								ddate_india = DateAdd("n", 30, ddate_In)
'							else
'								ddate_In = DateAdd("h", 9, ddate_us)  
'								ddate_india = DateAdd("n", 30, ddate_In)
'							end if
							ddate_india = ddate_us
					if isnull(rsDeveloper1("work_by_mark")) or rsDeveloper1("work_by_mark")="" then
						if(int(rsDeveloper1("del_status"))=0) then
							class1 = "Tab3"
						else
							class1 = "txtdel"
						end if	
					else
						if(int(rsDeveloper1("work_status"))=0) then							
								class1 = "txt"							
						else
							class1 = "txtpink"							
						end if						
					end if
					
					if (trim(rsDeveloper1("asignedby")) = trim(rsDeveloper1("working_per"))) then
					else						
						if isnull(rsDeveloper1("hourspend")) or rsDeveloper1("hourspend")="" then
							tioaltime1 = 0
						else
							tioaltime1 = round(rsDeveloper1("hourspend"),2)
						end if
						total_hour1 = round((total_hour1 + tioaltime1),2)
						'response.Write(total_hour)
					end if	
		%>
			<tr valign="top" bgcolor="#E6E6E6" class="tb2" > 				
				<!--td class='<%'=class1%>'><font color='<%'=coror1%>'><%'=rsDeveloper1("srno")%></font></td-->
				<td class='<%=class1%>'><%=ddate_india%>&nbsp;</td>
				<% if(isnull(rsDeveloper1("inhouse_id")) or rsDeveloper1("inhouse_id")="") then %> 
				<td class='<%=class1%>'><%=rsProject("proj_name")%>&nbsp;</td>
				<% 
					else 
					set rsInhouse = server.CreateObject("adodb.recordset")
					if rsInhouse.state then rsInhouse.close
					rsInhouse.open "SELECT * from tbl_pr_projInhouse where srno='"& rsDeveloper1("inhouse_id") & "'",NewConnection
					if rsInhouse.eof or rsInhouse.bof then
						inhouse_project = ""
					else
						inhouse_project = rsInhouse("ProjName")
					end if				
				%>
				<td class='<%=class1%>'><%=rsProject("proj_name")%><br><%=inhouse_project%>&nbsp;</td>
				<% end if %>
				<td class='<%=class1%>'><%=rsDeveloper1("asignedby")%>&nbsp;</td>
				<!--td class='<%'=class1%>'><%'=rsDeveloper1("type_proj")%></td-->
				<!--td class='<%'=class1%>'><%'=rsDeveloper1("proj_name")%></td-->
				<%
					work_by_mark1 = rsDeveloper1("work_by_mark")
					work_by_mark1_len = len(work_by_mark1)
				if(work_by_mark1_len>100) then
					work_by_mark1_100 = mid(work_by_mark1,1,100)
					len_work_by_mark1_100 = len(work_by_mark1_100)
			%>	  
				  <td class='<%=class1%>'><%= Server.HTMLEncode(work_by_mark1_100)%>&nbsp;<a href="only_work_by_mark.asp?srno=<%=rsDeveloper1("srno")%>&proj_id=<%=rsDeveloper1("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
			<%
				else
			%>
				<td class='<%=class1%>'><%= rsDeveloper1("work_by_mark")%>&nbsp;</td>	  
			<%
				end if
			%>
				<!--td class='<%'=class1%>'><%'=rsDeveloper1("work_by_mark")%>&nbsp;</td-->
				<td class='<%=class1%>'><%=round(rsDeveloper1("hourspend"),2)%>&nbsp;</td>
				<td class='<%=class1%>'><%=rsDeveloper1("ur_date")%>&nbsp;</td>
				<td class='<%=class1%>'><%=rsDeveloper1("working_per")%></td>				
				<!--td class='<%'=class1%>'><%'=rsDeveloper1("cost")%></td-->
				<%
					work_remark1 = rsDeveloper1("work_remark")
					work_remark1_len = len(work_remark1)
				if(work_remark1_len>100) then
					work_remark1_100 = mid(work_remark1,1,100)
					len_work_remark1_100 = len(work_remark1_100)
			%>	  
				  <td class='<%=class1%>'><%=work_remark1_100%>&nbsp;<a href="only_work_remark.asp?srno=<%=rsDeveloper1("srno")%>&proj_id=<%=rsDeveloper1("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
			<%
				else
			%>
				<td class='<%=class1%>'><%=rsDeveloper1("work_remark")%>&nbsp;</td>	  
			<%
				end if
			%>				
				<!--td class='<%'=class1%>'><%'=rsDeveloper1("work_remark")%>&nbsp;</td-->
	<% if int(rsDeveloper1("work_status")) = 1 then %>				
			<td class='<%=class1%>'>Done&nbsp;</td>
	<% else %>
    	<%	if isnull(rsDeveloper1("work_by_mark")) or rsDeveloper1("work_by_mark") = "" then %>
			<td class='<%=class1%>'>&nbsp;</td>
		<% else %>
			<td class='<%=class1%>'>Pending&nbsp;</td>
		<% end if %>				
	<% end if %>			
	<% if int(rsDeveloper1("del_status")) = 1 then %>
			<td class='<%=class1%>'><a href="#" onClick="MM_openBrWindow('show_resign.asp?srno=<%=rsDeveloper1("srno")%>&refno=<%=refno%>','','width=200,height=200')"><strong><font color="#999999"><u>Deleted</u></font></strong></a></td>
	<% else %>
			<td class='<%=class1%>'>&nbsp;</td>
	<% end if %>
		</tr>
	<%
			rsDeveloper1.movenext
			loop
			end if		  	
	end if	
	%>
		</table>
		<br>
		<% 
		''''''''''''''''' showing form if work_status is recieved or trial'''''''''''''''''''''''''
		set rsworkstatus = server.CreateObject("adodb.recordset")
		sqlworkstatus = "SELECT * from tbl_pr_project where srno='"& refno & "'"
		set rsworkstatus= NewConnection.execute(sqlworkstatus)
		if(rsworkstatus("workstatus")="Received" or rsworkstatus("workstatus")="Trial Project") then		
		%>
    <form action="project_Details_selected_inhouse_cal.asp" method="post" name="form1"> 
		<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<td colspan="4" align="center" class="Tab2" bgcolor="#CCCCCC">Add New Task.....</td>				
			</tr>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				
          <td colspan="2" align="center" class="Tab2">&nbsp;Date</td>
				<td colspan="2" class="Tab3"> <font color="#FF0000">&nbsp; 
				  <input name="txt_date" type="text" id="txt_date" size="20" readonly>
				  </font></td>
			</tr>
			<% 
			if(trim(project_type)="InHouse") then 
			Set rsInhouse = server.CreateObject("adodb.recordset")
				rsInhouse.open "SELECT * from tbl_pr_projInhouse where ProjId='" & refno &"' order by convert(int,srNo) desc",NewConnection
				if rsInhouse.eof or rsInhouse.bof then
				else						
			%>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" >				
          		<td colspan="2" align="center" class="Tab2">InHouse Project</td>
				<td colspan="2" class="Tab3">&nbsp;
					<select name="inhouse">				
					<%
						do while not rsInhouse.eof
					%>
					<option value='<%=rsInhouse("srno")%>'><%=rsInhouse("ProjName")%></option>
					<%
								rsInhouse.movenext
							loop
						end if
					%>
					</select>
				</td>
			</tr>	
			<%
			end if
			%>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				
          <td colspan="2" align="center" class="Tab2">Assign The Person </td>
				<td colspan="2" class="Tab3">&nbsp; 
				  <select name="dd_Workper">
				  <option value="none" selected>Select Person</option>
		<%
				dim rstDev
				set rstDev = server.CreateObject("adodb.recordset")
				rstDev.open "select asigned_per from tbl_pr_project where srno='"& refno & "'",NewConnection
				if rstDev.eof or rstDev.bof then
					'Response.Write("<br><strong><font color=red>No Record Found !!</font></strong>")
				else
					asigneddevelopers_all = rstDev("asigned_per")
					no_asigneddevelopers = instr(asigneddevelopers_all,",")
					if(no_asigneddevelopers > 0) then
					
						dim ass_work_per11
							alpha11 = rstDev("asigned_per")
							ass_per11=split(alpha11,",")
							ass_limit11 = ubound(ass_per11)
										
							for i=0 to ass_limit11
								ass_work_per11 = ass_per11(i)							
		%>
				  <option value='<%=trim(ass_work_per11)%>'><%=trim(ass_work_per11)%></option>
		<%					
							next	
					else
		%>		  
				  <option value='<%=trim(asigneddevelopers_all)%>'><%=trim(asigneddevelopers_all)%></option>
		<%			
					end if		
				end if
		%>		  
				  </select>
				  </font></td>
			  </tr>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				
          <td colspan="2" align="center" class="Tab2">Assign Total Hour</td>
				
          <td colspan="2" class="Tab3"> <font color="#FF0000">&nbsp; 
            <input name="txt_ths" type="text" id="txt_ths" size="20">
            <strong>Hr</strong> (Don't put minute, if requires then put in hour 
            format, for Ex. 15 min=0.25, 30 minute=0.5, 45 min=0.75, 1Hour and 
            15 min=1.25)</font></td>
			  </tr>
			  <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<td colspan="2" align="center" class="Tab2">Task Should be Completed on </td>
				<td colspan="2" class="Tab3"> <font color="#FF0000">&nbsp; 
				  <input name="txt_ur" type="text" id="txt_ur" size="20" readonly>&nbsp;(MM/DD/YYYY)
				  
				  <script type="text/javascript">
						function catcalc(cal)
						{
							var date = cal.date;
							var time = date.getTime()
							var field = document.getElementById("txt_ur");
							var date2 = new Date(time);
							field.value = date2.print("%m/%d/%Y");
						}
						Calendar.setup({inputField:"txt_ur", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
				</script>
				<select name="dd_time" id="dd_time">
				<option value="">Hr</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
				<option value="13">13</option>
				<option value="14">14</option>
				<option value="15">15</option>
				<option value="16">16</option>
				<option value="17">17</option>
				<option value="18">18</option>
				<option value="19">19</option>
				<option value="20">20</option>
				<option value="21">21</option>
				<option value="22">22</option>
				<option value="23">23</option>
				<option value="24">24</option>				
				</select>&nbsp;Hr
				</font></td>
			  </tr>
			  <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				
          <td colspan="2" align="center" class="Tab2">Assign Task [Description]</td>
				<td colspan="2" class="Tab3"><font color="#FF0000">&nbsp; 
				  <textarea name="txt_remark" cols="80" rows="18" id="txt_remark"></textarea>
				  </font></td>
			  </tr>
			  <input type="hidden" name="h_id" id="h_id" value="<%=refno%>">
          <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom"> 
            <td colspan="4"> <input name="Submit" type="submit" class="Tab2" style="WIDTH: 150px;" value="Submit" onClick="return checkLogin();"> 
              <input name="Submit2" type="Reset" class="Tab2" style="WIDTH: 150px;" value="Reset"> 
            </td>
          </tr>
		  </table>
	 </form>
	 <%
	 		end if
	 ''''''''''''''''''''''''''''' end of form '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	 %>	  
	<br><br><br>	     
<tr><td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--><p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site Empowered by AKS India Web Solutions </font></strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">.</font></p>
      </td>
  </tr></div></table>
    <% call closeconnection %>
<p>&nbsp;</p></body>
</html>