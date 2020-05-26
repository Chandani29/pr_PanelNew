<%
	dim NewConnection
	sub OpenConnection
		Set NewConnection = Server.CreateObject("ADODB.Connection")		
		NewConnection.Open "Driver={SQL Server Native Client 10.0}; Server=103.241.146.195; Database=akswebsoft_praksindia; Uid=PrAksIndia1; Pwd=PrAI_9@#1()8Hg;"
	end sub
	sub CloseConnection
		NewConnection.close
		set NewConnection=Nothing
	end sub
%>