using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string newid = string.Empty; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");
             
            binddata();
            if (Request.QueryString["Id"] != null)
            {
                ReBindExpanse();
            } 
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (btnsubmit.Text == "Submit")
        {
            string[] col = { "@Id", "@Job_Profile", "@Status", "@Actiontype" };
            object[] val = { "0", txt_job.Text, status.Checked, "add" };
            int i = dal.execute("ManageJobProfile", col, val); 
            if (i == 1)
            { 
                lblmsg.Text = "Data Save Successfuly.";
            }  
        } 
        else
        {
            string[] col = { "@Id", "@Job_Profile", "@Status", "@Actiontype" };
            object[] val = { lblid.Text.Trim(), txt_job.Text, status.Checked, "edit" };
            int i = dal.execute("ManageJobProfile", col, val);
            if (i == 1)
            {
                lblmsg.Text = "Data Update Successfuly.";
            } 
        }
        dal.ClearControls(this);
        binddata();
        if (btnsubmit.Text == "Update")
        {
            btnsubmit.Text = "Submit";
            string strURL = "Job_Profile.aspx";
            ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert(' Data Update Successfully ');window.location='" + strURL + "';", true);
        }
        else
        {
            lblmsg.Text = "Data Save Successfuly.";
        }
    }
    private void binddata()
    {
        string[] col = { "@Id", "@Actiontype" };
        object[] val = { "0", "select1" };
        DataSet ds = dal.getDataSet("ManageJobProfile", col, val);
        if (ds.Tables[0].Rows.Count > 0)
        {
            Repeater1.DataSource = ds.Tables[0];
            Repeater1.DataBind();
        }
    }

    private void ReBindExpanse()
    {
        lblid.Text = Request.QueryString["Id"].ToString();
        string[] col = { "@Id", "@Actiontype" };
        object[] val = { lblid.Text, "select2" };
        DataSet ds = dal.getDataSet("ManageJobProfile", col, val); 
        if (ds.Tables[0].Rows.Count > 0)
        {
            txt_job.Text = ds.Tables[0].Rows[0]["Job_Profile"].ToString();
            status.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Status"].ToString());
            btnsubmit.Text = "Update"; 
        }
    }
}