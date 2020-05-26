<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hrfinalapproved.aspx.cs" Inherits="Admin_hrfinalapproved" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml"     style="text-align:center;">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h4>Final leave approval by HR</h4>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
        <table>
            <tr>
                <td>Total Leave:<asp:TextBox ID="txtTotalLeave" runat="server" type="number"  placeholder="Total Leave" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtTotalLeave"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </td><td>Total Absent:
                    <asp:TextBox ID="txtTotalAbsent" runat="server" type="number"  placeholder="Total Absent"></asp:TextBox>
                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtTotalAbsent"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                     </td>
            </tr>
            <tr align="center;"><td colspan="2">
                <input type="hidden" runat="server" id="txthdnid"/>
                 <asp:Button ID="btnsubmit" runat="server" Text="Final Approved" ToolTip="Final Approved" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                                </td></tr>
        </table>
    </div>
    </form>
</body>


</html>
