<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="expense_details.aspx.cs" Inherits="Admin_expense_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <%=PartialPayment %>
</asp:Content>

