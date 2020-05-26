using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;

public partial class Marketing_MarketingMaster : System.Web.UI.MasterPage
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string WelcomeMessages = string.Empty;
    public string submeted_on, a_msg = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["marketing_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");

            binddata();
            bindProjectList();
        }
    }

    private void binddata()
    {
        DataSet ds = new DataSet();
        string[] col = { "@srno", "@Actiontype" };
        object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
        ds = dal.getDataSet("ManageLogin", col, val);
        if (ds.Tables[0].Rows.Count > 0)
        {
            WelcomeMessages = ds.Tables[0].Rows[0]["name"].ToString();
        }
    } 
    protected void linkbLogout_OnClick(object sender, EventArgs e)
    {
        Session["marketing_srno"] = null;
        Session["marketing_srno"] = "";
        Session["marketing_password"] = null;
        Session["marketing_password"] = "";
        Session.Clear();
        Session.Abandon();
        FormsAuthentication.SignOut();
        Queue<string> marketing_srno;
        marketing_srno = new Queue<string>();
        HttpCookie cookie = Request.Cookies["marketing_srno"];
        cookie = new HttpCookie("marketing_srno");
        cookie.Value = null;
        Response.Cookies.Add(cookie);
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
