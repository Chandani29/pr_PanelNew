<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="deleted_resign.aspx.cs" Inherits="Developer_deleted_resign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="50%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr bgcolor="#E6E6E6" class="bottom">
            <td colspan="4" align="center" valign="top" class="Tab2" bgcolor="#CCCCCC">Remarks::</td>
        </tr>
        <tr bgcolor="#E6E6E6" class="bottom">
            <td width="50%" class="Tab3">
                <asp:TextBox ID="del_resion" runat="server" TextMode="MultiLine" Style="height: 135px; width: 100%;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="del_resion"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr align="center" bgcolor="#E6E6E6" class="bottom">
            <td width="50%" class="Tab2">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" ToolTip="Cancel"
                    Style="cursor: pointer; width: 150px;" OnClick="btnCancel_Click" CssClass="Tab2" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

