<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Pr-Admin-In.aspx.cs" Inherits="Pr_Admin_In" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Projet Report</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="icon" type="image/png" href="images/favicon.ico" media="all" />
    <link href="css/buttons.css" rel="stylesheet" type="text/css" />
    <link href="css/class1.css" rel="stylesheet" type="text/css" />
    <link href="css/marketing.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="#E6E6E6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <form id="form1" runat="server"> 
        <table id="Table_01" width="100%" height="196" border="0" cellpadding="0" cellspacing="0"> 
            <tr>
                <td height="78" valign="top" background="images/top-bg.jpg">  
                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0"> 
                        <tr>
                            <td width="32%" height="78" background="images/top-bg.jpg"> 
                                <div align="left"> 
                                    <a href="Pr-Admin-Log">
                                    <img src="images/index_04.jpg" width="385" height="78"></a><br>
                                </div>
                            </td>
                            <td width="52%" valign="bottom">
                                <table width="600" border="0" align="left" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <div align="center">
                                            </div>
                                        </td>
                                        <td valign="bottom">
                                            <div align="right">
                                                <font color="yellow" size="3" face="Courier New, Courier, mono"></font>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="trLoginHere" runat="server">
                <td>
                    <p>
                        &nbsp;
                    </p>
                    <p>
                        &nbsp;
                    </p>
                    <table width="38%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="6%" background="images/tabl-cor_02.jpg">
                                            <div align="left">
                                                <img src="images/tabl-cor_01.jpg" width="16" height="27">
                                            </div>
                                        </td>
                                        <td width="87%" valign="middle" background="../images/tabl-cor_02.jpg">
                                            <strong><font color="#006699" size="2" face="Verdana, Arial, Helvetica, sans-serif">Login Here</font></strong>
                                        </td>
                                        <td width="7%" background="images/tabl-cor_02.jpg">
                                            <div align="right">
                                                <img src="images/tabl-cor_03.jpg" width="19" height="27">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="21" valign="top" bgcolor="#727272">
                                <table width="100%" border="0" cellspacing="1" cellpadding="0">
                                    <tr>
                                        <td height="19" bgcolor="#FFFFFF">
                                            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="3" style="border-collapse: collapse">
                                                <tr>
                                                    <td height="34" width="196">
                                                        <div align="left">
                                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>User Name:</b></font>
                                                        </div>
                                                    </td>
                                                    <td height="34">
                                                        <b><font color="#ffffff">
                                                            <asp:TextBox ID="txtuname" runat="server" CssClass="login-input-text" placeholder="Name"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtuname"
                                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                                        </font></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="34" width="196">
                                                        <div align="left">
                                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Password:</b></font>
                                                        </div>
                                                    </td>
                                                    <td height="34">
                                                        <b><font color="#ffffff">
                                                            <asp:TextBox ID="txtpass" runat="server" CssClass="login-input-text" TextMode="Password" placeholder="Password"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                                                InitialValue="" ValidationGroup="valgroup" Display="Dynamic" ControlToValidate="txtpass"
                                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                                        </font></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="56">&nbsp;
                                                    </td>
                                                    <td height="40" width="196">
                                                        <div align="left">
                                                            <asp:ImageButton ID="ibsignin" runat="server" ImageUrl="~/images/signin.jpg"
                                                                ToolTip="sign in" OnClick="btntype_Click" ValidationGroup="valgroup"></asp:ImageButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="34" width="196" colspan="2">
                                                        <div align="left">
                                                            <font color="#ff0000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b><%=ExpansTypeMsg%></b></font>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <p>
                        &nbsp;
                    </p>
                </td>
            </tr>
            <tr id="trPinCode" runat="server" visible="false">
                <td>
                    <p>
                        &nbsp;
                    </p>
                    <p>
                        &nbsp;
                    </p>
                    <table width="38%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td width="6%" background="images/tabl-cor_02.jpg">
                                            <div align="left">
                                                <img src="images/tabl-cor_01.jpg" width="16" height="27">
                                            </div>
                                        </td>
                                        <td width="87%" valign="middle" background="../images/tabl-cor_02.jpg">
                                            <strong><font color="#006699" size="2" face="Verdana, Arial, Helvetica, sans-serif">Pin Code</font></strong>
                                        </td>
                                        <td width="7%" background="images/tabl-cor_02.jpg">
                                            <div align="right">
                                                <img src="images/tabl-cor_03.jpg" width="19" height="27">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="21" valign="top" bgcolor="#727272">
                                <table width="100%" border="0" cellspacing="1" cellpadding="0">
                                    <tr>
                                        <td height="19" bgcolor="#FFFFFF">
                                            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="3" style="border-collapse: collapse">
                                                <tr>
                                                    <td height="34" width="196">
                                                        <div align="left">
                                                            <font color="#000000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b>Pin Code:</b></font>
                                                        </div>
                                                    </td>
                                                    <td height="34">
                                                        <b><font color="#ffffff">
                                                            <asp:TextBox ID="txtPinCode" runat="server" CssClass="login-input-text" TextMode="Password" placeholder="Pin Code"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                                                InitialValue="" ValidationGroup="valgroup1" Display="Dynamic" ControlToValidate="txtPinCode"
                                                                SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                                                        </font></b>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="56">&nbsp;
                                                    </td>
                                                    <td height="40" width="196">
                                                        <div align="left">
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/signin.jpg"
                                                                ToolTip="sign in" OnClick="btntype2_Click" ValidationGroup="valgroup1"></asp:ImageButton>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="34" width="196" colspan="2">
                                                        <div align="left">
                                                            <font color="#ff0000" size="1" face="Verdana, Arial, Helvetica, sans-serif"><b><%=ExpansTypeMsg%></b></font>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <p>
                        &nbsp;
                    </p>
                </td>
            </tr>
            <tr>
                <td valign="middle">
                    <div align="center">
                        <p>
                            &nbsp;
                        </p>
                        <p align="center">
                            &nbsp;
                        </p>
                        <p>
                            &nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="#999999" size="1" face="Verdana, Arial, Helvetica, sans-serif">Site
                            Empowered by AKS India Web Solutions </font></strong>
                        </p>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
