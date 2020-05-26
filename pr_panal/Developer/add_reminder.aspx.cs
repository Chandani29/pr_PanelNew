using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_add_reminder : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string OldReminders = string.Empty;
    public string dv_name, PendingTask, ReminderPanel, WorkDoneorNot = string.Empty;
    public int numberOfPendingApprovalLeave = 0;
    public int numberOfSeenStatus = 0;
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
        else
        {
            Response.Redirect("~/Pr-Admin-Log");
        }
        
        if (!IsPostBack)
        {
            bindOldReminders();
            checkAnyWorkDoneorNot();
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
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

    private void bindOldReminders()
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
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), "select1" };
                    DataSet ds1 = dal.getDataSet("ManageReminder", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string strOldReminders = string.Empty;
                        strOldReminders += "<table width='400' border='1' cellspacing='2' cellpadding='1' class='tdrow4' align='center'>";
                        strOldReminders += "<tr align='center'><td colspan='3' class='txt'>";
                        strOldReminders += "Old Reminders</td></tr><tr>";
                        strOldReminders += "<td align='center' class='Tab3'><strong>Reminder Subject</strong></td>";
                        strOldReminders += "<td align='center' class='Tab3'><strong>Reminder Description</strong></td>";
                        strOldReminders += "<td align='center' class='Tab3'><strong>Reminder Date</strong></td></tr>";
                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            string strdate = ds1.Tables[0].Rows[j]["reminder_date"].ToString().Replace(" 12:00:00 AM", "");
                            strOldReminders += "<tr>";
                            strOldReminders += "<td align='left' class='Tab3'>" + ds1.Tables[0].Rows[j]["subject"].ToString() + "&nbsp;</td>";
                            strOldReminders += "<td align='left' class='Tab3'>" + ds1.Tables[0].Rows[j]["descr"].ToString() + "&nbsp;</td>";
                            strOldReminders += "<td align='left' class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                            strOldReminders += "</tr>";
                        }
                        strOldReminders += "</table><br />";
                        OldReminders = strOldReminders;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string strdateM = Request.Form[txt_re_date.UniqueID];
                DateTime reminder_date = DateTime.ParseExact(strdateM, "MM/dd/yyyy", System.Globalization.CultureInfo.InstalledUICulture);

                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["developer_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                if (btnsubmit.Text == "Submit")
                {
                    string[] col1 = { "@srno", "@user_id", "@subject", "@descr", "@reminder_date", "@date", "@status", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), txt_re_sub.Text.Trim(), txt_re_desc.Text.Trim(), reminder_date, txt_date.Text.Trim(), false, "add1" };
                    int i = dal.execute("ManageReminder", col1, val1);
                    if (i == 1)
                        lblmsg.Text = "Data Save Successfuly.";
                }
                else
                {
                    string[] col1 = { "@srno", "@user_id", "@subject", "@descr", "@reminder_date", "@date", "@status", "@Actiontype" };
                    object[] val1 = { lblid.Text.Trim(), ds.Tables[0].Rows[0]["user_id"].ToString(), txt_re_sub.Text.Trim(), txt_re_desc.Text.Trim(), reminder_date, txt_date.Text.Trim(), false, "add1" };
                    int i = dal.execute("ManageReminder", col1, val1);
                    if (i == 1)
                        lblmsg.Text = "Data Update Successfuly.";
                }

                dal.ClearControls(this);
                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                bindOldReminders();
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