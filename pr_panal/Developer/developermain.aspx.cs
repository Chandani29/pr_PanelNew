using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_developermain : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string total_hour_proj_in, total_hour_exp1_dev_in, total_hour_proj_in1, InHouseProject = string.Empty;
    public string total_hour_proj, total_hour_exp1_dev, total_hour_proj1, ProjectList = string.Empty;
    public string dv_name, PendingTask, ReminderPanel, WorkDoneorNot = string.Empty;
    public int numberOfPendingApprovalLeave = 0;
    public int numberOfSeenStatus = 0;
    public int leaveApplyFormStatus = 0;
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
        if ((Convert.ToString(Request.QueryString["status"]) == "start" || Convert.ToString(Request.QueryString["status"]) == "stop") && Convert.ToString(Request.QueryString["task_srno"]) != "")
        {
            string msg = checkSayGoodMorningorNot(Convert.ToString(Request.QueryString["task_srno"]), Convert.ToString(Request.QueryString["status"]));
            if (msg == "No")
            {
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Kindly say goodmorning then work "+ Convert.ToString(Request.QueryString["status"])+".');top.opener.document.location.reload();window.close();", true);

                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Kindly say goodmorning then work start.')", true);
            }
            else if (msg == "Upload Task")
            {
                if (Convert.ToString(Request.QueryString["status"]) == "stop")
                {
                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Kindly submit the task status that You want to stop.');top.opener.document.location.reload();window.close();", true);

                }
                else
                {
                    ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Kindly submit the task status that You Started before, then start another.');top.opener.document.location.reload();window.close();", true);
                }
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Kindly submit the task status that You Startd before, then start another.')", true);

            }
            else if (msg == "Yes")
            {
                Response.Redirect("~/developer/developermain.aspx");
            }

            goto found;
        }

    found:
        {

            if (!IsPostBack)
            {
                bindReminderPanel();
                bindInHouseProject();
                bindProjectList();
                bindPendingTask();
                checkLeaveGrant();
                checkSeenStatus();
                checkApplyFormStatus();
                checkAnyWorkDoneorNot();
            }
        }

    }

    private string checkSayGoodMorningorNot(string task_srno = "",string task="")
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@id", "@task_srno", "@task", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), task_srno, task, "checkAttendance" };
                DataSet ds4 = dal.getDataSet("ManageAttendance", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToString(ds4.Tables[0].Rows[0]["msg"]);
                }
            }
            return "";
        }

        catch (Exception ex)
        {
            return "";
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

    private void checkApplyFormStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "checkinstanceleave" };
                DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    leaveApplyFormStatus = ds4.Tables[0].Rows.Count;
                }
            }
        }

        catch (Exception ex)
        {

        }
    }

    private void checkSeenStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "checkseenstatusbyemployee" };
                DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    numberOfSeenStatus = ds4.Tables[0].Rows.Count;
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
    private void bindReminderPanel()
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
                        string strReminderPanel = string.Empty;
                        strReminderPanel += "<tr>";
                        strReminderPanel += "<td align='center'>";
                        strReminderPanel += "<table width='100%' height='25' border='1' cellpadding='1' cellspacing='1'>";
                        strReminderPanel += "<tr>";
                        strReminderPanel += "<td colspan='4' align='center' bgcolor='#666666'><strong class='Tab2 style1'>REMINDER PANEL</strong></td>";
                        strReminderPanel += "</tr>";
                        strReminderPanel += "<tr>";
                        strReminderPanel += "<td width='13%' align='center' bgcolor='#CCCCCC'><strong class='Tab2'>Subject</strong></td>";
                        strReminderPanel += "<td width='55%' align='center' bgcolor='#CCCCCC'><strong class='Tab2'>Description</strong></td>";
                        strReminderPanel += "<td width='13%' align='center' bgcolor='#CCCCCC'><strong class='Tab2'>Date</strong></td>";
                        strReminderPanel += "<td width='11%' align='center' bgcolor='#CCCCCC'><strong class='Tab2'>Status</strong></td>";
                        strReminderPanel += "</tr>";

                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            StringBuilder subcategory = new StringBuilder();
                            string strDesc = string.Empty;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["descr"].ToString()))
                            {
                                string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["descr"].ToString(), @"<[^>]+>", "");
                                if (s1.ToString().Length > 41)
                                    strDesc = s1.Substring(0, 40);
                                else
                                    strDesc = s1;
                                subcategory.Append(strDesc);
                            }

                            string lblreminder_date_show = string.Empty;
                            string strdt3 = Convert.ToDateTime(ds1.Tables[0].Rows[j]["reminder_date"].ToString()).ToString("d/MMM/yyyy");
                            DateTime dt = Convert.ToDateTime(ds1.Tables[0].Rows[j]["reminder_date"].ToString());
                            System.TimeSpan diff1 = dt.Subtract(DateTime.Now);
                            if (diff1.Days > -1)
                            {
                                if (diff1.Days == -1)
                                    lblreminder_date_show = "<font color='#000000' class='style_mr'>" + strdt3 + "</font>";
                                if (diff1.Days == 0)
                                    lblreminder_date_show = "<font color='#FF0000'>" + strdt3 + "</font>";
                                if (diff1.Days == 1)
                                    lblreminder_date_show = "<font color='#FF00FF'>" + strdt3 + "</font>";
                                if (diff1.Days > 1)
                                    lblreminder_date_show = strdt3;
                            }
                            else
                            {
                                lblreminder_date_show = "<font color='#FF0000'><b>" + strdt3 + "</b></font>";
                            }

                            //if (DateTime.Now.Day == dt.Day)
                            //lblreminder_date_show = "<font color='#000000' class='style_mr'>" + strdt3 + "</font>";

                            strReminderPanel += "<tr>";
                            strReminderPanel += "<td width='13%' align='center' bgcolor='#E6E6E6' class='Tab3'>" + ds1.Tables[0].Rows[j]["subject"].ToString() + "&nbsp;</td>";
                            strReminderPanel += "<td width='13%' align='center' bgcolor='#E6E6E6' class='Tab3'>" + subcategory.ToString() + "&nbsp;</td>";
                            strReminderPanel += "<td width='11%' align='center' bgcolor='#E6E6E6' class='Tab3'>" + lblreminder_date_show + "&nbsp;</td>";
                            strReminderPanel += "<td width='8%' align='center' bgcolor='#E6E6E6' class='Tab3'><a href='reminder_done.aspx?srno=" + ds1.Tables[0].Rows[j]["srno"].ToString() + "' target='_blank'><font color='#0000FF'>Pending</font></a></td>";
                            strReminderPanel += "</tr>";
                        }

                        strReminderPanel += "</table>";
                        strReminderPanel += "</td>";
                        strReminderPanel += "</tr>";
                        ReminderPanel = strReminderPanel;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    private void bindInHouseProject()
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
                    string[] col1 = { "@srno", "@asigned_per", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), "select6" };
                    DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string coror1 = string.Empty;
                        string strInHouseProject = string.Empty;
                        decimal total_hour = 0;
                        decimal hour_exp1 = 0;
                        decimal Balance_Hours = 0;
                        decimal total_hour_exp1_dev_in_new = 0;
                        decimal total_hour_proj_in_new = 0;

                        strInHouseProject += "<table width='70%' border='1' align='center' cellpadding='3' cellspacing='1' class='tdrow4'>";
                        strInHouseProject += "<tr valign='top' bgcolor='#E6E6E6' class='tdrow3' align='center'>";
                        strInHouseProject += "<td colspan='13' class='Tab2' bgcolor='#CCCCCC'>";
                        strInHouseProject += "<div align='center'><strong>InHouse Project Only</strong></div>";
                        strInHouseProject += "</td></tr>";
                        strInHouseProject += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                        strInHouseProject += "<td class='Tab2'><strong>Project Id</strong></td>";
                        strInHouseProject += "<td class='Tab2' align='center'>Project Name</td>";
                        strInHouseProject += "<td class='Tab2'><strong>Date</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Assigned By</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Project Type</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Project Description</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Total Hours</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Hours Spent</strong></td>";
                        strInHouseProject += "<td><strong class='Tab2'>Balance Hours</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Delivery Date</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Assigned To</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Client Remarks</strong></td>";
                        strInHouseProject += "<td class='Tab2'><strong>Project Status</strong></td>";
                        strInHouseProject += "</tr>";

                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            if (ds1.Tables[0].Rows[j]["workstatus"].ToString().Trim() == "Received")
                                coror1 = "blue";
                            if (ds1.Tables[0].Rows[j]["workstatus"].ToString().Trim() == "Trial Project")
                                coror1 = "brown";
                            if (ds1.Tables[0].Rows[j]["workstatus"].ToString().Trim() == "Dead")
                                coror1 = "red";
                            if (ds1.Tables[0].Rows[j]["workstatus"].ToString().Trim() == "Completed")
                                coror1 = "green";

                            string strdate = ds1.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                            string[] col2 = { "@srno", "@user_id", "@Actiontype" };
                            object[] val2 = { "0", ds1.Tables[0].Rows[j]["mp_id"].ToString(), "select4" };
                            DataSet ds2 = dal.getDataSet("ManageLogin", col2, val2);

                            string[] col3 = { "@srno", "@Actiontype" };
                            object[] val3 = { ds1.Tables[0].Rows[j]["type_proj"].ToString(), "select4" };
                            DataSet ds3 = dal.getDataSet("ManageProjectType", col3, val3);

                            StringBuilder subcategory = new StringBuilder();
                            string strDesc = string.Empty;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["proj_desc"].ToString()))
                            {
                                string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["proj_desc"].ToString(), @"<[^>]+>", "");
                                if (s1.ToString().Length > 41)
                                    strDesc = s1.Substring(0, 40);
                                else
                                    strDesc = s1;
                                subcategory.Append(strDesc);
                            }

                            total_hour = Math.Round(decimal.Parse(ds1.Tables[0].Rows[j]["total_hour"].ToString()), 2);

                            string[] col4 = { "@srno", "@proj_id", "@Actiontype" };
                            object[] val4 = { "0", ds1.Tables[0].Rows[j]["srno"].ToString(), "select4" };
                            DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                            if (ds4.Tables[0].Rows.Count > 0)
                            {
                                for (int z = 0; z < ds4.Tables[0].Rows.Count; z++)
                                {
                                    if (string.IsNullOrEmpty(ds4.Tables[0].Rows[z]["work_by_mark"].ToString()))
                                    {
                                        hour_exp1 = hour_exp1 + Math.Round(decimal.Parse(ds4.Tables[0].Rows[z]["hourspend"].ToString()), 2);
                                    }
                                }
                            }
                            total_hour_exp1_dev_in_new = total_hour_exp1_dev_in_new + hour_exp1;
                            total_hour_exp1_dev_in_new = Math.Round(total_hour_exp1_dev_in_new, 2);
                            total_hour_exp1_dev_in = total_hour_exp1_dev_in_new.ToString();

                            Balance_Hours = total_hour - hour_exp1;

                            string strMarketing = ds1.Tables[0].Rows[j]["asigned_per"].ToString();
                            string strMarketin = string.Empty;
                            string strasigned_per = string.Empty;
                            string[] split = strMarketing.Split(new char[] { ',' });
                            int arrLenth = split.Length;
                            for (int a = 0; a < arrLenth; a++)
                            {
                                strMarketin += strMarketin + "'" + split[a] + "',";
                            }
                            strMarketin = strMarketin.Remove(strMarketin.Length - 1);
                            DataSet ds5 = dal.retDatasetByquery(" select name from tbl_Login where user_id in (" + strMarketin.ToString().Trim() + ") ");
                            if (ds5.Tables[0].Rows.Count > 0)
                            {
                                for (int z = 0; z < ds5.Tables[0].Rows.Count; z++)
                                {
                                    strasigned_per += ds5.Tables[0].Rows[z]["name"].ToString() + ",";
                                }
                            }
                            strasigned_per = strasigned_per.Remove(strasigned_per.Length - 1);

                            StringBuilder subRemark = new StringBuilder();
                            string strRemark = string.Empty;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["Remark"].ToString()))
                            {
                                string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["Remark"].ToString(), @"<[^>]+>", "");
                                if (s1.ToString().Length > 41)
                                    strRemark = s1.Substring(0, 40);
                                else
                                    strRemark = s1;
                                subRemark.Append(strRemark);
                            }

                            total_hour_proj_in_new = total_hour_proj_in_new + total_hour;
                            total_hour_proj_in_new = Math.Round(total_hour_proj_in_new, 2);
                            total_hour_proj_in = total_hour_proj_in_new.ToString();

                            total_hour_proj_in_new = total_hour_proj_in_new - total_hour_exp1_dev_in_new;
                            total_hour_proj_in_new = Math.Round(total_hour_proj_in_new, 2);
                            total_hour_proj_in1 = total_hour_proj_in_new.ToString();

                            strInHouseProject += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                            strInHouseProject += "<td class='Tab3'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["proj_id"].ToString() + "</font>&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3' align='center'>&nbsp;<a href='project_report.aspx?srno=" + ds1.Tables[0].Rows[j]["srno"].ToString() + "' target='_blank'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["proj_name"].ToString() + "</font></a></td>";
                            strInHouseProject += "<td class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + ds2.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + ds3.Tables[0].Rows[0]["ProjectType"].ToString() + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + subcategory.ToString() + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + total_hour + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + hour_exp1 + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + Balance_Hours + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + ds1.Tables[0].Rows[j]["submeted_on"].ToString() + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + strasigned_per + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'>" + subRemark.ToString() + "&nbsp;</td>";
                            strInHouseProject += "<td class='Tab3'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["workstatus"].ToString() + "</font>&nbsp;</td>";
                            strInHouseProject += "</tr>";
                        }

                        strInHouseProject += "<tr valign='top' class='tb2'>";
                        strInHouseProject += "<td colspan='6' align='right' bgcolor='#E6E6E6' class='Tab2'><strong>Total</strong>&nbsp;</td>";
                        strInHouseProject += "<td align='left' bgcolor='#E6E6E6' class='Tab2'><strong>" + total_hour_proj_in + "</strong>&nbsp;</td>";
                        strInHouseProject += "<td align='left' bgcolor='#E6E6E6' class='Tab2'><strong>" + total_hour_exp1_dev_in + "&nbsp;</strong></td>";
                        strInHouseProject += "<td align='left' bgcolor='#E6E6E6' class='Tab2'>" + total_hour_proj_in1 + "&nbsp;</td>";
                        strInHouseProject += "<td colspan='4' align='right' bgcolor='#E6E6E6' class='Tab2'>&nbsp;</td>";
                        strInHouseProject += "</tr></table><br>";
                        InHouseProject = strInHouseProject;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    private void bindProjectList()
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
                    string[] col1 = { "@srno", "@asigned_per", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), "select7" };
                    DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string strProjectList = string.Empty;
                        decimal total_hour = 0;
                        decimal hour_exp1 = 0;
                        decimal Balance_Hours = 0;
                        decimal total_hour_exp1_dev_new = 0;
                        decimal total_hour_proj_new = 0;
                        decimal total_hour_proj1_new = 0;

                        strProjectList += "<table width='70%' border='1' cellpadding='3' cellspacing='1' class='tdrow4' align='center'>";
                        strProjectList += "<tr valign='top' bgcolor='#E6E6E6' class='tdrow3' align='center'>";
                        strProjectList += "<td colspan='13' class='Tab2' bgcolor='#CCCCCC'>";
                        strProjectList += "<div align='center'><strong>Project List</strong></div></td></tr>";
                        strProjectList += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                        strProjectList += "<td class='Tab2'><strong>Project Id</strong></td>";
                        strProjectList += "<td class='Tab2' align='center'>Project Name</td>";
                        strProjectList += "<td class='Tab2'><strong>Date</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Assigned By</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Project Type</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Project Description</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Total Hours</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Hours Spent</strong></td>";
                        strProjectList += "<td><strong class='Tab2'>Balance Hours</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Delivery Date</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Assigned To</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Client Remarks</strong></td>";
                        strProjectList += "<td class='Tab2'><strong>Project Status</strong></td>";
                        strProjectList += "</tr>";

                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            string strdate = ds1.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                            string[] col2 = { "@srno", "@user_id", "@Actiontype" };
                            object[] val2 = { "0", ds1.Tables[0].Rows[j]["mp_id"].ToString(), "select4" };
                            DataSet ds2 = dal.getDataSet("ManageLogin", col2, val2);

                            string[] col3 = { "@srno", "@Actiontype" };
                            object[] val3 = { ds1.Tables[0].Rows[j]["type_proj"].ToString(), "select4" };
                            DataSet ds3 = dal.getDataSet("ManageProjectType", col3, val3);

                            StringBuilder subcategory = new StringBuilder();
                            string strDesc = string.Empty;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["proj_desc"].ToString()))
                            {
                                string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["proj_desc"].ToString(), @"<[^>]+>", "");
                                if (s1.ToString().Length > 41)
                                    strDesc = s1.Substring(0, 40);
                                else
                                    strDesc = s1;
                                subcategory.Append(strDesc);
                            }

                            total_hour = Math.Round(decimal.Parse(ds1.Tables[0].Rows[j]["total_hour"].ToString()), 2);

                            string[] col4 = { "@srno", "@proj_id", "@Actiontype" };
                            object[] val4 = { "0", ds1.Tables[0].Rows[j]["srno"].ToString(), "select4" };
                            DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                            if (ds4.Tables[0].Rows.Count > 0)
                            {
                                for (int z = 0; z < ds4.Tables[0].Rows.Count; z++)
                                {
                                    if (string.IsNullOrEmpty(ds4.Tables[0].Rows[z]["work_by_mark"].ToString()))
                                    {
                                        hour_exp1 = hour_exp1 + Math.Round(decimal.Parse(ds4.Tables[0].Rows[z]["hourspend"].ToString()), 2);
                                    }
                                }
                            }
                            //total_hour_exp1_dev = total_hour_exp1_dev + hour_exp1;

                            total_hour_exp1_dev_new = total_hour_exp1_dev_new + hour_exp1;
                            total_hour_exp1_dev_new = Math.Round(total_hour_exp1_dev_new, 2);
                            total_hour_exp1_dev = total_hour_exp1_dev_new.ToString();

                            Balance_Hours = total_hour - hour_exp1;

                            string strMarketing = ds1.Tables[0].Rows[j]["asigned_per"].ToString();
                            string strMarketin = string.Empty;
                            string strasigned_per = string.Empty;
                            string[] split = strMarketing.Split(new char[] { ',' });
                            int arrLenth = split.Length;
                            for (int a = 0; a < arrLenth; a++)
                            {
                                strMarketin += strMarketin + "'" + split[a] + "',";
                            }
                            strMarketin = strMarketin.Remove(strMarketin.Length - 1);
                            DataSet ds5 = dal.retDatasetByquery(" select name from tbl_Login where user_id in (" + strMarketin.ToString().Trim() + ") ");
                            if (ds5.Tables[0].Rows.Count > 0)
                            {
                                for (int z = 0; z < ds5.Tables[0].Rows.Count; z++)
                                {
                                    strasigned_per += ds5.Tables[0].Rows[z]["name"].ToString() + ",";
                                }
                            }
                            strasigned_per = strasigned_per.Remove(strasigned_per.Length - 1);

                            StringBuilder subRemark = new StringBuilder();
                            string strRemark = string.Empty;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["Remark"].ToString()))
                            {
                                string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["Remark"].ToString(), @"<[^>]+>", "");
                                if (s1.ToString().Length > 41)
                                    strRemark = s1.Substring(0, 40);
                                else
                                    strRemark = s1;
                                subRemark.Append(strRemark);
                            }

                            total_hour_proj = total_hour_proj + total_hour;

                            total_hour_proj_new = total_hour_proj_new + total_hour;
                            total_hour_proj_new = Math.Round(total_hour_proj_new, 2);
                            total_hour_proj = total_hour_proj_new.ToString();

                            total_hour_proj1_new = total_hour_proj_new - total_hour_exp1_dev_new;
                            total_hour_proj1_new = Math.Round(total_hour_proj1_new, 2);
                            total_hour_proj1 = total_hour_proj1_new.ToString();

                            strProjectList += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                            strProjectList += "<td class='Tab3'>" + ds1.Tables[0].Rows[j]["proj_id"].ToString() + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3' align='center'>&nbsp;<a href='project_report.aspx?srno=" + ds1.Tables[0].Rows[j]["srno"].ToString() + "' target='_blank'><font>" + ds1.Tables[0].Rows[j]["proj_name"].ToString() + "</font></a></td>";
                            strProjectList += "<td class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + ds2.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + ds3.Tables[0].Rows[0]["ProjectType"].ToString() + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + subcategory.ToString() + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + total_hour + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + hour_exp1 + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + Balance_Hours + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + ds1.Tables[0].Rows[j]["submeted_on"].ToString() + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + strasigned_per + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + subRemark.ToString() + "&nbsp;</td>";
                            strProjectList += "<td class='Tab3'>" + ds1.Tables[0].Rows[j]["workstatus"].ToString() + "&nbsp;</td>";
                            strProjectList += "</tr>";
                        }

                        strProjectList += " <tr valign='top' class='tb2'>";
                        strProjectList += "<td colspan='6' align='right' bgcolor='#E6E6E6' class='Tab2'><strong>Total</strong>&nbsp;</td>";
                        strProjectList += "<td align='left' bgcolor='#E6E6E6' class='Tab2'><strong>" + total_hour_proj + "</strong>&nbsp;</td>";
                        strProjectList += "<td align='left' bgcolor='#E6E6E6' class='Tab2'><strong>" + total_hour_exp1_dev + "</strong>&nbsp;</td>";
                        strProjectList += "<td align='left' bgcolor='#E6E6E6' class='Tab2'>" + total_hour_proj1 + "&nbsp;</td>";
                        strProjectList += "<td colspan='4' align='right' bgcolor='#E6E6E6' class='Tab2'>&nbsp;</td>";
                        strProjectList += "</tr></table><br>";
                        ProjectList = strProjectList;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    private void bindPendingTask()
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
                    string[] col1 = { "@srno", "@working_per", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), "select3" };
                    DataSet ds1 = dal.getDataSet("ManageProjDetails", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string strPendingTask = string.Empty;
                        strPendingTask += "<table width='70%' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
                        strPendingTask += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                        strPendingTask += "<td colspan='11' align='center' bgcolor='#CCCCCC' class='Tab2'><strong>Pending Task of " + ds.Tables[0].Rows[0]["name"].ToString() + "::</strong></td></tr>";
                        strPendingTask += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                        strPendingTask += "<td class='Tab2'><strong>Task ID</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>Project ID</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>Project Name</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>Date</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>Assigned By</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>To Be Submmited By</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>Assigned Task</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>Assigned Hours</strong></td>";
                        strPendingTask += "<td class='Tab2' style='width:60px;'><strong>Started Time</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>Task Status</strong></td>";
                        strPendingTask += "<td class='Tab2'><strong>Start/Stop</strong></td>";
                        strPendingTask += "</tr>";

                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            string strdate = ds1.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                            DataSet ds2 = new DataSet();
                            string proj_id = string.Empty;
                            string strPddate = string.Empty;
                            decimal total_hour = 0;
                            decimal hourspend = 0;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_by_mark"].ToString()))
                            {
                                string[] col2 = { "@srno", "@Actiontype" };
                                object[] val2 = { ds1.Tables[0].Rows[j]["proj_id"].ToString(), "select5" };
                                ds2 = dal.getDataSet("ManageProject", col2, val2);
                                proj_id = ds2.Tables[0].Rows[0]["proj_id"].ToString();
                                strPddate = ds2.Tables[0].Rows[0]["ddate"].ToString();
                                total_hour = Math.Round(decimal.Parse(ds2.Tables[0].Rows[0]["total_hour"].ToString()), 2);

                                string[] col4 = { "@srno", "@user_id", "@Actiontype" };
                                object[] val4 = { "0", ds1.Tables[0].Rows[j]["asignedby"].ToString(), "select4" };
                                DataSet ds4 = dal.getDataSet("ManageLogin", col4, val4);

                                //StringBuilder subcategory = new StringBuilder();
                                //string strDesc = string.Empty;
                                //if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                //{
                                //    string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["work_by_mark"].ToString(), @"<[^>]+>", "");
                                //    if (s1.ToString().Length > 41)
                                //        strDesc = s1.Substring(0, 40);
                                //    else
                                //        strDesc = s1;
                                //    subcategory.Append(strDesc);
                                //}

                                hourspend = Math.Round(decimal.Parse(ds1.Tables[0].Rows[j]["hourspend"].ToString()), 2);

                                strPendingTask += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                                strPendingTask += "<td class='Tab3'>" + ds1.Tables[0].Rows[j]["task_srno"].ToString() + "&nbsp;</td>";
                                strPendingTask += "<td class='Tab3'>" + proj_id + "&nbsp;</td>";
                                if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["inhouse_id"].ToString()))
                                {
                                    string[] col3 = { "@srno", "@Actiontype" };
                                    object[] val3 = { ds1.Tables[0].Rows[j]["inhouse_id"].ToString(), "select1" };
                                    DataSet ds3 = dal.getDataSet("ManageProjectInhouse", col3, val3);
                                    strPendingTask += "<td class='Tab3'><font color='#FF0000'><strong>" + ds1.Tables[0].Rows[j]["proj_name"].ToString() + "<br>" + ds3.Tables[0].Rows[0]["ProjName"].ToString() + "</strong></font>&nbsp;</td>";
                                }
                                else { strPendingTask += "<td class='Tab3'><font color='#FF0000'><strong>" + ds1.Tables[0].Rows[j]["proj_name"].ToString() + "</strong></font>&nbsp;</td>"; }
                                strPendingTask += "<td class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                                strPendingTask += "<td class='Tab3'>" + ds4.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                                strPendingTask += "<td class='Tab3'><strong>" + ds1.Tables[0].Rows[j]["ur_date"].ToString() + "</strong>&nbsp;</td>";
                                strPendingTask += "<td class='Tab3'>" + ds1.Tables[0].Rows[j]["work_by_mark"].ToString() + "&nbsp;</td>";
                                strPendingTask += "<td class='Tab3'>" + hourspend.ToString() + "&nbsp;</td>";
                                if (Convert.ToString(ds1.Tables[0].Rows[j]["taskRunStatus"]) == "Yes" && Convert.ToString(ds1.Tables[0].Rows[j]["startingOnlyTime"])!="")
                                {
                                    strPendingTask += "<td class='Tab3'>" + DateTime.Parse(ds1.Tables[0].Rows[j]["startingOnlyTime"].ToString()).ToString("h:mm tt") + "&nbsp;</td>";
                                }
                                else
                                {
                                    strPendingTask += "<td class='Tab3'>&nbsp;</td>";
                                }


                                strPendingTask += "<td class='Tab3'><font color='#FF0000'><strong>Pending</strong></font>&nbsp;</td>";
                                if (Convert.ToString(ds1.Tables[0].Rows[j]["taskRunStatus"]) == "No")
                                {
                                    strPendingTask += "<td class='Tab3'><font color='#55E33C'><strong><a href='/developer/developermain.aspx?task_srno=" + ds1.Tables[0].Rows[j]["task_srno"].ToString() + "&status=start' title='Start this task' style='color: #1371DE;font-size: large;'>Start</a></strong></font>&nbsp;</td>";
                                }
                                else if (Convert.ToString(ds1.Tables[0].Rows[j]["taskRunStatus"]) == "Yes")
                                {
                                    strPendingTask += "<td class='Tab3'><font color='green'><strong style='font-size: large;'>Started</strong></font>&nbsp;</td>";
                                }

                                strPendingTask += "</tr>";
                            }
                        }
                        strPendingTask += "</table><br>";
                        PendingTask = strPendingTask;
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
            Response.Cookies["DeveloperSearch"]["SelectType"] = select_type.Value;
            Response.Cookies["DeveloperSearch"]["From"] = Request.Form[text_date_from.UniqueID];
            Response.Cookies["DeveloperSearch"]["To"] = Request.Form[text_date_to.UniqueID];
            Response.Cookies["DeveloperSearch"].Expires = DateTime.Now.AddDays(1);
            Response.Redirect("search_project.aspx");
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Cookies["DeveloperSearch"]["SelectType"] = select2_type.Value;
            Response.Cookies["DeveloperSearch"]["ProjectType"] = text_type.Text;
            Response.Cookies["DeveloperSearch"].Expires = DateTime.Now.AddDays(1);
            Response.Redirect("search_project.aspx");
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    protected void btnSubmit3_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Cookies["AllActivities"]["From"] = Request.Form[txt_dateFrom.UniqueID];
            Response.Cookies["AllActivities"]["To"] = Request.Form[txt_dateTo.UniqueID];
            Response.Cookies["AllActivities"].Expires = DateTime.Now.AddDays(1);
            Response.Redirect("all_activities.aspx");
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    protected void btnSubmit4_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Cookies["WorkReport"]["From"] = Request.Form[txt_dateFrom1.UniqueID];
            Response.Cookies["WorkReport"]["To"] = Request.Form[txt_dateTo1.UniqueID];
            Response.Cookies["WorkReport"].Expires = DateTime.Now.AddDays(1);
            Response.Redirect("work_report.aspx");
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

}






