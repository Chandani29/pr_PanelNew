<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480 ' in min
Server.ScriptTimeout=2400 'in sec
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if
session("ErrorMessage")=""
dim ddate
ddate = now()
%>
<html>
<head>
<title>Marketing Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style_mr {
 background-color: #FF0000;
}
-->
</style>
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" media="all" href="calender/calendar-win2k-2.css" title="win2k-cold-1" />
<script type="text/javascript" src="calender/calendar.js"></script>
<script type="text/javascript" src="calender/calendar-en.js"></script>
<script type="text/javascript" src="calender/calendar-setup.js"></script>

<script language="JavaScript">
//function hello(var i)
//{
  //var input=document.getElementById('dd_workstatus').value.toLowerCase();
  //alert(<%=i%>);
  //var output=document.getElementById(name1).options;
  //var output1=document.frm_report.name1.value;
  //alert(output1);
  //for(var i=0;i<output.length;i++)
 //  {
    	//if(output[i].value.indexOf(input)==0)
		//{
      //		output[i].selected=true;
      //	}
    //	if(document.frm_report.dd_workstatus1.value=='')
		//{
      //		output[0].selected=true;
      //	}
 // }
 
 //function Controls()
 // {
              //alert( document.frm_report.cboType[document.frm_report.cboType.selectedIndex].value );
//  }

