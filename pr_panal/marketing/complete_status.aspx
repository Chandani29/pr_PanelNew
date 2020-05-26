<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="complete_status.aspx.cs" Inherits="Marketing_complete_status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <asp:Panel ID="Panel1" runat="server" Visible="false">
        <%=PartialPayment%>
        <table width="400" border="1" cellspacing="2" cellpadding="1" class="tdrow4" align="center">
            <tr align="center">
                <td colspan="2" class="txt">Note: Make sure payment has been recieved</td>
            </tr>
            <tr>
                <td width="199" align="right" class="Tab3"><strong>Project Name</strong></td>
                <td width="185" class="Tab3">
                    <strong>
                        <%=p_name2%>
                    </strong>
                </td>
            </tr>
            <tr>
                <td width="199" align="right" class="Tab3"><strong>Paid&nbsp;Ammount&nbsp;INR</strong></td>
                <td width="185">
                    <asp:TextBox ID="txt_amount" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_amount"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right" class="Tab3"><strong>Payment Type</strong></td>
                <td>
                    <asp:TextBox ID="txt_PayType" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_PayType"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="right" class="Tab3"><strong>Client's Remark</strong></td>
                <td>
                    <asp:TextBox ID="txt_remark" runat="server" TextMode="MultiLine" Style="width: 400px; height: 115px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_remark"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr align="center">
                <td colspan="2">
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                        Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Text="Cancel" ToolTip="Cancel"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit2_Click" CssClass="Tab2" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="Panel2" runat="server" Visible="false">
        <center>
            <b>
                <br>
                <br>
                <br>
                <font color="red" size="2" face="verdana">This project is still showing some work in pending status, Kindly make it done before completing this project.</font></b>
            <br>
            <br>
            <a href="marketingmain.aspx">Back</a>
        </center>
    </asp:Panel>
</asp:Content>

