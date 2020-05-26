<%
	dim NewConnection
	sub OpenConnection
		Set NewConnection = Server.CreateObject("ADODB.Connection")		
		NewConnection.Open "Driver={SQL Server Native Client 10.0}; Server=111.118.181.145\SQLEXPRESS; Database=akswebsoft_praksindia; Uid=PrAksIndia1; Pwd=PrAI_9876;"
	end sub
	sub CloseConnection
		NewConnection.close
		set NewConnection=Nothing
	end sub
%>