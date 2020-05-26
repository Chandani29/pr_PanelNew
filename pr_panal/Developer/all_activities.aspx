<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="all_activities.aspx.cs" Inherits="Developer_all_activities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
    <%=ProjectList%>
    <br>
    <center>
        <input type="button" name="Back" value="Back" class="Tab2" style="width: 150px; cursor:pointer;" onclick="history.back()"></center>
</asp:Content>

