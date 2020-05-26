using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Globalization;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class Marketing_marketingmain : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string count2, total_hour, total_hour_ex, total_cost, total_payment_received, total_expenses, ReminderPanel, PendingTask = string.Empty;
    decimal inttotal_hour = 0;
    decimal inttotal_hour1 = 0;
    decimal inttotal_hour_ex = 0;
    decimal inttotal_cost = 0;
    decimal inttotal_payment_received = 0;
    decimal total_expenses_up = 0;
    decimal intlblproj_expenses = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Request.QueryString["notavid"]) != "" && Convert.ToString(Request.QueryString["notavid"]) != null)
        {
            insertNotAvelableMessage(Convert.ToString(Request.QueryString["notavid"]));
            Response.Redirect("~/marketing/marketingmain.aspx");
        }
        if (!IsPostBack)
        {
            bindReminderPanel();
            binddatagrid();
            CountProject();

        }
        bindPendingTask();

    }
    public int insertNotAvelableMessage(string developeruserid)
    {
        try
        {


            if (Session["marketing_srno"] != null)
            {
                if (Request.Cookies["notAvMsg"].Value != null)
                {
                    string[] col4 = { "@developer_UserID", "@marketingPerson_SRNO", "@txtmessage", "@actionType" };
                    object[] val4 = { developeruserid, Convert.ToInt32(Session["marketing_srno"]), Request.Cookies["notAvMsg"].Value, "insert" };
                    int i = dal.execute("USPNotAvelable", col4, val4);
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
    private void bindReminderPanel()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
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
    private void binddatagrid()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                string[] col2 = { "@srno", "@mp_id", "@Actiontype" };
                object[] val2 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select4" };
                DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                if (ds2.Tables[0].Rows.Count > 0)
                {
                    Repeater1.DataSource = ds2.Tables[0];
                    Repeater1.DataBind();
                }

                string[] col3 = { "@srno", "@Actiontype" };
                object[] val3 = { "0", "latestempstatus" };
                DataSet ds3 = dal.getDataSet("ManageLogin", col3, val3);
                if (ds3.Tables[0].Rows.Count > 0)
                {
                    Repeater2.DataSource = ds3.Tables[0];
                    Repeater2.DataBind();
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

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            decimal hour_exp = 0;
            decimal intBalanceCost1 = 0;
            decimal intBalanceCost2 = 0;
            decimal intBalanceCost3 = 0;
            decimal intlblcost = 0;
            decimal sum_expenses_up = 0;
            decimal total_bal_cost_dev_sub = 0;
            decimal total_bal_cost_sub = 0;
            decimal all_total_cast_upper = 0;
            decimal tioaltime_bal_upper = 0;
            decimal Devcost_upper = 0;
            decimal total_hour_bal_upper = 0;
            decimal total_cost_bal_upper = 0;
            decimal all_total_hour_upper = 0;

            // Bind Project Type
            Label lbltype_proj = (Label)e.Item.FindControl("lbltype_proj");
            Label lbltype_projshow = (Label)e.Item.FindControl("lbltype_projshow");
            string[] col = { "@srno", "@Actiontype" };
            object[] val = { lbltype_proj.Text.Trim(), "select4" };
            DataSet ds = dal.getDataSet("ManageProjectType", col, val);

            string type_projshow = "";
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                type_projshow += Convert.ToString(ds.Tables[0].Rows[i]["ProjectType"]) + ", ";
            }
            lbltype_projshow.Text = type_projshow.TrimEnd(' ').TrimEnd(',');
            //if (ds.Tables[0].Rows.Count > 0)
            //    lbltype_projshow.Text = ds.Tables[0].Rows[0]["ProjectType"].ToString();

            // Bind Developer
            Label lblasigned_per = (Label)e.Item.FindControl("lblasigned_per");
            Label lblasigned_pershow = (Label)e.Item.FindControl("lblasigned_pershow");
            string[] split = lblasigned_per.Text.Split(new char[] { ',' });
            int arrLenth = split.Length;
            string name = string.Empty;
            for (int j = 0; j < arrLenth; j++)
            {
                string[] col1 = { "@srno", "@user_id", "@Actiontype" };
                object[] val1 = { "0", split[j].ToString().Trim(), "select4" };
                DataSet ds1 = dal.getDataSet("ManageLogin", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    name = name + ds1.Tables[0].Rows[0]["name"].ToString() + ",";
                }
            }
            name = name.Remove(name.Length - 1);
            lblasigned_pershow.Text = name;

            // Bind Description
            Label lblproj_desc = (Label)e.Item.FindControl("lblproj_desc");
            Label lblproj_descshow = (Label)e.Item.FindControl("lblproj_descshow");
            StringBuilder subcategory = new StringBuilder();
            string strDesc = string.Empty;
            if (lblproj_desc.Text.Trim() != null)
            {
                string s1 = System.Text.RegularExpressions.Regex.Replace(lblproj_desc.Text.Trim(), @"<[^>]+>", "");
                if (s1.ToString().Length > 41)
                    strDesc = s1.Substring(0, 40);
                else
                    strDesc = s1;
                subcategory.Append(strDesc);
            }
            lblproj_descshow.Text = subcategory.ToString();

            // Bind Project Name
            Label lblworkstatusShow = (Label)e.Item.FindControl("lblworkstatusShow");
            Label lblworkstatus = (Label)e.Item.FindControl("lblworkstatus");
            Label lblproj_name_url = (Label)e.Item.FindControl("lblproj_name_url");
            Label lblsrno = (Label)e.Item.FindControl("lblsrno");
            if (lbltype_projshow.Text == "InHouse")
                lblproj_name_url.Text = "&nbsp;<br><strong><a href='add_inhouse_proj.aspx?srno=" + lblsrno.Text + "'>Add New</a></strong>";
            else
                if (lblworkstatus.Text == "Received")
                lblproj_name_url.Text = "<br>&nbsp;&nbsp;<strong><a href='extend_proj.aspx?srno=" + lblsrno.Text + "'>Ext.</a>&nbsp;&nbsp;&nbsp;<a href='reduce_proj.aspx?srno=" + lblsrno.Text + "'>Red.</a></strong>";

            if (lblworkstatus.Text == "Dead")
                lblworkstatusShow.Text = "<td bgcolor='#E6E6E6' class='txt'>" + lblworkstatus.Text + "</td>";
            if (lblworkstatus.Text == "Completed")
                lblworkstatusShow.Text = "<td bgcolor='#E6E6E6' class='txtgreen'>" + lblworkstatus.Text + "</td>";

            string strworkstatus = string.Empty;
            if (lblworkstatus.Text == "Received")
            {
                strworkstatus += "<td bgcolor='#E6E6E6' class='Tab3'>";
                strworkstatus += "<select name='dd_workstatus' id='dd_workstatus" + lblsrno.Text + "' onChange='Controls(this);'>";
                strworkstatus += "<option value='" + lblworkstatus.Text + "_" + lblsrno.Text + "' selected>" + lblworkstatus.Text + "</option>";
                strworkstatus += "<option value='Completed_" + lblsrno.Text + "'>Completed</option>";
                strworkstatus += "<option value='Dead_" + lblsrno.Text + "'>Dead</option>";
                strworkstatus += "</select> ";
                strworkstatus += "</td>";
                lblworkstatusShow.Text = strworkstatus;
            }

            if (lblworkstatus.Text == "Trial Project")
            {
                strworkstatus += "<td bgcolor='#E6E6E6' class='Tab3'>";
                strworkstatus += "<select name='dd_workstatus' id='dd_workstatus" + lblsrno.Text + "' onChange='Controls(this);'>";
                strworkstatus += "<option value='" + lblworkstatus.Text + "_" + lblsrno.Text + "' selected>" + lblworkstatus.Text + "</option>";
                strworkstatus += "<option value='Dead_" + lblsrno.Text + "'>Dead</option>";
                strworkstatus += "<option value='Received_" + lblsrno.Text + "'>Received</option>";
                strworkstatus += "</select> ";
                strworkstatus += "</td>";
                lblworkstatusShow.Text = strworkstatus;
            }

            // Bind Project Details Link
            Label lblproj_id = (Label)e.Item.FindControl("lblproj_id");
            HtmlAnchor aPD = (HtmlAnchor)e.Item.FindControl("aPD");
            if (lbltype_projshow.Text == "InHouse")
                aPD.HRef = "project_details_inhouse.aspx?srno=" + lblsrno.Text;
            else
                aPD.HRef = "project_details.aspx?srno=" + lblsrno.Text;

            // Bind Partial Payment
            Label lblpartial_payment = (Label)e.Item.FindControl("lblpartial_payment");
            string[] colP = { "@srno", "@proj_id", "@Actiontype" };
            object[] valP = { "0", lblsrno.Text.ToString().Trim(), "select2" };
            DataSet dsP = dal.getDataSet("ManagePartialPayment", colP, valP);
            if (dsP.Tables[0].Rows.Count > 0)
                lblpartial_payment.Text = dsP.Tables[0].Rows[0]["sum_pay"].ToString();
            if (lblpartial_payment.Text != "")
                inttotal_payment_received += Math.Round(decimal.Parse(lblpartial_payment.Text), 2);
            else
                lblpartial_payment.Text = "0";
            total_payment_received = inttotal_payment_received.ToString();

            // Bind Expenses
            Label lblproj_expenses = (Label)e.Item.FindControl("lblproj_expenses");
            string[] colE = { "@srno", "@proj_id", "@Actiontype" };
            object[] valE = { "0", lblsrno.Text.ToString().Trim(), "select2" };
            DataSet dsE = dal.getDataSet("ManageExpenses", colE, valE);
            if (dsE.Tables[0].Rows.Count > 0)
                lblproj_expenses.Text = dsE.Tables[0].Rows[0]["sum_pay"].ToString();
            if (lblproj_expenses.Text != "")
                intlblproj_expenses += Math.Round(decimal.Parse(lblproj_expenses.Text), 2);
            else
                lblproj_expenses.Text = "0";
            total_expenses = intlblproj_expenses.ToString();

            // Total Hour
            Label lbltotal_hour_Show = (Label)e.Item.FindControl("lbltotal_hour_Show");
            if (lbltotal_hour_Show.Text != "")
            {
                inttotal_hour += Math.Round(decimal.Parse(lbltotal_hour_Show.Text), 2);
                inttotal_hour1 = Math.Round(decimal.Parse(lbltotal_hour_Show.Text), 2);
            }
            total_hour = inttotal_hour.ToString();

            //Balance Hour
            Label lblhour_exp = (Label)e.Item.FindControl("lblhour_exp");
            string[] colHE = { "@srno", "@proj_id", "@Actiontype" };
            object[] valHE = { "0", lblsrno.Text.ToString().Trim(), "select4" };
            DataSet dsHE = dal.getDataSet("ManageProjDetails", colHE, valHE);
            if (dsHE.Tables[0].Rows.Count > 0)
            {
                for (int z = 0; z < dsHE.Tables[0].Rows.Count; z++)
                {
                    if (string.IsNullOrEmpty(dsHE.Tables[0].Rows[z]["work_by_mark"].ToString()))
                    {
                        hour_exp = hour_exp + Math.Round(decimal.Parse(dsHE.Tables[0].Rows[z]["hourspend"].ToString()), 2);
                    }
                }
            }
            decimal Showhour_exp = inttotal_hour1 - hour_exp;
            lblhour_exp.Text = Showhour_exp.ToString();
            if (lblhour_exp.Text != "")
                inttotal_hour_ex += Math.Round(decimal.Parse(lblhour_exp.Text), 2);
            total_hour_ex = inttotal_hour_ex.ToString();

            // Total Cost
            Label lblcost = (Label)e.Item.FindControl("lblcost");
            if (lblcost.Text != "")
                inttotal_cost += Math.Round(decimal.Parse(lblcost.Text), 2);
            total_cost = inttotal_cost.ToString();

            //Balance Cost
            if (lblcost.Text != "")
                intlblcost = decimal.Parse(lblcost.Text.Trim());
            HtmlTableCell tdBalanceCost = (HtmlTableCell)e.Item.FindControl("tdBalanceCost");
            Label lblBalanceCost = (Label)e.Item.FindControl("lblBalanceCost");

            if (arrLenth > 0)
            {
                for (int j = 0; j < arrLenth; j++)
                {
                    string[] colPD1 = { "@srno", "@proj_id", "@working_per", "@Actiontype" };
                    object[] valPD1 = { "0", lblsrno.Text.ToString().Trim(), split[j].ToString().Trim(), "select2" };
                    DataSet dsPD1 = dal.getDataSet("ManageProjDetails", colPD1, valPD1);
                    if (dsPD1.Tables[0].Rows.Count > 0)
                    {
                        for (int z = 0; z < dsPD1.Tables[0].Rows.Count; z++)
                        {
                            if (string.IsNullOrEmpty(dsPD1.Tables[0].Rows[z]["work_by_mark"].ToString()))
                            {
                                if (!string.IsNullOrEmpty(dsPD1.Tables[0].Rows[z]["hourspend"].ToString()))
                                {
                                    tioaltime_bal_upper = Math.Round(decimal.Parse(dsPD1.Tables[0].Rows[z]["hourspend"].ToString()), 2);
                                    Devcost_upper = Math.Round(decimal.Parse(dsPD1.Tables[0].Rows[z]["dev_cost"].ToString()), 2);
                                }
                                total_hour_bal_upper = Math.Round((total_hour_bal_upper + tioaltime_bal_upper), 2);
                                total_cost_bal_upper = Math.Round((total_cost_bal_upper + Devcost_upper), 2);
                                all_total_cast_upper = all_total_cast_upper + Math.Round(Devcost_upper, 2);
                                all_total_hour_upper = all_total_hour_upper + tioaltime_bal_upper;
                            }
                        }
                    }
                }
            }
            else
            {
                string[] colPD1 = { "@srno", "@proj_id", "@working_per", "@Actiontype" };
                object[] valPD1 = { "0", lblsrno.Text.ToString().Trim(), split[0].ToString().Trim(), "select5" };
                DataSet dsPD1 = dal.getDataSet("ManageProjDetails", colPD1, valPD1);
                if (dsPD1.Tables[0].Rows.Count > 0)
                {
                    for (int z = 0; z < dsPD1.Tables[0].Rows.Count; z++)
                    {
                        if (string.IsNullOrEmpty(dsPD1.Tables[0].Rows[z]["work_by_mark"].ToString()))
                        {
                            if (!string.IsNullOrEmpty(dsPD1.Tables[0].Rows[z]["hourspend"].ToString()))
                            {
                                tioaltime_bal_upper = Math.Round(decimal.Parse(dsPD1.Tables[0].Rows[z]["hourspend"].ToString()), 2);
                                Devcost_upper = Math.Round(decimal.Parse(dsPD1.Tables[0].Rows[z]["dev_cost"].ToString()), 2);
                            }
                            total_hour_bal_upper = Math.Round((total_hour_bal_upper + tioaltime_bal_upper), 2);
                            total_cost_bal_upper = Math.Round((total_cost_bal_upper + Devcost_upper), 2);
                            all_total_cast_upper = all_total_cast_upper + Math.Round(Devcost_upper, 2);
                            all_total_hour_upper = all_total_hour_upper + tioaltime_bal_upper;
                        }
                    }
                }
            }


            string[] colEx = { "@srno", "@proj_id", "@Actiontype" };
            object[] valEx = { "0", lblsrno.Text.ToString().Trim(), "select2" };
            DataSet dsEx = dal.getDataSet("ManageExpenses", colEx, valEx);
            if (dsEx.Tables[0].Rows.Count > 0)
            {
                if (!string.IsNullOrEmpty(dsEx.Tables[0].Rows[0]["sum_pay"].ToString()))
                {
                    sum_expenses_up = Math.Round(decimal.Parse(dsEx.Tables[0].Rows[0]["sum_pay"].ToString()), 2);
                }
            }
            total_expenses_up = Math.Round((total_expenses_up + sum_expenses_up), 2);
            total_bal_cost_dev_sub = Math.Round((total_bal_cost_dev_sub + Math.Round((intlblcost - all_total_cast_upper), 2)), 2);
            total_bal_cost_sub = Math.Round((total_bal_cost_sub + all_total_cast_upper), 2);

            intBalanceCost1 = Math.Round((intlblcost - sum_expenses_up - all_total_cast_upper), 2);
            intBalanceCost2 = Math.Round((all_total_cast_upper - intlblcost - sum_expenses_up), 2);
            intBalanceCost3 = (all_total_cast_upper - (all_total_cast_upper - (all_total_cast_upper * 20 / 100)));

            if (intBalanceCost1 < 0)
            {
                if (intBalanceCost2 < intBalanceCost3)
                {
                    tdBalanceCost.BgColor = "yellow";
                    lblBalanceCost.Text = intBalanceCost1.ToString();
                }
                else
                {
                    tdBalanceCost.BgColor = "red";
                    lblBalanceCost.Text = intBalanceCost1.ToString();
                }
            }
            else
            {
                tdBalanceCost.BgColor = "#25B311";
                lblBalanceCost.Text = intBalanceCost1.ToString();
            }
        }
    }

    private void bindPendingTask()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { "0", "select8fordev" };
                DataSet ds = dal.getDataSet("ManageLogin", col1, val1);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strPendingTask = string.Empty;
                    strPendingTask += "<table width='100%' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
                    strPendingTask += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPendingTask += "<td colspan='15' align='center' bgcolor='#CCCCCC' class='Tab2'><strong>Current working status of Developer</strong></td></tr>";
                    strPendingTask += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPendingTask += "<td class='Tab2'><strong>Emploee Name</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Task ID</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Project ID</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Project Name</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Date</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Assigned By</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>To Be Submmited By</strong></td>";
                    strPendingTask += "<td class='Tab2' style='width:200px'><strong>Assigned Task</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Assigned Hours</strong></td>";
                    strPendingTask += "<td class='Tab2' style='width:35px'><strong>Good Morning Time</strong></td>";
                    strPendingTask += "<td class='Tab2' style='width:87px'><strong>In/Out</strong></td>";
                    strPendingTask += "<td class='Tab2' style='width:46px'><strong>Good Night Time</strong></td>";
                    strPendingTask += "<td class='Tab2' style='width:60px;'><strong>Started Time</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Task Status</strong></td>";
                    strPendingTask += "<td class='Tab2'><strong>Start/Stop</strong></td>";
                    strPendingTask += "</tr>";
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        string[] col11 = { "@srno", "@working_per", "@Actiontype" };
                        object[] val11 = { "0", ds.Tables[0].Rows[i]["user_id"].ToString(), "selectForBD" };
                        DataSet ds1 = dal.getDataSet("ManageProjDetails", col11, val11);
                        if (ds1.Tables[0].Rows.Count > 0)
                        {


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
                                    strPendingTask += "<td class='Tab3'>" + ds.Tables[0].Rows[i]["name"].ToString() + "&nbsp;</td>";
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
                                    strPendingTask += "<td class='Tab3'>" + DateTime.Parse(ds1.Tables[0].Rows[j]["comingTime"].ToString()).ToString("h:mm tt") + "&nbsp;</td>";
                                    if (Convert.ToString(ds1.Tables[0].Rows[j]["comingTime"]) != Convert.ToString(ds1.Tables[0].Rows[j]["goingTime"]))
                                    {
                                        strPendingTask += "<td class='Tab3'><span style='color:red;'>Out for the Day</span>&nbsp;</td>";
                                    }
                                    else if (Convert.ToString(ds1.Tables[0].Rows[j]["InOutStatus"]).ToLower() == "in")
                                    {
                                        strPendingTask += "<td class='Tab3'><span style='color:green;'>In: "+ DateTime.Parse(ds1.Tables[0].Rows[j]["InOutTime"].ToString()).ToString("h:mm tt")+" </span>&nbsp;</td>";
                                    }
                                    else if (Convert.ToString(ds1.Tables[0].Rows[j]["InOutStatus"]).ToLower() == "out")
                                    {
                                        strPendingTask += "<td class='Tab3'><span style='color:red;'>Out: "+ DateTime.Parse(ds1.Tables[0].Rows[j]["InOutTime"].ToString()).ToString("h:mm tt") +"</span>&nbsp;</td>";
                                    }
                                    
                                    else 
                                    {
                                        strPendingTask += "<td class='Tab3'>&nbsp;</td>";
                                    }
                                    if (Convert.ToString(ds1.Tables[0].Rows[j]["comingTime"]) != Convert.ToString(ds1.Tables[0].Rows[j]["goingTime"]))
                                    {
                                        strPendingTask += "<td class='Tab3'><span style='color:red;'>"+ DateTime.Parse(ds1.Tables[0].Rows[j]["goingTime"].ToString()).ToString("h:mm tt") +"</span>&nbsp;</td>";
                                    }
                                    else
                                    {
                                        strPendingTask += "<td class='Tab3'>&nbsp;</td>";
                                    }

                                    if (Convert.ToString(ds1.Tables[0].Rows[j]["startingOnlyTime"]) != "")
                                    {
                                        strPendingTask += "<td class='Tab3'>" + DateTime.Parse(ds1.Tables[0].Rows[j]["startingOnlyTime"].ToString()).ToString("h:mm tt") + "&nbsp;</td>";
                                    }
                                    else
                                    {
                                        strPendingTask += "<td class='Tab3'>&nbsp;</td>";
                                    }


                                    strPendingTask += "<td class='Tab3'><font color='#FF0000'><strong>Pending</strong></font>&nbsp;</td>";

                                    strPendingTask += "<td class='Tab3'><font color='green'><strong style='font-size: large;'>Started</strong></font>&nbsp;</td>";


                                    strPendingTask += "</tr>";
                                }
                            }

                        }
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                Response.Cookies["PaymentReceived"]["From"] = Request.Form[text_date_from24.UniqueID];
                Response.Cookies["PaymentReceived"]["To"] = Request.Form[text_date_to24.UniqueID];
                Response.Cookies["PaymentReceived"].Expires = DateTime.Now.AddDays(1);
                Response.Redirect("payment_received.aspx");
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

    protected void btnSubmitAll_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                Response.Cookies["AllActivities"]["From"] = Request.Form[txt_dateFrom.UniqueID];
                Response.Cookies["AllActivities"]["To"] = Request.Form[txt_dateTo.UniqueID];
                Response.Cookies["AllActivities"].Expires = DateTime.Now.AddDays(1);
                Response.Redirect("payment_received.aspx");
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

    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Cookies["MarketingSearch"]["SelectType"] = select2_type.Value;
            Response.Cookies["MarketingSearch"]["ProjectType"] = text_type.Text;
            Response.Cookies["MarketingSearch"].Expires = DateTime.Now.AddDays(1);
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
            Response.Cookies["MarketingSearch"]["SelectType"] = select_type.Value;
            Response.Cookies["MarketingSearch"]["From"] = Request.Form[text_date_from.UniqueID];
            Response.Cookies["MarketingSearch"]["To"] = Request.Form[text_date_to.UniqueID];
            Response.Cookies["MarketingSearch"].Expires = DateTime.Now.AddDays(1);
            Response.Redirect("search_project.aspx");
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private void CountProject()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                string[] col1 = { "@srno", "@mp_id", "@Actiontype" };
                object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select1" };
                DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    count2 = ds1.Tables[0].Rows[0]["count1"].ToString();
                    if (count2 == "0")
                        count2 = "1";
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
}