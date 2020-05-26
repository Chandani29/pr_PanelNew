<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="add_reminder.aspx.cs" Inherits="Developer_add_reminder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
     <div style="text-align: center;" id="blink"><%=WorkDoneorNot%></div>
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
                        <td class="Tab3" align="left"><a href="add_reminder.aspx"><font color="#0000FF"><b>Add New Reminder</b></font></a></td>
                        <td class="Tab3" align="left"><a href="DeveloperLeave.aspx" ><font color="#0000FF"><b>Leave Apply Form</b></font></a></td>

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
                        <td class="Tab3" align="right"><a href="view_reminder.aspx" ><font color="#0000FF"><b>View Done Reminder</b></font></a></td>
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

    <%=OldReminders%>
    <table width="400" border="1" cellspacing="2" cellpadding="1" class='tdrow4' align='center'> 
        <tr align="center"> 
            <td colspan="2" class="txt">Reminder  Entry Form</td> 
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3"><strong>Date</strong></td>
            <td width="185">
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true" size="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3"><strong>Reminder Subject</strong></td>
            <td>
                <asp:TextBox ID="txt_re_sub" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_re_sub"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" class="Tab3"><strong>Reminder Description</strong></td>
            <td>
                <asp:TextBox ID="txt_re_desc" runat="server" TextMode="MultiLine" Style="height: 75px; width: 400px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_re_desc"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" class="Tab3"><strong>Reminder Date</strong></td>
            <td>
                <asp:TextBox ID="txt_re_date" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_re_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                &nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" /><br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
