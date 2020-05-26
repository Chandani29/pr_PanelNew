<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="add_expense.aspx.cs" Inherits="Marketing_add_expense" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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

