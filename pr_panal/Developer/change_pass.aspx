<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="change_pass.aspx.cs" Inherits="Developer_change_pass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="400" border="1" cellspacing="2" cellpadding="1" class='tdrow4' align='center'>
        <tr align="center">
            <td colspan="2" class="txt">Change Password</td>
        </tr>
        <tr>
            <td width="185" align="right" class="Tab3"><strong>Old Password</strong></td>
            <td>
                <asp:TextBox ID="txt_oldpass" runat="server" TextMode="Password" size="20"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ControlToValidate="txt_oldpass" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td width="185" align="right" class="Tab3"><strong>New Password</strong></td>
            <td>
                <asp:TextBox ID="txt_newpass" runat="server" TextMode="Password" size="20"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ControlToValidate="txt_newpass" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td width="185" align="right" class="Tab3"><strong>Confirm Password</strong></td>
            <td>
                <asp:TextBox ID="password" runat="server" TextMode="Password" size="20"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                    ControlToValidate="password" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server"
                    ControlToCompare="txt_newpass" ControlToValidate="password"
                    ErrorMessage="Password Mismatch" Display="Dynamic" SetFocusOnError="true" ForeColor="Red"></asp:CompareValidator>
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

