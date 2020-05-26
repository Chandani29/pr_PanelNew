<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="project_list.aspx.cs" Inherits="Admin_project_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" class="tdrow3">
            <td colspan="19" align="center" bgcolor="#CCCCCC" class="tdrow5">
                <div align="center">
                    <strong>Project Summary</strong>
                </div>
            </td>
        </tr>
        <tr valign="top" class="bottom">
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Assigned From</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Id&nbsp;&nbsp;&nbsp;&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Date</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Source</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Type</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Name</strong>
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
                <strong>Assigned To</strong>
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
                <strong>&nbsp;&nbsp;&nbsp;&nbsp;Client&nbsp;Remarks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project Expenses</strong>
            </td>
            <td bgcolor="#E6E6E6" class="Tab2">
                <strong>Project&nbsp;Status</strong>
            </td>
        </tr>
        <tr valign="top" class="tb2">
            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                    <tr valign="top" class="tb2">
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblmp_id" runat="server" Visible="false" Text='<%# Eval("mp_id")%>'></asp:Label>
                            <asp:Label ID="lblAssignedFrom" runat="server"></asp:Label>
                            &nbsp;
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <asp:Label ID="lblproj_id" runat="server" Visible="false" Text='<%# Eval("proj_id")%>'></asp:Label>
                            <a id="aPD" runat="server" target="_blank"><font color='#000'>
                                <%# Eval("proj_id")%></font></a>
                        </td>
                        <td bgcolor="#E6E6E6" class="Tab3">
                            <%#DataBinder.Eval(Container.DataItem, "ddate", "{0:d/MMM/yyyy}")%>&nbsp;
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
                            <asp:Label ID="lblsrno" runat="server" Visible="false" Text='<%# Eval("srno")%>'></asp:Label>
                            <%# Eval("proj_name")%>
                            <asp:Label ID="lblproj_name_url" runat="server"></asp:Label>
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
                            <asp:Label ID="lblpartial_payment" runat="server"></asp:Label>
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
                            <asp:Label ID="lblproj_expenses" runat="server"></asp:Label>&nbsp;
                        </td>
                        <asp:Label ID="lblworkstatus" runat="server" Text='<%# Eval("workstatus")%>' Visible="false"></asp:Label>
                        <asp:Label ID="lblworkstatusShow" runat="server"></asp:Label>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
        <tr valign="top" class="tb2">
            <td colspan="6" align="right" bgcolor="#E6E6E6" class="Tab2"><strong>Total</strong></td>
            <td align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=total_hour%></strong></td>
            <td align="left" bgcolor="#E6E6E6" class="Tab2"><strong><%=total_hour_ex%></strong></td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2"><%=total_cost%></td>
            <td colspan="4" align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;Total</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2"><%=total_payment_received%>&nbsp;</td>
            <td colspan="2" align="left" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">Total</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2"><%=total_expenses%>&nbsp;</td>
            <td align="right" bgcolor="#E6E6E6" class="Tab2">&nbsp;</td>
        </tr>
    </table>
</asp:Content>

