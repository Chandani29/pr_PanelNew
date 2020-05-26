using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_received_payment : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string PaymentDetail = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");

            bindPaymentDetail();
        }
    }
    private void bindPaymentDetail()
    {
        try
        {
            if (Request.Cookies["ReceivedPayment"]["From"] == null)
            {
                Response.Cookies["ReceivedPayment"].Expires = DateTime.Now.AddDays(-1);
                Response.Redirect("adminmain.aspx");
            }
            string roll;
            roll = Request.Cookies["ReceivedPayment"]["From"];
            roll = roll + "," + Request.Cookies["ReceivedPayment"]["To"];
            string[] split = roll.Split(new char[] { ',' });
            string text_date_from = split[0];
            string text_date_to = split[1];
            text_date_from24.Text = text_date_from;
            text_date_to24.Text = text_date_to;

            string strPaymentDetail = string.Empty;
            strPaymentDetail += "<table width='297' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
            strPaymentDetail += "<tr bgcolor='#CCCCCC'>";
            strPaymentDetail += "<td colspan='2' class='Tab3' align='center'><strong>From</strong>&nbsp;&nbsp;" + text_date_from + "&nbsp;&nbsp;<strong>To</strong>&nbsp;&nbsp;" + text_date_to + "</td>";
            strPaymentDetail += "</tr>";
            strPaymentDetail += "<tr bgcolor='#CCCCCC'>";
            strPaymentDetail += "<td width='193' class='Tab2'>Marketing Person</td>";
            strPaymentDetail += "<td width='83' class='Tab2'>Payment (INR)</td>";
            strPaymentDetail += "</tr>";

            string[] col = { "@srno", "@Actiontype" };
            object[] val = { "0", "select8" };
            DataSet ds = dal.getDataSet("ManageProject", col, val);
            if (ds.Tables[0].Rows.Count > 0)
            {
                decimal all_total_part_pay = 0;
                for (int z = 0; z < ds.Tables[0].Rows.Count; z++)
                {
                    decimal total_part_pay = 0;
                    string[] col1 = { "@srno", "@mp_id", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[z]["mp_id"].ToString().Trim(), "select9" };
                    DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string[] col2 = { "@srno", "@user_id", "@Actiontype" };
                        object[] val2 = { "0", ds1.Tables[0].Rows[0]["mp_id"].ToString(), "select4" };
                        DataSet ds2 = dal.getDataSet("ManageLogin", col2, val2);

                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            decimal part_sum = 0;
                            DataSet ds5 = dal.retDatasetByquery(" select sum(p_payment) as part_sum from tbl_PartialPayment where proj_id='" + ds1.Tables[0].Rows[j]["srno"].ToString() + "' and ddate >= '" + text_date_from + "' and ddate <= '" + text_date_to + "' ");
                            if (ds5.Tables[0].Rows.Count > 0)
                            {
                                if (!string.IsNullOrEmpty(ds5.Tables[0].Rows[0]["part_sum"].ToString()))
                                {
                                    part_sum = Math.Round(decimal.Parse(ds5.Tables[0].Rows[0]["part_sum"].ToString()), 2);
                                }
                            }

                            total_part_pay = Math.Round((total_part_pay + part_sum), 2);
                        }
                        strPaymentDetail += "<tr>";
                        strPaymentDetail += "<td class='Tab3'>" + ds2.Tables[0].Rows[0]["name"].ToString() + "</td>";
                        strPaymentDetail += "<td class='Tab3' align='right'>" + total_part_pay + "</td>";
                        strPaymentDetail += "</tr>";
                    }
                    all_total_part_pay = Math.Round((all_total_part_pay + total_part_pay), 2);
                }

                strPaymentDetail += "<tr bgcolor='#CCCCCC'>";
                strPaymentDetail += "<td class='Tab2' align='right'>Total (INR)</td>";
                strPaymentDetail += "<td class='Tab3' align='right'>" + all_total_part_pay + "</td>";
                strPaymentDetail += "</tr>";
                strPaymentDetail += "</table>";
                PaymentDetail = strPaymentDetail;
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    private void bindPaymentDetail1(string text_date_from, string text_date_to)
    {
        try
        {
            text_date_from24.Text = text_date_from;
            text_date_to24.Text = text_date_to;

            string strPaymentDetail = string.Empty;
            strPaymentDetail += "<table width='297' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
            strPaymentDetail += "<tr bgcolor='#CCCCCC'>";
            strPaymentDetail += "<td colspan='2' class='Tab3' align='center'><strong>From</strong>&nbsp;&nbsp;" + text_date_from + "&nbsp;&nbsp;<strong>To</strong>&nbsp;&nbsp;" + text_date_to + "</td>";
            strPaymentDetail += "</tr>";
            strPaymentDetail += "<tr bgcolor='#CCCCCC'>";
            strPaymentDetail += "<td width='193' class='Tab2'>Marketing Person</td>";
            strPaymentDetail += "<td width='83' class='Tab2'>Payment (INR)</td>";
            strPaymentDetail += "</tr>";

            string[] col = { "@srno", "@Actiontype" };
            object[] val = { "0", "select8" };
            DataSet ds = dal.getDataSet("ManageProject", col, val);
            if (ds.Tables[0].Rows.Count > 0)
            {
                decimal all_total_part_pay = 0;
                for (int z = 0; z < ds.Tables[0].Rows.Count; z++)
                {
                    decimal total_part_pay = 0;
                    string[] col1 = { "@srno", "@mp_id", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[z]["mp_id"].ToString().Trim(), "select9" };
                    DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string[] col2 = { "@srno", "@user_id", "@Actiontype" };
                        object[] val2 = { "0", ds1.Tables[0].Rows[0]["mp_id"].ToString(), "select4" };
                        DataSet ds2 = dal.getDataSet("ManageLogin", col2, val2);

                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            decimal part_sum = 0;
                            DataSet ds5 = dal.retDatasetByquery(" select sum(p_payment) as part_sum from tbl_PartialPayment where proj_id='" + ds1.Tables[0].Rows[j]["srno"].ToString() + "' and ddate >= '" + text_date_from + "' and ddate <= '" + text_date_to + "' ");
                            if (ds5.Tables[0].Rows.Count > 0)
                            {
                                if (!string.IsNullOrEmpty(ds5.Tables[0].Rows[0]["part_sum"].ToString()))
                                {
                                    part_sum = Math.Round(decimal.Parse(ds5.Tables[0].Rows[0]["part_sum"].ToString()), 2);
                                }
                            }

                            total_part_pay = Math.Round((total_part_pay + part_sum), 2);
                        }
                        strPaymentDetail += "<tr>";
                        strPaymentDetail += "<td class='Tab3'>" + ds2.Tables[0].Rows[0]["name"].ToString() + "</td>";
                        strPaymentDetail += "<td class='Tab3' align='right'>" + total_part_pay + "</td>";
                        strPaymentDetail += "</tr>";
                    }
                    all_total_part_pay = Math.Round((all_total_part_pay + total_part_pay), 2);
                }

                strPaymentDetail += "<tr bgcolor='#CCCCCC'>";
                strPaymentDetail += "<td class='Tab2' align='right'>Total (INR)</td>";
                strPaymentDetail += "<td class='Tab3' align='right'>" + all_total_part_pay + "</td>";
                strPaymentDetail += "</tr>";
                strPaymentDetail += "</table>";
                PaymentDetail = strPaymentDetail;
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            bindPaymentDetail1(Request.Form[text_date_from24.UniqueID], Request.Form[text_date_to24.UniqueID]);
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
}