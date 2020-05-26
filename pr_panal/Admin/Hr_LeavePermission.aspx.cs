using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Hr_LeavePermission : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin_srno"] == null)
            Response.Redirect("~/Pr-Admin-Log");

        if (!IsPostBack)
        {
            BindGrid();
            //changeSeenStatus();
        }
    }

    private void changeSeenStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "changeseenstatusbyhr" };
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
        string[] col4 = { "@Actiontype" };
        object[] val4 = { "showleaveforhr" };
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
            object[] val4 = { Convert.ToInt32(id), 2, "changestatusbyhr" };
            int i = dal.execute("ManageLeave", col4, val4);
            if (i == 1)
            {
                //changeSeenStatus();
                Response.Redirect("~/admin/Hr_LeavePermission.aspx");
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
                else if (lblStatus.Text == "Reconfirm")
                {
                    BtnStatus.Visible = false;
                    lblStatus.Visible = false;
                }
                else if (lblStatus.Text == "Partially approved")
                {
                    BtnStatus.Visible = false;
                    lblStatus.Visible = true;
                    lblStatus.Style.Add("color", "darkmagenta");
                    lblStatus.Style.Add("font-weight", "bolder");
                }
                else if (lblStatus.Text == "Absent")
                {
                    BtnStatus.Visible = false;
                    lblStatus.Visible = true;
                    lblStatus.Style.Add("color", "red");
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




}




