using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Marketing_reminder_done : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string WelcomeMessages, re_sub, re_desc, re_date = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            binddata();
            binddatagrid();
        }
    }

    private void binddata()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                DataSet ds = new DataSet();
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
                ds = dal.getDataSet("ManageLogin", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    WelcomeMessages = ds.Tables[0].Rows[0]["name"].ToString();
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
                object[] val1 = { Request.QueryString["srno"].ToString().Trim(), ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select3" };
                DataSet ds1 = dal.getDataSet("ManageReminder", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    re_sub = ds1.Tables[0].Rows[0]["subject"].ToString();
                    re_desc = ds1.Tables[0].Rows[0]["descr"].ToString();
                    re_date = Convert.ToDateTime(ds1.Tables[0].Rows[0]["reminder_date"].ToString()).ToString("d/MMM/yyyy");
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
                string strdateM = Request.Form[txt_date.UniqueID];
                DateTime reminder_date = DateTime.ParseExact(strdateM, "MM/dd/yyyy", System.Globalization.CultureInfo.InstalledUICulture);
                string qry1 = " Update tbl_Reminder set status='1', done_date='" + reminder_date + "', done_remark='" + txt_remark.Text + "' where srno='" + Request.QueryString["srno"].ToString().Trim() + "'; ";
                dal.ExecuteQuery(qry1);
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Data Update Successfuly.');top.opener.document.location.reload();window.close();", true);
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