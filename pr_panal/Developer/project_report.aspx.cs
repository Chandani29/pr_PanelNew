using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_project_report : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string proj_name, proj_id, ProjectDetail, Balance_Hours1 = string.Empty;
    public string DeveloperHour, TaskDoneAssigned = string.Empty;

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
        if (!IsPostBack)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["srno"].ToString()))
            {
                bindProjectDetail();
                bindDeveloperHour();
                bindTaskDoneAssigned();
            }
            else
                Response.Redirect("developermain.aspx");
        }
    }

    private void bindProjectDetail()
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
                    string[] col1 = { "@srno", "@Actiontype" };
                    object[] val1 = { Request.QueryString["srno"].ToString(), "select5" };
                    DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        proj_name = ds1.Tables[0].Rows[0]["proj_name"].ToString();
                        proj_id = ds1.Tables[0].Rows[0]["proj_id"].ToString();

                        string strProjectDetail = string.Empty;
                        decimal total_hour = 0;
                        decimal hour_exp1 = 0;

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

                            string strsubmeted_on = ds1.Tables[0].Rows[j]["submeted_on"].ToString().Replace(" 12:00:00 AM", "");

                            strProjectDetail += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                            strProjectDetail += "<td class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + ds2.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + ds3.Tables[0].Rows[0]["ProjectType"].ToString() + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + subcategory.ToString() + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + total_hour + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + hour_exp1 + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strsubmeted_on) + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + strasigned_per + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + subRemark.ToString() + "&nbsp;</td>";
                            strProjectDetail += "<td class='Tab3'>" + ds1.Tables[0].Rows[j]["workstatus"].ToString() + "&nbsp;</td>";
                            strProjectDetail += "</tr>";
                        }
                        ProjectDetail = strProjectDetail;

                        decimal Balance_Hours = Math.Round((total_hour - hour_exp1), 2);
                        Balance_Hours1 = Balance_Hours.ToString();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private void bindDeveloperHour()
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
                    decimal Devcost = Math.Round(decimal.Parse(ds.Tables[0].Rows[0]["per_cost"].ToString()), 2);

                    string[] col1 = { "@srno", "@proj_id", "@working_per", "@Actiontype" };
                    object[] val1 = { "0", Request.QueryString["srno"].ToString(), ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select5" };
                    DataSet ds1 = dal.getDataSet("ManageProjDetails", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string strDeveloperHour = string.Empty;
                        decimal total_hour_bal = 0;
                        decimal total_hour_assi = 0;
                        decimal Balance_Hours = 0;
                        decimal tioaltime_assi = 0;
                        decimal all_total_cast_assi = 0;
                        decimal all_total_hour_assi = 0;
                        decimal tioaltime_bal = 0;
                        decimal all_total_cast = 0;
                        decimal all_total_hour = 0;

                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            if (string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_remark"].ToString()))
                            {
                                if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["hourspend"].ToString()))
                                {
                                    tioaltime_assi = Math.Round(decimal.Parse(ds1.Tables[0].Rows[j]["hourspend"].ToString()), 2);
                                }
                                total_hour_assi = Math.Round((total_hour_assi + tioaltime_assi), 2);
                                all_total_cast_assi = all_total_cast_assi + Math.Round((tioaltime_assi * Devcost), 2);
                                all_total_hour_assi = all_total_hour_assi + tioaltime_assi;
                            }

                            if (string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_by_mark"].ToString()))
                            {
                                if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["hourspend"].ToString()))
                                {
                                    tioaltime_bal = Math.Round(decimal.Parse(ds1.Tables[0].Rows[j]["hourspend"].ToString()), 2);
                                }
                                total_hour_bal = Math.Round((total_hour_bal + tioaltime_bal), 2);
                                all_total_cast = all_total_cast + Math.Round((tioaltime_bal * Devcost), 2);
                                all_total_hour = all_total_hour + tioaltime_bal;
                            }

                            Balance_Hours = total_hour_assi - total_hour_bal;
                        }
                        strDeveloperHour += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                        strDeveloperHour += "<td class='Tab3'>" + ds.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                        strDeveloperHour += "<td class='Tab3'>" + total_hour_assi + "&nbsp;</td>";
                        strDeveloperHour += "<td class='Tab3'>" + total_hour_bal + "&nbsp;</td>";
                        if (Balance_Hours < 0)
                            strDeveloperHour += "<td class='Tab3' bgcolor='#FF0000'>" + Balance_Hours + "&nbsp;</td>";
                        else
                            strDeveloperHour += "<td class='Tab3' bgcolor='#00CC00'>" + Balance_Hours + "&nbsp;</td>";
                        strDeveloperHour += "</tr>";
                        DeveloperHour = strDeveloperHour;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private void bindTaskDoneAssigned()
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
                    decimal Devcost = Math.Round(decimal.Parse(ds.Tables[0].Rows[0]["per_cost"].ToString()), 2);
                    string strTaskDoneAssigned = string.Empty;

                    string[] col4 = { "@srno", "@proj_id", "@Actiontype" };
                    object[] val4 = { "0", Request.QueryString["srno"].ToString(), "select6" };
                    DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                    if (ds4.Tables[0].Rows.Count > 0)
                    {
                        string strMarketin = string.Empty;
                        string strasigned_per = string.Empty;
                        string struser_id = string.Empty;
                        for (int a = 0; a < ds4.Tables[0].Rows.Count; a++)
                        {
                            strMarketin += "'" + ds4.Tables[0].Rows[a]["working_per"].ToString() + "',";
                        }
                        strMarketin = strMarketin.Remove(strMarketin.Length - 1);
                        DataSet ds5 = dal.retDatasetByquery(" select name, user_id from tbl_Login where user_id in (" + strMarketin.ToString().Trim() + ") ");
                        if (ds5.Tables[0].Rows.Count > 0)
                        {
                            for (int z = 0; z < ds5.Tables[0].Rows.Count; z++)
                            {
                                strasigned_per += ds5.Tables[0].Rows[z]["name"].ToString() + ",";
                                struser_id += ds5.Tables[0].Rows[z]["user_id"].ToString() + ",";
                            }
                        }
                        strasigned_per = strasigned_per.Remove(strasigned_per.Length - 1);
                        string[] split = strasigned_per.Split(new char[] { ',' });
                        int arrLenth = split.Length;
                        struser_id = struser_id.Remove(struser_id.Length - 1);
                        string[] splitstruser_id = struser_id.Split(new char[] { ',' });

                        for (int z = 0; z < arrLenth; z++)
                        {
                            string[] col1 = { "@srno", "@proj_id", "@working_per", "@Actiontype" };
                            object[] val1 = { "0", Request.QueryString["srno"].ToString(), splitstruser_id[z], "select5" };
                            DataSet ds1 = dal.getDataSet("ManageProjDetails", col1, val1);
                            if (ds1.Tables[0].Rows.Count > 0)
                            {
                                decimal hourspend = 0;
                                string class1 = string.Empty;
                                for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                                {
                                    if (string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                    {
                                        if (ds1.Tables[0].Rows[j]["del_status"].ToString() == "0")
                                            class1 = "Tab3";
                                        else
                                            class1 = "txtdel";
                                    }
                                    else
                                    {
                                        if (ds1.Tables[0].Rows[j]["work_status"].ToString() == "0")
                                            class1 = "txt";
                                        else
                                            class1 = "txtpink";
                                    }

                                    string strdate = ds1.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                                    string[] col2 = { "@srno", "@user_id", "@Actiontype" };
                                    object[] val2 = { "0", ds1.Tables[0].Rows[j]["asignedby"].ToString(), "select4" };
                                    DataSet ds2 = dal.getDataSet("ManageLogin", col2, val2);

                                    string[] col3 = { "@srno", "@user_id", "@Actiontype" };
                                    object[] val3 = { "0", ds1.Tables[0].Rows[j]["working_per"].ToString(), "select4" };
                                    DataSet ds3 = dal.getDataSet("ManageLogin", col3, val3);

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

                                    string ur_date = ds1.Tables[0].Rows[j]["ur_date"].ToString().Replace(" 12:00:00 AM", "");

                                    //StringBuilder subwork_remark = new StringBuilder();
                                    //string strwork_remark = string.Empty;
                                    //if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_remark"].ToString()))
                                    //{
                                    //    string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["work_remark"].ToString(), @"<[^>]+>", "");
                                    //    if (s1.ToString().Length > 41)
                                    //        strwork_remark = s1.Substring(0, 40);
                                    //    else
                                    //        strwork_remark = s1;
                                    //    subwork_remark.Append(strwork_remark);
                                    //}

                                    string[] col6 = { "@srno", "@proj_id", "@working_per", "@task_srno", "@Actiontype" };
                                    object[] val6 = { "0", ds1.Tables[0].Rows[j]["proj_id"].ToString(), ds1.Tables[0].Rows[j]["working_per"].ToString(), ds1.Tables[0].Rows[j]["task_srno"].ToString(), "select15" };
                                    DataSet ds6 = dal.getDataSet("ManageProjDetails", col6, val6);
                                    int strTaskSrno = Convert.ToInt32(ds6.Tables[0].Rows[0]["Count"].ToString().Trim());

                                    strTaskDoneAssigned += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                                    strTaskDoneAssigned += "<td class='" + class1 + "'>" + ds1.Tables[0].Rows[j]["task_srno"].ToString() + "&nbsp;</td>";
                                    strTaskDoneAssigned += "<td class='" + class1 + "'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                                    strTaskDoneAssigned += "<td class='" + class1 + "'>" + ds2.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                                    strTaskDoneAssigned += "<td class='" + class1 + "'>" + ds1.Tables[0].Rows[j]["work_by_mark"].ToString() + "&nbsp;</td>";
                                    strTaskDoneAssigned += "<td class='" + class1 + "'>" + hourspend + "&nbsp;</td>";
                                    strTaskDoneAssigned += "<td class='" + class1 + "'>" + String.Format("{0:MM/dd/yyyy}", ur_date) + "&nbsp;</td>";
                                    strTaskDoneAssigned += "<td class='" + class1 + "'>" + ds3.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                                    strTaskDoneAssigned += "<td class='" + class1 + "'>" + ds1.Tables[0].Rows[j]["work_remark"].ToString() + "&nbsp;</td>";

                                    if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                    {
                                        if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_status"].ToString()))
                                        {
                                            if (ds1.Tables[0].Rows[j]["work_status"].ToString() == "0")
                                            {
                                                if (ds3.Tables[0].Rows[0]["srno"].ToString() == Session["developer_srno"].ToString().Trim())
                                                {
                                                    strTaskDoneAssigned += "<td class='" + class1 + "'><font color='#FF0000'>Pending&nbsp;&nbsp;<a href='task_reply.aspx?srno=" + ds1.Tables[0].Rows[j]["srno"].ToString() + "'>Reply</a>&nbsp;&nbsp;";
                                                     if (Request.QueryString["srno"].ToString() != "6")
                                                    {
                                                        strTaskDoneAssigned += "<a href='javascript:confirmform(" + ds1.Tables[0].Rows[j]["srno"].ToString() + ");'><font color='#FF00FF'>Done</font></a>";
                                                         
                                                    }
                                                    strTaskDoneAssigned += "</font></td>";

                                                }
                                                else
                                                    strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";
                                            }
                                            else
                                                strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";
                                        }
                                        else
                                            strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";
                                    }
                                    else
                                        strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";

                                    if (string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                    {
                                        if (ds3.Tables[0].Rows[0]["srno"].ToString() == Session["developer_srno"].ToString().Trim())
                                        {
                                            if (ds1.Tables[0].Rows[j]["del_status"].ToString() == "0")
                                            {
                                                if (strTaskSrno == 1)
                                                    strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";
                                                else
                                                {
                                                    string[] col7 = { "@srno", "@proj_id", "@working_per", "@task_srno", "@Actiontype" };
                                                    object[] val7 = { "0", Request.QueryString["srno"].ToString(), splitstruser_id[z], ds1.Tables[0].Rows[j]["task_srno"].ToString(), "select16" };
                                                    DataSet ds7 = dal.getDataSet("ManageProjDetails", col7, val7);
                                                    if (ds7.Tables[0].Rows.Count > 0)
                                                        strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";
                                                    else
                                                        strTaskDoneAssigned += "<td class='" + class1 + "'><a target='_blank' href='deleted_resign.aspx?srno=" + ds1.Tables[0].Rows[j]["srno"].ToString() + "'><font color='#FF0000'>Delete</font></a></td>";
                                                }
                                            }
                                            else
                                                strTaskDoneAssigned += "<td class='" + class1 + "'><a href='#' onClick='MM_openBrWindow('show_resign.asp?srno=<%=rsDeveloper('srno')%>&refno=<%=refno%>','','width=200,height=200')'><strong><font color='#999999'><u>Deleted</u></font></strong></a></td>";
                                        }
                                        else
                                            strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";
                                    }
                                    else
                                        strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";

                                    if (ds1.Tables[0].Rows[j]["del_status"].ToString() != "1" && ds1.Tables[0].Rows[j]["delete_Remark"].ToString() != "No")
                                    {
                                        strTaskDoneAssigned += "<td class='txt'>" + ds1.Tables[0].Rows[j]["delete_Remark"].ToString() + "</td>";
                                    }
                                    else
                                    {
                                        strTaskDoneAssigned += "<td class='" + class1 + "'>&nbsp;</td>";

                                    }

                                    strTaskDoneAssigned += "</tr>";
                                }
                                strTaskDoneAssigned += "<tr valign='top' bgcolor='#9999CC'><td colspan='10'>&nbsp;</td></tr>";
                            }
                        }
                        TaskDoneAssigned = strTaskDoneAssigned;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    [WebMethod]
    public static string UpdateWorkStatus(string srno)
    {
        DataAccessLayer dal = new DataAccessLayer();

        string[] col4 = { "@srno", "@Actiontype" };
        object[] val4 = { srno, "select7" };
        DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);

        DataSet ds5 = dal.retDatasetByquery(" SELECT COUNT(*) AS Count FROM tbl_ProjDetails WHERE task_srno='" + ds4.Tables[0].Rows[0]["task_srno"].ToString() + "' AND del_status='0' ");
        int strTaskSrno = Convert.ToInt32(ds5.Tables[0].Rows[0]["Count"].ToString().Trim());
        if (strTaskSrno > 1)
        {
            string[] col1 = { "@srno", "@Actiontype" };
            object[] val1 = { srno, "update1" };
            int i = dal.execute("ManageProjDetails", col1, val1);
            return "Data Save Successfuly.";
        }
        else
        {
            return "Not";
        }
    }
    
}