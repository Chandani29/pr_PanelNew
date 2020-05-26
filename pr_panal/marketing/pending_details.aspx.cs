using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Marketing_pending_details : System.Web.UI.Page
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
                string[] col = { "@srno", "@working_per", "@Actiontype" };
                object[] val = { "0", Request.QueryString["uid"].ToString(), "select3" };
                DataSet ds = dal.getDataSet("ManageProjDetails", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strPartialPayment = string.Empty;

                    string[] col1 = { "@srno", "@user_id", "@Actiontype" };
                    object[] val1 = { "0", Request.QueryString["uid"].ToString(), "select4" };
                    DataSet ds1 = dal.getDataSet("ManageLogin", col1, val1);

                    strPartialPayment += "<table width='70%' border='1' cellspacing='2' cellpadding='1' class='tdrow4' align='center'>";
                    strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPartialPayment += "<td class='Tab2' colspan='8' bgcolor='#CCCCCC'><strong>Pending Task of " + ds1.Tables[0].Rows[0]["name"].ToString() + "::</strong></td></tr>";
                    strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPartialPayment += "<td class='Tab2'><strong>Project Id</strong></td>";
                    strPartialPayment += "<td class='Tab2'><strong>Project Name</strong></td>";
                    strPartialPayment += "<td class='Tab2'><strong>Date</strong></td>";
                    strPartialPayment += "<td class='Tab2'><strong>Assigned By</strong></td>";
                    strPartialPayment += "<td class='Tab2'><strong>Assigned Task</strong></td>";
                    strPartialPayment += "<td class='Tab2'><strong>Assigned Hours</strong></td>";
                    strPartialPayment += "<td class='Tab2'><strong>To Be Submmited By</strong></td>";
                    strPartialPayment += "<td class='Tab2'><strong>Work Status</strong></td>";
                    strPartialPayment += "</tr>";

                    for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                    {
                        string proj_id = string.Empty;
                        string ddate = string.Empty;
                        string total_hour = string.Empty;
                        decimal hourspend = 0;

                        string strdate = ds.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[j]["work_by_mark"].ToString()))
                        {
                            string[] col2 = { "@srno", "@Actiontype" };
                            object[] val2 = { ds.Tables[0].Rows[j]["proj_id"].ToString(), "select5" };
                            DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                            proj_id = ds2.Tables[0].Rows[0]["proj_id"].ToString();
                            ddate = ds2.Tables[0].Rows[0]["ddate"].ToString();
                            total_hour = ds2.Tables[0].Rows[0]["total_hour"].ToString();

                            string[] col4 = { "@srno", "@user_id", "@Actiontype" };
                            object[] val4 = { "0", ds.Tables[0].Rows[j]["asignedby"].ToString(), "select4" };
                            DataSet ds4 = dal.getDataSet("ManageLogin", col4, val4);

                            StringBuilder subcategory = new StringBuilder();
                            string strDesc = string.Empty;
                            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[j]["work_by_mark"].ToString()))
                            {
                                string s1 = System.Text.RegularExpressions.Regex.Replace(ds.Tables[0].Rows[j]["work_by_mark"].ToString(), @"<[^>]+>", "");
                                if (s1.ToString().Length > 41)
                                    strDesc = s1.Substring(0, 40);
                                else
                                    strDesc = s1;
                                subcategory.Append(strDesc);
                            }

                            hourspend = Math.Round(decimal.Parse(ds.Tables[0].Rows[j]["hourspend"].ToString()), 2);

                            strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                            strPartialPayment += "<td class='Tab3'>" + proj_id + "</td>";

                            if (!string.IsNullOrEmpty(ds.Tables[0].Rows[j]["inhouse_id"].ToString()))
                            {
                                string[] col3 = { "@srno", "@Actiontype" };
                                object[] val3 = { ds.Tables[0].Rows[j]["inhouse_id"].ToString(), "select1" };
                                DataSet ds3 = dal.getDataSet("ManageProjectInhouse", col3, val3);
                                strPartialPayment += "<td class='txt'>" + ds.Tables[0].Rows[j]["proj_name"].ToString() + "<br>" + ds3.Tables[0].Rows[0]["ProjName"].ToString() + "</td>";
                            }
                            else
                                strPartialPayment += "<td class='txt'>" + ds.Tables[0].Rows[j]["proj_name"].ToString() + "</td>";

                            strPartialPayment += "<td class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "</td>";
                            strPartialPayment += "<td class='Tab3'>" + ds4.Tables[0].Rows[0]["name"].ToString() + "</td>";
                            strPartialPayment += "<td class='Tab3'>" + subcategory.ToString() + "</td>";
                            strPartialPayment += "<td class='Tab3'>" + hourspend.ToString() + "&nbsp;</td>";
                            strPartialPayment += "<td class='Tab3'>" + ds.Tables[0].Rows[j]["ur_date"].ToString() + "&nbsp;</td>";
                            strPartialPayment += "<td class='Tab3'><font color='#FF0000'><strong>Pending</strong></font>&nbsp;</td>";
                            strPartialPayment += "</tr>";
                        }
                    }
                    strPartialPayment += "</table><br>";
                    PartialPayment = strPartialPayment;
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