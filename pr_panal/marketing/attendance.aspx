<%@ Page Title="" Language="C#" MasterPageFile="~/marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="attendance.aspx.cs" Inherits="marketing_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
            <td colspan="2" class="txt">Attendance  Entry Form <strong>(Coming time <%=ComingTime%>)</strong><strong><%=GoingTime%></strong></td>
        </tr>
        <tr>
            <td width="199" align="right" class="Tab3"><strong>Date</strong></td>
            <td width="185">
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true" size="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr align="center">
            <td width="199" align="right" class="Tab3"></td>
            <td width="185">
                <asp:TextBox ID="txtmsg" runat="server" TextMode="multiline" Columns="50" Rows="5" placeholder="Enter Message" size="30"></asp:TextBox>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="gnvali" Display="Dynamic" ControlToValidate="txtmsg"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                 </td> 
        </tr> 
        <tr align="center">
            <td colspan="2">
                <asp:Label ID="lberror" runat="server" ForeColor="Red"></asp:Label>
                <asp:Button ID="btnmorning" runat="server" Text="Good Morning" ToolTip="Submit"
                    Style="cursor: pointer;" OnClick="btnmorning_Click" CssClass="Tab2" />
                <asp:Button ID="btnmeetingmorning" runat="server" Text="Meeting Good Morning" ToolTip="Submit" ValidationGroup="gnvali"
                    Style="cursor: pointer;" OnClick="btnmeetingmorning_Click" CssClass="Tab2" />
                <br />
                <asp:Button ID="btnnight" runat="server" Text="I have completed my all today's assigned work, should i leave now?" ToolTip="Submit"
                    Style="cursor: pointer;" OnClick="btnnight_Click" CssClass="Tab2" />
                <asp:Button ID="btnmeetingnight" runat="server" Text="Meeting Good Night" ToolTip="Submit" ValidationGroup="gnvali"
                    Style="cursor: pointer;" OnClick="btnmeetingnight_Click" CssClass="Tab2" /><br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>

                <asp:Label ID="txtmsg1" runat="server" ForeColor="Green"></asp:Label>

                <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>

      <%--<asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick"></asp:Timer>
    <asp:UpdatePanel runat="server">
          <ContentTemplate>
           <asp:Label ID="txtmsg1" runat="server" ForeColor="Green"></asp:Label>
          </ContentTemplate>
          <Triggers>
              <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" /> 
          </Triggers> 
      </asp:UpdatePanel>--%>
            </td>
        </tr>
    </table>
</asp:Content>
