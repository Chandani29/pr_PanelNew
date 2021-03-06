﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_pay_now : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string PartialPayment = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
            CountProject();
            bindpartialpayment();
        }
    }
    private void bindpartialpayment()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strPartialPayment = string.Empty;
                    strPartialPayment += "<table width='70%' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
                    strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='tdrow3' align='center'><td colspan='6' class='tdrow5' bgcolor='#CCCCCC'>";
                    strPartialPayment += "<div align='center'><strong>Summary of Expenses</strong></div></td>";
                    strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Date</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Marketing Person</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Total Amount</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Total Pay Amount</strong></td>";
                    strPartialPayment += "<td colspan='2' align='center' class='Tab3'><strong>Description</strong></td>";
                    strPartialPayment += "</tr>";

                    decimal Total_Amount = 0;
                    decimal Total_Pay_Amount = 0;
                    decimal Total_Balance_Amount = 0;
                    decimal Balance_Amount = 0;
                    decimal pay_amount = 0;

                    string[] col1 = { "@srno", "@mp_id", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), "select4" };
                    DataSet ds1 = dal.getDataSet("ManageMarketingExpenses", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        for (int z = 0; z < ds1.Tables[0].Rows.Count; z++)
                        {
                            string strdate = ds1.Tables[0].Rows[z]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                            Total_Balance_Amount = Math.Round(decimal.Parse(ds1.Tables[0].Rows[z]["amount"].ToString()), 2) - Math.Round(decimal.Parse(ds1.Tables[0].Rows[z]["pay_amount"].ToString()), 2);

                            pay_amount = Math.Round(decimal.Parse(ds1.Tables[0].Rows[z]["pay_amount"].ToString()), 2);

                            strPartialPayment += "<tr>";
                            strPartialPayment += "<td align='center' class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "</td>";
                            strPartialPayment += "<td align='center' class='Tab3'>" + ds.Tables[0].Rows[0]["name"].ToString() + "</td>";
                            strPartialPayment += "<td align='center' class='Tab3'>" + ds1.Tables[0].Rows[z]["amount"].ToString() + "</td>";
                            if (pay_amount > 0)
                                strPartialPayment += "<td align='center' class='Tab3' bgcolor='#00CC00'>" + ds1.Tables[0].Rows[z]["pay_amount"].ToString() + "</td>";
                            else
                                strPartialPayment += "<td align='center' class='Tab3'>" + ds1.Tables[0].Rows[z]["pay_amount"].ToString() + "</td>";
                            strPartialPayment += "<td colspan='2' align='center' class='Tab3'>" + ds1.Tables[0].Rows[z]["ex_desc"].ToString() + "</td>";
                            strPartialPayment += "</tr>";

                            Total_Amount = Total_Amount + decimal.Parse(ds1.Tables[0].Rows[z]["amount"].ToString());
                            Total_Pay_Amount = Total_Pay_Amount + decimal.Parse(ds1.Tables[0].Rows[z]["pay_amount"].ToString());
                            Balance_Amount = Balance_Amount + Total_Balance_Amount;
                        }
                    }
                    strPartialPayment += "<tr>";
                    strPartialPayment += "<td colspan='2' align='right' class='Tab2' bgcolor='#CCCCCC'>Total&nbsp;</td>";
                    strPartialPayment += "<td align='center' bgcolor='#CCCCCC' class='Tab2'>" + Total_Amount + "&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>" + Total_Pay_Amount + "&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>Balance Amount&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>" + Balance_Amount + "&nbsp;</td>";
                    strPartialPayment += "</tr></table><br>";
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
    private void CountProject()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);
                txt_uid.Text = ds.Tables[0].Rows[0]["name"].ToString().Trim();
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                string[] col1 = { "@srno", "@mp_id", "@Actiontype" };
                object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), "select2" };
                DataSet ds1 = dal.getDataSet("ManageMarketingExpenses", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[0]["amount"].ToString()))
                    {
                        decimal Total_Balance_Amount = Math.Round(decimal.Parse(ds1.Tables[0].Rows[0]["amount"].ToString()), 2) - Math.Round(decimal.Parse(ds1.Tables[0].Rows[0]["pay_amount"].ToString()), 2);
                        if (Total_Balance_Amount == 0)
                            lblmsg.Text = "You are pay total amount.";
                        else
                        {
                            string[] col3 = { "@srno", "@mp_id", "@amount", "@pay_amount", "@ex_desc", "@ddate", "@Actiontype" };
                            object[] val3 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString(), "0", txt_amount.Text.Trim(), txt_desc.Text.Trim(), Request.Form[txt_date.UniqueID], "add" };
                            int i = dal.execute("ManageMarketingExpenses", col3, val3);
                            if (i == 1)
                                lblmsg.Text = "Data Save Successfuly.";
                            dal.ClearControls(this);
                            txt_amount.Text = "";
                            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                            CountProject();
                            bindpartialpayment();
                        }
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

    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                Response.Redirect("pay_now.aspx");
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
    protected void btnSubmit3_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Cookies["ReceivedPayment"]["From"] = Request.Form[text_date_from24.UniqueID];
            Response.Cookies["ReceivedPayment"]["To"] = Request.Form[text_date_to24.UniqueID];
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Request.QueryString["srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strPartialPayment = string.Empty;
                    strPartialPayment += "<table width='70%' border='1' cellpadding='3' cellspacing='1' class='Tab2' align='center'>";
                    strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='tdrow3' align='center'><td colspan='6' class='tdrow5' bgcolor='#CCCCCC'>";
                    strPartialPayment += "<div align='center'><strong>Summary of Expenses</strong></div></td>";
                    strPartialPayment += "<tr valign='top' bgcolor='#E6E6E6' class='bottom'>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Date</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Marketing Person</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Total Amount</strong></td>";
                    strPartialPayment += "<td align='center' class='Tab3'><strong>Total Pay Amount</strong></td>";
                    strPartialPayment += "<td colspan='2' align='center' class='Tab3'><strong>Description</strong></td>";
                    strPartialPayment += "</tr>";

                    decimal Total_Amount = 0;
                    decimal Total_Pay_Amount = 0;
                    decimal Total_Balance_Amount = 0;
                    decimal Balance_Amount = 0;
                    decimal pay_amount = 0;

                    DataSet ds1 = dal.retDatasetByquery(" SELECT * FROM tbl_MarketingExpenses WHERE mp_id='" + ds.Tables[0].Rows[0]["user_id"].ToString() + "' and ddate >= '" + Request.Form[text_date_from24.UniqueID] + "' and ddate <= '" + Request.Form[text_date_to24.UniqueID] + "' ORDER BY srno DESC ");
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        for (int z = 0; z < ds1.Tables[0].Rows.Count; z++)
                        {
                            string strdate = ds1.Tables[0].Rows[z]["ddate"].ToString().Replace(" 12:00:00 AM", "");

                            Total_Balance_Amount = Math.Round(decimal.Parse(ds1.Tables[0].Rows[z]["amount"].ToString()), 2) - Math.Round(decimal.Parse(ds1.Tables[0].Rows[z]["pay_amount"].ToString()), 2);

                            pay_amount = Math.Round(decimal.Parse(ds1.Tables[0].Rows[z]["pay_amount"].ToString()), 2);

                            strPartialPayment += "<tr>";
                            strPartialPayment += "<td align='center' class='Tab3'>" + String.Format("{0:MM/dd/yyyy}", strdate) + "</td>";
                            strPartialPayment += "<td align='center' class='Tab3'>" + ds.Tables[0].Rows[0]["name"].ToString() + "</td>";
                            strPartialPayment += "<td align='center' class='Tab3'>" + ds1.Tables[0].Rows[z]["amount"].ToString() + "</td>";
                            if (pay_amount > 0)
                                strPartialPayment += "<td align='center' class='Tab3' bgcolor='#00CC00'>" + ds1.Tables[0].Rows[z]["pay_amount"].ToString() + "</td>";
                            else
                                strPartialPayment += "<td align='center' class='Tab3'>" + ds1.Tables[0].Rows[z]["pay_amount"].ToString() + "</td>";
                            strPartialPayment += "<td colspan='2' align='center' class='Tab3'>" + ds1.Tables[0].Rows[z]["ex_desc"].ToString() + "</td>";
                            strPartialPayment += "</tr>";

                            Total_Amount = Total_Amount + decimal.Parse(ds1.Tables[0].Rows[z]["amount"].ToString());
                            Total_Pay_Amount = Total_Pay_Amount + decimal.Parse(ds1.Tables[0].Rows[z]["pay_amount"].ToString());
                            Balance_Amount = Balance_Amount + Total_Balance_Amount;
                        }
                    }
                    strPartialPayment += "<tr>";
                    strPartialPayment += "<td colspan='2' align='right' class='Tab2' bgcolor='#CCCCCC'>Total&nbsp;</td>";
                    strPartialPayment += "<td align='center' bgcolor='#CCCCCC' class='Tab2'>" + Total_Amount + "&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>" + Total_Pay_Amount + "&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>Balance Amount&nbsp;</td>";
                    strPartialPayment += "<td align='center' class='Tab2' bgcolor='#CCCCCC'>" + Balance_Amount + "&nbsp;</td>";
                    strPartialPayment += "</tr></table><br>";
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
            string str = ex.Message.ToString();
        }
    }
}