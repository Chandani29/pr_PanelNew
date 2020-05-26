<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="leaveorabsent.aspx.cs" Inherits="Admin_leaveorabsent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
     <script src="https://code.jquery.com/jquery-3.5.0.js" type="text/javascript"></script>
    <script type="text/javascript" language="JavaScript">
        $(document).ready(function () {
            document.cookie = "ddluser=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
            $("[id^='leave_']").click(function () {
                if (confirm("Are you sure for assigned him leave on " + $(this).attr("id").substring(6) + "?")) {
                    //alert($("[id$='ddlusers']").val());
                    document.cookie = "ddluser=" + $("[id$='ddlusers']").val();
                    
                    return true;
                }
                else {
                    return false;
                }
                //if ($(this).attr("href") != "javascript:void(0);") {
                //    //$("[id$='hdnMessage']").val($("#txtArea_" + $(this).attr("id").substring(6)).val());
                //    document.cookie = "notAvMsg=" + $("#txtArea_" + $(this).attr("id").substring(6)).val();
                //    return true;
                //}
                ////alert($(this).attr("id").substring(6));
                //$("#txtArea_" + $(this).attr("id").substring(6)).fadeIn("slow");
                //$("#cancelnotAv_" + $(this).attr("id").substring(6)).fadeIn("slow");
                //$(this).attr("href", $(location).attr("href") + "?notavid=" + $(this).attr("id").substring(6));
                //return false;
            });
            $("[id^='absent_']").click(function () {
                if (confirm("Are you sure for assigned him absent on " + $(this).attr("id").substring(7) + "?")) {
                    //alert($("[id$='ddlusers']").val());
                    document.cookie = "ddluser=" + $("[id$='ddlusers']").val();

                    return true;
                }
                else {
                    return false;
                }
              
            });
        });
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblmsg" runat="server"></asp:Label>
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

                <%=PendingTask%>
            </td>
        </tr>
    </table>

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

