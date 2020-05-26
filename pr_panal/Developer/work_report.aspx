<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="work_report.aspx.cs" Inherits="Developer_work_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <%=ProjectList%>
    <br>
    <center>
        <input type="button" name="Back" value="Back" class="Tab2" style="width: 150px; cursor:pointer;" onclick="history.back()"></center>
</asp:Content>

