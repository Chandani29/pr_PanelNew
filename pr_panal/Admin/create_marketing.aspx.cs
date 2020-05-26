using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data; 
public partial class Admin_create_marketing : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer(); 
    public string newid, editmode = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    { 
        if (!IsPostBack)
        {
            if (Session["admin_srno"] == null) 
                Response.Redirect("~/Pr-Admin-Log");

            binddata();
            if (Request.QueryString["srno"] != null && Request.QueryString["srno"] != "")
                ReBindExpanse();
        }
    }

    private void binddata() 
    {
        int id = 1;
        string strid;
        string Query = " SELECT TOP 1 user_id FROM tbl_Login WHERE user_id LIKE 'm%' ORDER BY srno DESC ";
        DataSet dsCount = dut.GetDataSet(Query);
        if (dsCount.Tables[0].Rows.Count > 0)
        {
            string struser_id = dsCount.Tables[0].Rows[0]["user_id"].ToString().Replace("m0", "");
            struser_id = struser_id.Replace("m", "");
            id = id + Convert.ToInt32(struser_id);
            if (id.ToString().Length == 1)
                strid = "0" + id;
            else
                strid = id.ToString();
            Username.Text = "m" + strid.ToString();
        }
        else
        {
            strid = "0" + id;
            Username.Text = "m" + strid.ToString();
        }
    }
     
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (btnsubmit.Text == "Submit")  
        {
            string[] col = { "@srno", "@user_id", "@user_pass", "@name", "@job_profile", "@per_cost", "@date", "@login_type", "@status", "@Actiontype" };
            object[] val = { "0", Username.Text.Trim(), Password.Text.Trim(), txt_name.Text.Trim(), "Marketing", "", System.DateTime.Now, "3", status.Checked, "add" };
            int i = dal.execute("ManageLogin", col, val);
            if (i == 1)
            {
                lblmsg.Text = "Data Save Successfuly."; 
            }
        }
        else
        {
            string[] col = { "@srno", "@user_id", "@user_pass", "@name", "@job_profile", "@per_cost", "@date", "@login_type", "@status", "@Actiontype" };
            object[] val = { lblid.Text.Trim(), Username.Text.Trim(), Password.Text.Trim(), txt_name.Text.Trim(), "Marketing", "", lblDate.Text, "3", status.Checked, "edit" };
            int i = dal.execute("ManageLogin", col, val);
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
            string strURL = "adminmain.aspx";
            ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert(' Data Update Successfully ');window.location='" + strURL + "';", true);
        } 
        else
        {
            lblmsg.Text = "Data Save Successfuly.";
        }
    }

    private void ReBindExpanse()
    {
        lblid.Text = Request.QueryString["srno"].ToString();
        string[] col = { "@srno", "@Actiontype" };
        object[] val = { lblid.Text, "select3" };
        DataSet ds = dal.getDataSet("ManageLogin", col, val);
        if (ds.Tables[0].Rows.Count > 0)
        {
            txt_name.Text = ds.Tables[0].Rows[0]["name"].ToString();
            Username.Text = ds.Tables[0].Rows[0]["user_id"].ToString();
            Password.Text = ds.Tables[0].Rows[0]["user_pass"].ToString();
            status.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["status"].ToString());
            lblDate.Text = ds.Tables[0].Rows[0]["date"].ToString();
            btnsubmit.Text = "Update";
            editmode = "Yes";
        }
    }
}