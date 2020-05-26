using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class Marketing_add_inhouse_proj : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["marketing_srno"] != null)
        {
            var value = Request.Cookies["marketing_srno"].Value;
            if (value == "")
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
            Session["marketing_srno"] = value;
        }
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
                string[] col1 = { "@srno", "@ProjId", "@Actiontype" };
                object[] val1 = { "0", Request.QueryString["srno"].ToString().Trim(), "select2" };
                DataSet ds1 = dal.getDataSet("ManageProjectInhouse", col1, val1);
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
                string[] col1 = { "@srno", "@ProjId", "@ProjName", "@ddate", "@Actiontype" };
                object[] val1 = { "0", Request.QueryString["srno"].ToString().Trim(), txt_projInhouse.Text.Trim(), System.DateTime.Now.ToString("MM/dd/yy H:mm:ss"), "add" };
                int i = dal.execute("ManageProjectInhouse", col1, val1);
                if (i == 1)
                    lblmsg.Text = "Data Save Successfuly.";

                dal.ClearControls(this);
                binddatagrid();
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