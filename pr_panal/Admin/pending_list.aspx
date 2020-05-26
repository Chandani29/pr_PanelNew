<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="pending_list.aspx.cs" Inherits="Admin_pending_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" bgcolor="#999999" class="bottom">
            <td class="Tab2"><strong>Project Id</strong></td>
            <td class="Tab2"><strong>Project Name</strong></td>
            <td class="Tab2"><strong>Date</strong></td>
            <td class="Tab2"><strong>Assigned By</strong></td>
            <td class="Tab2"><strong>Assigned Task</strong></td>
            <td class="Tab2"><strong>Assigned Hours</strong></td>
            <td class="Tab2"><strong>To Be Submmited By</strong></td>
            <td class="Tab2"><strong>Work Status</strong></td>
        </tr>
        <%=PendingList%>
    </table>
</asp:Content>

