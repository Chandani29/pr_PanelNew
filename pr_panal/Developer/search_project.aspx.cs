using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_search_project : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string InHouseProject, total_hour_proj_in, total_hour_exp1_dev_in, total_hour_proj_in1 = string.Empty;
    public string ProjectList, total_hour_exp1_dev, total_hour_proj, total_hour_proj1 = string.Empty;
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
            bindInHouseProject();
            bindProjectList();
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

                            string[] col4 = { "@srno", "@Actiontype" };
                            object[] val4 = { ds1.Tables[0].Rows[j]["srno"].ToString(), "select4" };
                            DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                            if (ds4.Tables[0].Rows.Count > 0)
                            {
                                for (int z = 0; z < ds4.Tables[0].Rows.Count; z++)
                                {
                                    if (!string.IsNullOrEmpty(ds4.Tables[0].Rows[z]["work_by_mark"].ToString()))
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
                    if (Request.Cookies["DeveloperSearch"]["SelectType"] == null)
                    {
                        Response.Cookies["DeveloperSearch"].Expires = DateTime.Now.AddDays(-1);
                        Response.Redirect("developermain.aspx");
                    }

                    string roll;
                    roll = Request.Cookies["DeveloperSearch"]["SelectType"];
                    roll = roll + "," + Request.Cookies["DeveloperSearch"]["ProjectType"];
                    roll = roll + "," + Request.Cookies["DeveloperSearch"]["From"];
                    roll = roll + "," + Request.Cookies["DeveloperSearch"]["To"];
                    string[] split1 = roll.Split(new char[] { ',' });

                    string strSelectType = split1[0];
                    string strProjectType = split1[1];
                    string strFrom = split1[2];
                    string strTo = split1[3];

                    DataSet ds1 = new DataSet();
                    if (strProjectType == "")
                    {
                        select_type.Value = strSelectType;
                        text_date_from.Text = strFrom;
                        text_date_to.Text = strTo;

                        if(strSelectType == "Received" || strSelectType == "Trial Project")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and ddate between'" + strFrom + "' and '" + strTo + "' and workstatus='" + strSelectType + "' order by srNo desc ");
			
                        if(strSelectType == "Dead" || strSelectType == "Completed")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and completed_on between'" + strFrom + "' and '" + strTo + "' and workstatus='" + strSelectType + "' order by srNo desc ");
                
                        if(strSelectType == "All")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and ddate between'" + strFrom + "' and '" + strTo + "' order by srNo desc ");
                    }
                    else 
                    {
                        select2_type.Value = strSelectType;
                        text_type.Text = strProjectType;

                        if (strSelectType == "Project Name")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and proj_name like '" + strProjectType + "%' ");

                        if (strSelectType == "Project ID")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and proj_id ='" + strProjectType + "' ");
                    }
                    
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string coror1 = string.Empty;
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

                            string[] col4 = { "@srno", "@Actiontype" };
                            object[] val4 = { ds1.Tables[0].Rows[j]["srno"].ToString(), "select4" };
                            DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                            if (ds4.Tables[0].Rows.Count > 0)
                            {
                                for (int z = 0; z < ds4.Tables[0].Rows.Count; z++)
                                {
                                    if (!string.IsNullOrEmpty(ds4.Tables[0].Rows[z]["work_by_mark"].ToString()))
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
                            strProjectList += "<td class='Tab3'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["proj_id"].ToString() + "</font>&nbsp;</td>";
                            strProjectList += "<td class='Tab3' align='center'>&nbsp;<a href='project_report.aspx?srno=" + ds1.Tables[0].Rows[j]["srno"].ToString() + "' target='_blank'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["proj_name"].ToString() + "</font></a></td>";
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
                            strProjectList += "<td class='Tab3'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["workstatus"].ToString() + "</font>&nbsp;</td>";
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            bindInHouseProject();
            bindProjectList1(select_type.Value, "", Request.Form[text_date_from.UniqueID], Request.Form[text_date_to.UniqueID]);
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
            bindInHouseProject();
            bindProjectList1(select2_type.Value, text_type.Text, "", "");
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private void bindProjectList1(string strSelectType, string strProjectType, string strFrom, string strTo)
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
                    DataSet ds1 = new DataSet();
                    if (strProjectType == "")
                    {
                        select_type.Value = strSelectType;
                        text_date_from.Text = strFrom;
                        text_date_to.Text = strTo;

                        if (strSelectType == "Received" || strSelectType == "Trial Project")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and ddate between'" + strFrom + "' and '" + strTo + "' and workstatus='" + strSelectType + "' order by srNo desc ");

                        if (strSelectType == "Dead" || strSelectType == "Completed")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and completed_on between'" + strFrom + "' and '" + strTo + "' and workstatus='" + strSelectType + "' order by srNo desc ");

                        if (strSelectType == "All")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and ddate between'" + strFrom + "' and '" + strTo + "' order by srNo desc ");
                    }
                    else
                    {
                        select2_type.Value = strSelectType;
                        text_type.Text = strProjectType;

                        if (strSelectType == "Project Name")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and proj_name like '" + strProjectType + "%' ");

                        if (strSelectType == "Project ID")
                            ds1 = dal.retDatasetByquery(" SELECT * from tbl_Project WHERE asigned_per like '%" + ds.Tables[0].Rows[0]["user_id"].ToString() + "%' and type_proj<>'1' and proj_id ='" + strProjectType + "' ");
                    }

                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string coror1 = string.Empty;
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

                            string[] col4 = { "@srno", "@Actiontype" };
                            object[] val4 = { ds1.Tables[0].Rows[j]["srno"].ToString(), "select4" };
                            DataSet ds4 = dal.getDataSet("ManageProjDetails", col4, val4);
                            if (ds4.Tables[0].Rows.Count > 0)
                            {
                                for (int z = 0; z < ds4.Tables[0].Rows.Count; z++)
                                {
                                    if (!string.IsNullOrEmpty(ds4.Tables[0].Rows[z]["work_by_mark"].ToString()))
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
                            strProjectList += "<td class='Tab3'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["proj_id"].ToString() + "</font>&nbsp;</td>";
                            strProjectList += "<td class='Tab3' align='center'>&nbsp;<a href='project_report.aspx?srno=" + ds1.Tables[0].Rows[j]["srno"].ToString() + "' target='_blank'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["proj_name"].ToString() + "</font></a></td>";
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
                            strProjectList += "<td class='Tab3'><font color='" + coror1 + "'>" + ds1.Tables[0].Rows[j]["workstatus"].ToString() + "</font>&nbsp;</td>";
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
}