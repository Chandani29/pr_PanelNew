using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Marketing_reduce_proj : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string p_name, p_id = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["srno"]))
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

                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    p_name = ds1.Tables[0].Rows[0]["proj_name"].ToString();
                    p_id = ds1.Tables[0].Rows[0]["proj_id"].ToString();

                    string sDay;
                    string sMonthe;
                    string strdate = ds1.Tables[0].Rows[0]["submeted_on"].ToString().Replace(" 12:00:00 AM", "");
                    string[] sDate = strdate.Split('/');
                    if (sDate[0].Length == 1)
                        sDay = "0" + sDate[0];
                    else
                        sDay = sDate[0];
                    if (sDate[1].Length == 1)
                        sMonthe = "0" + sDate[1];
                    else
                        sMonthe = sDate[1];
                    strdate = sDay + '/' + sMonthe + '/' + sDate[2];
                    txt_Delivery.Text = String.Format("{0:MM/dd/yyyy}", strdate);
                }

                string[] col2 = { "@srno", "@proj_id", "@Actiontype" };
                object[] val2 = { "0", Request.QueryString["srno"].ToString().Trim(), "selectR" };
                DataSet ds2 = dal.getDataSet("ManageCostHistory", col2, val2);
                if (ds2.Tables[0].Rows.Count > 0)
                {
                    rptCustomers.DataSource = ds2.Tables[0];
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
    protected void rptCustomers_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblproj_id = (Label)e.Item.FindControl("lblproj_id");
            Label lblp_name1 = (Label)e.Item.FindControl("lblp_name1");
            Label lblp_id1 = (Label)e.Item.FindControl("lblp_id1");
            Label lblproj_desc = (Label)e.Item.FindControl("lblproj_desc");
            Label lblsubmeted_on = (Label)e.Item.FindControl("lblsubmeted_on");
            Label lbltotal_hour = (Label)e.Item.FindControl("lbltotal_hour");

            string[] col1 = { "@srno", "@Actiontype" };
            object[] val1 = { lblproj_id.Text.Trim(), "select5" };
            DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                lblp_name1.Text = ds1.Tables[0].Rows[0]["proj_name"].ToString();
                lblp_id1.Text = ds1.Tables[0].Rows[0]["proj_id"].ToString();
                lblproj_desc.Text = ds1.Tables[0].Rows[0]["proj_desc"].ToString();
                DateTime dt = Convert.ToDateTime(ds1.Tables[0].Rows[0]["submeted_on"].ToString());
                lblsubmeted_on.Text = dt.ToString("dd/MMM/yyyy");
                lbltotal_hour.Text = ds1.Tables[0].Rows[0]["total_hour"].ToString();
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                int data_hour = 0;
                string data_remark = string.Empty;
                int proj_cost = 0;
                int bal_amount = 0;
                string remark = txt_remark.Text.Trim();
                int totalHour = Convert.ToInt32(txt_totalHour.Text.Trim());

                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    data_hour = Convert.ToInt32(ds1.Tables[0].Rows[0]["total_hour"].ToString());
                    data_remark = ds1.Tables[0].Rows[0]["proj_desc"].ToString();
                    proj_cost = Convert.ToInt32(ds1.Tables[0].Rows[0]["cost"].ToString());
                    bal_amount = proj_cost - Convert.ToInt32(txt_totalcost.Text.Trim());
                    remark = data_remark + " - " + remark;
                    totalHour = data_hour - totalHour;
                }

                string[] col2 = { "@srno", "@submeted_on", "@proj_desc", "@cost", "@total_hour", "@Actiontype" };
                object[] val2 = { Request.QueryString["srno"].ToString().Trim(), Request.Form[txt_Delivery.UniqueID], remark, bal_amount, totalHour, "update" };
                int i2 = dal.execute("ManageProject", col2, val2);

                string[] col3 = { "@srno", "@proj_id", "@bal_cost", "@process", "@P_cost", "@ddate", "@Actiontype" };
                object[] val3 = { "0", Request.QueryString["srno"].ToString().Trim(), proj_cost, "Red", txt_totalcost.Text.Trim(), Request.Form[txt_date.UniqueID], "add" };
                int i3 = dal.execute("ManageCostHistory", col3, val3);
                lblmsg.Text = "Data Save Successfuly.";

                dal.ClearControls(this);
                if (!string.IsNullOrEmpty(Request.QueryString["srno"]))
                    binddatagrid();
                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                Response.Redirect("reduce_proj.aspx?srno=" + Request.QueryString["srno"].ToString().Trim());
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