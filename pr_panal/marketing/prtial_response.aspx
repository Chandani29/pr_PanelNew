<%@ Page Title="" Language="C#" MasterPageFile="~/marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="prtial_response.aspx.cs" Inherits="marketing_Default" %>

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
     <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
        <tr align="center">
            <td colspan="2" class="txt">
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Project Name</strong>
            </td> 
              <td align="left" class="Tab2">
                <%= p_name %>  
            </td>
        </tr>
        <tr>
            <td align="right" class="Tab3">
                <strong>Assigned/Spent Hour</strong>
            </td>
            <td align="left" class="Tab3">
                <asp:TextBox ID="txt_date" runat="server" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3">
                <strong>Remarks</strong>
            </td>
            <td width="185">
                <asp:TextBox TextMode="MultiLine" Width="300" Height="150" ID="txt_amount" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_amount"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr> 
        <tr align="center">
            <td colspan="2"> 
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer;" CssClass="Tab2" />
                &nbsp;&nbsp;&nbsp;&nbsp;
                <input name="Submit2" type="button" class="Tab2" value="Cancel" onclick="window.location = 'marketingmain.aspx';" style="cursor: pointer;" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>

</asp:Content>

