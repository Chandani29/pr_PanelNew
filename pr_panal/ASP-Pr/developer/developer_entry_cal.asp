<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
	dim strsql
	dim rsproject
	dim rsProject1
	Session.Timeout=480
	Server.ScriptTimeout=2400
	if Session("dr_username")="" then
		response.Redirect("admin.asp")
	end if
	call OpenConnection
	'srno = request("txt_srno")
	'type_proj = request("dd_type")
	proj_id = request("h_ref")
	Remark = request("txt_remark")
	totalhour_exp = request("txt_ths")
	response.Write(proj_id)	
	Session("dr_username")
	''''''''''''''''''''''''''' calculating cost of developer ''''''''''''''''''''''''''''''''''''''''''''''''''
		set rsdev = server.CreateObject("adodb.recordset")
		rsdev.open "SELECT * from tbl_pr_developerLogin where user_id='"& trim(Session("dr_username")) & "'",NewConnection
		if rsdev.eof or rsdev.bof then
			Response.Write("<strong><font color=red>No Record Found!!</font></strong>")
			dev_cost=0
		else		
			dev_cost = round(rsdev("per_cost"),2)					
	   end if
	 ''''''''''''''''''''''''''''' calculating all information of projects ''''''''''''''''''''''''''''''	   
		set rsProject = server.CreateObject("adodb.recordset")
		rsProject.open "SELECT * from tbl_pr_project where srno='"& proj_id & "'",NewConnection
		if rsProject.eof or rsProject.bof then
			Response.Write("<strong><font color=red>No Record Found!!</font></strong>")
		else				
		
			proj_name = rsProject("proj_name")
			mp_id = rsProject("mp_id")
			proj_desc = rsProject("proj_desc")
			total_hour = rsProject("total_hour")
			submeted_on = rsProject("submeted_on")	
			asigned_per = trim(Session("DeveloperName"))			
			ddate = request("txt_date")	
	   end if
	   dev_cal_cost = round((dev_cost * totalhour_exp),2)
	   '''''''''''''''''''''''''' inserting values in table '''''''''''''''''''''''''''''''''''''''''''''''''
		strsql = "insert into tbl_pr_projDetails(proj_id,asignedby,proj_name,working_per,hourspend,dev_cost,work_remark,ddate)"
		strsql = strsql & "values('" & proj_id & "','" & mp_id & "','" & proj_name & "','" & asigned_per & "','" & totalhour_exp & "','" & dev_cal_cost & "','" & Remark & "','" & ddate & "')"
		set rsproject1 = server.CreateObject("adodb.recordset")
		Set rsproject1 = NewConnection.Execute(strsql)		
		response.Redirect("project_report.asp?refno="& proj_id & "")		
%>