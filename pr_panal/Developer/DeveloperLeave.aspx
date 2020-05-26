<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="DeveloperLeave.aspx.cs" Inherits="Developer_DeveloperLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                            <a href="DeveloperLeave.aspx"  class="notification"><font color="#0000FF"><b>Leave Apply Form</b></font>
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
                            <a href="developerGrantLeave.aspx" ><font color="#0000FF"><b>Leave Grant</b></font></a>
                            <%} %>

                        </td>
                        <td class="Tab3" align="right"><a href="view_reminder.aspx" ><font color="#0000FF"><b>View Done Reminder</b></font></a></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%=ReminderPanel%>
    </table>

    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
    <script>
        $(document).ready(function () {
            // Date Object
            //var date = new Date();
            //date.setDate(date.getDate() + 7);
            var date = null;
            if ('<%=dtCurrentFormDate%>' != '') {
                date = new Date('<%=dtCurrentFormDate%>');
                $('.ddlApprovedByClass').prop('disabled', true);
                document.getElementById("<%=RequiredFieldValidator8.ClientID %>").enabled = false;
            }
            else {
                date = new Date();
                date.setDate(date.getDate() + 7);
                $('.ddlApprovedByClass').prop('disabled', false);
                document.getElementById("<%=RequiredFieldValidator8.ClientID %>").enabled = true;
            }

            $('.dateFrom').datepicker({
                dateFormat: "yy-mm-dd",
                minDate: date,
                onSelect: function (selected) {
                    var dt = new Date(selected);
                    dt.setDate(dt.getDate() + 1);
                    $(".dateTo").datepicker("option", "minDate", dt);
                },
            });


            $(".dateTo").datepicker({
                dateFormat: "yy-mm-dd",
                minDate: date,
                onSelect: function (selected) {
                    var dt = new Date(selected);
                    dt.setDate(dt.getDate() - 1);
                    $(".dateFrom").datepicker("option", "maxDate", dt);
                }
            });

        });
    </script>
    <h5>Leave Application Form (Please fill this form atleast 7 days before.)</h5>
    <asp:Label ID="lblmsg" runat="server" Style="color: green;"></asp:Label>
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td>Date From:  </td>
            <td style="width: 23px;">
                <asp:TextBox ID="txtFrom" runat="server" type="text" class="dateFrom" placeholder="yyyyy-mm-dd" autocomplete="off"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtFrom"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
            <td>Date To:  </td>
            <td colspan="3">
                <asp:TextBox ID="txtTo" runat="server" class="dateTo" placeholder="yyyyy-mm-dd" autocomplete="off"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtTo"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>

        </tr>
        <tr>
            <td>Last Working day:  </td>
            <td>
                <asp:TextBox ID="txtLastWorkingDay" runat="server" placeholder="Last working day & Date before leave" Style="margin: 0px; width: 500px; height: 60px;" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtLastWorkingDay"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
            <td>Reporting Date:  </td>
            <td colspan="3">
                <asp:TextBox ID="txtReportingDate" runat="server" placeholder="Reporting Date & Day" Style="height: 25px; width: 162px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtReportingDate"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Address:  </td>
            <td>
                <asp:TextBox ID="txtAddress" runat="server" placeholder="Address during leave period" Style="margin: 0px; width: 500px; height: 60px;" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtAddress"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
            <td>Mobile No:  </td>
            <td colspan="3">
                <asp:TextBox ID="txtMobileNo" runat="server" placeholder="Mobile Number" Style="height: 25px; width: 162px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtMobileNo"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>

        </tr>
        <tr>
            <td>Jobs TO Do Before Leave :</td>
            <td colspan="5">
                <asp:TextBox ID="txtJobsTODoBeforeLeave" runat="server" Style="margin: 0px; width: 1153px; height: 73px;"
                    TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtJobsTODoBeforeLeave"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Reason for Leave:</td>
            <td colspan="5">
                <asp:TextBox ID="txtReasonforLeave" runat="server" placeholder="Reason for Leave" Style="margin: 0px; width: 1153px; height: 105px;" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtReasonforLeave"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>

            </td>
        </tr>
        <tr>
            <%--<td>Job Profile:</td><td> <input type="text" /></td>--%>
            <td>Approved By:  </td>
            <td colspan="5">
                <%--<select style="width:172px;height:31px;"><option>--Select--</option><option>Ram</option><option>Radha</option></select>--%>
                <asp:DropDownList ID="ddlApprovedBy" class="ddlApprovedByClass" runat="server" Width="150" Style="width: 172px; height: 31px;">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" class="ddlApprovedByValidClass" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="ddlApprovedBy"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr align="center">
            <td colspan="6">
                <%--<input type="button" value="Submit" />--%>

                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
            </td>
        </tr>
    </table>
</asp:Content>
