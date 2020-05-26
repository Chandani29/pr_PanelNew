<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master"
    AutoEventWireup="true" CodeFile="view_reminder.aspx.cs" Inherits="Marketing_view_reminder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="882" align="center" bgcolor="#E6E6E6">
                <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                         <td class="Tab3" align="left"><a href="attendance.aspx"><font color="#0000FF"><b>Attendance</b></font></a></td>
                        <td class="Tab3" align="left"><a href="OutsideInside.aspx"><font color="#0000FF"><b>Outside Inside</b></font></a></td>
                        <td class="Tab3" align="left"><a href="add_reminder.aspx" target="_blank"><font color="#0000FF"><b>Add New Reminder</b></font></a></td>
                        <td class="Tab3" align="right"><a href="view_reminder.aspx" target="_blank"><font color="#0000FF"><b>View Done Reminder</b></font></a></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table width="800" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="6" class="txt">
                Done Reminders (<%=WelcomeMessages%>)
            </td>
        </tr>
        <tr>
            <td align="center" class="Tab3">
                <strong>Reminder Subject</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Reminder Description</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Reminder Date</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Reminder Status</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Reminder Remark</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Reminder Done</strong>
            </td>
        </tr>
        <tr>
            <asp:Repeater ID="rptCustomers" runat="server">
                <ItemTemplate>
                    <tr>
                        <td align="center" class="Tab3">
                            <%# Eval("subject")%>&nbsp;
                        </td>
                        <td align="center" class="Tab3">
                            <%# Eval("descr")%>&nbsp;
                        </td>
                        <td align="center" class="Tab3">
                            <%#DataBinder.Eval(Container.DataItem, "reminder_date", "{0:d/MMM/yyyy}")%>
                        </td>
                        <td align="center" class="Tab3">
                            <%# Eval("status")%>&nbsp;
                        </td>
                        <td align="center" class="Tab3">
                            <%# Eval("done_remark")%>&nbsp;
                        </td>
                        <td align="center" class="Tab3">
                            <%#DataBinder.Eval(Container.DataItem, "done_date", "{0:d/MMM/yyyy}")%>&nbsp;
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
    </table>
</asp:Content>
