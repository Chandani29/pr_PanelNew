<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="add_inhouse_proj.aspx.cs" Inherits="Marketing_add_inhouse_proj" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="50%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom">
            <td align="center" class="Tab2">SrNo.</td>
            <td align="center" class="Tab2">Date</td>
            <td align="center" class="Tab2">InHouse Project </td>
        </tr>
        <asp:Repeater ID="rptCustomers" runat="server">
            <ItemTemplate>
                <tr align="center" valign="top">
                    <td align="center" class="Tab3">
                        <%# Eval("srno")%>
                    </td>
                    <td align="center" class="Tab3">
                        <%#DataBinder.Eval(Container.DataItem, "ddate", "{0:d/MMM/yyyy}")%>
                    </td>
                    <td align="center" class="Tab3">
                        <%# Eval("ProjName")%>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <br>
    <table width="50%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom">
            <td align="center" class="Tab2">Add New InHouse Project </td>
            <td>&nbsp;
                <asp:TextBox ID="txt_projInhouse" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_projInhouse"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                <input name="Submit2" type="Reset" class="Tab2" style="cursor: pointer; width: 150px;" value="Reset"><br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

