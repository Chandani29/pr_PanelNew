using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_DeveloperLeave : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string dv_name, PendingTask, ReminderPanel, WorkDoneorNot = string.Empty;
    public int numberOfPendingApprovalLeave = 0;
    public int numberOfSeenStatus = 0, leaveApplyFormStatus = 0;
    //public string dtCurrentFormDate = DateTime.Today.ToString("yyyy-MM-dd");
    public string dtCurrentFormDate = "";
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
        else
        {
            Response.Redirect("~/Pr-Admin-Log");
        }

        if (!IsPostBack)
        {
            if (Convert.ToString(Session["msgg"]) != "")
            {
                lblmsg.Text = Convert.ToString(Session["msgg"]);
                Session["msgg"] = null;
            }
            bindApprovedBy();
            checkSeenStatus();
            checkLeaveGrant();
            checkAnyWorkDoneorNot();



        }
        checkApplyFormStatus();


    }

    private void checkAnyWorkDoneorNot()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]) };
                DataSet ds4 = dal.getDataSet("USPcheckAnyWorkDoneorNot", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    WorkDoneorNot = Convert.ToString(ds4.Tables[0].Rows[0]["msg"]);
                }
            }
        }

        catch (Exception ex)
        {

        }

    }


    private void checkApplyFormStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "checkinstanceleave" };
                DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    leaveApplyFormStatus = ds4.Tables[0].Rows.Count;
                    dtCurrentFormDate = Convert.ToDateTime(ds4.Tables[0].Rows[0]["dateFrom"]).ToString("yyyy-MM-dd"); ;
                }
                else
                {
                    leaveApplyFormStatus = 0;
                    dtCurrentFormDate = "";
                }
            }
        }

        catch (Exception ex)
        {

        }
    }

    public void bindApprovedBy()
    {
        string[] col4 = { "@srno", "@Actiontype" };
        object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "approvedby" };
        DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
        if (ds4.Tables[0].Rows.Count > 0)
        {
            ddlApprovedBy.DataSource = ds4.Tables[0];
            ddlApprovedBy.DataTextField = "name";
            ddlApprovedBy.DataValueField = "srno";
            ddlApprovedBy.DataBind();
            ddlApprovedBy.Items.Insert(0, new ListItem("--Select--", ""));
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {

            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@dateFrom", "@dateTo", "@srno", "@lastworkingday", "@reportingday", "@address", "@mobilenumber", "@JobsTODoBeforeLeave", "@ReasonforLeave", "@approvedBy", "@Actiontype" };
                object[] val4 = {new DateTime(Convert.ToInt32(txtFrom.Text.Split('-')[0]),Convert.ToInt32(txtFrom.Text.Split('-')[1]),Convert.ToInt32(txtFrom.Text.Split('-')[2])),new DateTime(Convert.ToInt32(txtTo.Text.Split('-')[0]),Convert.ToInt32(txtTo.Text.Split('-')[1]),Convert.ToInt32(txtTo.Text.Split('-')[2])),Convert.ToInt32(Session["developer_srno"]),txtLastWorkingDay.Text,txtReportingDate.Text,txtAddress.Text,
                    txtMobileNo.Text,txtJobsTODoBeforeLeave.Text,txtReasonforLeave.Text,ddlApprovedBy.SelectedValue,((ddlApprovedBy.SelectedValue==""&&leaveApplyFormStatus==1)?"instantleaveapply": "insert") };
                int i = dal.execute("ManageLeave", col4, val4);
                if (i == 1)
                {
                    Session["msgg"] = "Data Inserted Successfuly.";
                    Response.Redirect("~/Developer/DeveloperLeave.aspx");
                }
                else
                {
                    Session["msgg"] = "Error in Submition.";

                }
            }
            else
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
        }
        catch (Exception ex)
        {

        }
    }

    private void checkSeenStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "checkseenstatusbyemployee" };
                DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    numberOfSeenStatus = ds4.Tables[0].Rows.Count;
                }
            }
        }

        catch (Exception ex)
        {

        }
    }

    private void checkLeaveGrant()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "showpendingleavestatus" };
                DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    numberOfPendingApprovalLeave = ds4.Tables[0].Rows.Count;
                }
            }
        }

        catch (Exception ex)
        {

        }
    }


  

}





