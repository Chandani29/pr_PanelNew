using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
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
            if(Session["admin_srno"] == null)  
                Response.Redirect("~/Pr-Admin-Log");

            BinddropdownList(); 
            if (!string.IsNullOrEmpty(Request.QueryString["Id"])) 
                binddatagrid();
        } 
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (btnsubmit.Text == "Submit") 
        {
            string[] col = { "@Id", "@Reference_Id", "@Job_Profile_Id", "@Name", "@Email", "@Mobile", "@Location", "@Company_ID1","@Company_ID2","@Company_ID3","@Company_ID4", "@Remark", "@InterviewDate", "@Schedule", "@Reference_Detail", "@Condidate_Appearance", "@Status", "@Exprience", "@Cuttent_Income", "@Expected_Salary", "@Remarks_Head", "@Next_Schedule","@Key_Skill", "@Actiontype" };
            object[] val = { "0", dd_type.SelectedValue, dd_job.SelectedValue, txt_name.Text, txt_email.Text, txt_mob.Text, txt_location.Text, ddlList1.SelectedValue, ddlList2.SelectedValue, ddlList3.SelectedValue, ddlList4.SelectedValue, txt_hr_remark.Text.Trim(), DateTime.Parse(text_date_Interview.Text), txt_schedule.Text, txt_referencedetail.Text, ddl_appearance.SelectedValue, ddl_status.SelectedValue, txt_exprience.Text, txt_income.Text, txt_expected.Text, txt_head_remark.Text.Trim(), DateTime.Parse(txt_next_schedule.Text),txtkey.Text,"add" };
            int i = dal.execute("ManageIntervieweeDetail", col, val); 
            if (i == 1)   
            { 
                lblmsg.Text = "Data Save Successfuly."; 
            }
        }
        else
        {
            string[] col = { "@Id", "@Reference_Id", "@Job_Profile_Id", "@Name", "@Email", "@Mobile", "@Location","@Company_ID1", "@Company_ID2","@Company_ID3","@Company_ID4", "@Remark", "@InterviewDate", "@Schedule", "@Reference_Detail", "@Condidate_Appearance", "@Status", "@Exprience", "@Cuttent_Income", "@Expected_Salary", "@Remarks_Head", "@Next_Schedule", "@Key_Skill", "@Actiontype" };
            object[] val = { lblid.Text.Trim(), dd_type.SelectedValue, dd_job.SelectedValue, txt_name.Text, txt_email.Text, txt_mob.Text, txt_location.Text, ddlList1.SelectedValue, ddlList2.SelectedValue, ddlList3.SelectedValue, ddlList4.SelectedValue, txt_hr_remark.Text, DateTime.Parse(text_date_Interview.Text), txt_schedule.Text, txt_referencedetail.Text, ddl_appearance.SelectedValue, ddl_status.SelectedValue, txt_exprience.Text, txt_income.Text, txt_expected.Text, txt_head_remark.Text, DateTime.Parse(txt_next_schedule.Text),txtkey.Text,"edit" };           
            
            int i = dal.execute("ManageIntervieweeDetail", col, val);
            if (i == 1)
            {
                lblmsg.Text = "Data Update Successfuly."; 
            } 
        }
        dal.ClearControls(this); 
        BinddropdownList();
        if (btnsubmit.Text == "Update")
        {
            btnsubmit.Text = "Submit";
            string strURL = "Interviewee.aspx";
            ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert(' Data Update Successfully ');window.location='" + strURL + "';", true);
        }
        else
        {
            lblmsg.Text = "Data Save Successfuly.";
        }
    }
    private void BinddropdownList()
    {
         
        string[] col = { "@Id", "@Actiontype" };
        object[] val = { "0", "select3" };
        DataSet ds = dal.getDataSet("ManageRefrence", col, val);
        if (ds.Tables[0].Rows.Count > 0)
        { 
            dd_type.DataSource = ds.Tables[0];
            dd_type.DataTextField = "Reference_Type";
            dd_type.DataValueField = "Id";
            dd_type.DataBind();
        }
        dd_type.Items.Insert(0, new ListItem("Select Reference Type", ""));
        string[] col1 = { "@Id", "@Actiontype" };
        object[] val1 = { "0", "select3" };
        DataSet ds1 = dal.getDataSet("ManageJobProfile", col, val);
        if (ds1.Tables[0].Rows.Count > 0)
        {
            dd_job.DataSource = ds1.Tables[0];
            dd_job.DataTextField = "Job_Profile";
            dd_job.DataValueField = "Id";
            dd_job.DataBind();
        }
        dd_job.Items.Insert(0, new ListItem("Select Job Profile", ""));
        string[] col2 = { "@Id", "@Actiontype" };
        object[] val2 = { "0", "select3" };
        DataSet ds2 = dal.getDataSet("CompanyRefrence", col, val);
        if (ds1.Tables[0].Rows.Count > 0)
        {
            ddlList1.DataSource = ds2.Tables[0];
            ddlList1.DataTextField = "Company_Name";
            ddlList1.DataValueField = "Id";
            ddlList1.DataBind();
            ddlList1.Items.Insert(0, new ListItem("Select Company Name", ""));

            ddlList2.DataSource = ds2.Tables[0];
            ddlList2.DataTextField = "Company_Name";
            ddlList2.DataValueField = "Id";
            ddlList2.DataBind();
            ddlList2.Items.Insert(0, new ListItem("Select Company Name", ""));

            ddlList3.DataSource = ds2.Tables[0];
            ddlList3.DataTextField = "Company_Name";
            ddlList3.DataValueField = "Id";
            ddlList3.DataBind();
            ddlList3.Items.Insert(0, new ListItem("Select Company Name", ""));


            ddlList4.DataSource = ds2.Tables[0];
            ddlList4.DataTextField = "Company_Name";
            ddlList4.DataValueField = "Id";
            ddlList4.DataBind();
            ddlList4.Items.Insert(0, new ListItem("Select Company Name", ""));


        }
    } 
    private void binddatagrid() 
    {
        try
        {
            string[] col1 = { "@Id", "@Actiontype" };
            object[] val1 = { Request.QueryString["Id"].ToString().Trim(), "select2" };
            DataSet ds1 = dal.getDataSet("ManageIntervieweeDetail", col1, val1);
            if (ds1.Tables[0].Rows.Count > 0) 
            {
                
                txt_name.Text = ds1.Tables[0].Rows[0]["Name"].ToString();
                txt_email.Text = ds1.Tables[0].Rows[0]["Email"].ToString();
                txt_mob.Text = ds1.Tables[0].Rows[0]["Mobile"].ToString();
                txt_location.Text = ds1.Tables[0].Rows[0]["Location"].ToString();
                ddlList1.SelectedValue = ds1.Tables[0].Rows[0]["Company_ID1"].ToString();
                ddlList2.SelectedValue = ds1.Tables[0].Rows[0]["Company_ID2"].ToString();
                ddlList3.SelectedValue = ds1.Tables[0].Rows[0]["Company_ID3"].ToString();
                ddlList4.SelectedValue = ds1.Tables[0].Rows[0]["Company_ID4"].ToString();
                txt_hr_remark.Text = ds1.Tables[0].Rows[0]["Remark"].ToString();
                txt_schedule.Text = ds1.Tables[0].Rows[0]["Schedule"].ToString();
                dd_type.SelectedValue = ds1.Tables[0].Rows[0]["Reference_Id"].ToString();
                lbdate.Text = ds1.Tables[0].Rows[0]["InterviewDate"].ToString();
                dd_job.SelectedValue = ds1.Tables[0].Rows[0]["Job_Profile_Id"].ToString(); 
                ddl_status.SelectedValue = ds1.Tables[0].Rows[0]["Status"].ToString();
                ddl_appearance.SelectedValue = ds1.Tables[0].Rows[0]["Condidate_Appearance"].ToString();
                txt_exprience.Text = ds1.Tables[0].Rows[0]["Exprience"].ToString();  
                txt_income.Text = ds1.Tables[0].Rows[0]["Cuttent_Income"].ToString();   
                txt_expected.Text = ds1.Tables[0].Rows[0]["Expected_Salary"].ToString();  
                txt_next_schedule.Text = ds1.Tables[0].Rows[0]["Next_Schedule"].ToString();  
                txt_head_remark.Text =ds1.Tables[0].Rows[0]["Remarks_Head"].ToString();  
                text_date_Interview.Text = ds1.Tables[0].Rows[0]["InterviewDate"].ToString(); 
                txt_referencedetail.Text = ds1.Tables[0].Rows[0]["Reference_Detail"].ToString();
                txtkey.Text = ds1.Tables[0].Rows[0]["Key_Skill"].ToString(); 
                btnsubmit.Text = "Update"; 
                lblid.Text = Request.QueryString["Id"].ToString().Trim();
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    

    public class CompanyList 
    {
        public int Id { get; set; }

        public string Company_Name { get; set; } 
    }
} 