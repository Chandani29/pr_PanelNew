<%
dim mstr_injectionTestingURL
dim mstr_injectionbody
dim x
dim i_quick
dim txtuname
dim txtpass

txtuname = request("txtuname")
txtpass = request("txtpass")

mstr_injectionTestingURL = request.serverVariables("QUERY_STRING") & " " & txtuname & " " & txtpass

CheckInjectionChars(mstr_injectionTestingURL)


function CheckInjectionChars(strWords) 
	dim mstr_badChars 
	dim mstr_newChars 

	'mstr_badChars = array("select","select ", "select%20", "drop","drop ","drop%20",";","; ",";%20","--","-- ","--%20","insert","insert ","insert%20","delete","delete ","delete%20","xp_","xp_ ","xp_%20","update","update ","update%20","declare","declare ","declare%20","exec","exec ","exec%20","ntext","ntext ","ntext%20","nchar","nchar ","nchar%20","varchar","varchar ","varchar%20","char","char ","char%20","nvarchar","nvarchar ","nvarchar%20","alter","alter ","alter%20","begin","begin ","begin%20","create","create ","create%20","cursor","cursor ","cursor%20","declare","declare ","declare%20","exec","exec ","exec%20","execute","execute ","execute%20","fetch","fetch ","fetch%20","kill","kill ","kill%20","open","open ","open%20","sys","sys ","sys%20","sysobjects","sysobjects ","sysobjects%20","syscolumns","syscolumns ","syscolumns%20","rsquo","rsquo ","rsquo%20","<", ">", "<script>", "</script>", "&lt;", "&gt;", "^*", "<script", "</script", "&#60;", "&#62;")
	mstr_badChars = array("select", "select ", "select%20", "truncate", "truncate ", "truncate%20", "drop", "drop ", "drop%20", "information", "information ", "information%20", "schema", "schema ", "schema%20", "database", "database ", "database%20", "TABLES", "TABLES ", "TABLES%20", "columns", "columns ", "columns%20", ";", "; ", "%27", ";%20", "%2A", "%2B", "%2C", "%2D", "%2E", "%2F", "--", "-- ", "--%20", "insert", "insert ", "insert%20", "delete", "delete ", "delete%20", "xp_", "xp_ ", "xp_%20", "sp_", "sp_ ", "sp_%20", "update", "update ", "update%20", "ntext", "ntext ", "ntext%20", "nchar", "nchar ", "nchar%20", "varchar", "varchar ", "varchar%20", "char", "char ", "char%20", "nvarchar", "nvarchar ", "nvarchar%20", "alter", "alter ", "alter%20", "begin", "begin ", "begin%20", "create", "create ", "create%20", "cursor", "cursor ", "cursor%20", "declare", "declare ", "declare%20", "@@version", "@@version", "@@version%20", "@@version--", "exec", "exec ", "exec%20", "execute", "execute ", "execute%20", "fetch", "fetch ", "fetch%20", "kill", "kill ", "kill%20", "open", "open ", "open%20", "sys", "sys ", "sys%20", "sysobjects", "sysobjects ", "sysobjects%20", "syscolumns", "syscolumns ", "syscolumns%20", "rsquo", "rsquo ", "rsquo%20", "<", ">", "<script>", "</script>", "&lt;", "&gt;", "^*", "<script", "</script", "script", "title", "<title>", "</title>", "<title", "</title", "php", "&#60;", "&#62;")
	mstr_newChars = strWords

	for i_quick = 0 to uBound(mstr_badChars) 
		if instr(UCase(mstr_newChars),UCase(mstr_badChars(i_quick)))>0 then
			mstr_injectionbody =  "It seems that SQL Injection is being attempted by a viewer at "&now()&" (" & mstr_badChars(i_quick) & "). The viewer details are as under. The action perfoprmed by the viewer, if any, was not restricted. The complete details of the viewer is as under: <br>"
			mstr_injectionbody =  mstr_injectionbody  & "<b>Referred by : </b>" & request.serverVariables("HTTP_REFERRER") & "<br><br><br>"
			mstr_injectionbody =  mstr_injectionbody  & "<b>CLIENT IP: </b>" & Request.ServerVariables("HTTP_X_FORWARDED_FOR") & "<br><br><br>"
			for each x in request.servervariables
				mstr_injectionbody = mstr_injectionbody & "<br><b>" & x & "</b>::::" & Request.servervariables(x)
			next
			sendMail(mstr_injectionBody)
			exit for		
		end if
	next 

	CheckInjectionChars = mstr_newChars 
end function 

