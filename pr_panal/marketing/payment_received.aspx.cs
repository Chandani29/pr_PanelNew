using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Marketing_payment_received : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string text_date_from, text_date_to, z, total_partial_payment, total_payment_received, total_expenses, total_bal_cost_sub, total_balance, total_cost = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            binddatagrid();
        }
    }

    private void binddatagrid()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                if (Request.Cookies["PaymentReceived"]["From"] == null)
                {
                    Response.Cookies["PaymentReceived"].Expires = DateTime.Now.AddDays(-1);
                    Response.Redirect("marketingmain.aspx");
                }

                string roll;
                roll = Request.Cookies["PaymentReceived"]["From"];
                roll = roll + "," + Request.Cookies["PaymentReceived"]["To"];
                string[] split = roll.Split(new char[] { ',' });

                text_date_from = Convert.ToDateTime(split[0]).ToString("d/MMM/yyyy");
                text_date_to = Convert.ToDateTime(split[1]).ToString("d/MMM/yyyy");


                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                string[] col1 = { "@srno", "@user_id", "@Actiontype" };
                object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select1" };
                DataSet ds1 = dal.getDataSet("ManageReminder", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    //rptCustomers.DataSource = ds1.Tables[0];
                    //rptCustomers.DataBind();
                }
            }
            else
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
        }
        catch (Exception ex)
        {
            //lblmsg.Text = ex.Message.ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.Cookies["PaymentReceived"]["From"] == null)
            {
                Response.Cookies["PaymentReceived"].Expires = DateTime.Now.AddDays(-1);
                Response.Redirect("marketingmain.aspx");
            }

            string roll;
            roll = Request.Cookies["PaymentReceived"]["From"];
            roll = roll + "," + Request.Cookies["PaymentReceived"]["To"];
            string[] split = roll.Split(new char[] { ',' });

            string From = split[0];
            string To = split[1];
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
}