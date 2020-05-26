using System;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_hrInstantLeaveApproval : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindEmployee();
        }
    }
    public void bindEmployee()
    {
        string[] col4 = { "@Actiontype" };
        object[] val4 = { "allemployeelist" };
        DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
        if (ds4.Tables[0].Rows.Count > 0)
        {
            ddlEmployee.DataSource = ds4.Tables[0];
            ddlEmployee.DataTextField = "name";
            ddlEmployee.DataValueField = "srno";
            ddlEmployee.DataBind();
            ddlEmployee.Items.Insert(0, new ListItem("--Select--", ""));
        }
    }
    //public void bindEmployee()
    //{
    //    string[] col4 = { "@srno", "@Actiontype" };
    //    object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "approvedby" };
    //    DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
    //    if (ds4.Tables[0].Rows.Count > 0)
    //    {
    //        ddlEmployee.DataSource = ds4.Tables[0];
    //        ddlEmployee.DataTextField = "name";
    //        ddlEmployee.DataValueField = "srno";
    //        ddlEmployee.DataBind();
    //        ddlEmployee.Items.Insert(0, new ListItem("--Select--", ""));
    //    }
    //}
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string[] col4 = { "@srno", "@dateFrom", "@Actiontype" };
            object[] val4 = { Convert.ToInt32(ddlEmployee.SelectedValue), new DateTime(Convert.ToInt32(txtFrom.Text.Split('-')[0]), Convert.ToInt32(txtFrom.Text.Split('-')[1]), Convert.ToInt32(txtFrom.Text.Split('-')[2])), "instantapprovedbyhr" };
            int i = dal.execute("ManageLeave", col4, val4);
            if (i == 1)
            {
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Instant approval applicable.";
                txtFrom.Text = "";
                ddlEmployee.SelectedValue = "";
                btnsubmit.Visible = false;
            }

        }
        catch (Exception ex)
        {

        }
    }

}






