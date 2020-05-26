<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Missed_Attendance.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" />
  
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
    <table width="70%" border="1" align="center" cellpadding="3" cellspacing="1" class="tdrow4">
        <tr>
            <td width="571" align="center">
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
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_from"
                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </strong>
                                        <div class="Tab3">
                                            <asp:Button ID="btnsubmit" runat="server" Text="Search" ToolTip="Search" ValidationGroup="valgroup" OnClick="btnsubmit_Click"
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
            </td>
        </tr>
    </table>
    <%=DoneReminders%>


    <asp:Label ID="lblMsg" runat="server"></asp:Label>
    <div style="margin-left: 1203px;">
    <asp:Button ID="btnsubmits" Text="Update" CssClass="Tab2" runat="server" OnClick="btnsubmits_Click"/>
        </div>
    
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

