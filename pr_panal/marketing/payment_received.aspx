<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master"
    AutoEventWireup="true" CodeFile="payment_received.aspx.cs" Inherits="Marketing_payment_received" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center" style="display: none;">
        <tr valign="top" class="tdrow3">
            <td colspan="16" class="tdrow5">
                <strong><a href="marketingmain.aspx"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Main Page</font></a> &nbsp;</strong>
            </td>
        </tr>
        <tr valign="top" class="tdrow3">
            <td colspan="16" class="tdrow5">
                <strong><font color="red">No Record Found!!</font></strong>
            </td>
        </tr>
    </table>
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                    <tr>
                        <td align="center">
                            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                <tr>
                                    <td align="center" bgcolor="#E7C84E">
                                        <strong class="Tab2">Received Payment</strong><strong class="Tab3"> </strong>
                                    </td>
                                    <td align="center">
                                        <strong class="Tab2">From
                                            <asp:TextBox ID="text_date_from24" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"
                                                class="Tab2" size="15"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="text_date_from24"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            To
                                            <asp:TextBox ID="text_date_to24" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"
                                                class="Tab2" size="15"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="text_date_to24"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:Button ID="btnsubmit" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroup"
                                                Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                                            <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                                            <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                    <tr>
                        <td align="center">
                            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                <tr>
                                    <td align="center">&nbsp;
                                        <asp:DropDownList ID="select_type" runat="server" CssClass="Tab2">
                                            <%--<asp:ListItem Value="none" Selected="True">Select Project Status</asp:ListItem>--%>
                                            <asp:ListItem Value="Received">Received</asp:ListItem>
                                            <asp:ListItem Value="Completed">Completed</asp:ListItem>
                                            <asp:ListItem Value="Trial Project">Trial Project</asp:ListItem>
                                            <asp:ListItem Value="Dead">Dead</asp:ListItem>
                                            <asp:ListItem Value="All" Selected="True">All</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                                            InitialValue="none" ValidationGroup="valgroup1" Display="Dynamic" ControlToValidate="select_type"
                                            SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <strong class="Tab2">From
                                            <asp:TextBox ID="text_date_from1" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"
                                                class="Tab2" size="15"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup1" Display="Dynamic" ControlToValidate="text_date_from1"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            To
                                            <asp:TextBox ID="text_date_to1" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"
                                                class="Tab2" size="15"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup1" Display="Dynamic" ControlToValidate="text_date_to1"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </strong>
                                        <div class="Tab3">
                                            <asp:Button ID="Button1" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroup1"
                                                Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="409" align="center">
                <table width="100%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#CCCC00">
                    <tr>
                        <td>
                            <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                <tr>
                                    <td align="center">&nbsp;
                                        <strong class="Tab2">Search By </strong>
                                        <asp:DropDownList ID="select2_type" runat="server" CssClass="Tab2">
                                            <asp:ListItem Value="Project ID" Selected="True">Project ID</asp:ListItem>
                                            <asp:ListItem Value="Project Name">Project Name</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:TextBox ID="text_type" runat="server" class="Tab2" size="20"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                                            InitialValue="" ValidationGroup="valgroup2" Display="Dynamic" ControlToValidate="text_type"
                                            SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <div class="Tab3">
                                            <asp:Button ID="Button2" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroup2"
                                                Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" class="tdrow3">
            <td colspan="17" class="tdrow5">
                <strong><a href="marketingmain.aspx"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Main Page</font></a> &nbsp;&nbsp;</strong>
            </td>
        </tr>
        <tr valign="top" class="Tab3">
            <td height="31" colspan="17" align="center" bgcolor="#CCCCCC" class="tdrow5">
                <strong>Result Found</strong> - <strong><font color="#CC0000" size="2">
                    <%=z%></font></strong> &nbsp;[Payment Received From
                <%=text_date_from%>
                To
                <%=text_date_to%>]
            </td>
        </tr>
        <tr valign="top" class="bottom">
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Id&nbsp;&nbsp;&nbsp;&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Proj. Receiving Date</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Type</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Name</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Cost</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Payment Received</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Bal.&nbsp;Cost</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Dev. Cost</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Expenses</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Completed&nbsp;On</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Status</strong>
            </td>
        </tr>
        <tr valign="top" class="tb2">
        </tr>
        <tr valign="top" class="tb2">
            <td colspan="4" align="right" bgcolor="#E6E6E6" class="Tab2">
                <strong>Total</strong>
            </td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">
                <%=total_cost%>
            </td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">
                <%=total_payment_received%>&nbsp;
            </td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">
                <%=total_balance%>&nbsp;
            </td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">
                <%=total_bal_cost_sub%>&nbsp;
            </td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">
                <%=total_expenses%>&nbsp;
            </td>
            <td colspan="2" align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;
            </td>
        </tr>
        <tr valign="top" class="tb2">
            <td colspan="5" align="right" bgcolor="#E6E6E6" class="Tab2">
                <strong>Balance Payment</strong>
            </td>
            <td colspan="2" align="right" bgcolor="#E6E6E6" class="Tab2">
                <%=total_payment_received%>
            </td>
            <td colspan="4" align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;
            </td>
        </tr>
    </table>
    <br>
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" class="Tab3">
            <td height="31" colspan="17" align="center" bgcolor="#CCCCCC" class="tdrow5">
                <strong>Partial Payment</strong> Received From
                <%=text_date_from%>
                To
                <%=text_date_to%>
            </td>
        </tr>
        <tr valign="top" class="bottom">
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Id&nbsp;&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Name&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Type&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Cost&nbsp;(INR)</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Payment Received (INR)</strong>
            </td>
        </tr>
        <asp:Repeater ID="rptCustomers" runat="server">
            <ItemTemplate>
                <tr valign="top" class="bottom">
                    <td bgcolor="#E6E6E6" class="Tab3">
                        <a href="project_Details_selected.aspx?refno=<%# Eval("srno")%>&total_id=<%# Eval("proj_id")%>"
                            target="_blank"><font color="#0000FF">
                                <%# Eval("proj_id")%></font></a>
                    </td>
                    <td bgcolor="#E6E6E6" class="Tab3">
                        <%# Eval("proj_name")%>&nbsp;
                    </td>
                    <td bgcolor="#E6E6E6" class="Tab3">
                        <%# Eval("type_proj")%>&nbsp;
                    </td>
                    <td bgcolor="#E6E6E6" class="Tab3">
                        <%# Eval("cost")%>&nbsp;
                    </td>
                    <td bgcolor="#E6E6E6" class="Tab3">
                        <%# Eval("sumparttial")%><br>
                        <strong><a href="payment_history.asp?srno=<%# Eval("srno")%>">P.&nbsp;History</a></strong>&nbsp;
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <tr valign="top" class="bottom">
            <td bgcolor="#E6E6E6" align="right" colspan="4" class="Tab2">Total&nbsp;
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <%=total_partial_payment%>&nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
