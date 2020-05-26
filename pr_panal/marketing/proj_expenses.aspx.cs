using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Marketing_proj_expenses : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string p_name, p_id = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yyyy H:mm:ss");

            if (!string.IsNullOrEmpty(Request.QueryString["srno"]))
                binddatagrid();
        }
    }

    private void binddatagrid()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds = dal.getDataSet("ManageProject", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    p_name = ds.Tables[0].Rows[0]["proj_name"].ToString();
                    p_id = ds.Tables[0].Rows[0]["proj_id"].ToString();
                }

                string[] col1 = { "@srno", "@proj_id", "@Actiontype" };
                object[] val1 = { "0", Request.QueryString["srno"].ToString().Trim(), "select1" };
                DataSet ds1 = dal.getDataSet("ManageExpenses", col1, val1);
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

    protected void rptCustomers_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblproj_id = (Label)e.Item.FindControl("lblproj_id");
            Label lblp_name1 = (Label)e.Item.FindControl("lblp_name1");
            Label lblp_id1 = (Label)e.Item.FindControl("lblp_id1");

            string[] col1 = { "@srno", "@Actiontype" };
            object[] val1 = { lblproj_id.Text.Trim(), "select5" };
            DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                lblp_name1.Text = ds1.Tables[0].Rows[0]["proj_name"].ToString();
                lblp_id1.Text = ds1.Tables[0].Rows[0]["proj_id"].ToString();
            }
        }
    } 
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try  
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col3 = { "@srno", "@proj_id", "@proj_exp_cost", "@exp_name", "@ddate", "@Actiontype" };
                object[] val3 = { "0", Request.QueryString["srno"].ToString().Trim(), txt_amount.Text.Trim(), txt_PayType.Text.Trim(), Request.Form[txt_date.UniqueID], "add" };
                int i3 = dal.execute("ManageExpenses", col3, val3);
                lblmsg.Text = "Data Save Successfuly."; 
                dal.ClearControls(this); 
                if (!string.IsNullOrEmpty(Request.QueryString["srno"]))
                    binddatagrid();
                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yyyy H:mm:ss");

                Page.ClientScript.RegisterStartupScript(this.GetType(), "KeyMsg", "alert('Data Save Successfuly.');", true);
                Response.Redirect(Request.Url.AbsoluteUri);
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