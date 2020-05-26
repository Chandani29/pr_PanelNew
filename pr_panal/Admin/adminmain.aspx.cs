using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Admin_adminmain : System.Web.UI.Page
{
    //insert into tbl_Login(user_id, user_pass, name, job_profile,date,login_type) values('adminaks','admin0987','admin','admin',GETDATE(),'1')
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");

            binddatagrid();
        }
    }

    private void binddatagrid()
    {
        string[] col = { "@srno", "@Actiontype" };
        object[] val = { "0", "select2" };
        DataSet ds = dal.getDataSet("ManageLogin", col, val);
        if (ds.Tables[0].Rows.Count > 0)
        {
            rptCustomers.DataSource = ds.Tables[0];
            rptCustomers.DataBind();
        }

        string[] col3 = { "@srno", "@Actiontype" };
        object[] val3 = { "0", "select3" };
        DataSet ds3 = dal.getDataSet("ManageLogin", col3, val3);
        if (ds3.Tables[0].Rows.Count > 0)
        {
            Repeater1.DataSource = ds3.Tables[0];
            Repeater1.DataBind();
        }

        string[] col2 = { "@srno", "@Actiontype" };
        object[] val2 = { "0", "select6" };
        DataSet ds2 = dal.getDataSet("ManageLogin", col2, val2);
        if (ds2.Tables[0].Rows.Count > 0)
        {
            Repeater2.DataSource = ds2.Tables[0];
            Repeater2.DataBind();
        }

        string[] col4 = { "@srno", "@Actiontype" };
        object[] val4 = { "0", "select7" };
        DataSet ds4 = dal.getDataSet("ManageLogin", col4, val4);
        if (ds4.Tables[0].Rows.Count > 0)
        {
            Repeater3.DataSource = ds4.Tables[0];
            Repeater3.DataBind();
        }
    }

    protected void rptCustomers_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
             
        }
    } 
    protected void btnSubmit_Click(object sender, EventArgs e) 
    {
        try
        {
            Response.Cookies["ReceivedPayment"]["From"] = Request.Form[text_date_from24.UniqueID];
            Response.Cookies["ReceivedPayment"]["To"] = Request.Form[text_date_to24.UniqueID];
            Response.Cookies["ReceivedPayment"].Expires = DateTime.Now.AddDays(1);
            Response.Redirect("received_payment.aspx", false);
        }
        catch (Exception ex)
        {
            string str = ex.Message.ToString();
        }
    }
}