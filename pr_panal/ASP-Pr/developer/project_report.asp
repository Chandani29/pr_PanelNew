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
<script language="JavaScript">
function confirmform(var1,var2)
{  
		var answer = confirm("Did you complete the assigned task ?");
		if (answer)
		{
			//alert(var1);
			window.location = "update_workstatus.asp?h_id=" + var1 + "&refno=" + var2;						
		}
		else
		{
			//alert(var2);			
			window.location = "project_report.asp?refno=" + var2;
		}
}

function checkLogin()
{	
	if(document.form1.txt_ths.value=="")
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
	else if(document.form1.txt_ths.value.indexOf(".")>0)
	{
		alert("Please Enter Only integer value.");
		document.form1.txt_ths.select();
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

</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="140" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
                <td width="282"><div align="center"><font color="#CCFF00" size="2" face="Verdana, Arial, Helvetica, sans-serif">Welcome 
                    <strong><%=Session("DeveloperName")%></strong></font></div></td>
                <td width="318"><div align="right"><img src="images/logout.jpg" width="15" height="15" align="absmiddle">&nbsp;<span class="red"><strong><a href="logout.asp"><font color="yellow" size="1" face="Verdana, Arial, Helvetica, sans-serif">LOGOUT</font></a></strong></span>&nbsp; 
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
		refno = request("refno")
		'response.Write(refno)
		'response.Write(Session("DeveloperName"))
		dim rsProject
		set rsProject = server.CreateObject("adodb.recordset")
		rsProject.open "SELECT * from tbl_pr_project where srno='"& refno & "'",NewConnection
		if rsProject.eof or rsProject.bof then
			'Response.Write("<strong><font color=red>No Project Found!!</font></strong>")
		else
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
	 %>
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
				<td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;&nbsp;Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
				<td class="Tab2"><strong>Total Hours</strong></td>
				
        <td class="Tab2"><strong>Hours Spent</strong></td>					
          		
        <td class="Tab2"><strong>Delivery Date</strong></td>
				
        <td class="Tab2"><strong>Assigned to</strong></td>								
          		<!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->          		
				
        <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Client&nbsp;&nbsp;Remarks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
				<td class="Tab2"><strong>Project Status</strong></td>
			</tr>
	<%
			
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
				total_id = Session("dr_username") & "-" & count1 & "-" & rsProject("srno")
	%>		
			<tr valign="top" bgcolor="#E6E6E6" class="tb2" > 				
				<!--td class="Tab3"><font color='<%'=coror1%>'><%'=rsProject("proj_id")%></font></td-->
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
				end if				
	
	%>				
				<td class="Tab3"><%=hour_exp1%>&nbsp;</td>
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
			  <td class="Tab3"><%=Remark_100%>&nbsp;&nbsp;<a href="only_proj_remark.asp?srno=<%=rsProject("srno")%>&proj_id=<%=rsProject("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
		<%
			else
		%>
			<td class="Tab3"><%=rsProject("Remark")%>&nbsp;</td>	  
		<%
			end if
		%> 				
				<td class="Tab2"><font color='<%=coror1%>'><%=rsProject("workstatus")%></font></td>
			</tr>
			<tr valign="top" bgcolor="#E6E6E6" class="tb2">
					
        <td colspan="4" align="right" class="Tab2" bgcolor="#CCCCCC">Balance Hours&nbsp;</td>
					<td colspan="2" class="Tab2" bgcolor="#CCCCCC"><%=round((rsProject("total_hour") - hour_exp1),2)%>&nbsp;</td>
					<td colspan="10" class="Tab2" bgcolor="#CCCCCC">&nbsp;</td>
			</tr>			
		</table>
<br>
<% '''''''''''''''''''''''''''''''''''''''''''' hour balance in developer section ''''''''''''''''''''''''''''''''''''''''''''''''' %>


    <table width="300" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
      <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
        <td colspan="14" class="tdrow5" bgcolor="#CCCCCC"><div align="center"><strong>Developer 
            Hour Calculation</strong></div></td>
      </tr>
      <% 				'dim ass_work_per1_bal			
				ass_work_per_bal = trim(Session("DeveloperName"))
				total_hour_bal = 0
				set rsDevcost = server.CreateObject("adodb.recordset")								
				if rsDevcost.state then rsDevcost.close
				rsDevcost.open "SELECT * from tbl_pr_developerLogin where name='" & trim(ass_work_per_bal) & "'",NewConnection
				if rsDevcost.eof or rsDevcost.bof then 
					Devcost = 0
				else
					Devcost =rsDevcost("per_cost")
				end if
				set rsDeveloper1_bal = server.CreateObject("adodb.recordset")
				if rsDeveloper1_bal.state then rsDeveloper1_bal.close
				rsDeveloper1_bal.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' and working_per='" & ass_work_per_bal & "' and del_status='0' order by working_per asc,srno desc",NewConnection
				if rsDeveloper1_bal.eof or rsDeveloper1_bal.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else				
	   %>
					  <tr valign="top" bgcolor="#E6E6E6" class="bottom" >  
						<td class="Tab2"><strong>Developers&nbsp;</strong></td> 
						<td class="Tab2"><strong>Assign Hour</strong></td>     
						<td class="Tab2"><strong>Hour Spent</strong></td>  
						<td class="Tab2"><strong>Balance Hour</strong></td>						
        				<!--td class="Tab2"><strong>Total Cost Per Hr.</strong></td-->
        				  
								
					  </tr>
      <%
					do while not rsDeveloper1_bal.eof							
					
						''''''''''''''''''''' calculating assigned hour '''''''''''''''''''''''''''''''
						if (isnull(rsDeveloper1_bal("work_remark")) or rsDeveloper1_bal("work_remark")="") then						
							if isnull(rsDeveloper1_bal("hourspend")) or rsDeveloper1_bal("hourspend")="" then
								tioaltime_assi = 0
							else							
								tioaltime_assi = round(rsDeveloper1_bal("hourspend"),2)
							end if
							total_hour_assi = round((total_hour_assi + tioaltime_assi),2)
							all_total_cast_assi = all_total_cast_assi + round((tioaltime_assi * Devcost),2)						
							all_total_hour_assi = all_total_hour_assi + tioaltime_assi
						end if
						
						''''''''''''''''''''''' Cal culation spent hour ''''''''''''''''''''''''''''''''''
						
						if (isnull(rsDeveloper1_bal("work_by_mark")) or rsDeveloper1_bal("work_by_mark")="") then						
							if isnull(rsDeveloper1_bal("hourspend")) or rsDeveloper1_bal("hourspend")="" then
								tioaltime_bal = 0
							else							
								tioaltime_bal = round(rsDeveloper1_bal("hourspend"),2)
							end if
							total_hour_bal = round((total_hour_bal + tioaltime_bal),2)
							all_total_cast = all_total_cast + round((tioaltime_bal * Devcost),2)						
							all_total_hour = all_total_hour + tioaltime_bal
						end if	
				rsDeveloper1_bal.movenext
			loop
		%>
			 <tr valign="top" bgcolor="#E6E6E6" class="tb2" >                
				<!--td class='<%'=class1%>'><%'=rsDeveloper("work_by_mark")%>&nbsp;</td-->
				<td class='Tab3'><%=ass_work_per_bal%></td>     
				<td class='Tab3'><%=round(total_hour_assi,2)%>&nbsp;</td>     
				<td class='Tab3'><%=round(total_hour_bal,2)%>&nbsp;</td>  
				<% if(round(total_hour_assi,2) - round(total_hour_bal,2)<0) then %>
				<td class='Tab3' bgcolor="#FF0000"><%=round(total_hour_assi,2) - round(total_hour_bal,2)%>&nbsp;</td> 
				<% else %>
				<td class='Tab3' bgcolor="#00CC00"><%=round(total_hour_assi,2) - round(total_hour_bal,2)%>&nbsp;</td>
				<% end if  %>   
        		<!--td class='Tab3'>&nbsp;<%'=round((total_hour_bal * Devcost),2)%></td-->
				<!--td class='Tab3'><%'=round(Devcost,2)%></td-->             
				<!--td class='<%'=class1%>'><%'=rsDeveloper("work_remark")%>&nbsp;</td-->
			</tr>
		<%	
		end if
	%>
			<!--tr valign="top" bgcolor="#E6E6E6" class="tb2">
				<td class='Tab2' align="right" bgcolor="#CCCCCC">Total&nbsp;</td>
				<td class='Tab2' bgcolor="#CCCCCC"><%'=all_total_hour_assi%>&nbsp;</td>
				<td class='Tab2' bgcolor="#CCCCCC"><%'=all_total_hour%>&nbsp;</td>
				<td class='Tab2' bgcolor="#CCCCCC"><%'=all_total_hour_assi - all_total_hour%>&nbsp;</td>
				<td class='Tab2' bgcolor="#CCCCCC"><%'=all_total_cast%>&nbsp;</td-->
				<!--td class='Tab2' bgcolor="#CCCCCC">&nbsp;</td-->
			<!--/tr-->	
    </table>
	<br>
	
<% ''''''''''''''''''''''''''''''''''''''' end ofhour balance in developer section ''''''''''''''''''''''''''''''''''''''''''''''''' %>

	<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
      <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
        <td colspan="14" class="tdrow5" bgcolor="#CCCCCC"><div align="center"><strong>Task Done/Assigned 
            By Developers/Marketing ...</strong></div></td>
      </tr>
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
				ass_work_per = ass_per(i)
				if rsDeveloper.state then rsDeveloper.close
				'response.Write(ass_work_per)
				rsDeveloper.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' and working_per='" & trim(ass_work_per) & "' order by working_per asc,srno desc",NewConnection
				if rsDeveloper.eof or rsDeveloper.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else				
	   %>
      <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
        <!--td class="Tab2"><strong>SrNo.</strong></td-->
        <td class="Tab2"><strong>Date</strong></td>
        <td class="Tab2"><strong>Assigned by </strong></td>
        <!--td class="Tab2"><strong>Project&nbsp;Type</strong></td-->
        <!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
        <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Assigned&nbsp;&nbsp;Task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td--> 
        <td class="Tab2"><strong>Assigned / Spent Hours</strong></td>
        <td class="Tab2"><strong>To be Submmited&nbsp;by</strong> 
        <td class="Tab2"><strong>&nbsp;Developers</strong></td>
        <!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->
        <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;Task&nbsp;Done&nbsp;by&nbsp;Developer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
        <td class="Tab2"><strong>Task Status</strong></td>
        <td class="Tab2"><strong>&nbsp;</strong></td>
      </tr>
      <%
				do while not rsDeveloper.eof
					
						ddate_us = rsDeveloper("ddate")
						'differ = datediff("d",ddate_us,"03/09/2008")
'						if(differ > 0) then						
'							ddate_In = DateAdd("h", 10, ddate_us)  
'							ddate_india = DateAdd("n", 30, ddate_In) 
'						else
'							ddate_In = DateAdd("h", 9, ddate_us)  
'							ddate_india = DateAdd("n", 30, ddate_In) 
'						end if
						ddate_india = ddate_us
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
        <td class='<%=class1%>'><%=ddate_india%>&nbsp;</td>
        <td class='<%=class1%>'><%=rsDeveloper("asignedby")%>&nbsp;</td>
        <!--td class='<%'=class1%>'><%'=rsDeveloper("type_proj")%>&nbsp;</td-->
        <!--td class='<%'=class1%>'><%'=rsDeveloper("proj_name")%>&nbsp;</td-->
        <%
					work_by_mark = rsDeveloper("work_by_mark")
					work_by_mark_len = len(work_by_mark)
				if(work_by_mark_len>100) then
					work_by_mark_100 = mid(work_by_mark,1,100)
					len_work_by_mark_100 = len(work_by_mark_100)
			%>
        <td class='<%=class1%>'><%=server.HTMLEncode(work_by_mark_100)%>&nbsp;<a href="only_work_by_mark.asp?srno=<%=rsDeveloper("srno")%>&proj_id=<%=rsDeveloper("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
        <%
				else
			%>
        <td class='<%=class1%>'><%=rsDeveloper("work_by_mark")%>&nbsp;</td>
        <%
				end if
			%>
        <!--td class='<%'=class1%>'><%'=rsDeveloper("work_by_mark")%>&nbsp;</td-->
        <td class='<%=class1%>'><%=round(rsDeveloper("hourspend"),2)%>&nbsp;</td>
        <td class='<%=class1%>'><%=rsDeveloper("ur_date")%>&nbsp;</td>
        <td class='<%=class1%>'><%=rsDeveloper("working_per")%>&nbsp;</td>
        <!--td class='<%'=class1%>'><%'=rsDeveloper("cost")%>&nbsp;</td-->
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
        <%
				if isnull(rsDeveloper("work_by_mark")) or rsDeveloper("work_by_mark")="" then
	%>
        <td class='<%=class1%>'>&nbsp;</td>
        <%
				else
					if isnull(rsDeveloper("work_status")) or rsDeveloper("work_status")="" then
	%>
        <td class='<%=class1%>'>&nbsp;</td>
        <%				
					else
						if rsDeveloper("work_status") = 0 then
							if(trim(rsDeveloper("working_per")) = trim(Session("DeveloperName"))) then
	%>
        <td class='<%=class1%>'><font color="#FF0000">Pending&nbsp;&nbsp;<a href="task_reply.asp?h_id=<%=rsDeveloper("srno")%>&refno=<%=refno%>">Reply</a>&nbsp;&nbsp;<a href="#" onClick="confirmform(<%=rsDeveloper("srno")%>,<%=refno%>);"><font color="#FF00FF">Done</font></a></font></td>
        <%
							else
	%>
        <td class='<%=class1%>'>Pending</td>
        <%					
							end if
						else
	%>
        <td class='<%=class1%>'>Done</td>
        <%					
						end if
					end if
				end if
	
				if isnull(rsDeveloper("work_by_mark")) or rsDeveloper("work_by_mark")="" then
					if(trim(rsDeveloper("working_per")) = trim(Session("DeveloperName"))) then
						if rsDeveloper("del_status") = 0 then
						
						%>
        <td class='<%=class1%>'><a href="deleted_resign.asp?h_id=<%=rsDeveloper("srno")%>&refno=<%=refno%>"><font color="#FF0000">Delete</font></a></td>
        <%
						else
	%>
        <td class='<%=class1%>'><a href="#" onClick="MM_openBrWindow('show_resign.asp?srno=<%=rsDeveloper("srno")%>&refno=<%=refno%>','','width=200,height=200')"><strong><font color="#999999"><u>Deleted</u></font></strong></a></td>
        <%
						end if
	     			else
	%>
        <td class='<%=class1%>'>&nbsp;</td>
        <%
					end if
	%>
        <%
				else
	%>
        <td class='<%=class1%>'>&nbsp;</td>
        <%
				end if
	%>
      </tr>
      <%
			rsDeveloper.movenext
			loop
			end if
	%>
      <tr valign="top" bgcolor="#9999CC"> 
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
				rsDeveloper1.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' and working_per='" & ass_work_per & "' order by working_per asc,srno desc",NewConnection
				if rsDeveloper1.eof or rsDeveloper1.bof then
					'Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
				else				
	   %>
      <tr valign="top" bgcolor="#E6E6E6" class="Tab2" >
        <td><strong>Date</strong></td>
        <td><strong>Assigned by </strong></td>
        <td><strong>&nbsp;&nbsp;&nbsp;&nbsp;Assigned&nbsp;&nbsp;Task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong> 
        <td><strong>Assigned / Spent Hours</strong></td>
        <td><strong>To be Submmited by</strong> 
        <td><strong>&nbsp;Developers</strong></td>
        <td><strong>&nbsp;&nbsp;&nbsp;Task&nbsp;Done&nbsp;by&nbsp;Developer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
        <td><strong>Task Status</strong></td>
        <!--td class="Tab2"><strong>SrNo.</strong></td-->
        <!--td class="Tab2"><strong>Project&nbsp;Type</strong></td-->
        <!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
        <!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->
        <td class="Tab2"><strong>&nbsp;</strong></td>
      </tr>
      <%
				do while not rsDeveloper1.eof
						ddate_us1 = rsDeveloper1("ddate")
						'differ = datediff("d",ddate_us1,"03/09/2008")
'						if(differ > 0) then							
'							ddate_In1 = DateAdd("h", 10, ddate_us1)  
'							ddate_india1 = DateAdd("n", 30, ddate_In1)
'						else							
'							ddate_In1 = DateAdd("h", 9, ddate_us1)  
'							ddate_india1 = DateAdd("n", 30, ddate_In1)
'						end if
						ddate_india1 = ddate_us1
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
        <td class='<%=class1%>'><%=ddate_india1%>&nbsp;</td>
        <td class='<%=class1%>'><%=rsDeveloper1("asignedby")%>&nbsp;</td>
        <!--td class='<%'=class1%>'><%'=rsDeveloper1("type_proj")%>&nbsp;</td-->
        <!--td class='<%'=class1%>'><%'=rsDeveloper1("proj_name")%>&nbsp;</td-->
        <%
					work_by_mark1 = rsDeveloper1("work_by_mark")
					work_by_mark1_len = len(work_by_mark1)
				if(work_by_mark1_len>100) then
					work_by_mark1_100 = mid(work_by_mark1,1,100)
					len_work_by_mark1_100 = len(work_by_mark1_100)
			%>
        <td class='<%=class1%>'><%=server.HTMLEncode(work_by_mark1_100)%>&nbsp;<a href="only_work_by_mark.asp?srno=<%=rsDeveloper1("srno")%>&proj_id=<%=rsDeveloper1("proj_name")%>" target="_blank">more...</a>&nbsp;</td>
        <%
				else
			%>
        <td class='<%=class1%>'><%=rsDeveloper1("work_by_mark")%>&nbsp;</td>
        <%
				end if
			%>
        <!--td class='<%'=class1%>'><%'=rsDeveloper1("work_by_mark")%>&nbsp;</td-->
        <td class='<%=class1%>'><%=round(rsDeveloper1("hourspend"),2)%>&nbsp;</td>
        <td class='<%=class1%>'><%=rsDeveloper1("ur_date")%>&nbsp;</td>
        <td class='<%=class1%>'><%=rsDeveloper1("working_per")%>&nbsp;</td>
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
        <%
				if isnull(rsDeveloper1("work_by_mark")) or rsDeveloper1("work_by_mark")="" then
	%>
        <td class='<%=class1%>'>&nbsp;</td>
        <%
				else
					if isnull(rsDeveloper1("work_status")) or rsDeveloper1("work_status")="" then
	%>
        <td class='<%=class1%>'>&nbsp;</td>
        <%				
					else
						if rsDeveloper1("work_status") = 0 then
							if(trim(rsDeveloper1("working_per")) = trim(Session("DeveloperName"))) then
	%>
        <td class='<%=class1%>'><font color="#FF0000">Pending&nbsp;&nbsp;<a href="task_reply.asp?h_id=<%=rsDeveloper1("srno")%>&refno=<%=refno%>">Reply</a>&nbsp;&nbsp;<a href="#" onClick="confirmform(<%=rsDeveloper1("srno")%>,<%=refno%>);"><font color="#FF00FF">Done</font></a></font></td>
        <%
							else
	%>
        <td class='<%=class1%>'>Pending</td>
        <%					
							end if				
						else
	%>
        <td class='<%=class1%>'>Done</td>
        <%					
						end if
					end if
				end if
				if isnull(rsDeveloper1("work_by_mark")) or rsDeveloper1("work_by_mark")="" then
					if(trim(rsDeveloper1("working_per")) = trim(Session("DeveloperName"))) then
						if rsDeveloper1("del_status") = 0 then
						
						%>
        <td class='<%=class1%>'><a href="deleted_resign.asp?h_id=<%=rsDeveloper1("srno")%>&refno=<%=refno%>"><font color="#FF0000">Delete</font></a></td>
        <%
						else
	%>
        <td class='<%=class1%>'><a href="#" onClick="MM_openBrWindow('show_resign.asp?srno=<%=rsDeveloper1("srno")%>&refno=<%=refno%>','','width=200,height=200')"><strong><font color="#999999"><u>Deleted</u></font></strong></a></td>
        <%
						end if
	     			else
	%>
        <td class='<%=class1%>'>&nbsp;</td>
        <%
					end if
	%>
        <%
				else
	%>
        <td class='<%=class1%>'>&nbsp;</td>
        <%
				end if
	%>
      </tr>
      <%
				
			rsDeveloper1.movenext
			loop
			end if		  	
	end if	
	%>
    </table>		
    <br>			  
	<br>
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