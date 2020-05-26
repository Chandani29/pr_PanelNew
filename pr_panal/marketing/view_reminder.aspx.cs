using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Marketing_view_reminder : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string WelcomeMessages = string.Empty;

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
        DataSet ds = new DataSet();
        string[] col = { "@srno", "@Actiontype" };
        object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
        ds = dal.getDataSet("ManageLogin", col, val);
        if (ds.Tables[0].Rows.Count > 0)
        {
            WelcomeMessages = ds.Tables[0].Rows[0]["name"].ToString();
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
                object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select2" };
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
            //lblmsg.Text = ex.Message.ToString();
        }
    }
}