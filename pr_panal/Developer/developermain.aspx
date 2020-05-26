<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="developermain.aspx.cs" Inherits="Developer_developermain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
    <style type="text/css">
        .style_mr {
            background-color: #FF0000;
        }

        .style1 {
            color: #33FFFF;
        }


        
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

     <div style="text-align: center;" id="blink"><%=WorkDoneorNot%></div>
    <%--You have not started any work till now.    You are sitting ideal since last 1 hours.--%>
    <script type="text/javascript">
        var blink = document.getElementById('blink');
        setInterval(function () {
            blink.style.opacity = (blink.style.opacity == 0 ? 1 : 0);
        }, 1000);
    </script>
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="882" align="center" bgcolor="#E6E6E6">
                <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="Tab3" align="left"><a href="developermain.aspx"><font color="#0000FF"><b>Dashboard</b></font></a></td>
                        <td class="Tab3" align="left"><a href="attendance.aspx"><font color="#0000FF"><b>Attendance</b></font></a></td>
                        <td class="Tab3" align="left"><a href="OutsideInside.aspx"><font color="#0000FF"><b>Outside Inside</b></font></a></td>
                        <td class="Tab3" align="left"><a href="add_reminder.aspx" ><font color="#0000FF"><b>Add New Reminder</b></font></a></td>
                        <td class="Tab3" align="left">
                            <%if (leaveApplyFormStatus > 0)
                                {%>
                            <a href="DeveloperLeave.aspx" class="notification"><font color="#0000FF"><b>Leave Apply Form</b></font>
                                <span class="badge">
                                <%=leaveApplyFormStatus%></span>
                            </a>
                            <%} %>
                            <%else
                                { %>
                                 <a href="DeveloperLeave.aspx" ><font color="#0000FF"><b>Leave Apply Form</b></font></a>
                            <%} %>

                        </td>

                        <td class="Tab3" align="left">
                            <%if (numberOfSeenStatus > 0)
                                {%>
                                   <a href="DeveloperLeaveStatus.aspx"  class="notification"><font color="#0000FF"><b>Applied Leave Status</b></font><span class="badge">
                                <%=numberOfSeenStatus%></span></a>
                            <%} %>
                            <%else
                                { %>
                                     <a href="DeveloperLeaveStatus.aspx" ><font color="#0000FF"><b>Applied Leave Status</b></font></a>
                            <%} %>
                        </td>
                        <td class="Tab3" align="left">
                            <%if (numberOfPendingApprovalLeave > 0)
                                {%>
                            <a href="developerGrantLeave.aspx"  class="notification"><font color="#0000FF"><b>Leave Grant</b></font><span class="badge">
                                <%=numberOfPendingApprovalLeave%></span></a>
                            <%} %>
                            <%else
                                { %>
                            <a href="developerGrantLeave.aspx"  ><font color="#0000FF"><b>Leave Grant</b></font></a>
                            <%} %>

                        </td>
                        <td class="Tab3" align="right"><a href="view_reminder.aspx" target="_blank"><font color="#0000FF"><b>View Done Reminder</b></font></a></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%=ReminderPanel%>
    </table>
    <br>
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <asp:Panel ID="pnlReceived" runat="server" DefaultButton="btnsubmit">
                    <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                        <tr>
                            <td align="center">
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
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td width="409" align="center">
                <asp:Panel ID="Panel1" runat="server" DefaultButton="Button1">
                    <table width="100%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#CCCC00">
                        <tr>
                            <td>
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
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <br>
    <%=InHouseProject%>
    <%=ProjectList%>
    <%=PendingTask%>
    <asp:Panel ID="Panel2" runat="server" DefaultButton="Button2">
        <table width="52%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
            <tr align="center" valign="top" bgcolor="#CCCCCC" class="bottom">
                <td height="20" bgcolor="#CCCCCC" class="Tab2">
                All Activities ::
            </tr>
            <tr valign="top" class="bottom">
                <td height="40" class="Tab2">
                    <p align="left">
                        <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>From</b></font><b><font color="#ffffff">
                            <asp:TextBox ID="txt_dateFrom" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                InitialValue="" ValidationGroup="valgroupActivities" Display="Dynamic" ControlToValidate="txt_dateFrom"
                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                        </font></b><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>To</b></font><b><font color="#ffffff">
                            <asp:TextBox ID="txt_dateTo" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                                InitialValue="" ValidationGroup="valgroupActivities" Display="Dynamic" ControlToValidate="txt_dateTo"
                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                        </font></b>
                        <asp:Button ID="Button2" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupActivities"
                            Style="cursor: pointer; width: 150px;" OnClick="btnSubmit3_Click" CssClass="Tab2" />
                    </p>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br>
    <asp:Panel ID="Panel3" runat="server" DefaultButton="Button3">
        <table width="52%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
            <tr align="center" valign="top" bgcolor="#CCCCCC" class="bottom">
                <td height="26" bgcolor="#CCCCCC" class="Tab2">Total Working Hour Report ::
                </td>
            </tr>
            <tr valign="top" class="bottom">
                <td height="40" class="Tab2">
                    <p align="left">
                        <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>From</b></font><b><font color="#ffffff">
                            <asp:TextBox ID="txt_dateFrom1" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                                InitialValue="" ValidationGroup="valgroupWork" Display="Dynamic" ControlToValidate="txt_dateFrom1"
                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                        </font></b><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>To</b></font><b><font color="#ffffff">
                            <asp:TextBox ID="txt_dateTo1" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="20"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                                InitialValue="" ValidationGroup="valgroupWork" Display="Dynamic" ControlToValidate="txt_dateTo1"
                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                        </font></b>
                        <b><font color="#ffffff">
                            <asp:Button ID="Button3" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupWork"
                                Style="cursor: pointer; width: 150px;" OnClick="btnSubmit4_Click" CssClass="Tab2" />
                        </font></b>
                    </p>
                </td>
            </tr>
        </table>
    </asp:Panel>

</asp:Content>
