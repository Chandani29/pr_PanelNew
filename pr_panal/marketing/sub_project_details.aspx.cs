using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Marketing_sub_project_details : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string PartialPayment = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindpartialpayment();
        }
    }
    private void bindpartialpayment()
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
                    string[] col1 = { "@srno", "@inhouse_id", "@Actiontype" };
                    object[] val1 = { "0", Request.QueryString["srno"].ToString().Trim(), "select12" };
                    DataSet ds1 = dal.getDataSet("ManageProjDetails", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string strPartialPayment = string.Empty;
                        strPartialPayment += "<table width='70%' border='1' cellpadding='3' cellspacing='1' class='tdrow4' align='center'>";
                        strPartialPayment += "<tr valign='top' bgcolor='#CCCCCC' class='bottom'>";
                        strPartialPayment += "<td colspan='4' align='center' class='Tab2' bgcolor='#CCCCCC'><font color='#0000FF'>" + ds.Tables[0].Rows[0]["projname"].ToString() + "</font>&nbsp;&nbsp;Details.....</td></tr>";
                        strPartialPayment += "<tr valign='top' bgcolor='#CCCCCC' class='bottom'>";
                        strPartialPayment += "<td class='Tab2'>Developer Name</td>";
                        strPartialPayment += "<td class='Tab2'>Total Hour Spent</td>";
                        strPartialPayment += "<td class='Tab2'>Cost</td>";
                        strPartialPayment += "<td class='Tab2'>Task Done</td>";
                        strPartialPayment += "</tr>";

                        string strSubProjects = string.Empty;
                        decimal all_hourspend_inhouse1 = 0;
                        decimal all_dev_cost_inhouse1 = 0;

                        for (int z = 0; z < ds1.Tables[0].Rows.Count; z++)
                        {
                            decimal hourspend_inhouse = 0;
                            decimal dev_cost_inhouse = 0;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[z]["hourspend"].ToString()))
                                hourspend_inhouse = Math.Round(decimal.Parse(ds1.Tables[0].Rows[z]["hourspend"].ToString()), 2);
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[z]["dev_cost"].ToString()))
                                dev_cost_inhouse = Math.Round(decimal.Parse(ds1.Tables[0].Rows[z]["dev_cost"].ToString()), 2);
                            all_hourspend_inhouse1 = all_hourspend_inhouse1 + hourspend_inhouse;
                            all_dev_cost_inhouse1 = all_dev_cost_inhouse1 + dev_cost_inhouse;

                            StringBuilder subcategory = new StringBuilder();
                            string strDesc = string.Empty;
                            if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[z]["work_remark"].ToString()))
                            {
                                string s1 = System.Text.RegularExpressions.Regex.Replace(ds1.Tables[0].Rows[z]["work_remark"].ToString(), @"<[^>]+>", "");
                                if (s1.ToString().Length > 41)
                                    strDesc = s1.Substring(0, 40);
                                else
                                    strDesc = s1;
                                subcategory.Append(strDesc);
                            }

                            strSubProjects += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                            string[] col2 = { "@srno", "@Actiontype" };
                            object[] val2 = { Session["marketing_srno"].ToString().Trim(), "select3" };
                            DataSet ds2 = dal.getDataSet("ManageLogin", col2, val2);
                            if (ds1.Tables[0].Rows[z]["working_per"].ToString().Trim() == ds2.Tables[0].Rows[0]["user_id"].ToString().Trim())
                                strSubProjects += "<td class='Tab3'>&nbsp;</td>";
                            else
                            {
                                string[] col3 = { "@srno", "@user_id", "@Actiontype" };
                                object[] val3 = { "0", ds1.Tables[0].Rows[z]["working_per"].ToString(), "select4" };
                                DataSet ds3 = dal.getDataSet("ManageLogin", col3, val3);
                                strSubProjects += "<td class='Tab3'>" + ds3.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";

                            }
                            strSubProjects += "<td class='Tab3'>" + hourspend_inhouse + "&nbsp;</td>";
                            strSubProjects += "<td class='Tab3'>" + dev_cost_inhouse + "&nbsp;</td>";
                            strSubProjects += "<td class='Tab3'>" + subcategory.ToString() + "&nbsp;</td>";
                            strSubProjects += "</tr>";
                        }
                        strPartialPayment += "<tr valign='top' bgcolor='#CCCCCC' class='bottom'>";
                        strPartialPayment += "<td class='Tab2' align='right'>&nbsp;Total</td>";
                        strPartialPayment += "<td class='Tab2'>&nbsp;" + all_hourspend_inhouse1.ToString() + "</td>";
                        strPartialPayment += "<td class='Tab2'>&nbsp;"+all_dev_cost_inhouse1.ToString()+"</td>";
                        strPartialPayment += "<td class='Tab2'>&nbsp;</td></tr>";
                        strPartialPayment += "</table><br>";
                        PartialPayment = strPartialPayment;
                    }
                    else
                    {
                        PartialPayment = "<center><font color=red>No Record Found</font></center>";
                    }
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
}