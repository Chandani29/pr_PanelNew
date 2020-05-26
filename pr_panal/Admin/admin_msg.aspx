<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="admin_msg.aspx.cs" Inherits="Admin_admin_msg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="400" border="1" cellspacing="2" cellpadding="1" class='tdrow4' align='center'>
        <tr align="center">
            <td colspan="3" class="txt"><strong class="Tab2">&nbsp;</strong><br>
                Admin Message</td>
        </tr>
        <tr>
            <td align="center" class="Tab3"><strong>Date</strong></td>
            <td align="center" class="Tab3"><strong>New Message</strong></td>
        </tr>
        <tr>
            <td align="left" class="Tab3"><%=submeted_on%>&nbsp;</td>
            <td align="left" class="Tab3"><%=a_msg%>&nbsp;</td>
        </tr>
    </table><br />
    <table width="400" border="1" cellspacing="2" cellpadding="1" class='tdrow4' align='center'>
        <tr align="center">
            <td colspan="2" class="txt">Admin Message  Entry Form</td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3"><strong>Date</strong></td>
            <td width="185" align="left" class="Tab3">
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true" size="20"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3"><strong>New Message</strong></td>
            <td>
                <asp:TextBox ID="txt_re_desc" runat="server" TextMode="MultiLine" Style="height: 75px; width: 400px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_re_desc"
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

