<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="view_reminder.aspx.cs" Inherits="Developer_view_reminder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
         <div style="text-align: center;" id="blink"><%=WorkDoneorNot%></div>
    <%--You have not started any work till now.    You are sitting ideal since last 1 hours.--%>
    <script type="text/javascript">
        var blink = document.getElementById('blink');
        setInterval(function () {
            blink.style.opacity = (blink.style.opacity == 0 ? 1 : 0);
        }, 1000);
    </script>
        <tr>
            <td width="882" align="center" bgcolor="#E6E6E6">
                <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="Tab3" align="left"><a href="developermain.aspx"><font color="#0000FF"><b>Dashboard</b></font></a></td>
                        <td class="Tab3" align="left"><a href="attendance.aspx"><font color="#0000FF"><b>Attendance</b></font></a></td>
                        <td class="Tab3" align="left"><a href="OutsideInside.aspx"><font color="#0000FF"><b>Outside Inside</b></font></a></td>
                        <td class="Tab3" align="left"><a href="add_reminder.aspx" target="_blank"><font color="#0000FF"><b>Add New Reminder</b></font></a></td>
                        <td class="Tab3" align="left"><a href="DeveloperLeave.aspx" target="_blank"><font color="#0000FF"><b>Leave Apply Form</b></font></a></td>

                        <td class="Tab3" align="left">
                            <%if (numberOfSeenStatus > 0)
                                {%>
                                   <a href="DeveloperLeaveStatus.aspx" target="_blank" class="notification"><font color="#0000FF"><b>Applied Leave Status</b></font><span class="badge">
                                <%=numberOfSeenStatus%></span></a>
                            <%} %>
                            <%else
                                { %>
                                     <a href="DeveloperLeaveStatus.aspx" target="_blank"><font color="#0000FF"><b>Applied Leave Status</b></font></a>
                            <%} %>
                        </td>
                        <td class="Tab3" align="left">
                            <%if (numberOfPendingApprovalLeave > 0)
                                {%>
                            <a href="developerGrantLeave.aspx" target="_blank" class="notification"><font color="#0000FF"><b>Leave Grant</b></font><span class="badge">
                                <%=numberOfPendingApprovalLeave%></span></a>
                            <%} %>
                            <%else
                                { %>
                            <a href="developerGrantLeave.aspx" target="_blank" ><font color="#0000FF"><b>Leave Grant</b></font></a>
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
        <%=ReminderPanel%>
    </table>

    <%=DoneReminders%>
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
</asp:Content>