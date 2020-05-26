<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="pay_now.aspx.cs" Inherits="Admin_pay_now" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
    <script type="text/javascript">
        function isNumberKey(evt, element) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (
                (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
                (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                    <tr>
                        <td align="center">
                            <asp:Panel ID="Panel2" runat="server" DefaultButton="btnsubmit">
                                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                    <tr>
                                        <td align="center" bgcolor="#E7C84E"><strong class="Tab2">Pay
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
                                            <asp:Button ID="Button2" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupdate"
                                                Style="cursor: pointer;" OnClick="btnSubmit3_Click" CssClass="Tab2" />
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
    <%=PartialPayment %>
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center">
            <td colspan="4" class="Tab2" bgcolor="#CCCCCC">
                <div align="center">
                    <strong>Enter Expense</strong>
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
            <td colspan="2" align="center">Date
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_date" runat="server" ReadOnly="true" size="30"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Marketing Id
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_uid" runat="server" ReadOnly="true" size="30"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Amount
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_amount" runat="server" size="30" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_amount"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Description
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_desc" runat="server" TextMode="MultiLine" Style="width: 600px; height: 200px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_desc"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
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
                <asp:Button ID="Button1" runat="server" Text="Reset" ToolTip="Reset" Style="cursor: pointer; width: 150px;"
                    OnClick="btnSubmit2_Click" CssClass="Tab2" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false" Text="0"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>