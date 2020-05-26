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
refno = request("refno")
'response.Write(refno)
%>
<html>
<head>
<title>Developer Panel</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="css/buttons.css" ref="stylesheet" type="text/css">
<link href="css/class1.css" rel="stylesheet" type="text/css">
<link href="css/marketing.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function checkLogin()
{
		//sa = new String(document.form1.username.value);
		//getsa=sa.lastIndexOf(' ');
	
	if(document.form1.txt_srno.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.txt_srno.focus();
		return false;
	}
	//else if(getsa>-1)
	//{
	//	alert("Blank space is not allowed in the Username");
		//alert(getsa);
		//alert(document.form1.username.value.length);
	//	document.form1.username.focus();
	//	return false;
	//}
	//else if(document.form1.username.value.length < 6)
	//{
	//	alert("UserName Should be greater than six Characters");
	//	document.form1.username.focus();
	//	return false;
	//}
	else if(document.form1.txt_date.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_date.focus();
		return false;
	}
	else if(document.form1.txt_uid.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		document.form1.txt_uid.focus();
		return false;
	}
	else if(document.form1.dd_type.value=="none")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.dd_type.focus();
		return false;
	}
	else if(document.form1.txt_proj.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_proj.focus();
		return false;
	}	
	else if(document.form1.txt_desc.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_desc.focus();
		return false;
	}
	else if(document.form1.txt_hour.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_hour.focus();
		return false;
	}
	else if(document.form1.txt_duration.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_duration.focus();
		return false;
	}
	else if(document.form1.dd_developer.value=="none")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.dd_developer.focus();
		return false;
	}
	else if(document.form1.txt_completedon.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_completedon.focus();
		return false;
	}
	else if(document.form1.txt_cost.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_cost.focus();
		return false;
	}
	else if(document.form1.txt_ths.value=="")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.txt_ths.focus();
		return false;
	}
	else if(document.form1.dd_status.value=="none")
	{
		alert("This entry must be completed before you can submit this form for processing.");
		//alert(document.form1.Password.value.length);
		document.form1.dd_status.focus();
		return false;
	}
	
	//else if (!isNaN(document.form1.password.value))
	//{
	//	alert("Please Enter Only Alphabets for Password.");
	//	document.form1.password.focus();
	//	return false;}

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
		dim rsProject
		set rsProject = server.CreateObject("adodb.recordset")
		Set rsProject = NewConnection.Execute("SELECT * FROM tbl_pr_project where srno='" & refno & "'")
		if rsProject.eof or rsProject.bof then
			Response.Write("<strong><font color=red>No Record Found</font></strong>")			
		else			
	 %>
	 <form action="developer_entry_cal.asp" method="post" name="form1">
	    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
          <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center"> 
            <td colspan="4" class="tdrow5"><div align="center"><strong>Project 
                Detail Form For Developers. </strong></div></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">&nbsp;</td>
            <td width="54%" colspan="1"> <font color="#FF0000">&nbsp;</font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">SrNo</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_srno" type="text" id="txt_srno" size="20" value='DP-<%=rsProject("srno")%>' readonly>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Date</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_date" type="text" id="txt_date" size="20" value='<%=rsProject("ddate")%>' readonly>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Name</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_projname" type="text" id="txt_projname" size="20" value='<%=rsProject("proj_name")%>' readonly>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Assigned By</td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_mpid" type="text" id="txt_mpid" size="20" value='<%=rsProject("mp_id")%>' readonly>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Description </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <textarea name="txt_desc" id="txt_desc" readonly><%=rsProject("proj_desc")%></textarea>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Total Hours </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_hour" type="text" id="txt_hour" size="20" value='<%=rsProject("total_hour")%>'>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Must be Submmited on </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_duration" type="text" id="txt_duration" size="20" value='<%=rsProject("duration")%>'>
              </font> </td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Assign person</td>
            <td colspan="2">&nbsp; <font color="#FF0000"> 
              <input name="txt_assignperson" type="text" id="txt_assignperson" size="20" value='<%=rsProject("asigned_per")%>' readonly>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Total Hr. Spend </td>
            <td colspan="2"> <font color="#FF0000">&nbsp; 
              <input name="txt_ths" type="text" id="txt_ths" size="20">
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">Project Remark</td>
            <td colspan="2"><font color="#FF0000">&nbsp; 
              <textarea name="txt_remark" id="txt_remark"></textarea>
              </font></td>
          </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom" > 
            <td colspan="2" align="center">&nbsp;</td>
            <td colspan="2"> <font color="#FF0000">&nbsp;</font></td>
          </tr>
		  <input type="hidden" name="h_id" id="h_id" value="<%=rsProject("srno")%>">
          <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom"> 
            <td colspan="4"> <input name="Submit" type="submit" class="Tab2" style="WIDTH: 150px;" value="Submit" onClick="return checkLogin();"> 
              <input name="Submit2" type="Reset" class="Tab2" style="WIDTH: 150px;" value="Reset"> 
            </td>
          </tr>
        </table>
     </form>
	<% end if %> 
     </td>
  </tr>
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
</table></div></table>
<p>&nbsp;</p></body>
</html>