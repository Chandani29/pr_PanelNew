<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if
dim ddate
ddate = date()
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
	 <%
	 	call OpenConnection
		refno = request("refno")
		'response.Write(refno)
		'response.Write(Session("DeveloperName"))
		dim rsProject
		set rsProject = server.CreateObject("adodb.recordset")
		rsProject.open "SELECT * from tbl_pr_project where srno='"& refno & "'",NewConnection
		if rsProject.eof or rsProject.bof then
			Response.Write("<strong><font color=red>No Project Found!!</font></strong>")
		else				
	 %>
		    
        <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
            	<td colspan="14" class="tdrow5"><div align="center"><strong>Project 
                Detail ...<%=rsProject("proj_name")%>(<%=rsProject("proj_id")%>) </strong></div></td>
            </tr>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<!--td class="Tab2"><strong>SrNo.</strong></td-->
				<td class="Tab2"><strong>Date</strong></td>				
          		<td class="Tab2"><strong>Asign&nbsp;by </strong></td>
				<td class="Tab2"><strong>Project&nbsp;Type</strong></td>
				<!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
				<td class="Tab2"><strong>Project&nbsp;Description</strong></td>
				<td class="Tab2"><strong>Total&nbsp;Hours</strong></td>				
          		<td class="Tab2"><strong>Submmited&nbsp;on</strong></td>
				<td class="Tab2"><strong>Assign&nbsp;to</strong></td>								
          		<td class="Tab2"><strong>Cost&nbsp;</strong></td>          		
				<td class="Tab2"><strong>Project&nbsp;Remark</strong></td>
				<td class="Tab2"><strong>Trial/Recieved</strong></td>
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
				<td class="Tab3"><%=rsProject("ddate")%></td>
				<td class="Tab3"><%=rsProject("mp_id")%></td>
				<td class="Tab3"><%=rsProject("type_proj")%></td>
				<!--td class="Tab3"><%'=rsProject("proj_name")%></td-->
				<td class="Tab3"><%=rsProject("proj_desc")%></td>
				<td class="Tab3"><%=rsProject("total_hour")%></td>
				<td class="Tab3"><%=rsProject("duration")%></td>
				<td class="Tab3"><%=rsProject("asigned_per")%></td>				
				<td class="Tab3"><%=rsProject("cost")%></td>				
				<td class="Tab3"><%=rsProject("Remark")%></td>
				<td class="Tab3"><%=rsProject("workstatus")%></td>
			</tr>			
		</table>  		
		
		<% end if 
		%>
		<%
			'call OpenConnection
			'refno = request("refno")
			dim rsDeveloper
			set rsDeveloper = server.CreateObject("adodb.recordset")
			rsDeveloper.open "SELECT * from tbl_pr_projDetails where proj_id='"& refno & "' order by srno desc",NewConnection
			if rsDeveloper.eof or rsDeveloper.bof then
				Response.Write("<br><strong><font color=red>No work done !!</font></strong>")
			else				
	   %>
		<br><br>
		<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
            	<td colspan="14" class="tdrow5"><div align="center"><strong>Work Done By Developers ...</strong></div></td>
            </tr>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<!--td class="Tab2"><strong>SrNo.</strong></td-->
				<td class="Tab2"><strong>Date</strong></td>				
          		<td class="Tab2"><strong>Asigned&nbsp;by </strong></td>
				<!--td class="Tab2"><strong>Project&nbsp;Type</strong></td-->
				<!--td class="Tab2"><strong>Project&nbsp;Name</strong></td-->
				<td class="Tab2"><strong>Project&nbsp;Description</strong></td>
				<td class="Tab2"><strong>Hour&nbsp;Spend</strong></td>				
          		<td class="Tab2"><strong>Date&nbsp;</strong></td>
				<td class="Tab2"><strong>Working&nbsp;Person</strong></td>								
          		<!--td class="Tab2"><strong>Cost&nbsp;</strong></td-->          		
				<td class="Tab2"><strong>Task&nbsp;Done</strong></td>
				<!--td class="Tab2"><strong>Status</strong></td-->
			</tr>
		<%
				do while not rsDeveloper.eof	
		%>
			<tr valign="top" bgcolor="#E6E6E6" class="tb2" > 				
				<!--td class="Tab3"><font color='<%'=coror1%>'><%'=rsDeveloper("srno")%></font></td-->
				<td class="Tab3"><%=rsDeveloper("ddate")%></td>
				<td class="Tab3"><%=rsDeveloper("asignedby")%></td>
				<!--td class="Tab3"><%'=rsDeveloper("type_proj")%></td-->
				<!--td class="Tab3"><%'=rsDeveloper("proj_name")%></td-->
				<td class="Tab3"><%=rsDeveloper("work_by_mark")%></td>
				<td class="Tab3"><%=rsDeveloper("hourspend")%></td>
				<td class="Tab3"><%=rsDeveloper("ddate")%></td>
				<td class="Tab3"><%=rsDeveloper("working_per")%></td>				
				<!--td class="Tab3"><%'=rsDeveloper("cost")%></td-->				
				<td class="Tab3"><%=rsDeveloper("work_remark")%></td>
				<!--td class="Tab3"><%'=rsDeveloper("workstatus")%></td-->
			</tr>
	<%
			rsDeveloper.movenext
			loop
			end if
	%>					
		</table>
		<br><br>
	<form action="developer_entry_cal.asp" method="post" name="form1"> 
		<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<td colspan="4" align="center" class="Tab2">Add New Work.....</td>				
			</tr>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<td colspan="2" align="center" class="Tab2">&nbsp;Date</td>
				<td colspan="2" class="Tab3"> <font color="#FF0000">&nbsp; 
				  <input name="txt_date" type="text" id="txt_date" size="20" value="<%=Date()%>" readonly>
				  </font></td>
			</tr>
			<tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<td colspan="2" align="center" class="Tab2">Total Hr. Spend </td>
				<td colspan="2" class="Tab3"> <font color="#FF0000">&nbsp; 
				  <input name="txt_ths" type="text" id="txt_ths" size="20">
				  </font></td>
			  </tr>
			  <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
				<td colspan="2" align="center" class="Tab2">Project Remark</td>
				<td colspan="2" class="Tab3"><font color="#FF0000">&nbsp; 
				  <textarea name="txt_remark" id="txt_remark"></textarea>
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
	<br><br><br>	     
<tr><td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--><p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site Empowered by AKS India Web Solutions </font></strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">.</font></p>
      </td>
  </tr></div></table>
<p>&nbsp;</p></body>
</html>