function CheckFormBadChars(strWords)
	dim mstr_badChars
	dim mstr_newChars 
	dim flag
	flag = 0
	
	'mstr_badChars = array("select","select ", "select%20", "drop","drop ","drop%20",";","; ",";%20","--","-- ","--%20","insert","insert ","insert%20","delete","delete ","delete%20","xp_","xp_ ","xp_%20","update","update ","update%20","declare","declare ","declare%20","exec","exec ","exec%20","ntext","ntext ","ntext%20","nchar","nchar ","nchar%20","varchar","varchar ","varchar%20","char","char ","char%20","nvarchar","nvarchar ","nvarchar%20","alter","alter ","alter%20","begin","begin ","begin%20","create","create ","create%20","cursor","cursor ","cursor%20","declare","declare ","declare%20","exec","exec ","exec%20","execute","execute ","execute%20","fetch","fetch ","fetch%20","kill","kill ","kill%20","open","open ","open%20","sys","sys ","sys%20","sysobjects","sysobjects ","sysobjects%20","syscolumns","syscolumns ","syscolumns%20","rsquo","rsquo ","rsquo%20","<", ">", "<script>", "</script>", "&lt;", "&gt;", "^*", "<script", "</script", "&#60;", "&#62;")
	
	mstr_badChars = array("select", "select ", "select%20", "truncate", "truncate ", "truncate%20", "drop", "drop ", "drop%20", "information", "information ", "information%20", "schema", "schema ", "schema%20", "database", "database ", "database%20", "TABLES", "TABLES ", "TABLES%20", "columns", "columns ", "columns%20", ";", "; ", "%27", ";%20", "%2A", "%2B", "%2C", "%2D", "%2E", "%2F", "--", "-- ", "--%20", "insert", "insert ", "insert%20", "delete", "delete ", "delete%20", "xp_", "xp_ ", "xp_%20", "sp_", "sp_ ", "sp_%20", "update", "update ", "update%20", "ntext", "ntext ", "ntext%20", "nchar", "nchar ", "nchar%20", "varchar", "varchar ", "varchar%20", "char", "char ", "char%20", "nvarchar", "nvarchar ", "nvarchar%20", "alter", "alter ", "alter%20", "begin", "begin ", "begin%20", "create", "create ", "create%20", "cursor", "cursor ", "cursor%20", "declare", "declare ", "declare%20", "@@version", "@@version", "@@version%20", "@@version--", "exec", "exec ", "exec%20", "execute", "execute ", "execute%20", "fetch", "fetch ", "fetch%20", "kill", "kill ", "kill%20", "open", "open ", "open%20", "sys", "sys ", "sys%20", "sysobjects", "sysobjects ", "sysobjects%20", "syscolumns", "syscolumns ", "syscolumns%20", "rsquo", "rsquo ", "rsquo%20", "<", ">", "<script>", "</script>", "&lt;", "&gt;", "^*", "<script", "</script", "script", "title", "<title>", "</title>", "<title", "</title", "php", "&#60;", "&#62;")
	mstr_newChars = strWords

	for i_quick = 0 to uBound(mstr_badChars) 
		if instr(UCase(mstr_newChars),UCase(mstr_badChars(i_quick)))>0 then
			flag = 1
			exit for		
		end if		
	next 
	if flag = 1 then
		Response.Redirect "thanks.asp"
	else
		CheckFormBadChars = mstr_newChars 
	end if	
end function 

function sendMail(mstr_injectionBody)
		
		from1 = "support@aksindia.com"
		host1 = "mail.webdesignseodelhi.com"
		uid1 =  "test@webdesignseodelhi.com"
		pwd1 =  "testing123"	
		to1 = "sandeep@aksindia.com"
		
		Subject1 = "Script Injection PR Developer (aksindia.com) : "
		
		Set Mail = Server.CreateObject("Persits.MailSender")
		' enter valid SMTP host
		Mail.Host = host1
		Mail.Username = uid1
		Mail.Password = pwd1
		
		Mail.From = from1 ' From address
		Mail.FromName = txtName ' optional
		Mail.AddAddress to1
		'Mail.AddBcc BccEmail1
		
		' message subject
		Mail.Subject = Subject1
		' for text message
		Mail.Body = mstr_injectionBody
				
		' for html message
		'Mail.Body = ContentACInfo1
		Mail.IsHTML = True 
		''''''''''''''''''''
		
		strErr = ""
		bSuccess = False
		
		On Error Resume Next ' catch errors
		Mail.Send ' send message
		
		If Err <> 0 Then ' error occurred
			strErr = Err.Description
		else
			bSuccess = True
		End If
		
	response.redirect("thanks.asp")
end function

'response.write(mstr_injectionBody)
%>