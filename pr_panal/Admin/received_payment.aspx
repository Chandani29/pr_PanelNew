<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="received_payment.aspx.cs" Inherits="Admin_received_payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                    <tr>
                        <td align="center">
                            <asp:Panel ID="Panel2" runat="server" DefaultButton="btnsubmit">
                                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                    <tr>
                                        <td align="center" bgcolor="#E7C84E"><strong class="Tab2">Received 
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
                                            <asp:Button ID="btnsubmit" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupdate"
                                                Style="cursor: pointer;" OnClick="btnSubmit_Click" CssClass="Tab2" />
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
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label><br />
    <%=PaymentDetail%>
    <br>
    <center><strong><a href="adminmain.aspx"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Back</font></a> &nbsp;</strong></center>
    <br>
</asp:Content>
