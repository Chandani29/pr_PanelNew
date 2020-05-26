<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
	Session.Timeout=480
	Server.ScriptTimeout=2400
	if Session("pr_username")="" then
		response.Redirect("admin.asp")
	end if
	
	m_id = trim(mid(Session("pr_username"),2))
	response.Write(m_id)
	call OpenConnection
		'' counting no. of projects
		dim rsCount
		set rsCount = server.CreateObject("adodb.recordset")
		rsCount.open "SELECT count(*) as count1 from tbl_pr_project where mp_id='"& trim(session("MarketingName")) & "'",NewConnection
		if isnull(rsCount("count1")) then
			count2 = 1
		else
			count2 = int(trim(rsCount("count1"))) + 1
		end if
		
		''' counting project no
		dim rsProjectID
		set rsProjectID = server.CreateObject("adodb.recordset")
		Set rsProjectID = NewConnection.Execute("SELECT max(srno) as maxid FROM tbl_pr_project")
		if isnull(rsProjectID("maxid")) then
			srno = 1
		else
			srno = int(trim(rsProjectID("maxid"))) + 1
		end if
		'''''''''''''''''''' generating project id '''''''''''''''''''''''''
		
			p_id = trim(m_id) & "-" & trim(count2) & "-" & trim(srno)
			response.Write(p_id)
	dim strsql
	dim rsproject
	'p_id = request("h_id")
	mp_id = request("txt_uid")
	clientname = request("txt_clientname")
	p_referance = request("txt_referance")
	clientmobile = request("txt_clientmobile")
	clientemail = request("txt_clientemail")
	clientcompany = request("txt_clientcompany")
	clientadd = request("txt_clientadd")
	type_proj = request("dd_type")
	proj_name = request("txt_proj")
	ddate = request("txt_date")
	proj_desc = request("txt_desc")
	total_hour = request("txt_hour")
	submeted_on = request("txt_submitedon")	
	asigned_per = request("dd_developer")
	Remark = request("txt_remark")
	totalhour_exp = request("txt_ths")
	
	workstatus = request("dd_status")
	cost = 0	
	if(trim(workstatus)="Trial Project") then
		cost = 0
	else
		cost = request("txt_cost")
	end if
	call OpenConnection
		strsql = "insert into tbl_pr_project(proj_id,mp_id,clientname,proj_source,clientmobile,clientemail,clientcompany,clientadd,type_proj,proj_name,ddate,proj_desc,total_hour,submeted_on,asigned_per,Remark,cost,workstatus)"
		strsql = strsql & "values('" & p_id & "','" & mp_id & "','" & clientname & "','" & p_referance & "','" & clientmobile & "','" & clientemail & "','" & clientcompany & "','" & clientadd & "','" & type_proj & "','" & proj_name & "','" & ddate & "','" & proj_desc & "','" & total_hour & "','" & submeted_on & "','" & asigned_per & "','" & Remark & "','" & cost & "','" & workstatus & "')"
		set rsproject = server.CreateObject("adodb.recordset")
		Set rsproject = NewConnection.Execute(strsql)
		response.Write(strsql)
		
		response.Redirect("project_report_selected.asp")		
%>