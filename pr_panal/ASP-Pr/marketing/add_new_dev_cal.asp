<!-- #include file="header.inc"-->
<!--#include file="CreateConnection.asp"-->
<%
Session.Timeout=480
Server.ScriptTimeout=2400
if Session("pr_username")="" then
	response.Redirect("admin.asp")
end if
	srno = Request("h_id")
	proj_id = Request("proj_id")
	dd_select = request("dd_developer")
response.Write(srno)
response.Write(proj_id)
response.Write(dd_select & "<br>")
call OpenConnection


	Set rsProject = server.CreateObject("adodb.recordset")
				rsProject.open "SELECT asigned_per from tbl_pr_project where srNo='" & srno &"'",NewConnection
				
				if rsProject.eof or rsProject.bof then
					Response.Write("no record found")
				else		
					
					asigneddevelopers_all = rsProject("asigned_per")					
					no_asigneddevelopers = instr(asigneddevelopers_all,",")
					if(no_asigneddevelopers > 0) then					
						dim ass_work_per11
							alpha11 = rsProject("asigned_per")
							ass_per11=split(alpha11,",")
							ass_limit11 = ubound(ass_per11)
							for i=0 to ass_limit11
								ass_work_per11 = ass_per11(i)
								if(trim(ass_work_per11) = trim(dd_select)) then
									ass_work_per11 = ""
									exit for
								else
									ass_work_per11 = rsProject("asigned_per") & "," & dd_select
								end if
							next	
					
					else
						ass_work_per11 = rsProject("asigned_per")
						if(trim(ass_work_per11) = trim(dd_select)) then
							ass_work_per11 = ""
						else
						ass_work_per11 = ass_work_per11 & "," & dd_select
						end if
					end if
					response.Write(ass_work_per11 & "<br>")
				end if
				

	set rsUPProject = server.CreateObject("adodb.recordset")
		if (ass_work_per11="") then
			response.Redirect("project_report_selected.asp")
		else
			strsql = "update tbl_pr_project set asigned_per='" & ass_work_per11 &"' where srno='"& srno & "'"
			response.Write(strsql)
			set rsUPProject= NewConnection.execute(strsql)
			response.Redirect("project_report_selected.asp")
			'response.Write("Data updated!!")
		end if
%>