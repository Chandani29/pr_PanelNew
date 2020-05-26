using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Marketing_project_details_inhouse : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string proj_name, proj_id, total_hour, all_total_cast_upper, all_total_hour, all_total_cast, DoneAssigned, CostHour, ProjectDetail, SubProjects, all_hourspend_inhouse, all_dev_cost_inhouse, InHouseProject = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
            if (!string.IsNullOrEmpty(Request.QueryString["srno"]))
            {
                binddata();
                bindTaskDone();
                bindCostHour();
                bindProjectDetail();
                bindSubProjects();
            }
        }
    }

    private void bindProjectDetail()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds = dal.getDataSet("ManageProject", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strProjectDetail = string.Empty;
                    decimal total_hour_bal = 0;
                    decimal hour_exp1 = 0;
                    decimal total_expenses_up1 = 0;
                    decimal all_total_cast_upper2 = 0;

                    for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                    {
                        decimal tioaltime_bal_upper = 0;
                        decimal Devcost_upper = 0;
                        decimal total_hour_bal_upper = 0;
                        decimal total_cost_bal_upper = 0;
                        decimal all_total_hour_upper = 0;
                        decimal all_total_cast_upper1 = 0;
                        decimal sum_expenses_up = 0;
                        decimal total_expenses_up = 0;

                        string strdate = ds.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                        string[] col1 = { "@srno", "@Actiontype" };
                        object[] val1 = { Session["marketing_srno"].ToString().Trim(), "select3" };
                        DataSet ds1 = dal.getDataSet("ManageLogin", col1, val1);

                        string[] col2 = { "@srno", "@Actiontype" };
                        object[] val2 = { ds.Tables[0].Rows[j]["type_proj"].ToString(), "select4" };
                        DataSet ds2 = dal.getDataSet("ManageProjectType", col2, val2);

                        StringBuilder subcategory = new StringBuilder();
                        string strDesc = string.Empty;
                        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[j]["proj_desc"].ToString()))
                        {
                            string s1 = System.Text.RegularExpressions.Regex.Replace(ds.Tables[0].Rows[j]["proj_desc"].ToString(), @"<[^>]+>", "");
                            if (s1.ToString().Length > 41)
                                strDesc = s1.Substring(0, 40);
                            else
                                strDesc = s1;
                            subcategory.Append(strDesc);
                        }
                        total_hour_bal = Math.Round(decimal.Parse(ds.Tables[0].Rows[j]["total_hour"].ToString()), 2);

                        string[] col3 = { "@srno", "@proj_id", "@Actiontype" };
                        object[] val3 = { "0", ds.Tables[0].Rows[j]["srno"].ToString(), "select4" };
                        DataSet ds3 = dal.getDataSet("ManageProjDetails", col3, val3);
                        if (ds3.Tables[0].Rows.Count > 0)
                        {
                            for (int z = 0; z < ds3.Tables[0].Rows.Count; z++)
                            {
                                if (string.IsNullOrEmpty(ds3.Tables[0].Rows[z]["work_by_mark"].ToString()))
                                {
                                    hour_exp1 = hour_exp1 + Math.Round(decimal.Parse(ds3.Tables[0].Rows[z]["hourspend"].ToString()), 2);
                                }
                            }
                        }

                        string strMarketing = ds.Tables[0].Rows[j]["asigned_per"].ToString();
                        string strMarketin = string.Empty;
                        string strasigned_per = string.Empty;
                        string[] split = strMarketing.Split(new char[] { ',' });
                        int arrLenth = split.Length;
                        for (int a = 0; a < arrLenth; a++)
                        {
                            strMarketin += strMarketin + "'" + split[a] + "',";
                        }
                        strMarketin = strMarketin.Remove(strMarketin.Length - 1);
                        DataSet ds4 = dal.retDatasetByquery(" select name from tbl_Login where user_id in (" + strMarketin.ToString().Trim() + ") ");
                        if (ds4.Tables[0].Rows.Count > 0)
                        {
                            for (int z = 0; z < ds4.Tables[0].Rows.Count; z++)
                            {
                                strasigned_per += ds4.Tables[0].Rows[z]["name"].ToString() + ",";
                            }
                        }
                        strasigned_per = strasigned_per.Remove(strasigned_per.Length - 1);

                        if (arrLenth > 0)
                        {
                            DataSet ds5 = dal.retDatasetByquery("SELECT * from tbl_ProjDetails where proj_id='" + Request.QueryString["srno"].ToString().Trim() + "' and working_per in (" + strMarketin.ToString().Trim() + ") and del_status='0' order by srno desc ");
                            if (ds5.Tables[0].Rows.Count > 0)
                            {
                                for (int b = 0; b < ds5.Tables[0].Rows.Count; b++)
                                {
                                    if (string.IsNullOrEmpty(ds5.Tables[0].Rows[b]["work_by_mark"].ToString()))
                                    {
                                        if (string.IsNullOrEmpty(ds5.Tables[0].Rows[b]["hourspend"].ToString()))
                                        {
                                            tioaltime_bal_upper = 0;
                                            Devcost_upper = 0;
                                        }
                                        else
                                        {
                                            tioaltime_bal_upper = Math.Round(decimal.Parse(ds5.Tables[0].Rows[b]["hourspend"].ToString()), 2);
                                            Devcost_upper = Math.Round(decimal.Parse(ds5.Tables[0].Rows[b]["dev_cost"].ToString()), 2);
                                        }
                                        total_hour_bal_upper = Math.Round((total_hour_bal_upper + tioaltime_bal_upper), 2);
                                        total_cost_bal_upper = Math.Round((total_cost_bal_upper + Devcost_upper), 2);
                                        all_total_cast_upper1 = all_total_cast_upper1 + Math.Round(Devcost_upper, 2);
                                        all_total_hour_upper = all_total_hour_upper + tioaltime_bal_upper;
                                    }
                                }
                            }
                        }
                        else
                        {
                            DataSet ds5 = dal.retDatasetByquery("SELECT * from tbl_ProjDetails where proj_id='" + Request.QueryString["srno"].ToString().Trim() + "' and working_per in (" + strMarketin.ToString().Trim() + ") and del_status='0' order by working_per asc,srno desc ");
                            if (ds5.Tables[0].Rows.Count > 0)
                            {
                                for (int b = 0; b < ds5.Tables[0].Rows.Count; b++)
                                {
                                    if (string.IsNullOrEmpty(ds5.Tables[0].Rows[b]["work_by_mark"].ToString()))
                                    {
                                        if (string.IsNullOrEmpty(ds5.Tables[0].Rows[b]["hourspend"].ToString()))
                                        {
                                            tioaltime_bal_upper = 0;
                                            Devcost_upper = 0;
                                        }
                                        else
                                        {
                                            tioaltime_bal_upper = Math.Round(decimal.Parse(ds5.Tables[0].Rows[b]["hourspend"].ToString()), 2);
                                            Devcost_upper = Math.Round(decimal.Parse(ds5.Tables[0].Rows[b]["dev_cost"].ToString()), 2);
                                        }
                                        total_hour_bal_upper = Math.Round((total_hour_bal_upper + tioaltime_bal_upper), 2);
                                        total_cost_bal_upper = Math.Round((total_cost_bal_upper + Devcost_upper), 2);
                                        all_total_cast_upper1 = all_total_cast_upper1 + Math.Round(Devcost_upper, 2);
                                        all_total_hour_upper = all_total_hour_upper + tioaltime_bal_upper;
                                    }
                                }
                            }
                        }
                        decimal Dev_Cost = Math.Round(all_total_cast_upper1 - (all_total_cast_upper1 * 20 / 100), 2);

                        string[] col6 = { "@srno", "@proj_id", "@Actiontype" };
                        object[] val6 = { "0", Request.QueryString["srno"].ToString().Trim(), "select2" };
                        DataSet ds6 = dal.getDataSet("ManageExpenses", col6, val6);
                        if (ds6.Tables[0].Rows.Count > 0)
                        {
                            if (string.IsNullOrEmpty(ds6.Tables[0].Rows[0]["sum_pay"].ToString()))
                                sum_expenses_up = 0;
                            else
                                sum_expenses_up = Math.Round(decimal.Parse(ds6.Tables[0].Rows[0]["sum_pay"].ToString()), 2);
                            total_expenses_up = Math.Round((total_expenses_up + sum_expenses_up), 2);
                        }

                        StringBuilder sbRemark = new StringBuilder();
                        string srtRemark = string.Empty;
                        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[j]["Remark"].ToString()))
                        {
                            string s1 = System.Text.RegularExpressions.Regex.Replace(ds.Tables[0].Rows[j]["Remark"].ToString(), @"<[^>]+>", "");
                            if (s1.ToString().Length > 41)
                                srtRemark = s1.Substring(0, 40);
                            else
                                srtRemark = s1;
                            sbRemark.Append(srtRemark);
                        }

                        strProjectDetail += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                        strProjectDetail += "<td class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + ds1.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + ds2.Tables[0].Rows[0]["ProjectType"].ToString() + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + subcategory.ToString() + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + total_hour_bal + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + hour_exp1 + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + ds.Tables[0].Rows[j]["submeted_on"].ToString() + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + strasigned_per + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + ds.Tables[0].Rows[j]["cost"].ToString() + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + all_total_cast_upper1 + "&nbsp;<br><font color='#FF0099'>" + Dev_Cost + "</font></td>";
                        strProjectDetail += "<td class='Tab3'>" + sum_expenses_up + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + sbRemark.ToString() + "&nbsp;</td>";
                        strProjectDetail += "<td class='Tab3'>" + ds.Tables[0].Rows[j]["workstatus"].ToString() + "&nbsp;</td>";
                        strProjectDetail += "</tr>";

                        all_total_cast_upper2 += all_total_cast_upper1;
                        total_expenses_up1 += total_expenses_up;
                    }

                    ProjectDetail = strProjectDetail;

                    decimal total_hour1 = Math.Round((total_hour_bal - hour_exp1), 2);
                    total_hour = total_hour1.ToString();

                    decimal Tcost = Math.Round((decimal.Parse(ds.Tables[0].Rows[0]["cost"].ToString()) - total_expenses_up1 - all_total_cast_upper2), 2);
                    decimal Tcost1 = Math.Round(all_total_cast_upper2 - ((decimal.Parse(ds.Tables[0].Rows[0]["cost"].ToString()) - total_expenses_up1)), 2);
                    decimal Tcost2 = (all_total_cast_upper2 - (all_total_cast_upper2 - (all_total_cast_upper2 * 20 / 100)));
                    if (Tcost < 0)
                    {
                        if (Tcost1 < Tcost2)
                        {
                            all_total_cast_upper = "<td colspan='3' align='right' bgcolor='yellow' class='Tab2'>" + Tcost + "&nbsp;</td>";
                        }
                        else
                        {
                            all_total_cast_upper = "<td colspan='3' align='right' bgcolor='red' class='Tab2'>" + Tcost + "&nbsp;</td>";
                        }
                    }
                    else
                    {
                        all_total_cast_upper = "<td colspan='3' align='right' bgcolor='#25B311' class='Tab2'>" + Tcost + "&nbsp;</td>";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private void bindCostHour()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds = dal.getDataSet("ManageProject", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strMarketing = ds.Tables[0].Rows[0]["asigned_per"].ToString();
                    string strMarketin = string.Empty;
                    string strCostHour = string.Empty;
                    decimal all_total_cast1 = 0;
                    decimal all_total_hour1 = 0;

                    string[] split = strMarketing.Split(new char[] { ',' });
                    int arrLenth = split.Length;
                    for (int z = 0; z < arrLenth; z++)
                    {
                        strMarketin += strMarketin + "'" + split[z] + "',";
                        strMarketin = strMarketin.Remove(strMarketin.Length - 1);

                        DataSet ds5 = dal.retDatasetByquery("SELECT * from tbl_ProjDetails where proj_id='" + Request.QueryString["srno"].ToString().Trim() + "' and working_per='" + split[z] + "' and del_status='0' order by working_per asc,srno desc");
                        if (ds5.Tables[0].Rows.Count > 0)
                        {
                            decimal total_hour_bal = 0;
                            decimal total_cost_bal = 0;
                            decimal tioaltime_bal = 0;
                            decimal Devcost = 0;

                            for (int j = 0; j < ds5.Tables[0].Rows.Count; j++)
                            {
                                if (string.IsNullOrEmpty(ds5.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                {
                                    if (!string.IsNullOrEmpty(ds5.Tables[0].Rows[j]["hourspend"].ToString()))
                                    {
                                        tioaltime_bal = Math.Round(decimal.Parse(ds5.Tables[0].Rows[j]["hourspend"].ToString()), 2);
                                        Devcost = Math.Round(decimal.Parse(ds5.Tables[0].Rows[j]["dev_cost"].ToString()), 2);
                                    }
                                    total_hour_bal = Math.Round((total_hour_bal + tioaltime_bal), 2);
                                    total_cost_bal = Math.Round((total_cost_bal + Devcost), 2);
                                    all_total_cast1 = all_total_cast1 + Math.Round(Devcost, 2);
                                    all_total_hour1 = all_total_hour1 + tioaltime_bal;
                                }
                            }

                            string[] col4 = { "@srno", "@user_id", "@Actiontype" };
                            object[] val4 = { "0", ds5.Tables[0].Rows[0]["working_per"].ToString(), "select4" };
                            DataSet ds4 = dal.getDataSet("ManageLogin", col4, val4);

                            strCostHour += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                            strCostHour += "<td>" + ds4.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                            strCostHour += "<td>" + total_hour_bal + "&nbsp;</td>";
                            strCostHour += "<td>" + total_cost_bal + "&nbsp;</td>";
                            strCostHour += "</tr>";
                        }
                    }
                    all_total_cast = all_total_cast1.ToString();
                    all_total_hour = all_total_hour1.ToString();
                    CostHour = strCostHour;
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private void bindTaskDone()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds = dal.getDataSet("ManageProject", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strDoneAssigned = string.Empty;
                    string strMarketing = ds.Tables[0].Rows[0]["asigned_per"].ToString();
                    string strMarketin = string.Empty;
                    string[] split = strMarketing.Split(new char[] { ',' });
                    int arrLenth = split.Length;
                    for (int z = 0; z < arrLenth; z++)
                    {
                        strMarketin += strMarketin + "'" + split[z] + "',";
                        strMarketin = strMarketin.Remove(strMarketin.Length - 1);

                        string class1 = string.Empty;
                        DataSet ds5 = dal.retDatasetByquery("SELECT * from tbl_ProjDetails where proj_id='" + Request.QueryString["srno"].ToString().Trim() + "' and working_per='" + split[z] + "' order by working_per asc,srno desc");
                        if (ds5.Tables[0].Rows.Count > 0)
                        {
                            strDoneAssigned += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                            strDoneAssigned += "<td class='Tab2'><strong>Task ID</strong></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>Date</strong></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>Assigned by </strong></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>&nbsp;&nbsp;&nbsp;&nbsp;Assigned&nbsp;&nbsp;Task&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>Assigned/Spent<br>Hour </strong></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>To be Submmited by</strong></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>&nbsp;Developers</strong></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>Task&nbsp;Done&nbsp;by&nbsp;Developer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>Work Status</strong></td>";
                            strDoneAssigned += "<td class='Tab2'><strong>Remarks</strong></td></tr>";

                            for (int j = 0; j < ds5.Tables[0].Rows.Count; j++)
                            {
                                if (string.IsNullOrEmpty(ds5.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                {
                                    if (ds5.Tables[0].Rows[j]["del_status"].ToString() == "0")
                                        class1 = "Tab3";
                                    else
                                        class1 = "txtdel";
                                }
                                else
                                {
                                    if (ds5.Tables[0].Rows[j]["work_status"].ToString() == "0")
                                        class1 = "txt";
                                    else
                                        class1 = "txtpink";
                                }

                                string strdate = ds5.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");
                                string[] col1 = { "@srno", "@Actiontype" };
                                object[] val1 = { Session["marketing_srno"].ToString().Trim(), "select3" };
                                DataSet ds1 = dal.getDataSet("ManageLogin", col1, val1);

                                string[] col4 = { "@srno", "@user_id", "@Actiontype" };
                                object[] val4 = { "0", ds5.Tables[0].Rows[j]["working_per"].ToString(), "select4" };
                                DataSet ds4 = dal.getDataSet("ManageLogin", col4, val4);

                                strDoneAssigned += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                                strDoneAssigned += "<td class='" + class1 + "'>" + ds5.Tables[0].Rows[j]["task_srno"].ToString() + "&nbsp;</td>";
                                strDoneAssigned += "<td class='" + class1 + "'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                                strDoneAssigned += "<td class='" + class1 + "'>" + ds1.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                                strDoneAssigned += "<td class='" + class1 + "'>" + ds5.Tables[0].Rows[j]["work_by_mark"].ToString() + "&nbsp;</td>";
                                strDoneAssigned += "<td class='" + class1 + "'>" + ds5.Tables[0].Rows[j]["hourspend"].ToString() + "&nbsp;</td>";
                                strDoneAssigned += "<td class='" + class1 + "'>" + ds5.Tables[0].Rows[j]["ur_date"].ToString() + "&nbsp;</td>";
                                strDoneAssigned += "<td class='" + class1 + "'>" + ds4.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                                strDoneAssigned += "<td class='" + class1 + "'>" + ds5.Tables[0].Rows[j]["work_remark"].ToString() + "&nbsp;</td>";

                                if (ds5.Tables[0].Rows[j]["work_status"].ToString() == "1")
                                    strDoneAssigned += "<td class='" + class1 + "'>Done&nbsp;</td>";
                                else
                                {
                                    if (string.IsNullOrEmpty(ds5.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                        strDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";
                                    else
                                        strDoneAssigned += "<td class='" + class1 + "'>Pending&nbsp;</td>";
                                }

                                if (ds5.Tables[0].Rows[j]["del_status"].ToString() == "1")
                                    strDoneAssigned += "<td class='" + class1 + "'>" + ds5.Tables[0].Rows[j]["delete_remark"].ToString() + "&nbsp;</td>";
                                else
                                    strDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";

                                strDoneAssigned += "</tr>";
                            }
                            strDoneAssigned += "<tr valign='top' bgcolor='#9999CC'><td colspan='10'>&nbsp;</td></tr>";
                        }
                    }
                    DoneAssigned = strDoneAssigned;
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private void bindSubProjects()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select1" };
                DataSet ds = dal.getDataSet("ManageProjectInhouse", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strSubProjects = string.Empty;
                    decimal all_hourspend_inhouse1 = 0;
                    decimal all_dev_cost_inhouse1 = 0;

                    for (int z = 0; z < ds.Tables[0].Rows.Count; z++)
                    {
                        decimal hourspend_inhouse = 0;
                        decimal dev_cost_inhouse = 0;
                        string[] col1 = { "@srno", "@inhouse_id", "@Actiontype" };
                        object[] val1 = { "0", ds.Tables[0].Rows[z]["srno"].ToString().Trim(), "select11" };
                        DataSet ds1 = dal.getDataSet("ManageProjDetails", col1, val1);
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[0]["hourspend_inhouse"].ToString()))
                            {
                                hourspend_inhouse = Math.Round(decimal.Parse(ds1.Tables[0].Rows[0]["hourspend_inhouse"].ToString()), 2);
                            }

                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[0]["dev_cost_inhouse"].ToString()))
                            {
                                dev_cost_inhouse = Math.Round(decimal.Parse(ds1.Tables[0].Rows[0]["dev_cost_inhouse"].ToString()), 2);
                            }
                        }
                        all_hourspend_inhouse1 = all_hourspend_inhouse1 + hourspend_inhouse;
                        all_dev_cost_inhouse1 = all_dev_cost_inhouse1 + dev_cost_inhouse;

                        strSubProjects += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                        strSubProjects += "<td class='Tab3'>" + ds.Tables[0].Rows[z]["ProjName"].ToString() + "</td>";
                        strSubProjects += "<td class='Tab3'>" + hourspend_inhouse + "&nbsp;</td>";
                        strSubProjects += "<td class='Tab3'>" + dev_cost_inhouse + "&nbsp;</td>";
                        strSubProjects += "<td class='Tab3'><a href='sub_project_details.aspx?srno=" + ds.Tables[0].Rows[z]["srno"].ToString().Trim() + "' target='_blank'>Details</a>&nbsp;</td>";
                        strSubProjects += "</tr>";
                    }
                    all_hourspend_inhouse = all_hourspend_inhouse1.ToString();
                    all_dev_cost_inhouse = all_dev_cost_inhouse1.ToString();
                    SubProjects = strSubProjects;
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private void binddata()
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds = dal.getDataSet("ManageProject", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strMarketing = ds.Tables[0].Rows[0]["asigned_per"].ToString();
                    string strMarketin = string.Empty;
                    string[] split = strMarketing.Split(new char[] { ',' });
                    int arrLenth = split.Length;
                    for (int j = 0; j < arrLenth; j++)
                    {
                        strMarketin += strMarketin + "'" + split[j] + "',";
                    }
                    strMarketin = strMarketin.Remove(strMarketin.Length - 1);
                    DataSet ds2 = dal.retDatasetByquery("select * from tbl_Login where user_id in (" + strMarketin.ToString().Trim() + ")");
                    if (ds2.Tables[0].Rows.Count > 0)
                    {
                        dd_Workper.DataSource = ds2.Tables[0];
                        dd_Workper.DataTextField = "name";
                        dd_Workper.DataValueField = "user_id";
                        dd_Workper.DataBind();
                        dd_Workper.Items.Insert(0, new ListItem("Select Person", "0"));
                    }
                }

                //string[] col3 = { "@srno", "@Actiontype" };
                //object[] val3 = { Session["marketing_srno"].ToString().Trim(), "select3" };
                //DataSet ds3 = dal.getDataSet("ManageLogin", col3, val3);
                //string Actiontype = "select3";
                //if (ds3.Tables[0].Rows[0]["user_id"].ToString().Trim() == "m12")
                //    Actiontype = "select";

                string[] col3 = { "@srno", "@Actiontype" };
                object[] val3 = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds3 = dal.getDataSet("ManageProject", col3, val3);
                if (ds3.Tables[0].Rows.Count > 0)
                {
                    proj_name = ds3.Tables[0].Rows[0]["proj_name"].ToString();
                    proj_id = ds3.Tables[0].Rows[0]["proj_id"].ToString();
                    InHouseProject = ds3.Tables[0].Rows[0]["type_proj"].ToString();

                    if (ds3.Tables[0].Rows[0]["type_proj"].ToString() == "1")
                    {
                        string[] col4 = { "@srno", "@ProjId", "@Actiontype" };
                        object[] val4 = { "0", Request.QueryString["srno"].ToString().Trim(), "select2" };
                        DataSet ds4 = dal.getDataSet("ManageProjectInhouse", col4, val4);
                        if (ds4.Tables[0].Rows.Count > 0)
                        {
                            inhouse.DataSource = ds4.Tables[0];
                            inhouse.DataTextField = "ProjName";
                            inhouse.DataValueField = "srno";
                            inhouse.DataBind();
                        }
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
            if (Session["marketing_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Session["marketing_srno"].ToString().Trim(), "select3" };
                DataSet ds4 = dal.getDataSet("ManageLogin", col4, val4);

                string[] col3 = { "@srno", "@Actiontype" };
                object[] val3 = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds3 = dal.getDataSet("ManageProject", col3, val3);
                if (ds3.Tables[0].Rows.Count > 0)
                {
                    proj_name = ds3.Tables[0].Rows[0]["proj_name"].ToString();
                    proj_id = ds3.Tables[0].Rows[0]["proj_id"].ToString();
                }

                string ur_date_time = string.Empty;
                if (Request.Form[txt_ur.UniqueID] != "")
                    ur_date_time = Request.Form[txt_ur.UniqueID] + "-" + dd_time.Value + ":00:00 hr";

                DataSet ds6 = dal.retDatasetByquery("SELECT max(srno) as maxid FROM tbl_ProjDetails");
                string strTaskSrno = "AKS-0" + (Convert.ToInt32(ds6.Tables[0].Rows[0]["maxid"].ToString().Trim()) + 1);

                string[] col5 = { "@srno", "@Actiontype" };
                object[] val5 = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds5 = dal.getDataSet("ManageProject", col5, val5);
                if (ds5.Tables[0].Rows.Count > 0)
                {
                    if (ds5.Tables[0].Rows[0]["type_proj"].ToString() == "1")
                    {
                        string[] col1 = { "@srno", "@proj_id", "@inhouse_id", "@asignedby", "@proj_name", "@working_per", "@hourspend", "@work_by_mark", "@ddate", "@ur_date", "@task_srno", "@Actiontype" };
                        object[] val1 = { "0", Request.QueryString["srno"].ToString().Trim(), inhouse.SelectedValue, ds4.Tables[0].Rows[0]["user_id"].ToString().Trim(), proj_name, dd_Workper.SelectedValue, txt_ths.Text.Trim(), txt_remark.Text.Trim(), txt_date.Text.Trim(), ur_date_time, strTaskSrno.ToString(), "add1" };
                        int i = dal.execute("ManageProjDetails", col1, val1);
                        if (i == 1)
                            lblmsg.Text = "Data Save Successfuly.";
                    }
                    else
                    {
                        string[] col1 = { "@srno", "@proj_id", "@asignedby", "@proj_name", "@working_per", "@hourspend", "@work_by_mark", "@ddate", "@ur_date", "@task_srno", "@Actiontype" };
                        object[] val1 = { "0", Request.QueryString["srno"].ToString().Trim(), ds4.Tables[0].Rows[0]["user_id"].ToString().Trim(), proj_name, dd_Workper.SelectedValue, txt_ths.Text.Trim(), txt_remark.Text.Trim(), txt_date.Text.Trim(), ur_date_time, strTaskSrno.ToString(), "add2" };
                        int i = dal.execute("ManageProjDetails", col1, val1);
                        if (i == 1)
                            lblmsg.Text = "Data Save Successfuly.";
                    }
                }

                dd_time.Value = "Hr";
                dal.ClearControls(this);
                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                binddata();
                bindTaskDone();
                bindCostHour();
                bindProjectDetail();
                bindSubProjects();
                Response.Redirect("project_details_inhouse.aspx?srno=" + Request.QueryString["srno"].ToString().Trim());
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