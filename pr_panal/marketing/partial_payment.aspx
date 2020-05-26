<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master"
    AutoEventWireup="true" CodeFile="partial_payment.aspx.cs" Inherits="Marketing_partial_payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="5" class="txt">Summary of Payment
            </td>
        </tr>
        <tr>
            <td align="center" class="Tab3">
                <strong>Project&nbsp;Name</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Project&nbsp;ID</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Date</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Paid Ammount INR</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Payment Type</strong>
            </td>
        </tr>
        <tr>
            <asp:Repeater ID="rptCustomers" runat="server" OnItemDataBound="rptCustomers_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <td align="center" class="Tab3">
                            <asp:Label ID="lblproj_id" runat="server" Visible="false" Text='<%# Eval("proj_id")%>'></asp:Label>
                            <asp:Label ID="lblp_name1" runat="server"></asp:Label>
                        </td>
                        <td align="center" class="Tab3">
                            <asp:Label ID="lblp_id1" runat="server"></asp:Label>
                        </td>
                        <td align="center" class="Tab3">
                            <%#DataBinder.Eval(Container.DataItem, "ddate", "{0:d/MMM/yyyy}")%>
                        </td>
                        <td align="center" class="Tab3">
                            <%# Eval("p_payment")%>&nbsp;
                        </td>
                        <td align="center" class="Tab3">
                            <%# Eval("pay_mode")%>&nbsp;
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
    </table><br />

    <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="2" class="txt">Note: Make sure payment has been recieved
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Project ID/Name</strong>
            </td>
            <td align="left" class="Tab2">
                <%= p_name %>
                -
                <%= p_id %>
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Date</strong>
            </td>
            <td align="left" class="Tab3">
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3">
                <strong>Paid Ammount INR</strong>
            </td>
            <td width="185">
                <asp:TextBox ID="txt_amount" runat="server" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_amount"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Payment Type</strong>
            </td>
            <td>
                <asp:TextBox ID="txt_PayType" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_PayType"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input name="Submit2" type="button" class="Tab2" value="Cancel" onclick="window.location = 'marketingmain.aspx';" style="cursor: pointer;" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
