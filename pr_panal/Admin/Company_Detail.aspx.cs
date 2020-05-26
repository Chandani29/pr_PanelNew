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

    public object txt_Reference { get; private set; }

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
            if (Request.QueryString["del"] != null)
            {
                DeleteCompany();
            } 
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (btnsubmit.Text == "Submit")
        {
            string[] col = { "@Id", "@Company_Name", "@Status", "@Actiontype" };
            object[] val = { "0", txt_company.Text, status.Checked, "add" };
            int i = dal.execute("CompanyRefrence", col, val);
            if (i == 1)
            {
                lblmsg.Text = "Data Save Successfuly.";
            }
        }
        else
        {
            string[] col = { "@Id", "@Company_Name", "@Status", "@Actiontype" };
            object[] val = { lblid.Text.Trim(), txt_company.Text, status.Checked, "edit" };
            int i = dal.execute("CompanyRefrence", col, val);
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
            string strURL = "Company_Detail.aspx";
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
        DataSet ds = dal.getDataSet("CompanyRefrence", col, val);
        if (ds.Tables[0].Rows.Count > 0)
        {
            Repeater1.DataSource = ds.Tables[0];
            Repeater1.DataBind();
        }
    }
    private void DeleteCompany()
    {
        string[] col = { "@Id", "@Actiontype" };
        object[] val = { Request.QueryString["del"].ToString(), "delete" };
        DataSet ds = dal.getDataSet("CompanyRefrence", col, val);
        int i = dal.execute("CompanyRefrence", col, val);
        if (i == 1)
        {
            lblmsg.Text = "Data Save Successfuly.";
        }
        binddata();
    }
    private void ReBindExpanse()
    {
        lblid.Text = Request.QueryString["Id"].ToString();
        string[] col = { "@Id", "@Actiontype" };
        object[] val = { lblid.Text, "select2" };
        DataSet ds = dal.getDataSet("CompanyRefrence", col, val);
        if (ds.Tables[0].Rows.Count > 0)
        {
            txt_company.Text = ds.Tables[0].Rows[0]["Company_Name"].ToString();
            status.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["Status"].ToString());
            btnsubmit.Text = "Update";
        }
    } 
    private void binddatagrid()
    {
        try
        {
            string[] col1 = { "@Id", "@Actiontype" };
            object[] val1 = { Request.QueryString["Id"].ToString().Trim(), "select2" };
            DataSet ds1 = dal.getDataSet("CompanyRefrence", col1, val1);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                txt_company.Text = ds1.Tables[0].Rows[0]["Company_Name"].ToString();
                btnsubmit.Text = "Update";
                lblid.Text = Request.QueryString["Id"].ToString().Trim();


            }

        }
        catch(Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();

        }
    }
}