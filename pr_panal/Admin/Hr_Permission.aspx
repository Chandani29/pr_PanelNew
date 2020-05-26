<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Hr_Permission.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <%-- <table width="100%" border="1" cellpadding="0" cellspacing="0">
        <asp:Label ID="lblmsg" runat="server" ForeColor="Green"></asp:Label>
        <tr>
             <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Coming Time
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Going Time
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Employee Name
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Permission
            </td>
        </tr>  
           <%=DoneReminders%>
    </table>--%>

    <h6>Pending Task approved by HR For display Good Night button</h6>

     <table>
            <asp:Label ID="lblmsg" runat="server" ForeColor="Green"></asp:Label>
            <tr>
                <td>Select Employee:<asp:DropDownList ID="ddlEmployee" runat="server" Width="150" style="width:172px;height:31px;">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="ddlEmployee"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator></td>
                <td><asp:Button ID="btnsubmit" runat="server" Text="Approved" ToolTip="Final Approved" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" /></td>
               
                     
            </tr>
         
        </table>
</asp:Content>

