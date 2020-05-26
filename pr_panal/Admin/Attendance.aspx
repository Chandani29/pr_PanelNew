<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Attendance.aspx.cs" Inherits="Admin_Default" %>

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
    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                                                <asp:DropDownList ID="ddlusers" hdn="hdnddlList2" runat="server" Width="150" class="companyChoice" OnSelectedIndexChanged="ddlusers_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:DropDownList>
                                            <strong class="Tab2">From 
                                             <asp:TextBox ID="txt_from" runat="server" data-date-format="DD-MM-YYYY HH:mm:ss" class="date-picker" size="15" autocomplete="off"></asp:TextBox>

                                                To
                                             <asp:TextBox ID="txt_to" runat="server" data-date-format="DD-MM-YYYY HH:mm:ss" class="date-picker" size="15" autocomplete="off"></asp:TextBox>

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

    <div style="width: 49px; height: 81px; position: absolute; top: 214px; right: 96px;">
        <asp:LinkButton ID="download_XL" runat="server" OnClick="download_XL_Click" ToolTip="Download Excel Sheet"><img src="../images/download_XL_logo.gif" style="width:50px;"/></asp:LinkButton>
    </div>
    <table class="table table-bordered cart_summary">
        <thead>
            <%=Outside%>
        </thead>
    </table>
    <%=DoneReminders%>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".date-picker").datepicker({
                dateFormat: 'dd-MM-yy'
            });
        });
    </script>
</asp:Content>
