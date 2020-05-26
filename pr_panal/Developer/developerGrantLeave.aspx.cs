using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_developerGrantLeave : System.Web.UI.Page
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
    private void BindGrid()
    {
        string[] col4 = { "@srno", "@Actiontype" };
        object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "showgrantleave" };
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
            object[] val4 = { Convert.ToInt32(id), 1, "changestatusbyapprovedby" };
            int i = dal.execute("ManageLeave", col4, val4);
            if (i == 1)
            {
                Response.Redirect("~/Developer/developerGrantLeave.aspx");
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

                if (lblStatus.Text == "Pending")
                {
                    BtnStatus.Visible = true;
                }
                else if (lblStatus.Text == "Forwaded to hr")
                {
                    BtnStatus.Visible = false;
                    lblStatus.Visible = true;
                    lblStatus.Style.Add("color", "mediumvioletred");
                    lblStatus.Style.Add("font-weight", "bolder");
                }

                else
                {
                    BtnStatus.Visible = false;
                    lblStatus.Visible = true;
                    lblStatus.Style.Add("color", "Green");
                    lblStatus.Style.Add("font-weight", "bolder");
                }

            }
        }
        catch (Exception ex)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "KeyMsg", "alert('" + ex.Message.ToString() + "');", true);
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






