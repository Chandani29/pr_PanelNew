<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="search_project.aspx.cs" Inherits="Marketing_search_project" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                    <tr>
                        <td align="center">
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnsubmit">
                                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                    <tr>
                                        <td align="center">&nbsp;
                                            <select id="select_type" runat="server" name="select_type" class="Tab2">
                                                <option value="Received">Received</option>
                                                <option value="Completed">Completed</option>
                                                <option value="Trial Project">Trial Project</option>
                                                <option value="Dead">Dead</option>
                                                <option value="All" selected>All</option>
                                                <%--<option value="none">Select Project Status</option>--%>
                                            </select>
                                            <strong class="Tab2">From 
                                            <asp:TextBox ID="text_date_from" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="15"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                                    InitialValue="" ValidationGroup="valgroupdate" Display="Dynamic" ControlToValidate="text_date_from"
                                                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                                To
                                            <asp:TextBox ID="text_date_to" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="15"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                    InitialValue="" ValidationGroup="valgroupdate" Display="Dynamic" ControlToValidate="text_date_to"
                                                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </strong>
                                            <div class="Tab3">
                                                <asp:Button ID="btnsubmit" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupdate"
                                                    Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="409" align="center">
                <table width="100%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#CCCC00">
                    <tr>
                        <td>
                            <asp:Panel ID="Panel2" runat="server" DefaultButton="Button1">
                                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                    <tr>
                                        <td align="center">&nbsp;<strong class="Tab2">Search By </strong>
                                            <select id="select2_type" runat="server" name="select2_type" class="Tab2">
                                                <option value="Project Name">Project Name</option>
                                                <option value="Project ID">Project ID</option>
                                            </select>
                                            <strong class="Tab2">
                                                <asp:TextBox ID="text_type" runat="server" class="Tab2" size="20"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                                    InitialValue="" ValidationGroup="valgroupname" Display="Dynamic" ControlToValidate="text_type"
                                                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </strong>
                                            <div class="Tab3">
                                                <asp:Button ID="Button1" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupname"
                                                    Style="cursor: pointer;" OnClick="btnSubmit2_Click" CssClass="Tab2" />
                                            </div>
                                        </td>
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
    <%=InHouseProject%>
    <%=ProjectList%>
</asp:Content>

