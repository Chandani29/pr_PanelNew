<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master"
    AutoEventWireup="true" CodeFile="add_reminder.aspx.cs" Inherits="Marketing_add_reminder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
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
    <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="3" class="txt">
                <strong>Old Reminders</strong>
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
        </tr>
        <tr>
            <asp:Repeater ID="rptCustomers" runat="server">
                <ItemTemplate>
                    <tr>
                        <td align="left" class="Tab3">
                            <%# Eval("subject")%>&nbsp;
                        </td>
                        <td align="left" class="Tab3">
                            <%# Eval("descr")%>&nbsp;
                        </td>
                        <td align="left" class="Tab3">
                            <%#DataBinder.Eval(Container.DataItem, "reminder_date", "{0:d/MMM/yyyy}")%>&nbsp;
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
    </table><br />
    <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="2" class="txt">
                Reminder Entry Form
            </td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3">
                <strong>Date</strong>
            </td>
            <td>
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Reminder Subject</strong>
            </td>
            <td>
                <asp:TextBox ID="txt_re_sub" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_re_sub"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Reminder Description</strong>
            </td>
            <td>
                <asp:TextBox ID="txt_re_desc" runat="server" TextMode="MultiLine" Style="height: 75px;
                    width: 400px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_re_desc"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Reminder Date</strong>
            </td>
            <td>
                <asp:TextBox ID="txt_re_date" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_re_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                &nbsp;
            </td>
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
