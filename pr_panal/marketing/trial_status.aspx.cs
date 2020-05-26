using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Marketing_trial_status : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

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
                decimal data_hour = 0;
                string data_remark = string.Empty;

                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { strsrnon, "select5" };
                DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    data_hour = decimal.Parse(ds1.Tables[0].Rows[0]["total_hour"].ToString());
                    data_remark = ds1.Tables[0].Rows[0]["proj_desc"].ToString();
                }

                string remark = data_remark + " + " + txt_remark.Text.Trim();
                decimal totalHour = data_hour + decimal.Parse(txt_totalHour.Text);

                string[] col3 = { "@srno", "@workstatus", "@proj_desc", "@cost", "@total_hour", "@Actiontype" };
                object[] val3 = { strsrnon, strworkstatus, remark, txt_totalcost.Text.Trim().Replace(",", ""), totalHour, "update3" };
                int i = dal.execute("ManageProject", col3, val3);
                if (i == 1)
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