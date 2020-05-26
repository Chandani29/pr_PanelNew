using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Marketing_delete_status : System.Web.UI.Page
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
                object[] val3 = { strsrnon, strworkstatus, txt_remark.Text.Trim(), "0", "", System.DateTime.Now.ToString("MM/dd/yy H:mm:ss"), "update2" };
                int i = dal.execute("ManageProject", col3, val3);

                string[] col4 = { "@srno", "@proj_id", "@p_payment", "@pay_mode", "@ddate", "@Actiontype" };
                object[] val4 = { "0", strsrnon, "0", "", System.DateTime.Now.ToString("MM/dd/yy H:mm:ss"), "add" };
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