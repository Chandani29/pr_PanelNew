<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="attendance.aspx.cs" Inherits="Developer_Default" %>

<asp:Content http-equiv="Refresh" content="10" ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center;" id="blink"><%=WorkDoneorNotMsg%></div>
    <%--You have not started any work till now.    You are sitting ideal since last 1 hours.--%>
    <script type="text/javascript">
        var blink = document.getElementById('blink');
        setInterval(function () {
            blink.style.opacity = (blink.style.opacity == 0 ? 1 : 0);
        }, 1000);
    </script>
     <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="882" align="center" bgcolor="#E6E6E6">
                <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="Tab3" align="left"><a href="developermain.aspx"><font color="#0000FF"><b>Dashboard</b></font></a></td>
                        <td class="Tab3" align="left"><a href="attendance.aspx"><font color="#0000FF"><b>Attendance</b></font></a></td>
                        <td class="Tab3" align="left"><a href="OutsideInside.aspx"><font color="#0000FF"><b>Outside Inside</b></font></a></td>
                        <td class="Tab3" align="left"><a href="add_reminder.aspx" ><font color="#0000FF"><b>Add New Reminder</b></font></a></td>
                        <td class="Tab3" align="left">
                            <%if (leaveApplyFormStatus > 0)
                                {%>
                            <a href="DeveloperLeave.aspx"  class="notification"><font color="#0000FF"><b>Leave Apply Form</b></font>
                                <span class="badge">
                                <%=leaveApplyFormStatus%></span>
                            </a>
                            <%} %>
                            <%else
                                { %>
                                 <a href="DeveloperLeave.aspx" ><font color="#0000FF"><b>Leave Apply Form</b></font></a>
                            <%} %>

                        </td>

                        <td class="Tab3" align="left">
                            <%if (numberOfSeenStatus > 0)
                                {%>
                                   <a href="DeveloperLeaveStatus.aspx"  class="notification"><font color="#0000FF"><b>Applied Leave Status</b></font><span class="badge">
                                <%=numberOfSeenStatus%></span></a>
                            <%} %>
                            <%else
                                { %>
                                     <a href="DeveloperLeaveStatus.aspx" ><font color="#0000FF"><b>Applied Leave Status</b></font></a>
                            <%} %>
                        </td>
                        <td class="Tab3" align="left">
                            <%if (numberOfPendingApprovalLeave > 0)
                                {%>
                            <a href="developerGrantLeave.aspx"  class="notification"><font color="#0000FF"><b>Leave Grant</b></font><span class="badge">
                                <%=numberOfPendingApprovalLeave%></span></a>
                            <%} %>
                            <%else
                                { %>
                            <a href="developerGrantLeave.aspx"  ><font color="#0000FF"><b>Leave Grant</b></font></a>
                            <%} %>

                        </td>
                        <td class="Tab3" align="right"><a href="view_reminder.aspx" target="_blank"><font color="#0000FF"><b>View Done Reminder</b></font></a></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
           <br />
    <br />
    <table width="400" border="1" cellspacing="2" cellpadding="1" class='tdrow4' align='center'>
         
        <tr align="center">
            <td colspan="2" class="txt">Attendance  Entry Form <strong>(Coming time <%=ComingTime%>)</strong><%=GoingTime%></td>
        </tr>
        <tr class="rowDate" class="rowDate">
            <td width="199" align="right" class="Tab3"><strong>Date</strong></td>
            <td width="185">
              
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true" size="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr> 
        <tr align="center" class="rowMessage"> 
            <td width="199" align="right" class="Tab3"></td>
            <td width="185">
                <asp:TextBox ID="txtmessage" runat="server" TextMode="multiline" Columns="50" Rows="5" placeholder="Enter Message,If Any?" size="30"></asp:TextBox>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                <asp:Button ID="btnmorning" runat="server" Text="Good Morning" ToolTip="Submit"
                    Style="cursor: pointer;" OnClick="btnmorning_Click" CssClass="Tab2" /><br />
                <asp:Button ID="btnnight" runat="server" Text="I have completed my all today's assigned work, should I leave now?" ToolTip="Submit"
                    Style="cursor: pointer;" OnClick="btnnight_Click"  CssClass="Tab2" /><br /> 
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
                <asp:Label ID="txtmsg" class="txtmsgg" runat="server" ForeColor="Green"></asp:Label>
                 <%-- <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

      <asp:Timer ID="Timer1" runat="server" Interval="10000" OnTick="Timer1_Tick"></asp:Timer>
    <asp:UpdatePanel runat="server">
          <ContentTemplate>
           <asp:Label ID="txtmsg" class="txtmsgg" runat="server" ForeColor="Green"></asp:Label>
          </ContentTemplate>
          <Triggers>
              <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" /> 
          </Triggers> 
      </asp:UpdatePanel>--%>
            </td>
        </tr>
    </table> 
</asp:Content>
