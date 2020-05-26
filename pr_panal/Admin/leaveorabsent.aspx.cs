using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_leaveorabsent : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string PendingTask = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");
            
            if(Convert.ToString(Request.QueryString["status"])=="leave" && Convert.ToString(Request.QueryString["date"]) !=null)
            {
                insertLeaveOrAbsent(Convert.ToString(Request.QueryString["date"]), "insertForLeave");
                Response.Redirect("~/admin/leaveorabsent.aspx");
            }
            if (Convert.ToString(Request.QueryString["status"]) == "absent" && Convert.ToString(Request.QueryString["date"]) != null)
            {
                insertLeaveOrAbsent(Convert.ToString(Request.QueryString["date"]), "insertForAbsent");
                Response.Redirect("~/admin/leaveorabsent.aspx");
            }

            BinddropdownList();
        }
    }
    public int insertLeaveOrAbsent(string date, string actiontype)
    {
        try
        {


            if (Session["admin_srno"] != null)
            {
                if (Request.Cookies["ddluser"].Value != null)
                {
                    DateTime dt = new DateTime(Convert.ToInt32(date.Split('_')[2]), Convert.ToInt32(date.Split('_')[1]), Convert.ToInt32(date.Split('_')[0]));
                    string[] col4 = { "@userid", "@dateFrom", "@dateTo", "@actionType" };
                    object[] val4 = { Request.Cookies["ddluser"].Value, dt, dt, actiontype };
                    int i = dal.execute("USPLeaveOrAbsent", col4, val4);
                    return i;
                }
                

            }

            else
            {
                Response.Redirect("~/Pr-Admin-Log");

            }
            return 0;
        }
        catch (Exception ex)
        {
            return 0;
        }
    }

    private void BinddropdownList()
    {
        string[] col1 = { "@srno", "@Actiontype" };
        object[] val1 = { "0", "bindUser" };
        DataSet ds1 = dal.getDataSet("ManageLogin", col1, val1);
        if (ds1.Tables[0].Rows.Count > 0)
        {
            ddlusers.DataSource = ds1.Tables[0];
            ddlusers.DataTextField = "name";
            ddlusers.DataValueField = "srno";
            ddlusers.DataBind();
        }
        ddlusers.Items.Insert(0, new ListItem("Select Employee", "0"));
    }
    protected void btnsubmit_Click(object sender,EventArgs e)
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                DataSet ds = new DataSet();
                if (txt_from.Text != "" && ddlusers.SelectedValue != "0")
                {
                    if (txt_to.Text != "")
                    {
                        string[] col1 = { "@userid", "@dateFrom", "@dateTo", "@actionType" };
                        object[] val1 = { ddlusers.SelectedValue, DateTime.Parse(txt_from.Text), DateTime.Parse(txt_to.Text),"select" };
                        ds = dal.getDataSet("USPLeaveOrAbsent", col1, val1);
                    }
                    if (txt_to.Text == "")
                    {
                        string[] col1 = { "@userid", "@dateFrom", "@actionType" };
                        object[] val1 = { ddlusers.SelectedValue, DateTime.Parse(txt_from.Text), "select" };
                        ds = dal.getDataSet("USPLeaveOrAbsent", col1, val1);
                    }
                }
                //Test only
                if (ds.Tables[1].Rows.Count > 0)
                {
                    string strPendingTask = string.Empty;
                    strPendingTask += "<table width='100%' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
                    strPendingTask += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPendingTask += "<td colspan='6' align='center' bgcolor='#CCCCCC' class='Tab2'><strong>Attendance of Employee</strong></td></tr>";
                    strPendingTask += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPendingTask += "<td class='Tab2'><strong>Emploee Name</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Coming Time</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Coming Date</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Going Time</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Going Date</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Actions</strong></td>";
                    strPendingTask += "</tr>";
                    int k = 0;
                    for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                    {



                        strPendingTask += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                        strPendingTask += "<td class='Tab3'>" + ds.Tables[1].Rows[i]["name"].ToString() + "&nbsp;</td>";
                        if ((ds.Tables[0].Rows.Count>k)&& (ds.Tables[0].Rows[k]["comingDate"].ToString() == ds.Tables[1].Rows[i]["comingDate"].ToString()))
                        {
                            strPendingTask += "<td class='Tab3'>" + ds.Tables[0].Rows[k]["comingTime"].ToString() + "&nbsp;</td>";
                            strPendingTask += "<td class='Tab3'>" + ds.Tables[0].Rows[k]["comingDate"].ToString() + "&nbsp;</td>";
                            strPendingTask += "<td class='Tab3'>" + ds.Tables[0].Rows[k]["goingTime"].ToString() + "&nbsp;</td>";
                            if (ds.Tables[0].Rows[k]["comingTime"].ToString() == ds.Tables[0].Rows[k]["goingTime"].ToString())
                            {
                                strPendingTask += "<td class='Tab3'>&nbsp;</td>";
                            }
                            else
                            {
                                strPendingTask += "<td class='Tab3'>" + ds.Tables[0].Rows[k]["goingDate"].ToString() + "&nbsp;</td>";
                            }
                            strPendingTask += "<td class='Tab3'><a href='/admin/leaveorabsent.aspx?status=leave&date="+ ds.Tables[0].Rows[k]["comingDate"].ToString().Replace("/", "_")+"' id='leave_" + ds.Tables[0].Rows[k]["comingDate"].ToString() + "'><input type='button'  value='Leave'/></a>&nbsp;<a href='/admin/leaveorabsent.aspx?status=absent&date="+ ds.Tables[0].Rows[k]["comingDate"].ToString().Replace("/", "_") +"' id='absent_" + ds.Tables[0].Rows[k]["comingDate"].ToString() + "'><input type='button'  value='Absent'/></a></td>";
                            k++;
                        }
                        else
                        {
                            strPendingTask += "<td class='Tab3'>&nbsp;</td>";
                            strPendingTask += "<td class='Tab3'>"+ ds.Tables[1].Rows[i]["comingDate"].ToString() +"&nbsp;</td>";
                            strPendingTask += "<td class='Tab3'>&nbsp;</td>";
                            strPendingTask += "<td class='Tab3'>&nbsp;</td>";
                            strPendingTask += "<td class='Tab3'><a href='/admin/leaveorabsent.aspx?status=leave&date="+ds.Tables[1].Rows[i]["comingDate"].ToString().Replace("/", "_")+"' id='leave_" + ds.Tables[1].Rows[i]["comingDate"].ToString() + "'><input type='button'  value='Leave'/></a>&nbsp;<a href='/admin/leaveorabsent.aspx?status=absent&date="+ ds.Tables[1].Rows[i]["comingDate"].ToString().Replace("/", "_") +"' id='absent_" + ds.Tables[1].Rows[i]["comingDate"].ToString() + "'><input type='button'  value='Absent'/></a></td>";
                        }
                        strPendingTask += "</tr>";
                    }

                    strPendingTask += "</table><br>";
                    PendingTask = strPendingTask;
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
}