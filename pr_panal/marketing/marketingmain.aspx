<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master"
    AutoEventWireup="true" CodeFile="marketingmain.aspx.cs" Inherits="Marketing_marketingmain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style_mr {
            background-color: #FF0000;
        }

        .style1 {
            color: #33FFFF;
        }
    </style>
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js" type="text/javascript"></script>
    <script type="text/javascript" language="JavaScript">
        $(document).ready(function () {
            document.cookie = "notAvMsg=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
            $("[id^='notAv_']").click(function () {
                if ($(this).attr("href") != "javascript:void(0);") {
                    //$("[id$='hdnMessage']").val($("#txtArea_" + $(this).attr("id").substring(6)).val());
                    document.cookie = "notAvMsg=" + $("#txtArea_" + $(this).attr("id").substring(6)).val();
                    return true;
                }
                //alert($(this).attr("id").substring(6));
                $("#txtArea_" + $(this).attr("id").substring(6)).fadeIn("slow");
                $("#cancelnotAv_" + $(this).attr("id").substring(6)).fadeIn("slow");
                $(this).attr("href", $(location).attr("href") + "?notavid=" + $(this).attr("id").substring(6));
                return false;
            });
            $("[id^='cancelnotAv_']").click(function () {
                //alert($(this).attr("id").substring(6));
                $("#txtArea_" + $(this).attr("id").substring(12)).val("");
                $("#txtArea_" + $(this).attr("id").substring(12)).fadeOut("slow");
                $("#cancelnotAv_" + $(this).attr("id").substring(12)).fadeOut("slow");
                $("#notAv_" + $(this).attr("id").substring(12)).attr("href", "javascript:void(0);");

            });

        });

        function Controls(obj) {
            var dd_status = obj[obj.selectedIndex].value;
            var dd_value = dd_status.substring(0, dd_status.indexOf('_'))
            if (dd_value == "Dead") {
                window.location = "delete_status.aspx?srno=" + dd_status;
            }
            if (dd_value == "Completed") {
                window.location = "complete_status.aspx?srno=" + dd_status; 
            }
            if (dd_value == "Received") {
                window.location = "trial_status.aspx?srno=" + dd_status;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="882" align="center" bgcolor="#E6E6E6">
                <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                         <td class="Tab3" align="left"><a href="attendance.aspx"><font color="#0000FF"><b>Attendance</b></font></a></td>
                        <td class="Tab3" align="left"><a href="OutsideInside.aspx"><font color="#0000FF"><b>Outside Inside</b></font></a></td>
                        <td class="Tab3" align="left"><a href="add_reminder.aspx" target="_blank"><font color="#0000FF"><b>Add New Reminder</b></font></a></td>
                        <td class="Tab3" align="right"><a href="view_reminder.aspx" target="_blank"><font color="#0000FF"><b>View Done Reminder</b></font></a></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <%=ReminderPanel%>
    </table>
    <br />
    <%--style="display:none;"--%>
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                    <tr>
                        <td align="center">
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnsubmit">
                                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                    <tr>
                                        <td align="center" bgcolor="#E7C84E">
                                            <strong class="Tab2">Received Payment</strong><strong class="Tab3"> </strong>
                                        </td>
                                        <td align="center">&nbsp;
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
                                            <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                                                Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" /><br />
                                            <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                                            <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
                                        </strong>
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
    <br />
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                    <tr>
                        <td align="center">
                            <asp:Panel ID="Panel2" runat="server" DefaultButton="Button2">
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
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                                                    InitialValue="" ValidationGroup="valgroupdate" Display="Dynamic" ControlToValidate="text_date_from"
                                                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                                To
                                            <asp:TextBox ID="text_date_to" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);" class="Tab2" size="15"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                                                    InitialValue="" ValidationGroup="valgroupdate" Display="Dynamic" ControlToValidate="text_date_to"
                                                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </strong>
                                            <div class="Tab3">
                                                <asp:Button ID="Button2" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupdate"
                                                    Style="cursor: pointer;" OnClick="btnSubmit3_Click" CssClass="Tab2" />
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
                            <asp:Panel ID="Panel3" runat="server" DefaultButton="Button3">
                                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                    <tr>
                                        <td align="center">&nbsp;<strong class="Tab2">Search By </strong>
                                            <select id="select2_type" runat="server" name="select2_type" class="Tab2">
                                                <option value="Project Name">Project Name</option>
                                                <option value="Project ID">Project ID</option>
                                            </select>
                                            <strong class="Tab2">
                                                <asp:TextBox ID="text_type" runat="server" class="Tab2" size="20"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                                                    InitialValue="" ValidationGroup="valgroupname" Display="Dynamic" ControlToValidate="text_type"
                                                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </strong>
                                            <div class="Tab3">
                                                <asp:Button ID="Button3" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupname"
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
    <br />
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" class="tdrow3">
            <td colspan="19" class="tdrow5">
                <strong><a href="add_project.aspx"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Add New Project</font></a> &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#desinger"><font
                    size="1" face="Verdana, Arial, Helvetica, sans-serif">Designper/Developer List</font></a>
                    &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="#activities"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">All
                        Activities</font></a> &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="pending_list.aspx" target="_blank"><font
                            size="1" face="Verdana, Arial, Helvetica, sans-serif">Pending List</font></a> &nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="add_expense.aspx" target="_blank"><font
                                size="1" face="Verdana, Arial, Helvetica, sans-serif">Add Expense</font></a></strong>
            </td>
        </tr>
        <tr valign="top" class="tdrow3">
            <td colspan="19" align="center" bgcolor="#CCCCCC" class="tdrow5">
                <div align="center">
                    <strong>Project Summary</strong>
                </div>
            </td>
        </tr>
        <tr valign="top" class="bottom">
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Id&nbsp;&nbsp;&nbsp;&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Date</strong>
            </td>
              <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Name</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Source</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Type</strong>
            </td>
          
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Total Hours</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Balance Hour </strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Cost</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Bal.&nbsp;Cost</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Delivery date</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Assigned to</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Payment Received</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Payment Type</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Completed&nbsp;On</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>&nbsp;&nbsp;&nbsp;&nbsp;client&nbsp;Remarks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Expenses</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Status</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Edit</strong>
            </td>
        </tr>
        <tr valign="top" class="tb2">
            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                    <tr valign="top" class="tb2">
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblproj_id" runat="server" Visible="false" Text='<%# Eval("proj_id")%>'></asp:Label>
                            <a id="aPD" runat="server" target="_blank"><font color='#000'>
                                <%# Eval("proj_id")%></font></a>
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <%#DataBinder.Eval(Container.DataItem, "ddate", "{0:d/MMM/yyyy}")%>&nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblsrno" runat="server" Visible="false" Text='<%# Eval("srno")%>'></asp:Label>
                            <%# Eval("proj_name")%>
                            <asp:Label ID="lblproj_name_url" runat="server"></asp:Label>
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <%# Eval("proj_source")%>&nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lbltype_proj" runat="server" Visible="false" Text='<%# Eval("type_proj")%>'></asp:Label>
                            <asp:Label ID="lbltype_projshow" runat="server"></asp:Label>
                            &nbsp;
                        </td> 
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lbltotal_hour_Show" runat="server" Text='<%# Eval("total_hour")%>'></asp:Label>&nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblhour_exp" runat="server"></asp:Label>&nbsp;
                        </td>
                        <td align="right" bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblcost" runat="server" Text='<%# Eval("cost")%>'></asp:Label>&nbsp;
                        </td>
                        <td id="tdBalanceCost" runat="server" align="right" class="Tab2">
                            <asp:Label ID="lblBalanceCost" runat="server"></asp:Label>&nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <%#DataBinder.Eval(Container.DataItem, "submeted_on", "{0:d/MMM/yyyy}")%>&nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblasigned_per" runat="server" Visible="false" Text='<%# Eval("asigned_per")%>'></asp:Label>
                            <asp:Label ID="lblasigned_pershow" runat="server"></asp:Label>&nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblproj_desc" runat="server" Visible="false" Text='<%# Eval("proj_desc")%>'></asp:Label>
                            <asp:Label ID="lblproj_descshow" runat="server"></asp:Label>&nbsp;
                        </td>
                        <td align="right" bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblpartial_payment" runat="server"></asp:Label><br />
                            <strong><a href="partial_payment.aspx?srno=<%# Eval("srno")%>">Part.&nbsp;Pay.</a></strong>
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <%# Eval("payment_Type")%>&nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <%#DataBinder.Eval(Container.DataItem, "completed_on", "{0:d/MMM/yyyy}")%>&nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3" align="right">
                            <%# Eval("Remark")%>&nbsp;
                        </td>
                        <td align="right" bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblproj_expenses" runat="server"></asp:Label><br />
                            <a href="proj_expenses.aspx?srno=<%# Eval("srno")%>"><strong>Expense</strong></a>&nbsp;
                        </td>
                        <asp:Label ID="lblworkstatus" runat="server" Text='<%# Eval("workstatus")%>' Visible="false"></asp:Label>
                        <asp:Label ID="lblworkstatusShow" runat="server"></asp:Label>
                        <td bgcolor="#E6E6E6" class="Tab3"> 
                            <strong><a href="add_project.aspx?srno=<%# Eval("srno")%>">Edit</a></strong>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
        <tr valign="top" class="tb2">
            <td colspan="5" align="right" bgcolor="#E6E6E6" class="Tab2"><strong>Total</strong></td>
            <td align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=total_hour%></strong></td>
            <td align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=total_hour_ex%></strong></td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2"><%=total_cost%></td>
            <td colspan="4" align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;Total</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2"><%=total_payment_received%>&nbsp;</td>
            <td colspan="2" align="left" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">Total</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2"><%=total_expenses%>&nbsp;</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>
        </tr>
    </table>
    <br />
    <%=PendingTask %>
    <br />
    <table width="100%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tb2">
            <td class="Tab2" colspan="8" align="left" bgcolor="#CCCCCC">
                <div align="center">
                    <a name="desinger"></a>Designers/Developers 
            ::
                </div>
            </td>
            <td class="Tab2" colspan="4" align="left" bgcolor="#CCCCCC">
                <div align="center">
                    <a name="desinger"></a>Cost (INR Per Hr)
            ::
                </div>
            </td>
            <td class="Tab2" colspan="15" align="left" bgcolor="#CCCCCC">
                <div align="center">
                    Not Available Messages
                </div>
            </td>
        </tr>
        <tr>
            <asp:Repeater ID="Repeater2" runat="server">
                <ItemTemplate>
                    <tr valign="top" bgcolor="#E6E6E6" class="tb2">
                        <td class="Tab2" colspan="8" align="left">
                            <a href='pending_details.aspx?uid=<%# Eval("user_id")%>' target="_blank"><%# Eval("name")%></a>
                        </td>
                        <td class="Tab2" colspan="4" align="center">
                            <%# Eval("per_cost")%>
                        </td>
                        <td class="Tab2" colspan="15" align="right">
                            
                            <textarea id="txtArea_<%# Eval("user_id")%>" name="txtArea_<%# Eval("user_id")%>" style="display:none;" rows="2" cols="70" ></textarea>
                            <a href="javascript:void(0);" id="cancelnotAv_<%# Eval("user_id")%>" style="display:none;"><input type="button"  value="Cancel"/></a>
                            <a href="javascript:void(0);" id="notAv_<%# Eval("user_id")%>"><input type="button"  value="Not Available"/></a>
                            </br>
                            <%# Eval("msg")%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
    </table>
    <br />
    <asp:Panel ID="Panel4" runat="server" DefaultButton="Button1">
        <table width="550" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
            <tr valign="top" bgcolor="#999999" class="bottom">
                <td height="20" bgcolor="#CCCCCC" class="Tab2">
                    <div align="center">
                        <a name="activities" id="activities"></a>All 
              Activities ::
                    </div>
                </td>
            </tr>
            <tr valign="top" class="bottom">
                <td height="40" align="center" class="Tab2">
                    <p align="left">
                        <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>From</b></font><b><font color="#ffffff">
                            <asp:TextBox ID="txt_dateFrom" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"
                                class="Tab2" size="15"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                InitialValue="" ValidationGroup="valgroupall" Display="Dynamic" ControlToValidate="txt_dateFrom"
                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                        </font></b><font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>To</b></font><b><font color="#ffffff">
                            <asp:TextBox ID="txt_dateTo" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"
                                class="Tab2" size="15"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                InitialValue="" ValidationGroup="valgroupall" Display="Dynamic" ControlToValidate="txt_dateTo"
                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                        </font></b>
                        <asp:Button ID="Button1" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroupall"
                            Style="cursor: pointer; width: 150px;" OnClick="btnSubmitAll_Click" CssClass="Tab2" />
                    </p>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
