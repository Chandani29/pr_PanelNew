using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;

public partial class Admin_AdminMaster : System.Web.UI.MasterPage
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string submeted_on, a_msg = string.Empty;
    public int numberOfPendingApprovalLeave = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindProjectList();
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");
            checkLeaveGrant();
        }
    }

    private void checkLeaveGrant()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col4 = { "@Actiontype" };
                object[] val4 = { "countforhrpermission" };
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

    protected void linkbLogout_OnClick(object sender, EventArgs e)
    {
        Session["admin_srno"] = null;
        Session["admin_srno"] = "";
        Session["admin_password"] = null;
        Session["admin_password"] = "";
        Session.Clear();
        Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("~/Pr-Admin-Log");
    }

    private void bindProjectList()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { "0", "select1" };
                DataSet ds1 = dal.getDataSet("ManageAdminMessage", col, val);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    submeted_on = ds1.Tables[0].Rows[0]["s_date"].ToString();
                    a_msg = ds1.Tables[0].Rows[0]["admin_msg"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
            submeted_on = ex.Message.ToString();
        }
    }
}



