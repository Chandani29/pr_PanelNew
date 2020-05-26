<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="OutsideInside.aspx.cs" Inherits="Developer_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     
</asp:Content> 

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
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
                            <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
           <br />
    <br />
    <table width="400" border="1" cellspacing="2" cellpadding="1" class='tdrow4' align='center'>
        
        <tr align="center">
            <td colspan="2" class="txt">Time Calculator (Today Details)</td>
        </tr>
         <%=DoneReminders%>  
        <tr align="center">
            <td colspan="2">  
                <asp:Button ID="btncmp" OnClick="btncmp_Click" Text="Company Purpose" runat="server" CssClass="Tab2" />   
                 <asp:TextBox ID="txtcomypor" Width="200" Height="100" TextMode="MultiLine" runat="server" Visible="false"></asp:TextBox>
                <asp:Label ID="errormsg" runat="server" Font-Size="10" ForeColor="Red"></asp:Label>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtcomypor"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>

                <asp:Button ID="btnout" runat="server" Text=" Out " ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer;" OnClick="btnout_Click" CssClass="Tab2" /> 

                 <asp:Button ID="btnhidetext" OnClick="btnhidetext_Click" Visible="false" Text="hide" runat="server" CssClass="Tab2" /> 
                <asp:Button ID="btnin" runat="server" Text=" In  " ToolTip="Submit"
                    Style="cursor: pointer;" OnClick="btnin_Click" CssClass="Tab2" />  
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label> 
                <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
            </td>
        </tr>
    </table>
    <table width="400" border="1" cellspacing="2" cellpadding="1" class='tdrow4' align='right'>
        <tr>
            <td width="199" align="right" class="Tab3"><strong>Outside spend time</strong></td>
            <td width="199" align="right" class="Tab3"><strong>(<%=TimeSpend%>) Mins</strong></td>
        </tr>
    </table>  
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.js"></script>
     <script type="text/javascript">
         $(".Tab211").on('click', function() 
         {    
             document.getElementById("txtcomypor").style.display = "block";
         })
    </script>
</asp:Content>
