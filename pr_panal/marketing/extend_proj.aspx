<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master"
    AutoEventWireup="true" CodeFile="extend_proj.aspx.cs" Inherits="Marketing_extend_proj" %>

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
    <table width="1000" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="7" class="txt">Summary of Payment
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
                <strong>Total Hour</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Total Cost</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Delivery Date</strong>
            </td>
            <td align="center" class="Tab3">
                <strong>Description</strong>
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
                            <asp:Label ID="lbltotal_hour" runat="server"></asp:Label>
                        </td>
                        <td align="center" class="Tab3">
                            <%# Eval("P_cost")%>&nbsp;
                        </td>
                        <td align="center" class="Tab3">
                            <asp:Label ID="lblsubmeted_on" runat="server"></asp:Label>
                        </td>
                        <td align="center" class="Tab3">
                            <asp:Label ID="lblproj_desc" runat="server"></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
    </table>
    <br />
    <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="2" class="txt">
                Kindly fill the new requirements :
            </td>
        </tr>
        <tr>
            <td align="center" class="Tab3">
                <strong>Project ID/Name</strong>
            </td>
            <td align="left" class="Tab2">
                <%= p_name %>
                -
                <%= p_id %>
            </td>
        </tr>
        <tr>
            <td align="center" class="Tab3">
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
            <td align="center" class="Tab3">
                <strong>Hour</strong>
            </td>
            <td align="left" class="Tab3">
                <asp:TextBox ID="txt_totalHour" runat="server" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_totalHour"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                [Hour you want to increase]
            </td>
        </tr>
        <tr>
            <td align="center" class="Tab3">
                <strong>Cost</strong>
            </td>
            <td align="left" class="Tab3">
                <asp:TextBox ID="txt_totalcost" runat="server" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_totalcost"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                [Cost you want to increase]
            </td>
        </tr>
        <tr>
            <td align="center" class="Tab3">
                <strong>Delivery Date</strong>
            </td>
            <td align="left" class="Tab3">
                <asp:TextBox ID="txt_Delivery" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_Delivery"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                [You can extend/reduce delivery date, if required]
            </td>
        </tr>
        <tr>
            <td align="center" class="Tab3">
                <strong>New Description/Remarks</strong>
            </td>
            <td align="left" class="Tab3">
                <asp:TextBox ID="txt_remark" runat="server" TextMode="MultiLine" Style="height: 250px;
                    width: 650px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_remark"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                &nbsp;&nbsp;&nbsp;
                <input style="cursor: pointer" name="Submit2" type="button" class="Tab2" value="Cancel"
                    onclick="window.location = 'marketingmain.aspx';" /><br />
                    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>