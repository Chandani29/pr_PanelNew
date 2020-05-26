using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_expense_details : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string PartialPayment = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindpartialpayment();
        }
    }

    private void bindpartialpayment()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { "0", "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strPartialPayment = string.Empty;
                    strPartialPayment += "<table width='70%' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
                    strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='tdrow3' align='center'><td colspan='6' class='tdrow5' bgcolor='#CCCCCC'>";
                    strPartialPayment += "<div align='center'><strong>Summary of Expenses</strong></div></td>";
                    strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Date</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Marketing Person</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Total Amount</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Total Pay Amount</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Balance Amount</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Pay Now</strong></td>";
                    strPartialPayment += "</tr>";

                    decimal Total_Amount = 0;
                    decimal Total_Pay_Amount = 0;
                    decimal Total_Balance_Amount = 0;
                    decimal Balance_Amount = 0;
                    decimal pay_amount = 0;

                    for (int z = 0; z < ds.Tables[0].Rows.Count; z++)
                    {
                        string[] col1 = { "@srno", "@mp_id", "@Actiontype" };
                        object[] val1 = { "0", ds.Tables[0].Rows[z]["user_id"].ToString(), "select2" };
                        DataSet ds1 = dal.getDataSet("ManageMarketingExpenses", col1, val1);
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[0]["amount"].ToString()))
                            {
                                string[] col2 = { "@srno", "@mp_id", "@Actiontype" };
                                object[] val2 = { "0", ds.Tables[0].Rows[z]["user_id"].ToString(), "select3" };
                                DataSet ds2 = dal.getDataSet("ManageMarketingExpenses", col2, val2);

                                string strdate = ds2.Tables[0].Rows[0]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                                string[] col3 = { "@srno", "@user_id", "@Actiontype" };
                                object[] val3 = { "0", ds.Tables[0].Rows[z]["user_id"].ToString(), "select4" };
                                DataSet ds3 = dal.getDataSet("ManageLogin", col3, val3);

                                Total_Balance_Amount = Math.Round(decimal.Parse(ds1.Tables[0].Rows[0]["amount"].ToString()), 2) - Math.Round(decimal.Parse(ds1.Tables[0].Rows[0]["pay_amount"].ToString()), 2);

                                pay_amount = Math.Round(decimal.Parse(ds1.Tables[0].Rows[0]["pay_amount"].ToString()), 2);

                                strPartialPayment += "<tr>";
                                strPartialPayment += "<td align='center' class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "</td>";
                                strPartialPayment += "<td align='center' class='Tab3'>" + ds3.Tables[0].Rows[0]["name"].ToString() + "</td>";
                                strPartialPayment += "<td align='center' class='Tab3'>" + ds1.Tables[0].Rows[0]["amount"].ToString() + "</td>";
                                if (pay_amount > 0)
                                    strPartialPayment += "<td align='center' class='Tab3' bgcolor='#00CC00'>" + ds1.Tables[0].Rows[0]["pay_amount"].ToString() + "</td>";
                                else
                                    strPartialPayment += "<td align='center' class='Tab3'>" + ds1.Tables[0].Rows[0]["pay_amount"].ToString() + "</td>";
                                strPartialPayment += "<td align='center' class='Tab3'>" + Total_Balance_Amount + "</td>";
                                if (Total_Balance_Amount == 0)
                                    strPartialPayment += "<td align='center' class='Tab3'>&nbsp;</td>";
                                else
                                    strPartialPayment += "<td align='center' class='Tab3'><a href='pay_now.aspx?srno=" + ds.Tables[0].Rows[z]["srno"].ToString() + "'>Pay Now</a></td>";
                                strPartialPayment += "</tr>";

                                Total_Amount = Total_Amount + decimal.Parse(ds1.Tables[0].Rows[0]["amount"].ToString());
                                Total_Pay_Amount = Total_Pay_Amount + decimal.Parse(ds1.Tables[0].Rows[0]["pay_amount"].ToString());
                                Balance_Amount = Balance_Amount + Total_Balance_Amount;
                            }
                        }
                    }
                    strPartialPayment += "<tr>";
                    strPartialPayment += "<td colspan='2' align='right' class='Tab2' bgcolor='#CCCCCC'>Total&nbsp;</td>";
                    strPartialPayment += "<td align='center' bgcolor='#CCCCCC' class='Tab2'>" + Total_Amount + "&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>" + Total_Pay_Amount + "&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>" + Balance_Amount + "&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>&nbsp;</td>";
                    strPartialPayment += "</tr></table>";
                    PartialPayment = strPartialPayment;
                }
            }
            else
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
}