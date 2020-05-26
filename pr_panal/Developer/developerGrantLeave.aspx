<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="developerGrantLeave.aspx.cs" Inherits="Developer_developerGrantLeave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="text-align: center;" id="blink"><%=WorkDoneorNot%></div>
    <%--You have not started any work till now.    You are sitting ideal since last 1 hours.--%>
    <script type="text/javascript">
        var blink = document.getElementById('blink');
        setInterval(function () {
            blink.style.opacity = (blink.style.opacity == 0 ? 1 : 0);
        }, 1000);
    </script>
         <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="882" align="center" bgcolor="#E6E6E6">
                <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="Tab3" align="left"><a href="developermain.aspx"><font color="#0000FF"><b>Dashboard</b></font></a></td>
                        <td class="Tab3" align="left"><a href="attendance.aspx"><font color="#0000FF"><b>Attendance</b></font></a></td>
                        <td class="Tab3" align="left"><a href="OutsideInside.aspx"><font color="#0000FF"><b>Outside Inside</b></font></a></td>
                        <td class="Tab3" align="left"><a href="add_reminder.aspx" ><font color="#0000FF"><b>Add New Reminder</b></font></a></td>
                        <td class="Tab3" align="left">
                             <%if (leaveApplyFormStatus > 0)
                                {%>
                            <a href="DeveloperLeave.aspx"  class="notification"><font color="#0000FF"><b>Leave Apply Form</b></font>
                                <span class="badge">
                                <%=leaveApplyFormStatus%></span>
                            </a>
                            <%} %>
                            <%else
                                { %>
                                 <a href="DeveloperLeave.aspx" ><font color="#0000FF"><b>Leave Apply Form</b></font></a>
                            <%} %>

                        </td>

                        <td class="Tab3" align="left">
                            <%if (numberOfSeenStatus > 0)
                                {%>
                                   <a href="DeveloperLeaveStatus.aspx"  class="notification"><font color="#0000FF"><b>Applied Leave Status</b></font><span class="badge">
                                <%=numberOfSeenStatus%></span></a>
                            <%} %>
                            <%else
                                { %>
                                     <a href="DeveloperLeaveStatus.aspx" ><font color="#0000FF"><b>Applied Leave Status</b></font></a>
                            <%} %>
                        </td>
                        <td class="Tab3" align="left">
                            <%if (numberOfPendingApprovalLeave > 0)
                                {%>
                            <a href="developerGrantLeave.aspx"  class="notification"><font color="#0000FF"><b>Leave Grant</b></font><span class="badge">
                                <%=numberOfPendingApprovalLeave%></span></a>
                            <%} %>
                            <%else
                                { %>
                            <a href="developerGrantLeave.aspx"  ><font color="#0000FF"><b>Leave Grant</b></font></a>
                            <%} %>

                        </td>
                        <td class="Tab3" align="right"><a href="view_reminder.aspx" ><font color="#0000FF"><b>View Done Reminder</b></font></a></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%=ReminderPanel%>
    </table>
    <h6>Grant Leave </h6>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" valign="middle" class="Tab2" bgcolor="#CCCCCC" width="100%" border="1" cellpadding="0" cellspacing="0" OnRowCommand="GridView1_RowCommand" onrowdatabound="GridData_RowDataBound" >
    <Columns>
     <asp:TemplateField HeaderText="Sr.No." HeaderStyle-Width="59px">
            <ItemTemplate >    <%#Container.DataItemIndex +1 %>   
                <asp:Label ID="lblID" runat="server" Text='<%# Eval("id")%>' Visible="false"></asp:Label>
            </ItemTemplate>

        </asp:TemplateField>
        <asp:TemplateField HeaderText="DateFrom">
           <ItemTemplate >  <%# Convert.ToDateTime(Eval("dateFrom")).ToString("dd MMMM yyy")%> </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="DateTo">
           <ItemTemplate >  <%# Convert.ToDateTime(Eval("dateTo")).ToString("dd MMMM yyy")%> </ItemTemplate>
        </asp:TemplateField>
       
        <asp:TemplateField HeaderText="lastworkingday">
            <ItemTemplate >
              <%# Eval("lastworkingday")%>
           </ItemTemplate>
        </asp:TemplateField>
          <asp:TemplateField HeaderText="Reportingday">
            <ItemTemplate >
              <%# Eval("reportingday")%>
           </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Address">
            <ItemTemplate >
              <%# Eval("address")%>
           </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mobilenumber">
            <ItemTemplate >
              <%# Eval("mobilenumber")%>
           </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="JobsTODoBeforeLeave">
            <ItemTemplate >
              <%# Eval("JobsTODoBeforeLeave")%>
           </ItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="ReasonforLeave">
            <ItemTemplate >
              <%# Eval("ReasonforLeave")%>
           </ItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="EmployeeName">
            <ItemTemplate >
              <%# Eval("employeeName")%>
           </ItemTemplate>
        </asp:TemplateField>
       <%-- <asp:TemplateField HeaderText="ApprovedBy">
            <ItemTemplate >
              <%# Eval("approvedPerson")%>
           </ItemTemplate>
        </asp:TemplateField>--%>
          <asp:TemplateField HeaderText="ApprovedStatus">
            <ItemTemplate >
                <asp:Label ID="lblStatus" runat="server" Text='<%# (Convert.ToInt32(Eval("approvedStatus"))==0)?"Pending":(Convert.ToInt32(Eval("approvedStatus"))==1)?"Forwaded to hr":"Confirmed from my side"%>' Visible="false"></asp:Label>
              
                 <asp:LinkButton ID="BtnStatus" Text="Forward to hr" runat="server" CommandName="Select" CommandArgument="<%# Container.DataItemIndex %>" onclientclick="return confirm('Are You sure to forward to HR?')"/>
           </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
</asp:Content>

