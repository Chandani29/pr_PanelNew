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
    public string srno = "P-1";   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");

            BinddropdownList();
            bindJobProfile();
            bindCompanyDetails();
        } 
    }

    private void BinddropdownList()
    {
        string[] col2 = { "@Id", "@Actiontype" };
        object[] val2 = { "0", "select1" };
        DataSet ds2 = dal.getDataSet("ManageIntervieweeDetail", col2, val2);
        if (ds2.Tables[0].Rows.Count > 0)
        {
            Repeater1.DataSource = ds2.Tables[0];
            Repeater1.DataBind();
        } 
    }

    
    private void bindJobProfile(string profile = "", string status = "")
    {
        string[] col2 = { "@Id", "@Actiontype" };
        object[] val2 = { "0", "bindjobprofile" };
        DataSet ds2 = dal.getDataSet("ManageIntervieweeDetail", col2, val2);
        if (ds2.Tables[0].Rows.Count > 0)
        {
            jobProfile.Items.Clear();//Clear all item from dropdown that is allready exist
            jobProfile.DataSource = ds2.Tables[0];  //Here ddlstate is the id of the dropdownlist
            jobProfile.DataTextField = "Job_Profile";
            jobProfile.DataValueField = "Id";
            jobProfile.DataBind();
            jobProfile.Items.Insert(0, new ListItem("Select Job Profile", ""));
            jobProfile.SelectedValue = profile;
            jobStatus.SelectedValue = status;
        }
    }

    protected void btnSearch_Click(object sebder, EventArgs e)
    {
        string[] col2 = { "@Id", "@Job_Profile_Id", "@Status", "@Actiontype", "@Company_ID1" };
        object[] val2 = { "0", jobProfile.SelectedValue, jobStatus.SelectedValue, "select1", (CompanyDetails.SelectedValue == "" ? "0" : CompanyDetails.SelectedValue) };
        DataSet ds2 = dal.getDataSet("ManageIntervieweeDetail", col2, val2);

        Repeater1.DataSource = ds2.Tables[0];
        Repeater1.DataBind();

        bindJobProfile(jobProfile.SelectedValue, jobStatus.SelectedValue);
        bindCompanyDetails(CompanyDetails.SelectedValue); 
    }
        private void bindCompanyDetails(string comanyDetail = "", string status = "")
    {
        string[] col2 = { "@Id", "@Actiontype" };
        object[] val2 = { "0", "bindCompanyDetails" };
        DataSet ds2 = dal.getDataSet("ManageIntervieweeDetail", col2, val2);
        if (ds2.Tables[0].Rows.Count > 0)
        {
            CompanyDetails.Items.Clear();//Clear all item from dropdown that is allready exist
            CompanyDetails.DataSource = ds2.Tables[0];  //Here ddlstate is the id of the dropdownlist
            CompanyDetails.DataTextField = "Company_Name";
            CompanyDetails.DataValueField = "Id";
            CompanyDetails.DataBind();
            CompanyDetails.Items.Insert(0, new ListItem("Select Company", ""));
            CompanyDetails.SelectedValue = comanyDetail;
        }
    }

}

