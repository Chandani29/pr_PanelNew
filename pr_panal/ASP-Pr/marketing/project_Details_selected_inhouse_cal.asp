<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
	dim strsql
	dim rsproject
	dim rsProject1 
	
	Session.Timeout=480
	Server.ScriptTimeout=2400
	if Session("pr_username")="" then
		response.Redirect("admin.asp")
	end if
	
	call OpenConnection
	'srno = request("txt_srno")
	'type_proj = request("dd_type")
	proj_id = request("h_id")
	Remark = request("txt_remark")
	totalhour_exp = request("txt_ths")
	dd_developer = request("dd_Workper")
	txt_ur = request("txt_ur")
	dd_time = request("dd_time")
	ur_date_time = txt_ur & "-" & trim(dd_time) & ":00:00 hr" 
	if(trim(Session("pr_username"))="m01") then 
		inhouseId = request("inhouse")	
	end if	
	
		set rsProject = server.CreateObject("adodb.recordset")
		rsProject.open "SELECT * from tbl_pr_project where srno='"& proj_id & "'",NewConnection
		if rsProject.eof or rsProject.bof then
			Response.Write("<strong><font color=red>No Record Found!!</font></strong>")
		else				
		
			proj_name = rsProject("proj_name")
			mp_id = trim(rsProject("mp_id"))
			proj_desc = rsProject("proj_desc")
			total_hour = rsProject("total_hour")
			duration = rsProject("submeted_on")	
			asigned_per = trim(Session("pr_username"))			
			ddate = request("txt_date")
			
			if isnull(rsProject("type_proj")) or rsProject("type_proj")="" then
					project_type = ""
			else
					project_type = trim(rsProject("type_proj"))
			end if
							
	   end if
	   if(trim(project_type)="InHouse") then 
			strsql = "insert into tbl_pr_projDetails(proj_id,inhouse_id,asignedby,proj_name,working_per,hourspend,work_by_mark,ddate,ur_date)"
			strsql = strsql & "values('" & proj_id & "','" & inhouseId & "','" & mp_id & "','" & proj_name & "','" & dd_developer & "','" & totalhour_exp & "','" & Remark & "','" & ddate & "','" & ur_date_time &"')"
		else
			strsql = "insert into tbl_pr_projDetails(proj_id,asignedby,proj_name,working_per,hourspend,work_by_mark,ddate,ur_date)"
			strsql = strsql & "values('" & proj_id & "','" & mp_id & "','" & proj_name & "','" & dd_developer & "','" & totalhour_exp & "','" & Remark & "','" & ddate & "','" & ur_date_time &"')"
		end if
		set rsproject1 = server.CreateObject("adodb.recordset")
		Set rsproject1 = NewConnection.Execute(strsql)		
		response.Redirect("project_Details_selected_inhouse.asp?refno="& proj_id & "")		
%>