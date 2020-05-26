<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master" AutoEventWireup="true" CodeFile="project_details.aspx.cs" Inherits="Marketing_project_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
     <script type="text/javascript">
         function isNumberKey(evt, element) {
             var charCode = (evt.which) ? evt.which : event.keyCode
             if (
                 (charCode != 46 || $(element).val().indexOf('.') != -1) &&      // “.” CHECK DOT, AND ONLY ONE.
                 (charCode < 48 || charCode > 57))
                 return false;
             return true;
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center">
            <td colspan="14" class="tdrow5" bgcolor="#CCCCCC">
                <div align="center">
                    <strong>Project 
                Detail ...<%=proj_name%>(<%=proj_id%>) </strong>
                </div>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td class="Tab2"><strong>Date</strong></td>
            <td class="Tab2"><strong>Assigned by </strong></td>
            <td class="Tab2"><strong>Project Type</strong></td>
            <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
            <td class="Tab2"><strong>Total Hours</strong></td>
            <td class="Tab2"><strong>Hours spent</strong></td>
            <td class="Tab2"><strong>Delivery date</strong></td>
            <td class="Tab2"><strong>Assigned to</strong></td>
            <td class="Tab2"><strong>Cost&nbsp;</strong></td>
            <td class="Tab2"><strong>Dev. Cost&nbsp;</strong></td>
            <td class="Tab2"><strong>Expenses&nbsp;</strong></td>
            <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;Remark&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
            <td class="Tab2"><strong>Project&nbsp;Status</strong></td>
        </tr>
        <%=ProjectDetail%>
        <tr>
            <td colspan="4" align="right" class="Tab2" bgcolor="#CCCCCC">Balance Hours&nbsp;</td>
            <td colspan="2" align="right" bgcolor="#CCCCCC" class="Tab2"><%=total_hour%>&nbsp;</td>
            <td colspan="2" class="Tab2" bgcolor="#CCCCCC" align="right">Balance Cost&nbsp;</td>
            <%--<td colspan="3" align="right" bgcolor="#25B311" class="Tab2"><%=all_total_cast_upper%>&nbsp;</td>--%>
            <%=all_total_cast_upper%>
            <td colspan="2" class="Tab2" bgcolor="#CCCCCC">&nbsp;</td>
        </tr>
    </table>
    <br />
    <%=CostHour%>
    <%=DoneAssigned%>
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="4" align="center" class="Tab2" bgcolor="#CCCCCC">Add New Task.....</td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center" class="Tab2">&nbsp;Date</td>
            <td colspan="2" class="Tab3"><font color="#FF0000">&nbsp; 
                <asp:TextBox ID="txt_date" runat="server" ReadOnly="true" size="30"></asp:TextBox>
            </font></td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center" class="Tab2">Assign The Person </td>
            <td colspan="2" class="Tab3">&nbsp; 
                <asp:DropDownList ID="dd_Workper" runat="server">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                    InitialValue="0" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="dd_Workper"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center" class="Tab2">Assign Total Hour</td>
            <td colspan="2" class="Tab3"><font color="#FF0000">&nbsp; 
              <asp:TextBox ID="txt_ths" runat="server" size="20" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_ths"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                <strong>Hr</strong> (Don't put minute, if requires then put in hour 
            format, for Ex. 15 min=0.25, 30 minute=0.5, 45 min=0.75, 1Hour and 
            15 min=1.25)</font></td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center" class="Tab2">Task Should be Completed on </td>
            <td colspan="2" class="Tab3"><font color="#FF0000">&nbsp; 
				  <asp:TextBox ID="txt_ur" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"
                      size="20"></asp:TextBox>&nbsp;(MM/DD/YYYY)
                <select name="dd_time" id="dd_time" runat="server">
                    <option value="Hr">Hr</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                    <option value="21">21</option>
                    <option value="22">22</option>
                    <option value="23">23</option>
                    <option value="24">24</option>
                </select>&nbsp;Hr
            </font></td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">

            <td colspan="2" align="center" class="Tab2">Assign Task [Description]</td>
            <td colspan="2" class="Tab3"><font color="#FF0000">&nbsp; 
                <asp:TextBox ID="txt_remark" runat="server" TextMode="MultiLine" Style="width: 550px; height: 300px;"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_remark"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </font></td>
        </tr>
        <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="4">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                <input name="Submit2" type="Reset" class="Tab2" style="cursor: pointer; width: 150px;" value="Reset" onclick="window.location = 'marketingmain.aspx';" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

