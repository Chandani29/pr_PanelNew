using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
public partial class Admin_pending_list : System.Web.UI.Page
{
    MainClass dut = new MainClass(); 
    DataAccessLayer dal = new DataAccessLayer(); 
    public string PendingList = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");

            bindPendingList();
        }
    }
    private void bindPendingList()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["admin_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string[] col1 = { "@srno", "@Actiontype" };
                    object[] val1 = { "0", "select2" };
                    DataSet ds1 = dal.getDataSet("ManageLogin", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        string strPendingList = string.Empty;
                        for (int z = 0; z < ds1.Tables[0].Rows.Count; z++)
                        {
                            string[] col2 = { "@srno", "@working_per", "@Actiontype" };
                            object[] val2 = { "0", ds1.Tables[0].Rows[z]["user_id"].ToString(), "select8" };
                            DataSet ds2 = dal.getDataSet("ManageProjDetails", col2, val2);
                            if (ds2.Tables[0].Rows.Count > 0)
                            {
                                strPendingList += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                                strPendingList += "<td class='Tab2' colspan='8' bgcolor='#CCCCCC'><strong>Pending&nbsp;task&nbsp;of&nbsp;<font color='blue'>" + ds1.Tables[0].Rows[z]["name"].ToString() + "</font>::</strong></td></tr>";
                                for (int j = 0; j < ds2.Tables[0].Rows.Count; j++)
                                {
                                    string[] col3 = { "@srno", "@Actiontype" };
                                    object[] val3 = { ds2.Tables[0].Rows[j]["proj_id"].ToString(), "select5" };
                                    DataSet ds3 = dal.getDataSet("ManageProject", col3, val3);

                                    string strdate = ds2.Tables[0].Rows[j]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                                    string[] col5 = { "@srno", "@user_id", "@Actiontype" };
                                    object[] val5 = { "0", ds2.Tables[0].Rows[j]["asignedby"].ToString(), "select4" };
                                    DataSet ds5 = dal.getDataSet("ManageLogin", col5, val5);

                                    StringBuilder subcategory = new StringBuilder();
                                    string strDesc = string.Empty;
                                    if (!string.IsNullOrEmpty(ds2.Tables[0].Rows[j]["work_by_mark"].ToString()))
                                    {
                                        string s1 = System.Text.RegularExpressions.Regex.Replace(ds2.Tables[0].Rows[j]["work_by_mark"].ToString(), @"<[^>]+>", "");
                                        if (s1.ToString().Length > 41)
                                            strDesc = s1.Substring(0, 40);
                                        else
                                            strDesc = s1;
                                        subcategory.Append(strDesc);
                                    }

                                    strPendingList += "<tr valign='top' bgcolor='#E6E6E6' class='tb2'>";
                                    strPendingList += "<td class='Tab3'>" + ds3.Tables[0].Rows[0]["proj_id"].ToString() + "&nbsp;</td>";

                                    if (!string.IsNullOrEmpty(ds2.Tables[0].Rows[j]["inhouse_id"].ToString()))
                                    {
                                        string[] col4 = { "@srno", "@Actiontype" };
                                        object[] val4 = { ds2.Tables[0].Rows[j]["inhouse_id"].ToString(), "select1" };
                                        DataSet ds4 = dal.getDataSet("ManageProjectInhouse", col4, val4);
                                        strPendingList += "<td class='txttxt'>" + ds2.Tables[0].Rows[j]["proj_name"].ToString() + "<br>" + ds4.Tables[0].Rows[0]["ProjName"].ToString() + "&nbsp;</td>";
                                    }
                                    else
                                        strPendingList += "<td class='txt'>" + ds2.Tables[0].Rows[j]["proj_name"].ToString() + "&nbsp;</td>";

                                    strPendingList += "<td class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "&nbsp;</td>";
                                    strPendingList += "<td class='Tab3'>" + ds5.Tables[0].Rows[0]["name"].ToString() + "&nbsp;</td>";
                                    strPendingList += "<td class='Tab3'>" + subcategory.ToString() + "&nbsp;</td>";
                                    strPendingList += "<td class='Tab3'>" + ds2.Tables[0].Rows[j]["hourspend"].ToString() + "&nbsp;</td>";
                                    strPendingList += "<td class='Tab3'><strong>" + ds2.Tables[0].Rows[j]["ur_date"].ToString() + "&nbsp;</strong></td>";
                                    strPendingList += "<td class='Tab3'><font color='#FF0000'><strong>Pending</strong></font>&nbsp;</td>";
                                    strPendingList += "</tr>";
                                }
                            }
                        }
                        PendingList = strPendingList;
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