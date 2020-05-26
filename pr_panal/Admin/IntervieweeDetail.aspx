<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="IntervieweeDetail.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server"> 
    
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

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <script type="text/javascript">
    function validate()
    {
        if ($("[id*='jobProfile']").val() == "" && $("[id*='jobStatus']").val() == "" && $("[id*='CompanyDetails']").val() == "")
        {
            alert("Please select at least one dropdown options.");
            return false;
        }
    }
   
</script>
    <table width="50%" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td>
        <asp:DropDownList ID="jobProfile" runat="server" AppendDataBoundItems="true">
           <%--<asp:ListItem Text="Select jobProfile" Value=""></asp:ListItem>--%>
        </asp:DropDownList>
                </td>
            &nbsp; &nbsp;
            <td>
        <asp:DropDownList ID="CompanyDetails" runat="server" AppendDataBoundItems="true">
           <%--<asp:ListItem Text="Select jobProfile" Value=""></asp:ListItem>--%>
        </asp:DropDownList>
                </td>
             &nbsp; &nbsp;
            <td>
                 <asp:DropDownList ID="jobStatus" runat="server" AppendDataBoundItems="true">
                     <asp:ListItem Text="Select Status" Value=""></asp:ListItem>
                     <asp:ListItem Text="Selected" Value="Selected"></asp:ListItem>
                     <asp:ListItem Text="Not Selected" Value="Not Selected"></asp:ListItem>
                     <asp:ListItem Text="Hold" Value="Hold"></asp:ListItem>
             </asp:DropDownList>
                &nbsp; &nbsp;
            </td>
            <td>
                <asp:Button ID="btnSearch" runat="server" Text="Search" onClick="btnSearch_Click" OnClientClick="return validate()"/>
              
            </td>
            
            </tr>
     </table>
      &nbsp; &nbsp;
    <table width="100%" border="1" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Name&nbsp;  
              </td>
              <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Job Profile &nbsp;  
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Email &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Phone &nbsp;    
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Location &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Remark &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Interview Date &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Condidate Appearance &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Status &nbsp;    
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Exprience &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Cuttent Income &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Expected Salary &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Remarks Head &nbsp;   
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Key Skill &nbsp;   
            
            </td>
            <td valign="middle" class="Tab2" bgcolor="#CCCCCC">Edit &nbsp;   
            </td>
        </tr>
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <tr>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Name")%></a>&nbsp;  
                    </td>
                     <td valign="middle" class="Tab3">
                        <%# Eval("Job_Profile")%></a>&nbsp;    
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Email")%></a>&nbsp; 
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Mobile")%></a>&nbsp; 
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Location")%></a>&nbsp; 
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Remark")%></a>&nbsp;  
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("InterviewDate")%></a>&nbsp;  
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Condidate_Appearance")%></a>&nbsp;  
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Status")%></a>&nbsp;  
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Exprience")%></a>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Cuttent_Income")%></a>&nbsp;
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Expected_Salary")%></a>&nbsp;  
                    </td>
                    <td valign="middle" class="Tab3">
                        <%# Eval("Remarks_Head")%></a>&nbsp;
                    </td> 
                     <td valign="middle" class="Tab3">
                        <%# Eval("Key_Skill")%></a>&nbsp;    
                    </td>
                    
                    <td valign="middle" class="Tab3">
                        <a href="Interviewee.aspx?Id=<%# Eval("Id")%>">Edit</a>&nbsp;
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>

