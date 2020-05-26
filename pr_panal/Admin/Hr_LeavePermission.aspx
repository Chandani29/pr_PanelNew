<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Hr_LeavePermission.aspx.cs" Inherits="Admin_Hr_LeavePermission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        function openWindow(code) {
            
        window.open('hrFinalApproved.aspx?empid=' + code, 'open_window', 'height=200, width=500, status=yes, resizable=no, toolbar=no, menubar=no, location=center, scrollbars=no, resizable=no');
        }
        function openInstantWindow() {
            window.open('hrInstantLeaveApproval.aspx', 'open_window', 'height=450, width=600, status=yes, resizable=no, toolbar=no, menubar=no, location=center, scrollbars=no, resizable=no');
        }
</script>
    <h6>Hr Leave Permission</h6>
    <div class="refresh" style="margin-top: 31px;margin-left: 545px;margin-bottom: 29px;"><a href="javascript:void(0);" style="color: deeppink;" 
        onclick='openInstantWindow();'>Instant Leave Permission</a></div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" valign="middle" class="Tab2" bgcolor="#CCCCCC" width="100%" border="1" cellpadding="0" cellspacing="0" OnRowCommand="GridView1_RowCommand" onrowdatabound="GridData_RowDataBound" >
    <Columns>
     <asp:TemplateField HeaderText="Sr.No." HeaderStyle-Width="59px" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >    <%#Container.DataItemIndex +1 %>   
                <asp:Label ID="lblID" runat="server" Text='<%# Eval("id")%>' Visible="false"></asp:Label>
            </ItemTemplate>

        </asp:TemplateField>
        <asp:TemplateField HeaderText="DateFrom" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
           <ItemTemplate >  <%# Convert.ToDateTime(Eval("dateFrom")).ToString("dd MMMM yyy")%> </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="DateTo" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
           <ItemTemplate >  <%# Convert.ToDateTime(Eval("dateTo")).ToString("dd MMMM yyy")%> </ItemTemplate>
        </asp:TemplateField>
       
        <asp:TemplateField HeaderText="Lastworkingday" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
              <%# Eval("lastworkingday")%>
           </ItemTemplate>
        </asp:TemplateField>
          <asp:TemplateField HeaderText="Reportingday" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
              <%# Eval("reportingday")%>
           </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Address" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
              <%# Eval("address")%>
           </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mobilenumber" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
              <%# Eval("mobilenumber")%>
           </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="JobsTODoBeforeLeave" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
              <%# Eval("JobsTODoBeforeLeave")%>
           </ItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="ReasonforLeave" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
              <%# Eval("ReasonforLeave")%>
           </ItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="EmployeeName" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
              <%# Eval("employeeName")%>
           </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ApprovedBy" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
              <%# Eval("approvedPerson")%>
           </ItemTemplate>
        </asp:TemplateField>
          <asp:TemplateField HeaderText="ApprovedStatus" ItemStyle-Height="30px" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate >
                <asp:Label ID="lblStatus" runat="server" Text='<%# (Convert.ToInt32(Eval("approvedStatus"))==1)?"Pending":(Convert.ToInt32(Eval("approvedStatus"))==3)?"Reconfirm":(Convert.ToInt32(Eval("approvedStatus"))==2)?"Partially approved":(Convert.ToInt32(Eval("approvedStatus"))==4)?"Leave approved":"Absent"%>' Visible="false"></asp:Label>
              
                 <asp:LinkButton ID="BtnStatus" Text="Click for Confirm" runat="server" CommandName="Select" CommandArgument="<%# Container.DataItemIndex %>" />
                <a href="javascript:void(0);" style="color: deeppink;" onclick='openWindow("<%# Eval("id") %>");'><%#(Convert.ToInt32(Eval("approvedStatus"))==3)?"Reconfirm":""%></a>
           
                
           </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

</asp:Content>
