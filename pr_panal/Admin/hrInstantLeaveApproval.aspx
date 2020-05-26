<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hrInstantLeaveApproval.aspx.cs" Inherits="Admin_hrInstantLeaveApproval" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml"     style="text-align:center;">
<head runat="server">
    <title></title>
     <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
    <script>
        $(document).ready(function () {
            // Date Object
            var date = new Date();
            //date.setDate(date.getDate() + 7);
            $('.dateFrom').datepicker({
                dateFormat: "yy-mm-dd",
                minDate: date,
                //onSelect: function (selected) {
                //    var dt = new Date(selected);
                //    dt.setDate(dt.getDate() + 1);
                //    $(".dateTo").datepicker("option", "minDate", dt);
                //},
            });

           
            $(".dateTo").datepicker({
                dateFormat: "yy-mm-dd",
                minDate: date,
                //onSelect: function (selected) {
                //    var dt = new Date(selected);
                //    dt.setDate(dt.getDate() - 1);
                //    $(".dateFrom").datepicker("option", "maxDate", dt);
                //}
            });

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h4>Instant leave approval by HR</h4>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
        <table>
            
            <tr>
                <td>Select Employee:<asp:DropDownList ID="ddlEmployee" runat="server" Width="150" style="width:172px;height:31px;">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="ddlEmployee"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator></td>
                <td>Date From:<asp:TextBox ID="txtFrom" runat="server" type="text" class="dateFrom" placeholder="dd/mm/yyyyy"></asp:TextBox>
                <span><asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtFrom"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator></span>
                </td>
                     
            </tr>
           
            <tr><td colspan="2">
                
                 <asp:Button ID="btnsubmit" runat="server" Text="Instant leave Approved" ToolTip="Instant leave Approved" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                                </td></tr>
        </table>
    </div>
    </form>
</body>


</html>
