<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="project_home.aspx.cs" Inherits="Admin_project_home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center">
            <td colspan="4" class="Tab2" bgcolor="#CCCCCC">
                <div align="center">
                    <strong>All Project Report</strong>
                </div>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">&nbsp;
            </td>
            <td width="37%" colspan="1" align="right">&nbsp; 
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Status 
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="dd_type" runat="server" Width="150" OnSelectedIndexChanged="dd_type_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Value="none" Selected="True">All</asp:ListItem>
                    <asp:ListItem Value="Trial Project">Trial Project</asp:ListItem>
                    <asp:ListItem Value="Received">Received</asp:ListItem>
                    <asp:ListItem Value="Dead">Dead</asp:ListItem>
                    <asp:ListItem Value="Completed">Completed</asp:ListItem>
                </asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                    InitialValue="none" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="dd_type"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Marketing Person
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="dd_person" runat="server" OnSelectedIndexChanged="dd_person_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Type
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="ddprotype" runat="server" OnSelectedIndexChanged="ddprotype_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>
          <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Technology
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="ddprotechnology" runat="server" OnSelectedIndexChanged="ddprotechnology_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Name
            </td>
            <td colspan="2">&nbsp;
                <asp:ListBox ID="lbProjectName" runat="server" Style="width: 300px; height: 200px;"></asp:ListBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="0" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="lbProjectName"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">&nbsp;
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;</font>
            </td>
        </tr>
        <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="4">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false" Text="0"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
