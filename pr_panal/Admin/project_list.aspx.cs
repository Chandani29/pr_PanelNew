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

public partial class Admin_project_list : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string count2, total_hour, total_hour_ex, total_cost, total_payment_received, total_expenses = string.Empty;
    decimal inttotal_hour = 0;
    decimal inttotal_hour1 = 0;
    decimal inttotal_hour_ex = 0;
    decimal inttotal_cost = 0;
    decimal inttotal_payment_received = 0;
    decimal total_expenses_up = 0;
    decimal intlblproj_expenses = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            binddatagrid();
        }
    }

    private void binddatagrid()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                if (Request.Cookies["ProjectList"]["ProjectName"] == null)
                {
                    Response.Cookies["ProjectList"].Expires = DateTime.Now.AddDays(-1);
                    Response.Redirect("adminmain.aspx");
                }
                string roll; 
                roll =Request.Cookies["ProjectList"]["ProjectName"]; 
                string[] col2 = { "@srno", "@Actiontype" };
                object[] val2 = {roll, "select5" };
                DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                if (ds2.Tables[0].Rows.Count > 0)
                {
                    Repeater1.DataSource = ds2.Tables[0];
                    Repeater1.DataBind();
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
            if (ds.Tables[0].Rows.Count > 0)
                lbltype_projshow.Text = ds.Tables[0].Rows[0]["ProjectType"].ToString();

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

            // Bind Developer
            Label lblAssignedFrom = (Label)e.Item.FindControl("lblAssignedFrom");
            Label lblmp_id = (Label)e.Item.FindControl("lblmp_id");
            string[] colAF = { "@srno", "@user_id", "@Actiontype" };
            object[] valAF = { "0", lblmp_id.Text.Trim(), "select4" };
            DataSet dsAF = dal.getDataSet("ManageLogin", colAF, valAF);
            if (dsAF.Tables[0].Rows.Count > 0)
            {
                lblAssignedFrom.Text = dsAF.Tables[0].Rows[0]["name"].ToString();
            }

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
            //if (lbltype_projshow.Text == "InHouse")
            //    lblproj_name_url.Text = "&nbsp;<br><strong><a href='add_inhouse_proj.aspx?srno=" + lblsrno.Text + "'>Add New</a></strong>";
            //else
            //    if (lblworkstatus.Text == "Received")
            //        lblproj_name_url.Text = "<br>&nbsp;&nbsp;<strong><a href='extend_proj.aspx?srno=" + lblsrno.Text + "'>Ext.</a>&nbsp;&nbsp;&nbsp;<a href='reduce_proj.aspx?srno=" + lblsrno.Text + "'>Red.</a></strong>";

            if (lblworkstatus.Text == "Dead")
                lblworkstatusShow.Text = "<td bgcolor='#E6E6E6' class='txt'>" + lblworkstatus.Text + "</td>";
            if (lblworkstatus.Text == "Completed")
                lblworkstatusShow.Text = "<td bgcolor='#E6E6E6' class='txtgreen'>" + lblworkstatus.Text + "</td>";
            if (lblworkstatus.Text == "Received")
                lblworkstatusShow.Text = "<td bgcolor='#E6E6E6' class='Tab3'>" + lblworkstatus.Text + "</td>";
            if (lblworkstatus.Text == "Trial Project")
                lblworkstatusShow.Text = "<td bgcolor='#E6E6E6' class='Tab3'>" + lblworkstatus.Text + "</td>";

            // Bind Project Details Link
            Label lblproj_id = (Label)e.Item.FindControl("lblproj_id");
            //HtmlAnchor aPD = (HtmlAnchor)e.Item.FindControl("aPD");
            //if (lbltype_projshow.Text == "InHouse")
            //    aPD.HRef = "project_details_inhouse.aspx?srno=" + lblsrno.Text;
            //else
            //    aPD.HRef = "project_details.aspx?srno=" + lblsrno.Text;

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
}