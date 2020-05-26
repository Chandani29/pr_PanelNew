<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="adminmain.aspx.cs" Inherits="Admin_adminmain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Developers::&nbsp;
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">User&nbsp;Id::&nbsp;
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">User&nbsp;Password::&nbsp;
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Cost (INR Per Hr)::&nbsp;
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Edit::&nbsp;
            </td>
        </tr>
        <asp:Repeater ID="rptCustomers" runat="server" OnItemDataBound="rptCustomers_ItemDataBound">
            <ItemTemplate>
                <tr>
                    <td valign="middle" class="Tab3">
                        <a href="../Pr-Admin-Log?uid=<%# Eval("user_id")%>" target="_blank">
                            <%# Eval("name")%></a>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("user_id")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("user_pass")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("per_cost")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <a href="create_developer.aspx?srno=<%# Eval("srno")%>">Edit</a>&nbsp;
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Repeater ID="Repeater2" runat="server">
            <ItemTemplate>
                <tr>
                    <td valign="middle" class="Tab3" style="color: red">
                        <a href="../Pr-Admin-Log?uid=<%# Eval("user_id")%>" target="_blank">
                            <%# Eval("name")%></a>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3" style="color: red">
                        <%# Eval("user_id")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3" style="color: red">
                        <%# Eval("user_pass")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3" style="color: red">
                        <%# Eval("per_cost")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3" style="color: red">
                        <a href="create_developer.aspx?srno=<%# Eval("srno")%>">Edit</a>&nbsp;
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <br>
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Marketing::&nbsp;
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">User&nbsp;Id::&nbsp;
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">User&nbsp;Password::&nbsp;
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Edit::&nbsp;
            </td>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <tr>
                    <td valign="middle" class="Tab3">
                        <a href="../Pr-Admin-Log?uid=<%# Eval("user_id")%>" target="_blank">
                            <%# Eval("name")%></a>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("user_id")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("user_pass")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <a href="create_marketing.aspx?srno=<%# Eval("srno")%>">Edit</a>&nbsp;
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Repeater ID="Repeater3" runat="server">
            <ItemTemplate>
                <tr>
                    <td valign="middle" class="Tab3" style="color: red">
                        <a href="../Pr-Admin-Log?uid=<%# Eval("user_id")%>" target="_blank">
                            <%# Eval("name")%></a>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3" style="color: red">
                        <%# Eval("user_id")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3" style="color: red">
                        <%# Eval("user_pass")%>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3" style="color: red">
                        <a href="create_marketing.aspx?srno=<%# Eval("srno")%>">Edit</a>&nbsp;
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <%--<br>
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="middle" class="Tab2" colspan="2" bgcolor="#CCCCCC"><a href="pending_list.aspx" target="_blank">Pending&nbsp;List::&nbsp;</a></td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC"><a href="project_home.aspx" target="_blank">Project&nbsp;List::&nbsp;</a></td>
        </tr>
    </table>--%>
    <br>
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                    <tr>
                        <td align="center">
                            <asp:Panel ID="Panel2" runat="server" DefaultButton="btnsubmit">
                                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                    <tr>
                                        <td align="center" bgcolor="#E7C84E"><strong class="Tab2">Received
                        Payment</strong><strong class="Tab3"> </strong></td>
                                        <td align="center"><strong class="Tab2">From
                                        <asp:TextBox ID="text_date_from24" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="15"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroupdate" Display="Dynamic" ControlToValidate="text_date_from24"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            To
                                        <asp:TextBox ID="text_date_to24" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="15"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroupdate" Display="Dynamic" ControlToValidate="text_date_to24"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:Button ID="btnsubmit" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupdate"
                                                Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                                        </strong></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br>
</asp:Content>
