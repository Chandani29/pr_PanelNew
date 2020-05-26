<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
if Session("admin")="" then
	response.Redirect("index.asp")
end if
session("ErrorMessage")=""
dim ddate
ddate = now()
dim z
z=0
text_date_from = request("text_date_from24")
txt_date_From1 = dateadd("d",-1,text_date_from)
txt_date_From1 = txt_date_From1 & " " & "13:30:00.000"
'response.Write(txt_date_From1)
text_date_to = request("text_date_to24")
txt_date_To1 = dateadd("d",0,text_date_to)
txt_date_To1 = txt_date_To1 & " " & "13:30:00.000"
'response.Write(txt_date_To1)
%>

<html>
<head>
<title>Marketing Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="140" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="32%" height="78" background="images/top-bg.jpg"> <div align="left"> 
            <img src="images/index_01.jpg" width="385" height="78"><br>
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
                    <strong>Admin</strong></font></div></td>
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
      <%        ''''''''''''''''''''''''' upper table ''''''''''''''''''''''''''''''''''''		%>    
	<form name="form4" method="post" action="datewise_pay_received_all.asp" onSubmit="return checkdate3()">
      <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td align="center"><table width="500" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
              <tr> 
                <td align="center"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                    <tr> 
                      <td align="center" bgcolor="#E7C84E"><strong class="Tab2">Received 
                        Payment</strong><strong class="Tab3"> </strong></td>
                      <td align="center"><strong class="Tab2">From 
					  <% if (text_date_from="") then %>
                        <input name="text_date_from24" id="text_date_from24" type="text" class="Tab2" size="15" readonly>
					<% else %>
						<input name="text_date_from24" id="text_date_from24" type="text" class="Tab2" size="15" value='<%=text_date_from%>' readonly>
					<% end if %>		
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
						<% if (text_date_to="") then %>
                        <input name="text_date_to24" id="text_date_to24" type="text" class="Tab2" size="15" readonly>
						<% else %>
						  <input name="text_date_to24" id="text_date_to24" type="text" class="Tab2" size="15" value='<%=text_date_to%>' readonly>
						 <% end if %> 
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
	<table width="297" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
		<tr bgcolor="#CCCCCC">
		<td colspan="2" class="Tab3" align="center"><strong>From</strong>&nbsp;&nbsp;<%=text_date_from%>&nbsp;&nbsp;<strong>To</strong>&nbsp;&nbsp;<%=text_date_to%></td>		
		</tr>
		<tr bgcolor="#CCCCCC">
		<td width="193" class="Tab2">Marketing Person</td>
		<td width="83" class="Tab2">Payment (INR)</td>
		</tr>
	<%
		call OpenConnection
		dim rstmp
		dim rstproj
		set rstmp = server.CreateObject("adodb.recordset")
		mpsql = "select distinct(mp_id) from tbl_pr_project"
		rstmp.open mpsql,NewConnection
		if rstmp.eof or rstmp.bof then
		else		
		do while not rstmp.eof
		total_part_pay = 0
		'Response.Write(rstmp("mp_id") & "--")
			set rstproj = server.CreateObject("adodb.recordset")
			if rstproj.state then rstproj.close
			projsql="select * from tbl_pr_project where mp_id='" & trim(rstmp("mp_id")) & "'"
			rstproj.open projsql,NewConnection
			if rstproj.eof or rstproj.bof then
			else		
			do while not rstproj.eof
				'Response.Write(rstproj("srno") & "--")
					set rstpart = server.CreateObject("adodb.recordset")
					if rstpart.state then rstpart.close
					partsql="select sum(p_payment) as part_sum from tbl_pr_partial_payment where proj_id='" & rstproj("srno") & "' and ddate between '" & txt_date_From1 & "' and '" & txt_date_To1 & "'"
					rstpart.open partsql,NewConnection
					if (isnull(rstpart("part_sum")) or rstpart("part_sum") = "" or rstpart("part_sum") = 0) then
						part_sum = 0
					else		
						part_sum = rstpart("part_sum")												
					end if
						total_part_pay = round((total_part_pay + part_sum),2)
			rstproj.movenext
			loop
			%>	
						<tr>
							<td class="Tab3"><%=rstmp("mp_id")%></td>
							<td class="Tab3" align="right"><%=round(total_part_pay,2)%></td>
						</tr>						
			<%
			end if
				all_total_part_pay = round((all_total_part_pay + total_part_pay),2)	
		rstmp.movenext
		loop
		%>	
						<tr bgcolor="#CCCCCC">
							<td class="Tab2" align="right">Total (INR)</td>
							<td class="Tab3" align="right"><%=round(all_total_part_pay,2)%></td>
						</tr>						
		<%
		end if
		
	%>
	</table>
   	<br>
	<center><strong><a href="adminmain.asp"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Back</font></a> &nbsp;</strong></center>        
	<br><br>	  
<tr><td height="39" valign="top"><!--#include file="includefiles/footer1.asp"--><p align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site Empowered by AKS India Web Solutions </font></strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">.</font></p>
      </td>
  </tr></div></table>
  <% 	call closeconnection 
  %>
<p>&nbsp;</p></body>
</html>