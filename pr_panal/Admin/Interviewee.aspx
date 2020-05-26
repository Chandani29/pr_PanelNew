<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Interviewee.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblDate" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lbdate" runat="server" Visible="false"></asp:Label>
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">
                <a href="Reference_Type.aspx">Reference Type&nbsp;</a>
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">
                <a href="Job_Profile.aspx">Job Profile&nbsp;</a>
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">
                <a href="Interviewee.aspx">New Interviewee&nbsp;</a>
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">
                <a href="IntervieweeDetail.aspx">Interviewee Detail&nbsp;</a>
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">
                <a href="Company_Detail.aspx">Company Details&nbsp;</a>
            </td>
        </tr>
    </table>
    <table width="70%" border="1" cellpadding="3" cellspacing="1" class="tdrow4" align="center">
        <tr valign="top" bgcolor="#E6E6E6" class="tdrow3" align="center">
            <td colspan="4" class="Tab2" bgcolor="#CCCCCC">
                <div align="center">
                    <strong>Interviewee Detail Form HR. </strong>
                </div>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Interview Date   
            </td> 
            <td colspan="2">
                <font color="#FF0000">&nbsp; 
                    <asp:TextBox ID="text_date_Interview" data-date-format="DD-MM-YYYY HH:mm:ss" class="date-picker" runat="server" size="15"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="text_date_Interview"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Job Profile 
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="dd_job" runat="server" Width="150">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="dd_job"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                Key Skills
                <asp:TextBox ID="txtkey" runat="server" size="45"></asp:TextBox> 
            </td>
        </tr>
        
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Reference Type
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="dd_type" runat="server" Width="150">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*"
                    InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="dd_type"
                    SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                Reference Details 
                <asp:TextBox ID="txt_referencedetail" runat="server" size="45"></asp:TextBox>
            </td>
        </tr>

        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Name 
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_name" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_name"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Mobile 
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_mob" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_mob"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Email 
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_email" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_email"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">  
            <td colspan="2" align="center">Location
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
                    <asp:TextBox ID="txt_location" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_location"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>

        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Company Name 1
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="ddlList1" hdn="hdnddlList1" runat="server" Width="150" class="companyChoice">
                </asp:DropDownList>
                    <asp:HiddenField ID="hdnddlList1" runat="server" />
                
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Company Name 2
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="ddlList2" hdn="hdnddlList2" runat="server" Width="150" class="companyChoice">
                </asp:DropDownList>
                <asp:HiddenField ID="HiddenField1" runat="server" />

            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Company Name 3
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="ddlList3" hdn="hdnddlList3" runat="server" Width="150" class="companyChoice">
                </asp:DropDownList>
                 <asp:HiddenField ID="HiddenField2" runat="server" />
               
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Company Name 4
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="ddlList4"  hdn="hdnddlList4" runat="server" Width="150" class="companyChoice">
                </asp:DropDownList>

                 <asp:HiddenField ID="HiddenField4" runat="server" />
               
            </td>
        </tr>

        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Candidate Appearance
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="ddl_appearance" runat="server" Width="150">
                    <asp:ListItem Value="Modern">Modern</asp:ListItem>
                    <asp:ListItem Value="Backwards">Backwards</asp:ListItem>
                    <asp:ListItem Value="Average">Average</asp:ListItem>
                    <asp:ListItem Value="Below Average">Below Average</asp:ListItem>
                    <asp:ListItem Value="Above Average">Above Average</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Candidate Status
            </td>
            <td colspan="2">&nbsp;
                <asp:DropDownList ID="ddl_status" runat="server" Width="150">
                    <asp:ListItem Value="Hold">Hold</asp:ListItem>
                    <asp:ListItem Value="Not Selected">Not Selected</asp:ListItem>
                    <asp:ListItem Value="Selected">Selected</asp:ListItem>
                    <asp:ListItem Value="Next round">Next round</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Candidate Exprience 
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp; 
                    <asp:TextBox ID="txt_exprience" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_exprience"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Cuttent Monthly income
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp; 
                    <asp:TextBox ID="txt_income" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_income"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Expected salary
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp; 
                    <asp:TextBox ID="txt_expected" runat="server" size="45"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_expected"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">HR Remarks 
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;   
                    <asp:TextBox ID="txt_hr_remark" Width="600" Height="100" TextMode="MultiLine" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_hr_remark"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Head Remark  
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;   
                    <asp:TextBox ID="txt_head_remark" Width="600" Height="100" TextMode="MultiLine" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_head_remark"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td> 
        </tr>  
        <tr valign="top" bgcolor="#E6E6E6" class="bottom"> 
            <td colspan="2" align="center">Schedule 
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp; 
                    <asp:TextBox ID="txt_schedule" runat="server" size="45"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="2" align="center">Next Schedule     
            </td>
            <td colspan="2">
                <font color="#FF0000">&nbsp;
   <asp:TextBox ID="txt_next_schedule" runat="server" data-date-format="DD-MM-YYYY HH:mm:ss" class="date-picker" size="15"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="*"
                        InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txt_next_schedule"
                        SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                </font>
            </td>
        </tr> 
        <tr align="center" valign="top" bgcolor="#E6E6E6" class="bottom">
            <td colspan="4">
                <asp:Button ID="btnsubmit" runat="server" Text="Submit" ToolTip="Submit" ValidationGroup="valgroup"
                    Style="cursor: pointer; width: 150px;" OnClick="btnsubmit_Click" CssClass="Tab2" />
                <br />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="lblid" runat="server" Visible="false" Text="0"></asp:Label>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
    <script type="text/javascript">

        $(function () {
            $(".date-picker").datepicker({
                dateFormat: 'dd-MM-yy'
            });
        }); 

        var previousVal = "";
        var previousText = "";
        $(".companyChoice").on('click', function () {
            //update previous value
            previousVal = $(this).val();
            previousText = $(this).find("option:selected").text();
        }).change(function () {
            //alert(previousVal);  //I have previous value 
            //alert(previousText); //I have previous text 
            var dropdownval = $(this).val();
            $("[id*='" + $(this).attr("hdn") + "']").val(dropdownval);
            if (dropdownval != "0") {
                $('.companyChoice').not(this).find('option[value="' + dropdownval + '"]').remove();
            }
            if (previousVal != "0") {
                $('.companyChoice').not(this).append($('<option></option>').val(previousVal).html(previousText));
            }
        });

        //$("[id*='ddlList1']").change(function () {

        //    if ($("[id*='ddlList1']").val() != "") {
        //        $.ajax({
        //            type: "POST", 
        //            url: "Interviewee.aspx/UpdateComp",
        //            data: '{CompId: "' + $("[id*='ddlList1']").val() + '"}', 
        //            contentType: "application/json; charset=utf-8",
        //            dataType: "json",
        //            success: function (response) {
        //                $("[id*='ddlList2']").empty(); 
        //                $("[id*='ddlList3']").empty(); 
        //                $("[id*='ddlList4']").empty();  
        //                $("[id*='ddlList2']").append($("<option value='' Text=></option>").val("").html("Select Company"));
        //                $("[id*='ddlList3']").append($("<option value='' Text=></option>").val("").html("Select Company")); 
        //                $("[id*='ddlList4']").append($("<option value='' Text=></option>").val("").html("Select Company"));
        //                for (var i = 0; i < response.d.length; i++) {
        //                    $("[id*='ddlList2']").append($('<option></option>').val(response.d[i].ID).html(response.d[i].Company_Name));
        //                    $("[id*='ddlList3']").append($('<option></option>').val(response.d[i].Id).html(response.d[i].Company_Name));
        //                    $("[id*='ddlList4']").append($('<option></option>').val(response.d[i].Id).html(response.d[i].Company_Name));
        //                } 
        //            },
        //            failure: function (response) {

        //            }
        //        });
        //    }

        //});
    </script>
</asp:Content>

