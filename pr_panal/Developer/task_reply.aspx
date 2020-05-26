<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="task_reply.aspx.cs" Inherits="Developer_task_reply" %>

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
     <h5 style="color:red;margin-left: 333px;" id="errrormsg" runat="server">Sorry, You are not applicable to submit this task, because this task is not started yet.</h5>

    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr bgcolor="#E6E6E6" class="bottom">
            <td colspan="4" align="center" valign="top" class="Tab2" bgcolor="#CCCCCC">Reply Form.....</td>
        </tr>
        <tr bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center" valign="top" class="Tab2">&nbsp;Date</td>
            <td colspan="2" valign="top" class="Tab3"><font color="#FF0000">&nbsp; 
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true" size="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </font></td>
        </tr>
        <tr bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center" valign="top" class="Tab2">Total Hr. Spent</td>
            <td colspan="2" valign="top" class="Tab3"><font color="#FF0000">&nbsp; 
                <asp:TextBox ID="txt_ths" runat="server" size="20" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_ths"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                <strong>Hr </strong>(Don't put minute, if requires then put in hour format, 
        for Ex. 15 min=0.25, 30 minute=0.5, 45 min=0.75, 1Hour and 15 min=1.25) 
            </font></td>
        </tr>
        <tr bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center" valign="top" class="Tab2">Project Remark</td>
            <td colspan="2" valign="top" class="Tab3"><font color="#FF0000">&nbsp; 
                  <asp:TextBox ID="txt_remark" runat="server" TextMode="MultiLine" Style="height: 315px; width: 750px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_remark"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </font></td>
        </tr>
        <tr align="center" bgcolor="#E6E6E6" class="bottom">
            <td colspan="4" valign="top">
                <asp:Button ID="btnsubmit" runat="server" Text="Reply" ToolTip="Reply" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" ToolTip="Cancel"
                    Style="cursor: pointer; width: 150px;" OnClick="btnCancel_Click" CssClass="Tab2" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

