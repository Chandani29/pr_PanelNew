using System;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_DeveloperLeaveStatus : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string dv_name, PendingTask, ReminderPanel, WorkDoneorNot = string.Empty;
    public int numberOfPendingApprovalLeave = 0;
    public int numberOfSeenStatus = 0, leaveApplyFormStatus = 0;
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
            BindGrid();
            changeSeenStatus();
            checkSeenStatus();
            checkLeaveGrant();
            checkApplyFormStatus();
            checkAnyWorkDoneorNot();
        }
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
                }
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
    private void changeSeenStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "changeseenstatusbyemployee" };
                int i = dal.execute("ManageLeave", col4, val4);
                if (i == 1)
                {
                }
            }
        }

        catch (Exception ex)
        {

        }
    }
    private void BindGrid()
    {
        string[] col4 = { "@srno", "@Actiontype" };
        object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "showleavestatus" };
        DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
        if (ds4.Tables[0].Rows.Count > 0)
        {

            GridView1.DataSource = ds4.Tables[0];
            GridView1.DataBind();
        }

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            //Determine the RowIndex of the Row whose Button was clicked.
            int rowIndex = Convert.ToInt32(e.CommandArgument);

            //Reference the GridView Row.
            GridViewRow row = GridView1.Rows[rowIndex];

            //Fetch value of Name.
            string id = (row.FindControl("lblID") as Label).Text;
            string[] col4 = { "@id", "@approvedStatus", "@Actiontype" };
            object[] val4 = { Convert.ToInt32(id), 3, "changestatusforfinalapproval" };
            int i = dal.execute("ManageLeave", col4, val4);
            if (i == 1)
            {
                Response.Redirect("~/Developer/DeveloperLeaveStatus.aspx");
            }

        }
    }

    protected void GridData_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {


                LinkButton BtnStatus = (LinkButton)e.Row.FindControl("BtnStatus");

                Label lblStatus = (Label)e.Row.FindControl("lblStatus");

                if (lblStatus.Text.Trim() == "Reinitiate Now")
                {
                    lblStatus.Visible = false;
                    BtnStatus.Visible = true;
                }
                else if (lblStatus.Text.Trim() == "Pending")
                {
                    lblStatus.Style.Add("color", "red");
                    lblStatus.Style.Add("font-weight", "bold");
                }
                else if (lblStatus.Text.Trim() == "Waiting For Hr Approval")
                {
                    lblStatus.Style.Add("color", "mediumvioletred");
                    lblStatus.Style.Add("font-weight", "bold");
                }
                else if (lblStatus.Text.Trim().Contains("Partially approved"))
                {
                    lblStatus.Style.Add("color", "darkmagenta");
                    lblStatus.Style.Add("font-weight", "bold");
                }
                else if (lblStatus.Text.Trim() == "Final approval pending")
                {
                    lblStatus.Style.Add("color", "mediumvioletred");
                    lblStatus.Style.Add("font-weight", "bold");
                }
                else if (lblStatus.Text.Trim().Contains("Leave approved"))
                {
                    lblStatus.Style.Add("color", "green");
                    lblStatus.Style.Add("font-weight", "bold");
                }
                else if (lblStatus.Text.Trim().Contains("Absent"))
                {
                    lblStatus.Style.Add("color", "#3CE0E3");
                    lblStatus.Style.Add("font-weight", "bold");
                }



            }
        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "KeyMsg", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

}




