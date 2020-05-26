<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="reminder_done.aspx.cs" Inherits="Developer_reminder_done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="2" class="txt">
                Reminder (<%=WelcomeMessages%>)
            </td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3">
                <strong>Subject</strong>
            </td>
            <td width="185" align="left" class="Tab3">
                <%=re_sub%>
            </td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3">
                <strong>Description</strong>
            </td>
            <td width="185" align="left" class="Tab3">
                <%=re_desc%>
            </td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3">
                <strong>Reminder Date</strong>
            </td>
            <td width="185" align="left" class="Tab3">
                <%=re_date%>
            </td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3">
                <strong>Date</strong>
            </td>
            <td>
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Remark</strong>
            </td>
            <td>
                <asp:TextBox ID="txt_remark" runat="server" Style="height: 100px; width: 300px;"
                    TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_remark"
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
