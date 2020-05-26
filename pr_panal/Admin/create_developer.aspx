<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="create_developer.aspx.cs" Inherits="Admin_create_developer" %>

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
    <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblDate" runat="server" Visible="false"></asp:Label>
    <table width="38%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="6%" background="../images/tabl-cor_02.jpg">
                            <div align="left">
                                <img src="../images/tabl-cor_01.jpg" width="16" height="27"></div>
                        </td>
                        <td width="87%" valign="middle" background="../images/tabl-cor_02.jpg">
                            <strong><font color="#006699" size="2" face="Verdana, Arial, Helvetica, sans-serif">
                                Developer Entry Form</font></strong>
                        </td>
                        <td width="7%" background="../images/tabl-cor_02.jpg">
                            <div align="right">
                                <img src="../images/tabl-cor_03.jpg" width="19" height="27"></div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td height="21" valign="top" bgcolor="#727272">
                <table width="100%" border="0" cellspacing="1" cellpadding="0">
                    <tr>
                        <td height="19" bgcolor="#FFFFFF">
                            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="3" style="border-collapse: collapse">
                                <tr>
                                    <td height="34" width="196">
                                        <div align="left">
                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Name:</b></font></div>
                                    </td>
                                    <td height="34">
                                        <b><font color="#ffffff">
                                            <asp:TextBox ID="txt_name" runat="server" size="20"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_name"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </font></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="34" width="196">
                                        <div align="left">
                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>User
                                                Name:</b></font></div>
                                    </td>
                                    <td height="34" width="183">
                                        <b><font color="#ffffff">
                                            <asp:TextBox ID="Username" runat="server" ReadOnly="true" size="20"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="Username"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </font></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40">
                                        <div align="left">
                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Password:</b></font></div>
                                    </td>
                                    <td height="40">
                                        <b><font color="#ffffff">
                                            <asp:TextBox ID="Password" runat="server" size="20"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="Password"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </font></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" width="196">
                                        <div align="left">
                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Job Profile:</b></font></div>
                                    </td>
                                    <td height="40" width="183">
                                        <b><font color="#ffffff">
                                            <asp:TextBox ID="txt_jobprofile" runat="server" size="20"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_jobprofile"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </font></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" width="196">
                                        <div align="left">
                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Developer
                                                Cost:</b></font></div>
                                    </td>
                                    <td height="40" width="183">
                                        <b><font color="#ffffff">
                                            <asp:TextBox ID="txt_PerCost" runat="server" size="20" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_PerCost"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </font></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" width="196">
                                        <div align="left">
                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Status:</b></font></div>
                                    </td>
                                    <td height="40" width="183">
                                        <b><font color="#ffffff">
                                            <asp:CheckBox ID="status" runat="server" />
                                        </font></b>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="40" width="196">
                                        <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td height="40" width="183">
                                        <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                                            Style="cursor: pointer;" OnClick="btnSubmit_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
