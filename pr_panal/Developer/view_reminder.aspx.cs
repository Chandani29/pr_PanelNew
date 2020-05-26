using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_view_reminder : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string DoneReminders = string.Empty;
    public string dv_name, PendingTask, ReminderPanel, WorkDoneorNot = string.Empty;
    public int numberOfPendingApprovalLeave = 0;
    public int numberOfSeenStatus = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["developer_srno"] != null)
        {
            var value = Request.Cookies["developer_srno"].Value;
            Session["developer_srno"] = value;  
        }
        else
        {
            Response.Redirect("~/Pr-Admin-Log");
        }
        if (!IsPostBack)
        {
            bindDoneReminders();
            checkAnyWorkDoneorNot();
        }
    }
    private void checkAnyWorkDoneorNot()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]) };
                DataSet ds4 = dal.getDataSet("USPcheckAnyWorkDoneorNot", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    WorkDoneorNot = Convert.ToString(ds4.Tables[0].Rows[0]["msg"]);
                }
            }
        }

        catch (Exception ex)
        {

        }

    }
    private void checkLeaveGrant()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "showpendingleavestatus" };
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
    private void changeSeenStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "changeseenstatus" };
                int i = dal.execute("ManageLeave", col4, val4);
                if (i == 1)
                {
                }
            }
        }

        catch (Exception ex)
        {

        }
    }
    private void bindDoneReminders()
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
                    string[] col1 = { "@srno", "@user_id", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), "select2" };
                    DataSet ds1 = dal.getDataSet("ManageReminder", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string strDoneReminders = string.Empty;
                        strDoneReminders += "<table width='800' border='1' cellspacing='2' cellpadding='1' class='tdrow4' align='center'>";
                        strDoneReminders += "<tr align='center'><td colspan='6' class='txt'>";
                        strDoneReminders += "Done Reminders (" + ds.Tables[0].Rows[0]["name"].ToString() + ")</td></tr><tr>";
                        strDoneReminders += "<td align='center' class='Tab3'><strong>Reminder Subject</strong></td>";
                        strDoneReminders += "<td align='center' class='Tab3'><strong>Reminder Description</strong></td>";
                        strDoneReminders += "<td align='center' class='Tab3'><strong>Reminder Date</strong></td>";
                        strDoneReminders += "<td align='center' class='Tab3'><strong>Reminder Status</strong></td>";
                        strDoneReminders += "<td align='center' class='Tab3'><strong>Reminder Remark</strong></td>";
                        strDoneReminders += "<td align='center' class='Tab3'><strong>Reminder Done</strong></td></tr>";
                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            string strdate = ds1.Tables[0].Rows[j]["reminder_date"].ToString().Replace(" 12:00:00 AM", "");
                            string strdone_date = string.Empty;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["done_date"].ToString()))
                                strdone_date = ds1.Tables[0].Rows[j]["done_date"].ToString().Replace(" 12:00:00 AM", "");

                            strDoneReminders += "<tr>";
                            strDoneReminders += "<td align='left' class='Tab3'>" + ds1.Tables[0].Rows[j]["subject"].ToString() + "&nbsp;</td>";
                            strDoneReminders += "<td align='left' class='Tab3'>" + ds1.Tables[0].Rows[j]["descr"].ToString() + "&nbsp;</td>";
                            strDoneReminders += "<td align='left' class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                            strDoneReminders += "<td align='left' class='Tab3'>" + ds1.Tables[0].Rows[j]["status"].ToString() + "&nbsp;</td>";
                            strDoneReminders += "<td align='left' class='Tab3'>" + ds1.Tables[0].Rows[j]["done_remark"].ToString() + "&nbsp;</td>";
                            strDoneReminders += "<td align='left' class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdone_date) + "&nbsp;</td>";
                            strDoneReminders += "</tr>";
                        }
                        strDoneReminders += "</table>";
                        DoneReminders = strDoneReminders;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
}