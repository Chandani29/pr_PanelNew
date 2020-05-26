using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_hrfinalapproved : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int result;
            int.TryParse(Convert.ToString(Request.QueryString["empid"]), out result);
            txthdnid.Value = Convert.ToString(result);
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string[] col4 = { "@id", "@totalLeave", "@totalAbsent", "@Actiontype" };
            object[] val4 = { Convert.ToInt32(txthdnid.Value), Convert.ToInt32(txtTotalLeave.Text), Convert.ToInt32(txtTotalAbsent.Text == "" ? "0" : txtTotalAbsent.Text), "finalapprovedbyhr" };
            int i = dal.execute("ManageLeave", col4, val4);
            if (i == 1)
            {
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Final Approved";

                btnsubmit.Visible = false;
            }

        }
        catch (Exception ex)
        {

        }
    }
}


