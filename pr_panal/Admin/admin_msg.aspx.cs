using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_admin_msg : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string submeted_on, a_msg = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindProjectList();
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
        }
    }
    private void bindProjectList()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { "0", "select1" };
                DataSet ds1 = dal.getDataSet("ManageAdminMessage", col, val);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    submeted_on = ds1.Tables[0].Rows[0]["s_date"].ToString();
                    a_msg = ds1.Tables[0].Rows[0]["admin_msg"].ToString();
                }
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
            if (Session["admin_srno"] != null)
            {
                string[] col1 = { "@srno", "@admin_msg", "@s_date", "@Actiontype" };
                object[] val1 = { "0", txt_re_desc.Text.Trim(), txt_date.Text.Trim(), "add" };
                int i = dal.execute("ManageAdminMessage", col1, val1);
                if (i == 1)
                    lblmsg.Text = "Data Update Successfuly.";

                dal.ClearControls(this);
                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                bindProjectList();
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