// it is working
function MM_openBrWindow(theURL,winName,features)
{ //v2.0
  window.open(theURL,winName,features);
}
function Controls(obj)
{
    var dd_status = obj[obj.selectedIndex].value;	
	//alert(dd_status);
	//alert(dd_status.indexOf('_'));	
	var dd_value = dd_status.substring(0,dd_status.indexOf('_'))
	//alert(dd_value);
		
	if(dd_value=="Dead")
	{
		window.location = "delete_status.asp?srno=" + dd_status;
		
	}
	if(dd_value=="Completed")
	{
		
			window.location = "complete_status.asp?srno=" + dd_status;
			//var url1 = "update_status.asp?srno=" + dd_status
			//MM_openBrWindow(url1,'','width=400,height=400')		
		
	}
	if(dd_value=="Received")
	{
		//var answer = confirm("are you sure!!")
		//if (answer)
		//{
			//alert("Bye bye!")
			//window.location = "http://www.google.com/";
			//var url1 = "update_status.asp?srno=" + dd_status
		//	MM_openBrWindow(url1,'','width=400,height=400')
			
			window.location = "trial_status.asp?srno=" + dd_status;
			
			
		//}
		//else
		//{
		//	window.location = "project_report_selected.asp";
		//}		
	}
		
	//var url1 = "update_status.asp?srno=" + dd_status
	//alert(url1);
	//MM_openBrWindow(url1,'','width=400,height=400')
	//alert(dd_status);
}
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
function checkdate3()
{
	if(document.form4.text_date_from24.value=="")
	{
		alert("select date......");
		document.form4.text_date_from24.focus();
		return false;
	}	
	else if(document.form4.text_date_to24.value=="")
	{
		alert("select date......");
		document.form4.text_date_to24.focus();
		return false;
	}
	else
	{
		return true;
	}
}
</script>
<style type="text/css">
<!--
.style1 {color: #33FFFF}
-->
</style>
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="140" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
	<br>
	<table width="900" height="83" border="0" cellpadding="1" cellspacing="0">
              <tr> 
                <td width="18" height="21" align="center" bgcolor="#E6E6E6">&nbsp;</td>
			    <td width="882" align="center" bgcolor="#E6E6E6">
	              <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
	  <tr>
		<td class="Tab3" align="left"><a href="mr_reminder.asp" target="_blank"><font color="#0000FF"><b>Add New Reminder</b></font></td>
		<td class="Tab3" align="right"><a href="view_reminder.asp" target="_blank"><font color="#0000FF"><b>View Done Reminder</b></font></td>
	  </tr>
	</table>
				</td>
              </tr>	
	<%
	 	call OpenConnection
		dim rsREminder
		set rsREminder = server.CreateObject("adodb.recordset")
		rsREminder.open "SELECT * from tbl_pr_mpreminder where re_status='No' and mp_id='"& trim(session("MarketingName")) & "'",NewConnection
		if rsREminder.eof or rsREminder.bof then		
		else		
	%>
               <tr> 
                <td align="center" bgcolor="#E6E6E6">&nbsp;</td>
                <td align="center">
					<table width="100%" height="25" border="1" cellpadding="1" cellspacing="1">
                      <tr>
                        <td colspan="4" align="center" bgcolor="#666666"><strong class="Tab2 style1">REMINDER PANEL </strong></td>
                      </tr>
                      <tr>
                        <td width="13%" align="center" bgcolor="#CCCCCC"><strong class="Tab2">Subject </strong></td>
                        <td width="55%" align="center" bgcolor="#CCCCCC"><strong class="Tab2">Description </strong></td>
                        <td width="13%" align="center" bgcolor="#CCCCCC"><strong class="Tab2">Date </strong></td>
                        <td width="11%" align="center" bgcolor="#CCCCCC"><strong class="Tab2">Status </strong></td>
                      </tr>
                      <%		
		do while not rsREminder.eof	
		're_date = ""
		'i=0
		i = datediff("d",date(),rsREminder("re_date"))
		if(int(i)>-1) then
			if(int(i)=0) then
			   re_date = "<font color='#000000' class='style_mr'>" & rsREminder("re_date") & "</font>"
			end if
			if(int(i)=1) then
				re_date = "<font color='#FF0000'>" & rsREminder("re_date") & "</font>"
			end if
			if(int(i)=2) then
				re_date = "<font color='#FF00FF'>" & rsREminder("re_date") & "</font>"
			end if
			if(int(i)>2) then
			   re_date = rsREminder("re_date")
			end if			
		else
			re_date = "<font color='#FF0000'><b>" & rsREminder("re_date") & "</b></font>"
		end if	
		'response.Write(i)	
        %>
			  <tr>
				<td width="13%" align="center" bgcolor="#E6E6E6" class="Tab3"><%=rsREminder("re_sub")%></td>
		 <%
			remin_desc = rsREminder("re_desc")
			remin_len = len(remin_desc)
			if(remin_len>70) then
			remin_100 = mid(remin_desc,1,70)
			remin_len_100 = len(remin_100)
	     %>
          <td width="55%" align="center" bgcolor="#E6E6E6" class="Tab3"><%=remin_100%>&nbsp;<a href="only_reminder_desc.asp?srno=<%=rsREminder("srno")%>" target="_blank">more...</a>&nbsp;</td>
          <%
			else
	      %>
          <td width="13%" align="center" bgcolor="#E6E6E6" class="Tab3"><%=rsREminder("re_desc")%></td>
          <%
			end if
		  %>                        
		<td width="11%" align="center" bgcolor="#E6E6E6" class="Tab3"><%=re_date%></td>
		<td width="8%" align="center" bgcolor="#E6E6E6" class="Tab3"><a href="mr_reminder_done.asp?srno=<%=rsREminder("srno")%>" target="_blank"><font color="#0000FF">Pending</font></a></td>
	  </tr>
	    <% 
		rsREminder.movenext
		loop
		%>
		</table>
		</td>
		</tr>
		<%
		end if 
		%>                  
      </table>
	  <p>
	  <%
	 	call OpenConnection
		dim rsCount
		set rsCount = server.CreateObject("adodb.recordset")
		rsCount.open "SELECT count(*) as count1 from tbl_pr_project where mp_id='"& trim(session("MarketingName")) & "'",NewConnection
		count1 = rsCount("count1")
		count2 = rsCount("count1")
		dim rsProject
		set rsProject = server.CreateObject("adodb.recordset")
		rsProject.open "SELECT * from tbl_pr_project where mp_id='"& trim(session("MarketingName")) & "' and (workstatus='Received' or workstatus='Trial Project') order by srNo desc",NewConnection
		if rsProject.eof or rsProject.bof then
	%>
        </p>
	  <form name="form4" method="post" action="datewise_payment_received.asp" onSubmit="return checkdate3()">
      <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="center"><table width="500" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
              <tr> 
                <td align="center"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td align="center" bgcolor="#E7C84E"><strong class="Tab2">Received 
                        Payment</strong><strong class="Tab3"> </strong></td>
                      <td align="center"><strong class="Tab2">From 
                        <input name="text_date_from24" id="text_date_from24" type="text" class="Tab2" size="15" readonly>
                        <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("text_date_from24");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"text_date_from24", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                        to 
                        <input name="text_date_to24" id="text_date_to24" type="text" class="Tab2" size="15" readonly>
                        <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("text_date_to24");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"text_date_to24", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                        </strong><strong class="Tab3"> 
                        <input name="Submit3" type="submit" class="Tab2" value="Search">
                        </strong></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td width="571" align="center"><form name="form2" method="post" action="datewise_project_report_selected.asp" onSubmit="return checkdate1()">
            <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
              <tr> 
                <td align="center"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td align="center">&nbsp; <select name="select_type" class="Tab2" >
                          <option value="Received">Received</option>
                          <option value="Completed">Completed</option>
                          <option value="Trial Project">Trial Project</option>
                          <option value="Dead">Dead</option>
                          <option value="All">All</option>
                          <option value="none" selected>Select Project Status</option>
                        </select> <strong class="Tab2">From 
                        <input name="text_date_from" id="text_date_from" type="text" class="Tab2" size="15" readonly>
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
                        <input name="text_date_to" id="text_date_to" type="text" class="Tab2" size="15" readonly>
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
        <td width="409"><form name="form3" method="post" action="datewise_project_report_selected.asp" onSubmit="return checkdate2()">
            <table width="100%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#CCCC00">
              <tr> 
                <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td><strong class="Tab2">Search By </strong> <select name="select2_type" class="Tab2">
                          <option value="Project Name">Project Name</option>
                          <option value="Project ID"s selected>Project ID</option>                          
                        </select> <input name="text_type" type="text" class="Tab2" size="20"> 
                        <input name="Submit2" type="submit" class="Tab2" value="Search"> 
                      </td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            
          </form></td>
      </tr>
    </table>
	<table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" class="tdrow3">
          
        <td colspan="16" class="tdrow5"><strong><a href="marketing_entry.asp?count2=<%=count2%>"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Add 
          New Project</font></a> &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#desinger"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Designper/Developer 
          List</font></a> &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#activities"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">All 
          Activities</font></a> &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="pending_list.asp" target="_blank"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Pending 
          List</font></a></strong></td>
        </tr>
	</table>	
	<p>
      <%		
			Response.Write("<strong><font color=red>No Record Found!!</font></strong>")
		else
		''''''''''''''''''''''''' upper table ''''''''''''''''''''''''''''''''''''				
	 %>
    </p>
      <form name="form4" method="post" action="datewise_payment_received.asp" onSubmit="return checkdate3()">
      <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="center"><table width="500" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
              <tr> 
                <td align="center"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td align="center" bgcolor="#E7C84E"><strong class="Tab2">Received 
                        Payment</strong><strong class="Tab3"> </strong></td>
                      <td align="center"><strong class="Tab2">From 
                        <input name="text_date_from24" id="text_date_from24" type="text" class="Tab2" size="15" readonly>
                        <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("text_date_from24");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"text_date_from24", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                        to 
                        <input name="text_date_to24" id="text_date_to24" type="text" class="Tab2" size="15" readonly>
                        <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("text_date_to24");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"text_date_to24", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
                        </strong><strong class="Tab3"> 
                        <input name="Submit3" type="submit" class="Tab2" value="Search">
                        </strong></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </form>
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        <td width="571" align="center"><form name="form2" method="post" action="datewise_project_report_selected.asp" onSubmit="return checkdate1()">
            <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
              <tr> 
                <td align="center"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td align="center">&nbsp; <select name="select_type" class="Tab2" >
                          <option value="Received">Received</option>
                          <option value="Completed">Completed</option>
                          <option value="Trial Project">Trial Project</option>
                          <option value="Dead">Dead</option>
                          <option value="All">All</option>
                          <option value="none" selected>Select Project Status</option>
                        </select> <strong class="Tab2">From 
                        <input name="text_date_from" id="text_date_from" type="text" class="Tab2" size="15" readonly>
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
                        <input name="text_date_to" id="text_date_to" type="text" class="Tab2" size="15" readonly>
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
        <td width="409"><form name="form3" method="post" action="datewise_project_report_selected.asp" onSubmit="return checkdate2()">
            <table width="100%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#CCCC00">
              <tr> 
                <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td><strong class="Tab2">Search By </strong> <select name="select2_type" class="Tab2">
                          <option value="Project Name">Project Name</option>
                          <option value="Project ID"s selected>Project ID</option>                          
                        </select> <input name="text_type" type="text" class="Tab2" size="20"> 
                        <input name="Submit2" type="submit" class="Tab2" value="Search"> 
                      </td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            
          </form></td>
      </tr>
    </table>
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center"><form action="market_entry_cal.asp" method="post" name="frm_report">
        <tr valign="top" class="tdrow3">
          <td colspan="18" class="tdrow5"><strong><a href="marketing_entry.asp?count2=<%=count2%>"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Add 
            New Project</font></a> &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#desinger"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Designper/Developer 
            List</font></a> &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#activities"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">All 
            Activities</font></a>&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="pending_list.asp" target="_blank"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Pending 
          List</font></a></strong></td>
        </tr>
        <tr valign="top" class="tdrow3"> 
          <td colspan="18" align="center" bgcolor="#CCCCCC" class="tdrow5"><div align="center"><strong>Project 
              Summary</strong></div></td>
        </tr>
        <tr valign="top" class="bottom" > 
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Project Id&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Date</strong></td>
          <!--td class="Tab2"><strong>Person&nbsp;Id </strong></td-->
		  <td bgcolor="#E6E6E6" class="Tab2"><strong>Project Source</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Project Type</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Project&nbsp;Name</strong></td>          
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Total Hours</strong></td>
          <!--td bgcolor="#E6E6E6" class="Tab2"><strong>Hours Spent</strong></td-->
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Balance Hour </strong></td>
		  <td bgcolor="#E6E6E6" class="Tab2"><strong>Cost</strong></td>
		  <!--td bgcolor="#E6E6E6" class="Tab2"><strong>Dev. Cost</strong></td-->
		  <!--td bgcolor="#E6E6E6" class="Tab2"><strong>Expenses</strong></td-->
		  <td bgcolor="#E6E6E6" class="Tab2"><strong>Bal.&nbsp;Cost</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Delivery date</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Assigned to</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Payment Received</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Payment Type</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Completed&nbsp;On</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;client&nbsp;Remarks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
          <td bgcolor="#E6E6E6" class="Tab2"><strong>Project Expenses</strong></td>
		  <td bgcolor="#E6E6E6" class="Tab2"><strong>Project&nbsp;Status</strong></td>
        </tr>
        <%
			dim i
			i=1
			dim all_total_cast_upper
			dim total_bal_cost_sub
			dim total_bal_cost_dev_sub
			total_bal_cost_sub = 0
			total_bal_cost_dev_sub = 0
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
						all_total_cast_upper = 0
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
				total_id = trim(mid(Session("pr_username"),3)) & "-" & trim(count1) & "-" & trim(rsProject("srno"))
	%>
        <tr valign="top" class="tb2" > 
		<% if(trim(rsProject("type_proj"))="InHouse") then %>
		<td bgcolor="#E6E6E6" class="Tab3"><a href="project_Details_selected_Inhouse.asp?refno=<%=rsProject("srno")%>&total_id=<%=rsProject("proj_id")%>" target="_blank"><font color='<%=coror1%>'><%=rsProject("proj_id")%></font></a><br><br><a href="project_client_details.asp?refno=<%=rsProject("srno")%>" target="_blank"><font color='<%=coror1%>'>Clients</font></a></td>
		<% else %>
		<td bgcolor="#E6E6E6" class="Tab3"><a href="project_Details_selected.asp?refno=<%=rsProject("srno")%>&total_id=<%=rsProject("proj_id")%>" target="_blank"><font color='<%=coror1%>'><%=rsProject("proj_id")%></font></a><br><br><a href="project_client_details.asp?refno=<%=rsProject("srno")%>" target="_blank"><font color='<%=coror1%>'>Clients</font></a></td>
		<% end if %>          
          <td bgcolor="#E6E6E6" class="Tab3"><%=ddate_india2%>&nbsp;</td>
          <!--td class="Tab3"><%'=rsProject("mp_id")%></td-->
		   <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("proj_source")%>&nbsp;</td>
          <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("type_proj")%>&nbsp;</td>
      <% if(trim(rsProject("type_proj"))="InHouse") then %>  
		  <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("proj_name")%>&nbsp;<br><strong><a href="add_inhouse_proj.asp?srno=<%=rsProject("srno")%>">Add New</a></strong></td>
	  <% else %>
	  		<% if(rsProject("workstatus")="Received") then %>
			<td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("proj_name")%><br>&nbsp;&nbsp;<strong><a href="extend_proj.asp?srno=<%=rsProject("srno")%>&p=A">Ext.</a>&nbsp;&nbsp;&nbsp;<a href="reduce_proj.asp?srno=<%=rsProject("srno")%>&p=S">Red.</a></strong></td>
			<% else %>	
	  	  <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("proj_name")%></td>
	  		<% end if %>
	  <% end if %>	  
          
          <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("total_hour")%>&nbsp;</td>
          <%
				hour_exp =0
				dim rsProjectDetails
				set rsProjectDetails = server.CreateObject("adodb.recordset")
				rsProjectDetails.open "SELECT hourspend,work_by_mark from tbl_pr_projDetails where proj_id='" & rsProject("srno") &"' and del_status='0'",NewConnection
				if rsProjectDetails.eof or rsProjectDetails.bof then
					hour_exp = 0
				else
					do while not rsProjectDetails.eof
						if(isnull(rsProjectDetails("work_by_mark")) or rsProjectDetails("work_by_mark")="") then
							hour_exp = hour_exp + round(rsProjectDetails("hourspend"),2)
						end if
					rsProjectDetails.movenext
					loop
				end if
				total_hour = round((total_hour + rsProject("total_hour")),2)
				total_hour_ex = round((total_hour_ex + hour_exp),2)
				if isnull(rsProject("cost")) or rsProject("cost")="" then
					cost=0
				else
					cost = rsProject("cost")
				end if
				total_cost = total_cost + cost
				
				if isnull(rsProject("payment_received")) or rsProject("payment_received")="" then
					payment_received=0
				else
					payment_received = rsProject("payment_received")
				end if
					total_pay_rec = total_pay_rec + payment_received		
	
	%>
          <!--td bgcolor="#E6E6E6" class="Tab3"><%'=round(hour_exp,2)%>&nbsp;</td-->		  
          <td bgcolor="#E6E6E6" class="Tab3"><%=round((rsProject("total_hour") - hour_exp),2)%>&nbsp;</td>
		  <td align="right" bgcolor="#E6E6E6" class="Tab3"><%=rsProject("cost")%>&nbsp;</td>
	<% 
			''''''''''''''''''''''''''''''''' calculating balance cost ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			assigned_per_all_upper = rsProject("asigned_per")
		assigned_per_all_bal_upper = instr(assigned_per_all_upper,",")
	if(assigned_per_all_bal_upper > 0) then
				a="more"
			dim rsDeveloper_bal_upper
			set rsDeveloper_bal_upper = server.CreateObject("adodb.recordset")
			dim ass_work_per_bal_upper			
			alpha_bal_upper = rsProject("asigned_per")
			ass_per_bal_upper=split(alpha_bal_upper,",")
			ass_limit_bal_upper = ubound(ass_per_bal_upper)
			ass_work_per_bal_upper = ""		
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
				ass_work_per_bal_upper = ""				
				a="single"			
				ass_work_per_bal_upper = rsProject("asigned_per")
				total_hour_bal_upper = 0
				total_cost_bal_upper = 0
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
	'''''''''''''''''''''''' end of balance calculation ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'''''''''''''''''''''''''''''''''''''''''''' calculating expense cost '''''''''''''''''''''''''''''''''''''''''''''''''
	set rsexpenses_up = server.CreateObject("adodb.recordset")
			sqlexp_up = "select sum(proj_exp_cost) as sum_exp from tbl_pr_expenses where proj_id='"& rsProject("srno") & "'"
			set rsexpenses_up= NewConnection.execute(sqlexp_up)
			if isnull(rsexpenses_up("sum_exp")) then
				sum_expenses_up = 0 
			else
				sum_expenses_up = round(rsexpenses_up("sum_exp"),2)
			end if
			total_expenses_up = round((total_expenses_up + sum_expenses_up),2)		
			
	''''''''''''''''''''''''''''''''''''''''''''end of expenses''''''''''''''''''''''''''''''''''''''''''''''''
	
				total_bal_cost_dev_sub = round((total_bal_cost_dev_sub + round((rsProject("cost") - all_total_cast_upper),2)),2)
				total_bal_cost_sub = round((total_bal_cost_sub + all_total_cast_upper),2)
	%>	  
		 		<!--td align="right" bgcolor="#CCCCCC" class="Tab2"><%'=all_total_cast_upper%>&nbsp;</td--> 
				<!--td align="right" class="Tab2"><%'=round(sum_expenses_up,2)%>&nbsp;</td-->
		  		<% if (round((rsProject("cost") - sum_expenses_up - all_total_cast_upper),2) < 0 ) then %>
						<% if (round(all_total_cast_upper - (rsProject("cost") - sum_expenses_up),2) < (all_total_cast_upper - (all_total_cast_upper - (all_total_cast_upper * 20/100))) ) then %>
				<td align="right" bgcolor="yellow" class="Tab2"><%=round((rsProject("cost") - sum_expenses_up - all_total_cast_upper),2) %>&nbsp;</td>
						<% else %>		
				<td align="right" bgcolor="red" class="Tab2"><%=round((rsProject("cost") - sum_expenses_up - all_total_cast_upper),2)%>&nbsp;</td>						
						<% end if %>
				<% else %>
				<td align="right" bgcolor="#25B311" class="Tab2"><%=round((rsProject("cost") - sum_expenses_up - all_total_cast_upper),2)%>&nbsp;</td>
				<% end if %>
          <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("submeted_on")%>&nbsp;</td>
          <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("asigned_per")%>&nbsp;<strong><a href="add_new_dev.asp?srno=<%=rsProject("srno")%>&proj_id=<%=rsProject("proj_id")%>"><font color="#0000FF"><br>Add&nbsp;New</font></a></strong></td>
          <%
			proj_desc = rsProject("proj_desc")
			desc_len = len(proj_desc)
			if(desc_len>100) then
			desc_100 = mid(proj_desc,1,100)
			len_100 = len(desc_100)
	       %>
          <td bgcolor="#E6E6E6" class="Tab3"><%=desc_100%>&nbsp;<a href="only_Proj_desc.asp?srno=<%=rsProject("srno")%>&proj_id=<%=rsProject("proj_id")%>" target="_blank">more...</a>&nbsp;</td>
          <%
			else
	      %>
          <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("proj_desc")%>&nbsp;</td>
          <%
			end if
		  '''''''''''''''''''''''''''''''''' partial payment calculation ''''''''''''''''''''''''''''''''''''
		  set rsPartPay = server.CreateObject("adodb.recordset")
			strsql = "select sum(p_payment) as sum_pay from tbl_pr_partial_payment where proj_id='"& rsProject("srno") & "'"
			set rsPartPay= NewConnection.execute(strsql)
			if isnull(rsPartPay("sum_pay")) then
				sum_payment = 0 
			else
				sum_payment = round(rsPartPay("sum_pay"),2)
			end if
			total_payment_received = round((total_payment_received + sum_payment),2)
			
			''''''''''''''''''''''''''''''''''' end of partial payment calculation ''''''''''''''
		%>	
		 <td align="right" bgcolor="#E6E6E6" class="Tab3"><%=sum_payment%>&nbsp;
		 <% if(rsProject("workstatus")="Received") then %>
		 	<br><strong><a href="partial_payment.asp?srno=<%=rsProject("srno")%>">Part.&nbsp;Pay.</a></strong>
		 <% end if %>
		 <% if(rsProject("workstatus")="Completed") then %>
		 	<br><strong><a href="payment_history.asp?srno=<%=rsProject("srno")%>">P.&nbsp;History</a></strong>
		 <% end if %>
		  </td>
          <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("payment_Type")%>&nbsp;</td>
		  <%
		  					ddate_us12 = rsProject("completed_on")
							'differ = datediff("d",ddate_us12,"03/09/2008")
'							if(differ > 0) then
'								ddate_In12 = DateAdd("h", 10, ddate_us12)  
'								ddate_india12 = DateAdd("n", 30, ddate_In12)
'							else
'								ddate_In12 = DateAdd("h", 9, ddate_us12)  
'								ddate_india12 = DateAdd("n", 30, ddate_In12)
'							end if
							ddate_india12 = ddate_us12
							
		  %>
          <td bgcolor="#E6E6E6" class="Tab3"><%'=rsProject("completed_on")%><%=ddate_india12%>&nbsp;</td>
          <%
			proj_Remark = rsProject("Remark")
			Remark_len = len(proj_Remark)
			if (Remark_len>100) then
				Remark_100 = mid(proj_Remark,1,100)
				Remarklen_100 = len(Remark_100)
		%>
          <td bgcolor="#E6E6E6" class="Tab3"><%=Remark_100%>&nbsp;<a href="only_proj_remark.asp?srno=<%=rsProject("srno")%>&proj_id=<%=rsProject("proj_id")%>" target="_blank">more...</a>&nbsp;</td>
          <%
			else
		%>
          <td bgcolor="#E6E6E6" class="Tab3"><%=rsProject("Remark")%>&nbsp;</td>
          <%
			end if
			'''''''''''''''''''''''' project expenses ''''''''''''''''''''''''
			set rsexpenses = server.CreateObject("adodb.recordset")
			sqlexp = "select sum(proj_exp_cost) as sum_exp from tbl_pr_expenses where proj_id='"& rsProject("srno") & "'"
			set rsexpenses= NewConnection.execute(sqlexp)
			if isnull(rsexpenses("sum_exp")) then
				sum_expenses = 0 
			else
				sum_expenses = round(rsexpenses("sum_exp"),2)
			end if
			total_expenses = round((total_expenses + sum_expenses),2)		
		%>
		<% if(rsProject("workstatus")="Received" or rsProject("workstatus")="Trial Project") then %>
		 <td bgcolor="#E6E6E6" class="Tab3" align="right"><%=sum_expenses%><br><a href="proj_expenses.asp?srno=<%=rsProject("srno")%>"><strong>Expense</strong></a>&nbsp;</td>
		 <% else %>
		 <td bgcolor="#E6E6E6" class="Tab3" align="right"><%=sum_expenses%><br><a href="proj_expenses_history.asp?srno=<%=rsProject("srno")%>"><strong>History</strong></a>&nbsp;</td>
		 <% end if %>
		 <%
		 	''''''''''''''''''''''''''''' end of expense '''''''''''''''''''''
		 %>
          <%	if trim(rsProject("workstatus"))="Dead" then %>
          <td bgcolor="#E6E6E6" class="txt"><%=rsProject("workstatus")%></td>
          <%  end if %>
          <%	if trim(rsProject("workstatus"))="Completed" then %>
          <td bgcolor="#E6E6E6" class="txtgreen"><%=rsProject("workstatus")%></td>
          <%  end if %>
          <%	if trim(rsProject("workstatus"))="Received" then %>
          <td bgcolor="#E6E6E6" class="Tab3"> <select name="dd_workstatus" id="dd_workstatus<%=rsProject("srno")%>" onChange="Controls(this);">
              <option value='<%=rsProject("workstatus") & "_" & rsProject("srno")%>' selected><%=rsProject("workstatus")%></option>
              <option value='Completed_<%=rsProject("srno")%>'>Completed</option>
              <option value='Dead_<%=rsProject("srno")%>'>Dead</option>
            </select> </td>
          <%  end if %>
          <%	if trim(rsProject("workstatus"))="Trial Project" then %>
          <td bgcolor="#E6E6E6" class="Tab3"> <select name="dd_workstatus" id="dd_workstatus<%=rsProject("srno")%>" onChange="Controls(this);">
              <option value='<%=rsProject("workstatus") & "_" & rsProject("srno")%>' selected><%=rsProject("workstatus")%></option>
              <option value='Dead_<%=rsProject("srno")%>'>Dead</option>
              <option value='Received_<%=rsProject("srno")%>' >Received</option>
            </select> </td>
          <%  end if %>
        </tr>
        <%
					rsProject.movenext
					count1 = count1 - 1
					i=i+1
				loop
		%>
        <tr valign="top" class="tb2" > 
          <td colspan="5" align="right" bgcolor="#E6E6E6" class="Tab2"><strong>Total</strong></td>
          <td  align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=round(total_hour,2)%></strong></td>
          <!--td  align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%'=round(total_hour_ex,2)%></strong></td-->
          <td  align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=round((total_hour - total_hour_ex),2)%></strong></td>
          <td  align="right" bgcolor="#E6E6E6" class="Tab2"><%=total_cost%></td>
		  <!--td align="right" bgcolor="#E6E6E6" class="Tab2"><%'=round(total_bal_cost_sub,2)%>&nbsp;</td-->
		  <!--td align="right" bgcolor="#E6E6E6" class="Tab2"><%'=round(total_bal_cost_dev_sub,2)%>&nbsp;</td-->
		  <td colspan="4" align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;Total</td>          
          <td align="right" bgcolor="#E6E6E6" class="Tab2"><%'=total_pay_rec%><%=total_payment_received%>&nbsp;</td>
          <td colspan="2" align="left" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>
		  <td align="right" bgcolor="#E6E6E6" class="Tab2">Total</td>
		  <td align="right" bgcolor="#E6E6E6" class="Tab2"><%=total_expenses%>&nbsp;</td>
		  <td align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>		  
        </tr></form>
      </table>  	  
		
		
    <% 
		'''''''''''''''''''''''''' end of upper table ''''''''''''''''''''''''''''''''''''''''''''
		end if 
	%>
    <br> 
	
	<% '''''''''''''''' lower two tables ''''''''''''''''''''' %>
	
		 <table width="550" border="1" cellpadding="3" cellspacing="1" class="Tab2">
		  		<tr valign="top" bgcolor="#E6E6E6" class="tb2" >	
					<td class="Tab2" colspan="15" align="left" bgcolor="#CCCCCC"><div align="center"><a name="desinger"></a>Designers/Developers 
            ::</div></td>
			<td class="Tab2" colspan="15" align="left" bgcolor="#CCCCCC"><div align="center"><a name="desinger"></a>Cost (INR Per Hr)
            ::</div></td>
				</tr>
		<%	
			dim rsDevelopers
				set rsDevelopers = server.CreateObject("adodb.recordset")
				rsDevelopers.open "select * from tbl_pr_developerLogin order by name",NewConnection
				if rsDevelopers.eof or rsDevelopers.bof then
					
				else
					do while not rsDevelopers.eof
		%>				
						<tr valign="top" bgcolor="#E6E6E6" class="tb2">							
        <td class="Tab2" colspan="15" align="left"><a href='pending_dv_details.asp?dv_name=<%=rsDevelopers("name")%>' target="_blank"><%=rsDevelopers("name")%></a></td>
		<td class="Tab2" colspan="15" align="center"><%=rsDevelopers("per_cost")%></td>
						</tr>			
		<%				
					rsDevelopers.movenext
					loop
				end if
		%>          
        
		 </table>
		 <form name="form1" ACTION="daily_work.asp" Method="post" onSubmit="return checkLogin()">
      <table width="550" border="1" cellpadding="3" cellspacing="1" class="Tab2">
        <tr valign="top" bgcolor="#999999" class="bottom" > 
          <td height="20" bgcolor="#CCCCCC" class="Tab2"><div align="center"><a name="activities" id="activities"></a>All 
              Activities :: </div></tr>
        <tr valign="top" class="bottom" > 
          <td height="40" align="center" class="Tab2"> <p align="left"><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b> 
              From</b></font><b><font color="#ffffff"> 
              <input name="txt_dateFrom" size="20" type="text" id="txt_dateFrom" readonly>
              <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("txt_dateFrom");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"txt_dateFrom", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
              </font></b><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>To</b></font><b><font color="#ffffff">
              <input type="text" name="txt_dateTo" id="txt_dateTo" size="20" readonly>
              <script type="text/javascript">
							function catcalc(cal)
							{
								var date = cal.date;
								var time = date.getTime()
								var field = document.getElementById("txt_dateTo");
								var date2 = new Date(time);
								field.value = date2.print("%m/%d/%Y");
							}
							Calendar.setup({inputField:"txt_dateTo", ifFormat:"%m/%d/%Y", onUpdate:catcalc});
						</script>
              </font></b> 
              <input name="Search" type="submit"  value="Search" class="Tab2" style="WIDTH: 150px;">            
        </tr>
      </table>
</form>	  
	   <br>
	   <% '''''''''''''''''''''''' end of lower two tables ''''''''''''''''''''''''''''''''''''''' %>		   
<tr><td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--><p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site Empowered by AKS India Web Solutions </font></strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">.</font></p>
      </td>
  </tr></div></table>
  <% call closeconnection %>
<p>&nbsp;</p></body>
</html>