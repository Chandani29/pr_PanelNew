using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Developer_work_report : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string ProjectList = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindProjectList();
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
                    if (Request.Cookies["WorkReport"]["From"] == null)
                    {
                        Response.Cookies["WorkReport"].Expires = DateTime.Now.AddDays(-1);
                        Response.Redirect("developermain.aspx");
                    }

                    string roll;
                    roll = Request.Cookies["WorkReport"]["From"];
                    roll = roll + "," + Request.Cookies["WorkReport"]["To"];
                    string[] split1 = roll.Split(new char[] { ',' });

                    string strFrom = split1[0];
                    string strTo = split1[1];

                    DataSet ds1 = dal.retDatasetByquery(" SELECT * FROM tbl_ProjDetails WHERE working_per='" + ds.Tables[0].Rows[0]["user_id"].ToString().Trim() + "' and ddate between '" + strFrom + "' and '" + strTo + "' order by srno desc ");
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string coror1 = string.Empty;
                        string strProjectList = string.Empty;
                        decimal hourspend = 0;
                        decimal total_hourspend = 0;

                        strProjectList += "<table width='70%' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
                        strProjectList += "<tr valign='top' bgcolor='#E6E6E6' class='tdrow3' align='center'>";
                        strProjectList += "<td colspan='14' class='tdrow5' bgcolor='#CCCCCC'>";
                        strProjectList += "<div align='center'><strong>Total Working Hour Report:: From::" + strFrom + " To::" + strTo + "</strong></div></td></tr>";
                        strProjectList += "<tr valign='top' bgcolor='#E6E6E6' class='Tab2'>";
                        strProjectList += "<td><strong>Date</strong></td>";
                        strProjectList += "<td><strong>Project Name</strong></td>";
                        strProjectList += "<td><strong>Assigned By</strong></td>";
                        strProjectList += "<td><strong>Spent Hours</strong></td>";
                        strProjectList += "<td><strong>Developers</strong></td>";
                        strProjectList += "<td><strong>Task Done By Developer</strong></td>";
                        strProjectList += "</tr>";

                        for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                        {
                            if (string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_by_mark"].ToString()))
                            {
                                coror1 = "Tab3";

                                string strdate = ds1.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                                string[] col2 = { "@srno", "@user_id", "@Actiontype" };
                                object[] val2 = { "0", ds1.Tables[0].Rows[j]["asignedby"].ToString(), "select4" };
                                DataSet ds2 = dal.getDataSet("ManageLogin", col2, val2);

                                StringBuilder subcategory = new StringBuilder();
                                string strDesc = string.Empty;
                                if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                {
                                    string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["work_by_mark"].ToString(), @"<[^>]+>", "");
                                    if (s1.ToString().Length > 41)
                                        strDesc = s1.Substring(0, 40);
                                    else
                                        strDesc = s1;
                                    subcategory.Append(strDesc);
                                }

                                if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["hourspend"].ToString()))
                                {
                                    hourspend = Math.Round(decimal.Parse(ds1.Tables[0].Rows[j]["hourspend"].ToString()), 2);
                                    total_hourspend = Math.Round((total_hourspend + hourspend), 2);
                                }

                                string strMarketing = ds1.Tables[0].Rows[j]["working_per"].ToString();
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
                                if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["work_remark"].ToString()))
                                {
                                    string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[j]["work_remark"].ToString(), @"<[^>]+>", "");
                                    if (s1.ToString().Length > 41)
                                        strRemark = s1.Substring(0, 40);
                                    else
                                        strRemark = s1;
                                    subRemark.Append(strRemark);
                                }

                                strProjectList += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                                strProjectList += "<td class='" + coror1 + "'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";

                                if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[j]["inhouse_id"].ToString()))
                                {
                                    string[] col6 = { "@srno", "@Actiontype" };
                                    object[] val6 = { ds1.Tables[0].Rows[j]["inhouse_id"].ToString(), "select1" };
                                    DataSet ds6 = dal.getDataSet("ManageLogin", col6, val6);
                                    if (ds6.Tables[0].Rows.Count > 0)
                                        strProjectList += "<td class='txt'>" + ds1.Tables[0].Rows[j]["proj_name"].ToString() + "<br>" + ds6.Tables[0].Rows[0]["ProjName"].ToString() + "&nbsp;</td>";
                                }
                                else
                                    strProjectList += "<td class='txt'>" + ds1.Tables[0].Rows[j]["proj_name"].ToString() + "&nbsp;</td>";

                                strProjectList += "<td class='" + coror1 + "'>" + ds2.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                                strProjectList += "<td class='" + coror1 + "' align='right'>" + hourspend + "&nbsp;</td>";
                                strProjectList += "<td class='" + coror1 + "'>" + strasigned_per + "&nbsp;</td>";
                                strProjectList += "<td class='" + coror1 + "'>" + subRemark.ToString() + "&nbsp;</td>";
                                strProjectList += "</tr>";
                            }
                        }
                        strProjectList += "<tr valign='top' bgcolor='#E6E6E6' class='tb2' > ";
                        strProjectList += "<td colspan='3' align='right' class='Tab2'>Total&nbsp;</td>";
                        strProjectList += "<td class='Tab3' align='right'>" + total_hourspend + "&nbsp;</td>";
                        strProjectList += "<td colspan='2' align='right' class='Tab3'>&nbsp;</td>";
                        strProjectList += "</tr>";
                        strProjectList += "</table>";
                        ProjectList = strProjectList;
                    }
                    else
                    {
                        ProjectList = "<br><strong><font color=red>No work done !!</font></strong>";
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