using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Marketing_complete_status : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string PartialPayment, p_name2 = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["marketing_srno"] != null)
        {
            var value = Request.Cookies["marketing_srno"].Value;
            Session["marketing_srno"] = value;
        }
        else
        {
            Response.Redirect("~/Pr-Admin-Log");
        }
        if (!IsPostBack)
        {
            bindcompletestatus();
            bindpartialpayment();
        }
    }

    private void bindcompletestatus()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string strsrno = Request.QueryString["srno"].ToString();
                string[] split = strsrno.Split(new char[] { '_' });
                string strworkstatus = split[0];
                string strsrnon = split[1];

                string[] col = { "@srno", "@proj_id", "@Actiontype" };
                object[] val = { "0", strsrnon, "select9" };
                DataSet ds = dal.getDataSet("ManageProjDetails", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Panel1.Visible = false;
                    Panel2.Visible = true;
                }
                else
                {
                    Panel1.Visible = true;
                    Panel2.Visible = false;
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
    private void bindpartialpayment()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string strsrno = Request.QueryString["srno"].ToString();
                string[] split = strsrno.Split(new char[] { '_' });
                string strworkstatus = split[0];
                string strsrnon = split[1];

                string p_id1 = string.Empty;
                string p_cost = string.Empty;
                string p_name1 = string.Empty;
                string submeted_on1 = string.Empty;
                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { strsrnon, "select5" };
                DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    p_id1 = ds1.Tables[0].Rows[0]["proj_id"].ToString();
                    p_cost = ds1.Tables[0].Rows[0]["cost"].ToString();
                    p_name1 = ds1.Tables[0].Rows[0]["proj_name"].ToString();
                    submeted_on1 = ds1.Tables[0].Rows[0]["submeted_on"].ToString();
                }
                p_name2 = p_name1;

                string[] col = { "@srno", "@proj_id", "@Actiontype" };
                object[] val = { "0", strsrnon, "select3" };
                DataSet ds = dal.getDataSet("ManagePartialPayment", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strPartialPayment = string.Empty;
                    decimal totalp_payment = 0;
                    decimal totap_balance = 0;

                    strPartialPayment += "<table width='400' border='1' cellspacing='2' cellpadding='1' class='tdrow4' align='center'>";
                    strPartialPayment += "<tr align='center'><td colspan='5' class='txt'>Summary of Payment</td>";
                    strPartialPayment += "<tr>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Project&nbsp;Name</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Project&nbsp;ID</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Date</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Payment Type</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Payment Mode</strong></td>";
                    strPartialPayment += "</tr>";

                    for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                    {
                        string strdate = ds.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");
                        totalp_payment = totalp_payment + decimal.Parse(ds.Tables[0].Rows[j]["p_payment"].ToString());

                        strPartialPayment += "<tr>";
                        strPartialPayment += "<td align='left' class='Tab3'>" + p_name1 + "</td>";
                        strPartialPayment += "<td align='left' class='Tab3'>" + p_id1 + "</td>";
                        strPartialPayment += "<td align='left' class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "</td>";
                        strPartialPayment += "<td align='left' class='Tab3'>" + ds.Tables[0].Rows[j]["p_payment"].ToString() + "</td>";
                        strPartialPayment += "<td align='left' class='Tab3'>" + ds.Tables[0].Rows[j]["pay_mode"].ToString() + "</td>";
                        strPartialPayment += "</tr>";
                    }
                    totap_balance = decimal.Parse(p_cost.ToString()) - totalp_payment;

                    strPartialPayment += "<tr>";
                    strPartialPayment += "<td align='left' class='Tab3' colspan='3'><strong>Total Partial Payment</strong></td>";
                    strPartialPayment += "<td align='left' class='Tab3' colspan='2'><strong>" + totalp_payment + "</strong></td>";
                    strPartialPayment += "</tr>";
                    strPartialPayment += "<tr>";
                    strPartialPayment += "<td align='left' class='Tab3' colspan='3'><strong>Project Cost</strong></td>";
                    strPartialPayment += "<td align='left' class='Tab3' colspan='2'><strong>" + p_cost + "</strong></td>";
                    strPartialPayment += "</tr>";
                    strPartialPayment += "<tr>";
                    strPartialPayment += "<td align='left' class='Tab3' colspan='3'><strong>Balance Amount</strong></td>";
                    strPartialPayment += "<td align='left' class='Tab3' colspan='2'><strong>" + totap_balance + "</strong></td>";
                    strPartialPayment += "</tr></table><br>";
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string strsrno = Request.QueryString["srno"].ToString();
                string[] split = strsrno.Split(new char[] { '_' });
                string strworkstatus = split[0];
                string strsrnon = split[1];

                string[] col3 = { "@srno", "@workstatus", "@remark", "@payment_received", "@payment_type", "@completed_on", "@Actiontype" };
                object[] val3 = { strsrnon, strworkstatus, txt_remark.Text.Trim(), txt_amount.Text.Trim().Replace(",", ""), txt_PayType.Text, System.DateTime.Now.ToString("MM/dd/yy H:mm:ss"), "update2" };
                int i = dal.execute("ManageProject", col3, val3);

                string[] col4 = { "@srno", "@proj_id", "@p_payment", "@pay_mode", "@ddate", "@Actiontype" };
                object[] val4 = { "0", strsrnon, txt_amount.Text.Trim().Replace(",", ""), txt_PayType.Text, System.DateTime.Now.ToString("MM/dd/yy H:mm:ss"), "add" };
                int i1 = dal.execute("ManagePartialPayment", col4, val4);
                if (i1 == 1)
                    lblmsg.Text = "Data Update Successfuly.";

                txt_remark.Text = "";
                string strURL = "marketingmain.aspx";
                ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert(' Data Update Successfully. ');window.location='" + strURL + "';", true);
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

    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                Response.Redirect("~/marketing/marketingmain.aspx");
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