<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Edit_Attendance.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
    <style>
        .table {
            width: 100%;
            max-width: 100%;
            margin-bottom: 20px;
            text-align: right;
            border: 1px solid #efefef;
        }

        .cart_summary > thead, .cart_summary > tfoot {
            background: #f7f7f7;
            font-size: 16px;
        }

        .cart_summary th {
            padding: 10px;
            border: 1px solid #efefef;
        }

        .cart_summary td {
            padding: 10px;
            border: 1px solid #efefef;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblmsg" runat="server" Font-Size="20" ForeColor="#339933"></asp:Label>
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
                <asp:Panel ID="pnlReceived" runat="server" DefaultButton="btnsubmit">
                    <table width="95%" height="25" border="0" cellpadding="1" cellspacing="0" bgcolor="#D5D500">
                        <tr>
                            <td align="center">
                                <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFF99">
                                    <tr>
                                        <td align="center">&nbsp;
                                                <asp:DropDownList ID="ddlusers" hdn="hdnddlList2" runat="server" Width="150" class="companyChoice">
                                                </asp:DropDownList>
                                            <strong class="Tab2">Select Date 
                                             <asp:TextBox ID="txt_from" runat="server" data-date-format="DD-MM-YYYY HH:mm:ss" class="date-picker" size="15"></asp:TextBox>
                                            </strong>
                                            <div class="Tab3">
                                                <asp:Button ID="btnsubmit" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroupdate" OnClick="btnsubmit_Click"
                                                    Style="cursor: pointer;" CssClass="Tab2" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>

    <%=DoneReminders%>
    <table class='table table-bordered cart_summary'>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btnupdate" Visible="false" runat="server" Text="Update" CssClass="Tab2" OnClick="btnupdate_Click" /></td>
        </tr>
    </table>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            function updateoutin(Id, Tim1e) {
                debugger
                alert("Hello! I am an alert box!!");
            }
        }); 
    </script>
    <script type="text/javascript">
        $(function () {
            $(".date-picker").datepicker({
                dateFormat: 'dd-MM-yy'
            });
        });
    </script>

</asp:Content>

