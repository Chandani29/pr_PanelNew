using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Marketing_add_reminder : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();

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
            binddatagrid();
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
        }
    }

    private void binddatagrid()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                string[] col1 = { "@srno", "@user_id", "@Actiontype" };
                object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select1" };
                DataSet ds1 = dal.getDataSet("ManageReminder", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    rptCustomers.DataSource = ds1.Tables[0];
                    rptCustomers.DataBind();
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
                string strdateM = Request.Form[txt_re_date.UniqueID];
                DateTime reminder_date = DateTime.ParseExact(strdateM, "MM/dd/yyyy", System.Globalization.CultureInfo.InstalledUICulture);

                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                if (btnsubmit.Text == "Submit")
                {
                    string[] col1 = { "@srno", "@user_id", "@subject", "@descr", "@reminder_date", "@date", "@status", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), txt_re_sub.Text.Trim(), txt_re_desc.Text.Trim(), reminder_date, txt_date.Text.Trim(), false, "add1" };
                    int i = dal.execute("ManageReminder", col1, val1);
                    if (i == 1)
                        lblmsg.Text = "Data Save Successfuly.";
                }
                else
                {
                    string[] col1 = { "@srno", "@user_id", "@subject", "@descr", "@reminder_date", "@date", "@status", "@Actiontype" };
                    object[] val1 = { lblid.Text.Trim(), ds.Tables[0].Rows[0]["user_id"].ToString(), txt_re_sub.Text.Trim(), txt_re_desc.Text.Trim(), reminder_date, txt_date.Text.Trim(), false, "add1" };
                    int i = dal.execute("ManageReminder", col1, val1);
                    if (i == 1)
                        lblmsg.Text = "Data Update Successfuly.";
                }

                dal.ClearControls(this);
                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                binddatagrid();

                if (btnsubmit.Text == "Update")
                {
                    btnsubmit.Text = "Submit";
                    string strURL = "adminmain.aspx";
                    ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert(' Data Update Successfully ');window.location='" + strURL + "';", true);
                }
                else
                {
                    lblmsg.Text = "Data Save Successfuly.";
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