<%@ Page Title="" Language="C#" MasterPageFile="~/Marketing/MarketingMaster.master"
    AutoEventWireup="true" CodeFile="add_project.aspx.cs" Inherits="Marketing_add_project" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" />

    <link href="../cal/CalendarControl.css" rel="stylesheet" type="text/css" />
    <script src="../cal/CalendarControl.js" type="text/javascript" language="javascript"></script>


     <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<link href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/css/bootstrap.min.css"
    rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.3/js/bootstrap.min.js"></script>
<link href="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/css/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
<script src="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/js/bootstrap-multiselect.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        $('.multi').multiselect({
            includeSelectAllOption: true,
            nonSelectedText: 'Select Type' 

        });

        if ($("input[id$='hdn']").val() == "") {
            $(".multi").val('');
        }

        //$(".multi").val('');
        $(".multi").multiselect("refresh");

    });
</script>



    <script type="text/javascript">
        function isNumberKey(evt, element) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (
                (charCode != 46 || $(element).val().indexOf('.') != -1) &&       // “.” CHECK DOT, AND ONLY ONE.
                (charCode < 48 || charCode > 57)) 
                return false; 
            return true; 
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center">
            <td colspan="4" class="Tab2" bgcolor="#CCCCCC">
                <div align="center">
                    ss
                    <strong>Project Detail Form For Marketing Dept. </strong>
                </div>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">&nbsp;
            </td>
            <td width="37%" colspan="1" align="right">&nbsp; <%--<font color="#FF0000">&nbsp;<a href="project_report_selected.asp">View Report</a></font>--%>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">SrNo
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_srno" runat="server" ReadOnly="true" size="30"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Date
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                  <%--<asp:TextBox ID="txt_date" runat="server" data-date-format="DD-MM-YYYY HH:mm:ss" class="date-picker" size="30"></asp:TextBox>--%>
                   <asp:TextBox ID="txt_date" runat="server" data-date-format="DD-MM-YYYY HH:mm:ss" class="datepicker" size="30"></asp:TextBox>
                     
                </font>

                <asp:RequiredFieldValidator ID="Requiredtxt_date" runat="server" ErrorMessage="*"

                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_date"


                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Marketing Id
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_uid" runat="server" ReadOnly="true" size="30"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Client&nbsp;Name
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_clientname" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_clientname"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Referance
            </td>
            <td colspan="2"> 
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_referance" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_referance"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Client&nbsp;Mobile&nbsp;No.
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_clientmobile" runat="server" size="45"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Client&nbsp;Email
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_clientemail" runat="server" size="45"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Client&nbsp;Company
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_clientcompany" runat="server" size="45"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Client&nbsp;Address
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_clientadd" runat="server" size="45"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Type
            </td>
            <td colspan="2">&nbsp;

                  <asp:ListBox ID="dd_type" runat="server" Width="150" class="multi" SelectionMode="Multiple">
                </asp:ListBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="dd_type"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                <%--<asp:DropDownList ID="dd_type" runat="server" Width="150">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                    InitialValue="0" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="dd_type"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>--%>

                <asp:TextBox ID="txttype" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup1" Display="Dynamic" ControlToValidate="txttype"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:LinkButton ID="linkbAddMore" runat="server" Text="Add" ValidationGroup="valgroup1"
                    OnClick="linkbAddMore_Click"></asp:LinkButton>
                <asp:Label ID="lblmsg2" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Technology
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="dd_technology" runat="server" Width="150">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*"
                    InitialValue="0" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="dd_technology"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:TextBox ID="txttechnology" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup5" Display="Dynamic" ControlToValidate="txttechnology"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:LinkButton ID="linkaddtechnology" runat="server" Text="Add" ValidationGroup="valgroup5"
                    OnClick="linkaddtechnology_Click"></asp:LinkButton>
                <asp:Label ID="lblmsg3" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Name
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_proj" runat="server" size="45" MaxLength="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_proj"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Description
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_desc" runat="server" TextMode="MultiLine" Style="width: 600px; height: 200px;"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_desc"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Total Hours
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_hour" runat="server" size="20" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_hour"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                    Hr </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Must be Submmited on
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_submitedon" runat="server" ReadOnly="true" onfocus="showCalendarControl(this);"
                        size="20"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_submitedon"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Assign Person
            </td>
            <td colspan="2">&nbsp;
                <asp:CheckBoxList ID="dd_developer" runat="server">
                </asp:CheckBoxList>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Cost Of Project
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_cost" runat="server" size="20" onkeypress="return isNumberKey(event, this)"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_cost"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Project Status
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="dd_status" runat="server">
                    <asp:ListItem Value="none" Selected="True">Select Status</asp:ListItem>
                    <asp:ListItem Value="Trial Project">Trial Project</asp:ListItem>
                    <asp:ListItem Value="Received">Received</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                    InitialValue="none" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="dd_status"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">&nbsp;
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;</font>
            </td>
        </tr>
        <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="4">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnSubmit_Click" CssClass="Tab2" />
                <asp:Button ID="Button1" runat="server" Text="Reset" ToolTip="Reset" Style="cursor: pointer; width: 150px;"
                    OnClick="btnSubmit2_Click" CssClass="Tab2" />
                <br />
                    <asp:HiddenField ID="hdn" runat="server"/>
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false" Text="0"></asp:Label>
            </td>
        </tr>
    </table>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
  <link rel="stylesheet" href="/resources/demos/style.css"/>
  <%--<script src="https://code.jquery.com/jquery-1.12.4.js" type="text/javascript"></script>--%>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script>
  <script type="text/javascript">
  $( function() {
      $('.datepicker').datepicker({
          dateFormat: 'yy-dd-mm',
          onSelect: function (datetext) {
              var d = new Date(); // for now

              var h = d.getHours();
              h = (h < 10) ? ("0" + h) : h;

              var m = d.getMinutes();
              m = (m < 10) ? ("0" + m) : m;

              var s = d.getSeconds();
              s = (s < 10) ? ("0" + s) : s; 

              datetext = datetext + " " + h + ":" + m + ":" + s;

              $('.datepicker').val(datetext);
          }
      });
  });
  </script>


     <%--<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".date-picker").datepicker({
                dateFormat: 'dd-MM-yy'
            });
        });
    </script>--%>
</asp:Content>
