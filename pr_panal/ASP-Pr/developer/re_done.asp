<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->

<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("dr_username")="" then
	response.Redirect("admin.asp")
end if
	  call OpenConnection
		
		Set rsUser1 = NewConnection.Execute("update tbl_pr_devreminder set re_status='Yes',done_date='" & request("txt_date") & "',done_remark='" & request("txt_remark") & "' where srno='" & request("srno") & "'")
	  call closeconnection 				
response.Write("Thanks")
%>
<html>   
   <head>   
      <script language="javascript">   
         function Close()
		 {   
            window.close();   
         }   
      </script>   
   </head>   
   <body onLoad="top.opener.document.location.reload();Close();">   
      <br /><a href="javascript:Close()">Close this window</a>   
   </body>   
</html>  
