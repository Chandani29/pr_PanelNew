using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string DoneReminders = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");
            bindEmployee();

            //if (Request.QueryString["Id"] != null)
            //{
            //    string[] col = { "@Id", "@Actiontype" };
            //    object[] val = { Request.QueryString["Id"], "UpdateHr" };
            //    int i = dal.execute("ManageAttendance", col, val);
            //    if (i == 1)
            //    {
            //        lblmsg.Text = "Permission Set";
            //        Response.Redirect("~/admin/Hr_Permission.aspx");
            //    }
            //    binddata();
            //}
            //binddata();
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string[] col = { "@id", "@User_Id", "@Actiontype" };
            object[] val = { 0, ddlEmployee.SelectedValue, "PendHrUp" };
            int i = dal.execute("ManageAttendance", col, val);
            if (i == 1)
            {
                lblmsg.Text = "Permission Set for " + ddlEmployee.Items[ddlEmployee.SelectedIndex].Text;
                ddlEmployee.SelectedValue = "";
                //Response.Redirect("~/admin/Hr_Permission.aspx");
            }

        }
        catch (Exception ex)
        {

        }
    }

    private void binddata()
    {
        DoneReminders = "";
        string[] col1 = { "@Id", "@Actiontype" };
        object[] val1 = { "0", "Select11" };
        DataSet ds = dal.getDataSet("ManageAttendance", col1, val1);
        if (ds.Tables[0].Rows.Count > 0)
        {
            string strDoneReminders = string.Empty;

            for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
            {

                string Data = ds.Tables[0].Rows[j]["Status"].ToString();

                if (Data == "Go" && bool.Parse(ds.Tables[0].Rows[j]["Hr_Permission"].ToString()) == true)
                {

                    strDoneReminders += "<tr><td valign='middle' class='Tab3'>" + Convert.ToDateTime(ds.Tables[0].Rows[j]["Coming_Time"]).ToString("dd/MM/yyyy hh:mm tt") + " </td>";
                    strDoneReminders += "<td valign='middle' class='Tab3'>" + Convert.ToDateTime(ds.Tables[0].Rows[j]["Going_Time"]).ToString("dd/MM/yyyy hh:mm tt") + "</td>";
                    strDoneReminders += "<td valign='middle' class='Tab3'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</td>";
                    strDoneReminders += "<td valign='middle' class='Tab3'>Can Go</td></tr>";
                }
                else if (Data == "Come" && bool.Parse(ds.Tables[0].Rows[j]["Hr_Permission"].ToString()) == false)
                {

                    strDoneReminders += "<tr><td valign='middle' class='Tab3'>" + Convert.ToDateTime(ds.Tables[0].Rows[j]["Coming_Time"]).ToString("dd/MM/yyyy hh:mm tt") + " </td>";
                    strDoneReminders += "<td valign='middle' class='Tab3'>" + Convert.ToDateTime(ds.Tables[0].Rows[j]["Going_Time"]).ToString("dd/MM/yyyy hh:mm tt") + "</td>";
                    strDoneReminders += "<td valign='middle' class='Tab3'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</td>";
                    strDoneReminders += "<td valign='middle' class='Tab3'><a href='Hr_Permission.aspx?Id=" + ds.Tables[0].Rows[j]["Id"].ToString() + "'>Give Permission</a>&nbsp;</td></tr> ";

                }

            }
            DoneReminders += strDoneReminders;
        }
    }
}