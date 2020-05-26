using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_task_reply : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string refno = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["developer_srno"] != null)
        {
            var value = Request.Cookies["developer_srno"].Value;
            Session["developer_srno"] = value;
            string msg = checkApplicableForTaskReplayOrNot();
            if (msg == "Yes")
            {
                btnsubmit.Visible = true;
                errrormsg.Visible = false;
            }
            else
            {
                btnsubmit.Visible = false;
                errrormsg.Visible = true;
            }
        }
        else
        {
            Response.Redirect("~/Pr-Admin-Log");
        }
        if (!IsPostBack)
        {
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
        }
    }

    private string checkApplicableForTaskReplayOrNot()
    {
        string[] col2 = { "@srno", "@Actiontype" };
        object[] val2 = { Request.QueryString["srno"].ToString(), "verifyForTaskReplay" };
        DataSet ds2 = dal.getDataSet("ManageProjDetails", col2, val2);
        return Convert.ToString(ds2.Tables[0].Rows[0]["msg"]);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["developer_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                string[] col2 = { "@srno", "@Actiontype" };
                object[] val2 = { Request.QueryString["srno"].ToString(), "select7" };
                DataSet ds2 = dal.getDataSet("ManageProjDetails", col2, val2);

                decimal dev_cost = 0;
                decimal totalhour_exp = 0;
                decimal dev_cal_cost = 0;

                string[] col4 = { "@srno", "@proj_id", "@Actiontype" };
                object[] val4 = { "0", ds2.Tables[0].Rows[0]["proj_id"].ToString(), "select6" };
                DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    dev_cost = Math.Round((decimal.Parse(ds.Tables[0].Rows[0]["per_cost"].ToString())), 2);
                    totalhour_exp = Math.Round((decimal.Parse(txt_ths.Text.Trim())), 2);
                    dev_cal_cost = Math.Round((dev_cost * totalhour_exp), 2);
                    string[] col1 = { "@srno", "@proj_id", "@asignedby", "@proj_name", "@working_per", "@hourspend", "@dev_cost", "@work_remark", "@ddate", "@task_srno", "@Actiontype" };
                    object[] val1 = { "0", ds2.Tables[0].Rows[0]["proj_id"].ToString(), ds4.Tables[0].Rows[0]["asignedby"].ToString(), ds4.Tables[0].Rows[0]["proj_name"].ToString(), ds.Tables[0].Rows[0]["user_id"].ToString(), totalhour_exp, dev_cal_cost, txt_remark.Text.Trim(), txt_date.Text.Trim(), ds2.Tables[0].Rows[0]["task_srno"].ToString(), "add3" };
                    int i = dal.execute("ManageProjDetails", col1, val1);
                    //if (i == 1)
                    //    lblmsg.Text = "Data Save Successfuly.";

                    dal.ClearControls(this);
                    txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
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
                string[] col2 = { "@srno", "@Actiontype" };
                object[] val2 = { Request.QueryString["srno"].ToString(), "select7" };
                DataSet ds2 = dal.getDataSet("ManageProjDetails", col2, val2);
                Response.Redirect("project_report.aspx?srno=" + ds2.Tables[0].Rows[0]["proj_id"].ToString());
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