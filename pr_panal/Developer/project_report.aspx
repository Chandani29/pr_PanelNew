<%@ Page Title="" Language="C#" MasterPageFile="~/Developer/DeveloperMaster.master" AutoEventWireup="true" CodeFile="project_report.aspx.cs" Inherits="Developer_project_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function confirmform(srno) {
            if (window.confirm('Did you complete the assigned task ?')) {
                PageMethods.UpdateWorkStatus(srno, OnSuccess, OnFailure);
            };
        }

        function OnSuccess(result) {
            if (result == "Not") {
                alert("Please Reply...!!");
            }
            else {
                if (result) {
                    location.reload();
                }
            }
        }
        function OnFailure(error) {

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label><br />
    <table width="100%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
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
            <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Project&nbsp;&nbsp;Description&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
            <td class="Tab2"><strong>Total Hours</strong></td>
            <td class="Tab2"><strong>Hours Spent</strong></td>
            <td class="Tab2"><strong>Delivery Date</strong></td>
            <td class="Tab2"><strong>Assigned to</strong></td>
            <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Client&nbsp;&nbsp;Remarks&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
            <td class="Tab2"><strong>Project Status</strong></td>
        </tr>
        <%=ProjectDetail%>
        <tr valign="top" bgcolor="#E6E6E6" class="tb2">
            <td colspan="4" align="right" class="Tab2" bgcolor="#CCCCCC">Balance Hours&nbsp;</td>
            <td colspan="2" class="Tab2" bgcolor="#CCCCCC"><%=Balance_Hours1%>&nbsp;</td>
            <td colspan="10" class="Tab2" bgcolor="#CCCCCC">&nbsp;</td>
        </tr>
    </table>
    <br>
    <table width="500" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center">
            <td colspan="14" class="tdrow5" bgcolor="#CCCCCC">
                <div align="center">
                    <strong>Developer 
            Hour Calculation</strong>
                </div>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td class="Tab2"><strong>Developers&nbsp;</strong></td>
            <td class="Tab2"><strong>Assign Hour</strong></td>
            <td class="Tab2"><strong>Hour Spent</strong></td>
            <td class="Tab2"><strong>Balance Hour</strong></td>
        </tr>
        <%=DeveloperHour%>
         <tr valign="top" bgcolor="#E6E6E6" class="tb2">
            <td colspan="4" class="Tab2" bgcolor="#CCCCCC">&nbsp;</td>
        </tr>
    </table>
    <br>
    <table width="100%" border="1" cellpadding="3" cellspacing="1" class="Tab2" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center">
            <td colspan="14" class="tdrow5" bgcolor="#CCCCCC">
                <div align="center">
                    <strong>Task Done/Assigned 
            By Developers/Marketing ...</strong>
                </div>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td class="Tab2"><strong>Task ID</strong></td>
            <td class="Tab2"><strong>Date</strong></td>
            <td class="Tab2"><strong>Assigned By</strong></td>
            <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;&nbsp;Assigned&nbsp;&nbsp;Task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
            <td class="Tab2"><strong>Assigned / Spent Hours</strong></td>
            <td class="Tab2"><strong>To be Submmited&nbsp;by</strong></td>
            <td class="Tab2"><strong>&nbsp;Developers</strong></td>
            <td class="Tab2"><strong>&nbsp;&nbsp;&nbsp;Task&nbsp;Done&nbsp;by&nbsp;Developer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
            <td class="Tab2"><strong>Task Status</strong></td>
            <td class="Tab2"><strong>&nbsp;</strong></td>
            <td class="Tab2"><strong>Remark</strong></td>
        </tr>
        <%=TaskDoneAssigned%>
    </table>
</asp:Content>
