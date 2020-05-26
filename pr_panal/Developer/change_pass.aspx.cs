using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_change_pass : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
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
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["developer_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (txt_oldpass.Text.Trim() == ds.Tables[0].Rows[0]["user_pass"].ToString())
                    {
                        string[] col1 = { "@srno", "@user_id", "@user_pass", "@Actiontype" };
                        object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), txt_newpass.Text.Trim(), "edit1" };
                        int i = dal.execute("ManageLogin", col1, val1);
                        if (i == 1)
                            lblmsg.Text = "<P><font color='red'>Password Changed.</font></P>";
                        dal.ClearControls(this);
                    }
                    else
                    {
                        lblmsg.Text = "<P><font color='red'>Please Enter Correct Password.</font></P>";
                    }
                }
            }
            else
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
}