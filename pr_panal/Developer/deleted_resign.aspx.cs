using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_deleted_resign : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string refno = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["developer_srno"] != null)
        {
            var value = Request.Cookies["developer_srno"].Value;
            if (value == "")
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
            Session["developer_srno"] = value;
        } 
    } 
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Request.QueryString["srno"].ToString(), "select7" };
                DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    string[] col1 = { "@srno", "@delete_remark", "@Actiontype" };
                    object[] val1 = { Request.QueryString["srno"].ToString(), del_resion.Text.Trim(), "update2" };
                    int i = dal.execute("ManageProjDetails", col1, val1);
                    if (i == 1)
                        lblmsg.Text = "Data Save Successfuly.";

                    dal.ClearControls(this);
                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Data Update Successfuly.');top.opener.document.location.reload();window.close();", true);
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Request.QueryString["srno"].ToString(), "select7" };
                DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    Response.Redirect("project_report.aspx?srno=" + ds4.Tables[0].Rows[0]["proj_id"].ToString());
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