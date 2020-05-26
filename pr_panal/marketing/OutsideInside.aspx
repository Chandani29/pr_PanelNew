<%@ Page Title="" Language="C#" MasterPageFile="~/marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="OutsideInside.aspx.cs" Inherits="marketing_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="882" align="center" bgcolor="#E6E6E6">
                <table width="100%" height="15" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                         <td class="Tab3" align="left"><a href="attendance.aspx"><font color="#0000FF"><b>Attendance</b></font></a></td>
                        <td class="Tab3" align="left"><a href="OutsideInside.aspx"><font color="#0000FF"><b>Outside Inside</b></font></a></td>
                        <td class="Tab3" align="left"><a href="add_reminder.aspx" target="_blank"><font color="#0000FF"><b>Add New Reminder</b></font></a></td>
                        <td class="Tab3" align="right"><a href="view_reminder.aspx" target="_blank"><font color="#0000FF"><b>View Done Reminder</b></font></a></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label></td>
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
</asp:Content>

