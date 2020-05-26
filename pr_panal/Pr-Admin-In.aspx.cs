using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Pr_Admin_In : System.Web.UI.Page
{
    DataAccessLayer dal = new DataAccessLayer();
    public string ExpansTypeMsg = string.Empty;
    public string strPinCode = "2015";
    protected void Page_Load(object sender, EventArgs e)
    {
        //pr.aks-india.com/admin/index.asp  
        if (!IsPostBack)
        {
            checkurl();

            if (Request.QueryString["uid"] != null && Request.QueryString["uid"] != "")
                LoginUser();
        }
    }
    public void checkurl()
    {
        try
        {
            string UrlBrowser = HttpContext.Current.Request.Url.AbsolutePath;
            string path = HttpContext.Current.Request.Url.AbsolutePath;
            string[] split = path.Split(new char[] { '/' });
            for (int j = 0; j < split.Length; j++)
            {
                if (split[j] == "Pr-Admin-In.aspx")
                {
                    Response.Redirect("~/Pr-Admin-Lgi");
                }
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Pr-Admin-Lgi");
        }
    }
    protected void btntype_Click(object sender, EventArgs e)
    {
        try
        {
            Session["UserName"] = txtuname.Text.Trim();
            Session["Password"] = txtpass.Text.Trim();
            trLoginHere.Visible = false;
            trPinCode.Visible = true;
        }
        catch (Exception ex)
        {
            ExpansTypeMsg = ex.Message.ToString();
        }
    }
    protected void btntype2_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtPinCode.Text.Trim() == strPinCode)
            {
                DataSet ds = new DataSet();
                string[] col = { "@srno", "@user_id", "@user_pass", "@Actiontype" };
                object[] val = { "0", Session["UserName"], Session["Password"], "GetLogin" };
                ds = dal.getDataSet("ManageLogin", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Session["UserName"] = null;
                    Session["UserName"] = "";
                    Session["Password"] = null;
                    Session["Password"] = "";

                    int value = Convert.ToInt32(ds.Tables[0].Rows[0]["login_type"].ToString().Trim());
                    switch (value)
                    {
                        case 1:
                            Session["admin_srno"] = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                            Session["admin_password"] = ds.Tables[0].Rows[0]["user_pass"].ToString().Trim();
                            Response.Redirect("admin/adminmain.aspx");
                            break;
                        case 2:
                            Session["developer_srno"] = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                            Session["developer_password"] = ds.Tables[0].Rows[0]["user_pass"].ToString().Trim();
                            Queue<string> developer_srno;
                            developer_srno = new Queue<string>();
                            HttpCookie cookie = Request.Cookies["developer_srno"];
                            cookie = new HttpCookie("developer_srno");
                            cookie.Value = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                            Response.Cookies.Add(cookie);
                            Response.Redirect("developer/developermain.aspx");
                            break;
                        case 3:
                            Session["marketing_srno"] = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                            Session["marketing_password"] = ds.Tables[0].Rows[0]["user_pass"].ToString().Trim();
                            Queue<string> marketing_srno;
                            marketing_srno = new Queue<string>();
                            HttpCookie cookie1 = Request.Cookies["marketing_srno"];
                            cookie1 = new HttpCookie("marketing_srno");
                            cookie1.Value = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                            Response.Cookies.Add(cookie1);
                            Response.Redirect("marketing/marketingmain.aspx");
                            break;
                    }
                }
                else
                {
                    //ExpansTypeMsg = "Invalid User...";
                }
            }
        }
        catch (Exception ex)
        {
            ExpansTypeMsg = ex.Message.ToString();
        }
    }
    private void LoginUser() 
    {
        try
        { 
            DataSet ds = new DataSet();
            string[] col = { "@srno", "@user_id", "@Actiontype" };
            object[] val = { "0", Request.QueryString["uid"].ToString().Trim(), "select4" };
            ds = dal.getDataSet("ManageLogin", col, val);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int value = Convert.ToInt32(ds.Tables[0].Rows[0]["login_type"].ToString().Trim());
                switch (value)
                {
                    case 1:
                        Session["admin_srno"] = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                        Session["admin_password"] = ds.Tables[0].Rows[0]["user_pass"].ToString().Trim();
                        Response.Redirect("admin/adminmain.aspx");
                        break;
                    case 2:
                        Session["developer_srno"] = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                        Session["developer_password"] = ds.Tables[0].Rows[0]["user_pass"].ToString().Trim();
                        Queue<string> developer_srno;
                        developer_srno = new Queue<string>();
                        HttpCookie cookie = Request.Cookies["developer_srno"];
                        cookie = new HttpCookie("developer_srno");
                        cookie.Value = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                        Response.Cookies.Add(cookie);
                        Response.Redirect("developer/developermain.aspx");
                        break;
                    case 3:
                        Session["marketing_srno"] = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                        Session["marketing_password"] = ds.Tables[0].Rows[0]["user_pass"].ToString().Trim();
                        Queue<string> marketing_srno;
                        marketing_srno = new Queue<string>();
                        HttpCookie cookie1 = Request.Cookies["marketing_srno"];
                        cookie1 = new HttpCookie("marketing_srno");
                        cookie1.Value = ds.Tables[0].Rows[0]["srno"].ToString().Trim();
                        Response.Cookies.Add(cookie1);
                        Response.Redirect("marketing/marketingmain.aspx");
                        break;
                }
            }
            else
            {
                ExpansTypeMsg = "Invalid User...";
            }
        }
        catch (Exception ex)
        {
            ExpansTypeMsg = ex.Message.ToString();
        }
    }
}