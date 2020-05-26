<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="delete_status.aspx.cs" Inherits="Marketing_delete_status" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td class="txt">Reason For Distroy This Proejct:</td>
        </tr>
        <tr>
            <td align="center" class="Tab3">
                <asp:TextBox ID="txt_remark" runat="server" TextMode="MultiLine" Style="width: 400px; height: 115px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_remark"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Text="Cancel" ToolTip="Cancel"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit2_Click" CssClass="Tab2" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false" Text="0"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

