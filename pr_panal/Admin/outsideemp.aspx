<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="outsideemp.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .table {
    width: 100%;
    max-width: 100%;
    margin-bottom: 20px; text-align: right; border: 1px solid #efefef
}
.cart_summary>thead, .cart_summary>tfoot {
    background: #f7f7f7;
    font-size: 16px;
}
.cart_summary th { padding: 10px; border: 1px solid #efefef }
.cart_summary td { padding: 10px; border: 1px solid #efefef }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <table class="table table-bordered cart_summary">
                  <thead>
                      <%=Outside%>
                  </thead> 
                </table>
</asp:Content>
