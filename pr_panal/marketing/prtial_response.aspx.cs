using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class marketing_Default : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string proj_name, proj_id, total_hour, all_total_cast_upper, DoneAssigned, CostHour, ProjectDetail = string.Empty;
    public string p_name, p_id = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["srno"]))
            {
                binddatagrid();
                Session["srnoUp"] = Request.QueryString["srno"].ToString();
            }
        }
    }
    private void binddatagrid() 
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select7" };
                DataSet ds = dal.getDataSet("ManageProjDetails", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    p_name = ds.Tables[0].Rows[0]["proj_name"].ToString();
                    Session["projectname"] = p_name;
                    Session["projectId1"] = ds.Tables[0].Rows[0]["proj_id"].ToString();
                    string s = Session["projectId1"].ToString();
                    txt_date.Text = ds.Tables[0].Rows[0]["hourspend"].ToString();
                }
            }
            else
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
        }
        catch (Exception ex)
        {
            //lblmsg.Text = ex.Message.ToString();
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                p_name = Session["projectname"] == null ? "" : Session["projectname"].ToString(); 
                decimal totalhour_exp = 0;
                int srno=int.Parse(Session["srnoUp"].ToString());
                totalhour_exp = Math.Round((decimal.Parse(txt_date.Text.Trim())), 2);
                string[] col4 = { "@srno", "@hourspend", "@delete_remark","@Actiontype" };
                object[] val4 = { srno, totalhour_exp, txt_amount.Text, "update3" };
                int i = dal.execute("ManageProjDetails", col4, val4);
                if (i == 1)
                {
                    int ProjectiD=int.Parse(Session["projectId1"].ToString());
                    Response.Redirect("project_details.aspx?srno="+ProjectiD);
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