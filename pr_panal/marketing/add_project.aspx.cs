using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Marketing_add_project : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string srno = "P-1";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["marketing_srno"] != null)
        {
            var value = Request.Cookies["marketing_srno"].Value;
            if (value == "")
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
            Session["marketing_srno"] = value;
        }
        if (!IsPostBack)
        {
            txt_date.Text = System.DateTime.Now.ToString("yyyy-dd-MM HH:mm:ss");
            CountProject();
            BindCheckBoxList();

            if (!string.IsNullOrEmpty(Request.QueryString["srno"]))
                binddatagrid();
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

                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { Request.QueryString["srno"].ToString().Trim(), "select5" };
                DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    txt_srno.Text = ds1.Tables[0].Rows[0]["proj_id"].ToString();

                    txt_date.Text = Convert.ToDateTime(ds1.Tables[0].Rows[0]["ddate"]).ToString("yyyy-dd-MM HH:mm:ss");


                    txt_date.Text = ds1.Tables[0].Rows[0]["ddate"].ToString();
                    txt_clientname.Text = ds1.Tables[0].Rows[0]["clientname"].ToString();
                    txt_referance.Text = ds1.Tables[0].Rows[0]["proj_source"].ToString();
                    txt_clientmobile.Text = ds1.Tables[0].Rows[0]["clientmobile"].ToString();
                    txt_clientemail.Text = ds1.Tables[0].Rows[0]["clientemail"].ToString();
                    txt_clientcompany.Text = ds1.Tables[0].Rows[0]["clientcompany"].ToString();
                    txt_clientadd.Text = ds1.Tables[0].Rows[0]["clientadd"].ToString();

                    List<string> multiselectedValue = ds1.Tables[0].Rows[0]["type_proj"].ToString().Split(',').ToList();
                    dd_type.SelectionMode = ListSelectionMode.Multiple;

                    foreach (string item in multiselectedValue)
                        dd_type.Items.FindByValue(item).Selected = true;

                    dd_type.SelectedValue = ds1.Tables[0].Rows[0]["type_proj"].ToString();
                    dd_technology.SelectedValue = ds1.Tables[0].Rows[0]["project_technology"].ToString();
                    txt_proj.Text = ds1.Tables[0].Rows[0]["proj_name"].ToString();
                    txt_desc.Text = ds1.Tables[0].Rows[0]["proj_desc"].ToString();
                    txt_hour.Text = ds1.Tables[0].Rows[0]["total_hour"].ToString();
                    txt_cost.Text = ds1.Tables[0].Rows[0]["cost"].ToString();
                    dd_status.SelectedValue = ds1.Tables[0].Rows[0]["workstatus"].ToString();
                    string sDay;
                    string sMonthe;




                    DateTime strdate = (Convert.ToDateTime(ds1.Tables[0].Rows[0]["submeted_on"]));


                    txt_submitedon.Text = String.Format("{0:MM/dd/yyyy}", strdate);
                    if (txt_submitedon.Text.Contains("-"))
                    {
                        txt_submitedon.Text = txt_submitedon.Text.Replace("-", "/");
                    }


                    //string strdate = ds1.Tables[0].Rows[0]["submeted_on"].ToString().Replace(" 12:00:00 AM", "");
                    //string[] sDate = strdate.Split('/');
                    //if (sDate[0].Length == 1)
                    //    sDay = "0" + sDate[0];
                    //else
                    //    sDay = sDate[0];
                    //if (sDate[1].Length == 1)
                    //    sMonthe = "0" + sDate[1];
                    //else
                    //    sMonthe = sDate[1];
                    //strdate = sDay + '/' + sMonthe + '/' + sDate[2];
                    //txt_submitedon.Text = String.Format("{0:MM/dd/yyyy}", strdate);

                    string strMarketing = ds1.Tables[0].Rows[0]["asigned_per"].ToString();
                    string[] split = strMarketing.Split(new char[] { ',' });
                    int arrLenth = split.Length;
                    int aa = dd_developer.Items.Count;
                    for (int j = 0; j < arrLenth; j++)
                    {
                        for (int i = 0; i < aa; i++)
                        {
                            if (Convert.ToString(dd_developer.Items[i].Value) == split[j])
                            {
                                string[] col2 = { "@srno", "@proj_id", "@working_per", "@asignedby", "@Actiontype" };
                                object[] val2 = { "0", Request.QueryString["srno"].ToString().Trim(), split[j], ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select13" };
                                DataSet ds2 = dal.getDataSet("ManageProjDetails", col2, val2);
                                if (ds2.Tables[0].Rows.Count > 0)
                                {
                                    dd_developer.Items[i].Selected = true;
                                    dd_developer.Items[i].Enabled = false;
                                }
                                else
                                    dd_developer.Items[i].Selected = true;
                            }
                        }
                    }
                    btnsubmit.Text = "Update";

                    hdn.Value = Request.QueryString["srno"].ToString().Trim();
                    lblid.Text = Request.QueryString["srno"].ToString().Trim();
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
            if (Session["marketing_srno"] != null)
            {
                txt_srno.Text = "P-1";
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);
                txt_uid.Text = ds.Tables[0].Rows[0]["name"].ToString().Trim();

                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { "0", "select2" };
                DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    if (!string.IsNullOrEmpty(ds1.Tables[0].Rows[0]["maxid"].ToString()))
                    {
                        int count = Convert.ToInt32(ds1.Tables[0].Rows[0]["maxid"].ToString()) + 1;
                        txt_srno.Text = "P-" + count;
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
            //lblmsg.Text = ex.Message.ToString();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { Session["marketing_srno"].ToString().Trim(), "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);

                string[] col11 = { "@srno", "@proj_name", "@Actiontype" };
                object[] val11 = { lblid.Text.Trim(), txt_proj.Text.Trim(), "select3" };
                DataSet ds11 = dal.getDataSet("ManageProject", col11, val11);
                if (ds11.Tables[0].Rows.Count > 0)
                {
                    lblmsg.Text = "Project name already exists.";
                }
                else
                {
                    int count2 = 1;
                    string[] col1 = { "@srno", "@mp_id", "@Actiontype" };
                    object[] val1 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select1" };
                    DataSet ds1 = dal.getDataSet("ManageProject", col1, val1);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        count2 = Convert.ToInt32(ds1.Tables[0].Rows[0]["count1"].ToString());
                        if (count2 == 0)
                            count2 = 1;
                        else
                            count2 = Convert.ToInt32(ds1.Tables[0].Rows[0]["count1"].ToString()) + 1;
                    }
                    int srno = 1;
                    string[] col2 = { "@srno", "@mp_id", "@Actiontype" };
                    object[] val2 = { "0", ds.Tables[0].Rows[0]["user_id"].ToString().Trim(), "select2" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    if (ds2.Tables[0].Rows.Count > 0)
                    {
                        if (!string.IsNullOrEmpty(ds2.Tables[0].Rows[0]["maxid"].ToString()))
                            srno = Convert.ToInt32(ds2.Tables[0].Rows[0]["maxid"].ToString()) + 1;
                        if (srno == 0)
                            srno = 1;
                    }
                    string p_id = ds.Tables[0].Rows[0]["user_id"].ToString().Replace("m", "") + "-" + count2 + "-" + srno;

                    string developer = string.Empty;
                    int mm = dd_developer.Items.Count;
                    for (int index1 = 0; index1 < mm; index1++)
                    {
                        if (dd_developer.Items[index1].Selected == true)
                        {
                            developer = developer.Trim() + dd_developer.Items[index1].Value + ",";
                        }
                    }
                    developer = developer.Remove(developer.Length - 1);
                    if (!string.IsNullOrEmpty(developer))
                    {

                        //For datetime entry start
                        string[] subDate1 = txt_date.Text.Split('-');
                        string[] subDate2 = subDate1[2].Split(' ');
                        string[] subDate3 = subDate2[1].Split(':');
                        DateTime dt = new DateTime(Convert.ToInt32(subDate1[0]), Convert.ToInt32(subDate2[0]), Convert.ToInt32(subDate1[1]), Convert.ToInt32(subDate3[0]), Convert.ToInt32(subDate3[1]), Convert.ToInt32(subDate3[2]));
                        //For datetime entry start

                        //For multiselect dropdown start
                        string typeprojecetids = "";
                        foreach (ListItem item in dd_type.Items)
                        {
                            if (item.Selected)
                            {
                                typeprojecetids += item.Value + ",";
                            }
                        }
                        typeprojecetids = typeprojecetids.TrimEnd(',');
                        //For multiselect dropdown end


                        if (btnsubmit.Text == "Submit")
                        {
                            string[] col3 = { "@srno", "@p_srno", "@proj_id", "@mp_id", "@clientname", "@clientmobile", "@clientemail", "@clientcompany", "@clientadd", "@type_proj", "@proj_name", "@ddate", "@proj_desc", "@total_hour", "@submeted_on", "@asigned_per", "@Remark", "@cost", "@workstatus", "@proj_source", "@project_technology", "@Actiontype" };
                            //object[] val3 = { "0", txt_srno.Text.Trim(), p_id, ds.Tables[0].Rows[0]["user_id"].ToString(), txt_clientname.Text.Trim(), txt_clientmobile.Text.Trim(), txt_clientemail.Text.Trim(), txt_clientcompany.Text.Trim(), txt_clientadd.Text.Trim(), dd_type.SelectedValue, txt_proj.Text.Trim(), Request.Form[txt_date.UniqueID], txt_desc.Text.Trim(), txt_hour.Text.Trim(), Request.Form[txt_submitedon.UniqueID], developer, "", txt_cost.Text.Trim(), dd_status.SelectedValue, txt_referance.Text.Trim(), dd_technology.SelectedValue, "add1" };

                            object[] val3 = { "0", txt_srno.Text.Trim(), p_id, ds.Tables[0].Rows[0]["user_id"].ToString(), txt_clientname.Text.Trim(), txt_clientmobile.Text.Trim(), txt_clientemail.Text.Trim(), txt_clientcompany.Text.Trim(), txt_clientadd.Text.Trim(), typeprojecetids, txt_proj.Text.Trim(), dt, txt_desc.Text.Trim(), txt_hour.Text.Trim(), Request.Form[txt_submitedon.UniqueID], developer, "", txt_cost.Text.Trim(), dd_status.SelectedValue, txt_referance.Text.Trim(), dd_technology.SelectedValue, "add1" };

                            int i = dal.execute("ManageProject", col3, val3);
                            if (i == 1)
                                lblmsg.Text = "Data Save Successfuly.";
                        }
                        else
                        {
                            string[] col4 = { "@srno", "@p_srno", "@proj_id", "@mp_id", "@clientname", "@clientmobile", "@clientemail", "@clientcompany", "@clientadd", "@type_proj", "@proj_name", "@ddate", "@proj_desc", "@total_hour", "@submeted_on", "@asigned_per", "@Remark", "@cost", "@workstatus", "@proj_source", "@project_technology", "@Actiontype" };
                            //object[] val4 = { lblid.Text.Trim(), txt_srno.Text.Trim(), p_id, ds.Tables[0].Rows[0]["user_id"].ToString(), txt_clientname.Text.Trim(), txt_clientmobile.Text.Trim(), txt_clientemail.Text.Trim(), txt_clientcompany.Text.Trim(), txt_clientadd.Text.Trim(), dd_type.SelectedValue, txt_proj.Text.Trim(), Request.Form[txt_date.UniqueID], txt_desc.Text.Trim(), txt_hour.Text.Trim(), Request.Form[txt_submitedon.UniqueID], developer, "", txt_cost.Text.Trim(), dd_status.SelectedValue, txt_referance.Text.Trim(), dd_technology.SelectedValue, "update1" };
                            object[] val4 = { lblid.Text.Trim(), txt_srno.Text.Trim(), p_id, ds.Tables[0].Rows[0]["user_id"].ToString(), txt_clientname.Text.Trim(), txt_clientmobile.Text.Trim(), txt_clientemail.Text.Trim(), txt_clientcompany.Text.Trim(), txt_clientadd.Text.Trim(), typeprojecetids, txt_proj.Text.Trim(), dt, txt_desc.Text.Trim(), txt_hour.Text.Trim(), Request.Form[txt_submitedon.UniqueID], developer, "", txt_cost.Text.Trim(), dd_status.SelectedValue, txt_referance.Text.Trim(), dd_technology.SelectedValue, "update1" };
                            int i = dal.execute("ManageProject", col4, val4);
                            if (i == 1)
                                lblmsg.Text = "Data Update Successfuly.";
                        }
                        dal.ClearControls(this);
                        txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                        txt_submitedon.Text = "";
                        txt_srno.Text = "";
                        dd_status.ClearSelection();
                        CountProject();
                        BindCheckBoxList();
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "KeyMsg", "alert('Please Select Developer Person.');", true);
                    }
                    if (btnsubmit.Text == "Update")
                    {
                        btnsubmit.Text = "Submit";
                        string strURL = "marketingmain.aspx";
                        ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert(' Data Update Successfully. ');window.location='" + strURL + "';", true);
                    }
                    else
                    {
                        //lblmsg.Text = "Data Save Successfuly.";
                        ClientScript.RegisterStartupScript(Page.GetType(), "alert", "alert(' Data Save Successfully. ');window.location='add_project.aspx';", true);
                    }
                    //Response.Redirect(Request.Url.AbsoluteUri);
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
            if (Session["marketing_srno"] != null)
            {
                Response.Redirect("add_project.aspx");
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

    private void BindCheckBoxList()
    {
        if (Session["marketing_srno"] != null)
        {
            string[] col = { "@srno", "@Actiontype" };
            object[] val = { "0", "select2" };
            DataSet ds = dal.getDataSet("ManageLogin", col, val);
            if (ds.Tables[0].Rows.Count > 0)
            {
                dd_developer.DataSource = ds.Tables[0];
                dd_developer.DataTextField = "name";
                dd_developer.DataValueField = "user_id";
                dd_developer.DataBind();
            }

            string[] col3 = { "@srno", "@Actiontype" };
            object[] val3 = { Session["marketing_srno"].ToString().Trim(), "select3" };
            DataSet ds3 = dal.getDataSet("ManageLogin", col3, val3);
            string Actiontype = "select3";
            if (ds3.Tables[0].Rows[0]["user_id"].ToString().Trim() == "m01")
                Actiontype = "select";

            string[] col2 = { "@srno", "@ProjectType", "@Actiontype" };
            object[] val2 = { "0", "0", Actiontype };
            DataSet ds2 = dal.getDataSet("ManageProjectType", col2, val2);
            if (ds2.Tables[0].Rows.Count > 0)
            {
                dd_type.DataSource = ds2.Tables[0];
                dd_type.DataTextField = "ProjectType";
                dd_type.DataValueField = "srno";
                dd_type.DataBind();

                //dd_type.Items.Insert(0, new ListItem("Select Type", "0"));

            }
            string[] col4 = { "@srno", "@ProjectTechnologyN", "@Actiontype" };
            object[] val4 = { "0", "0", Actiontype };
            DataSet ds4 = dal.getDataSet("ManageProjectTechnology", col4, val4);
            if (ds4.Tables[0].Rows.Count > 0)
            {
                dd_technology.DataSource = ds4.Tables[0];
                dd_technology.DataTextField = "TechnologyName";
                dd_technology.DataValueField = "srno";
                dd_technology.DataBind();
                dd_technology.Items.Insert(0, new ListItem("Select Technology", "0"));
            }
        }
    }

    protected void linkbAddMore_Click(object sender, EventArgs e)
    {
        string[] col = { "@srno", "@ProjectType", "@Actiontype" };
        object[] val = { "0", txttype.Text.Trim(), "select1" };
        DataSet ds = dal.getDataSet("ManageProjectType", col, val);
        if (ds.Tables[0].Rows.Count > 0)
            lblmsg2.Text = "Project Type Already Exists.";
        else
        {
            string[] col2 = { "@srno", "@ProjectType", "@Actiontype" };
            object[] val2 = { "0", "0", "select2" };
            DataSet ds2 = dal.getDataSet("ManageProjectType", col2, val2);
            int intSrno = 1;
            if (ds2.Tables[0].Rows.Count > 0)
            {
                if (ds2.Tables[0].Rows[0]["srno"].ToString().Trim() != null && ds2.Tables[0].Rows[0]["srno"].ToString().Trim() != "")
                    intSrno = Convert.ToInt32(ds2.Tables[0].Rows[0]["srno"].ToString().Trim()) + 1;
            }
            string[] col1 = { "@srno", "@ProjectType", "@Actiontype" };
            object[] val1 = { intSrno, txttype.Text.Trim(), "add" };
            int i = dal.execute("ManageProjectType", col1, val1);
            if (i == 1)
                lblmsg2.Text = "Data Save Successfuly.";
            txttype.Text = "";
            BindCheckBoxList();
        }
    }
    protected void linkaddtechnology_Click(object sender, EventArgs e)
    {
        string[] col = { "@srno", "@ProjectTechnologyN", "@Actiontype" };
        object[] val = { "0", txttechnology.Text.Trim(), "select1" };
        DataSet ds = dal.getDataSet("ManageProjectTechnology", col, val);
        if (ds.Tables[0].Rows.Count > 0)
            lblmsg3.Text = "Project Type Already Exists.";
        else
        {
            string[] col2 = { "@srno", "@ProjectTechnologyN", "@Actiontype" };
            object[] val2 = { "0", "0", "select2" };
            DataSet ds2 = dal.getDataSet("ManageProjectTechnology", col2, val2);
            int intSrno = 1;
            if (ds2.Tables[0].Rows.Count > 0)
            {
                if (ds2.Tables[0].Rows[0]["srno"].ToString().Trim() != null && ds2.Tables[0].Rows[0]["srno"].ToString().Trim() != "")
                    intSrno = Convert.ToInt32(ds2.Tables[0].Rows[0]["srno"].ToString().Trim()) + 1;
            }
            string[] col1 = { "@srno", "@ProjectTechnologyN", "@Actiontype" };
            object[] val1 = { intSrno, txttechnology.Text.Trim(), "add" };
            int i = dal.execute("ManageProjectTechnology", col1, val1);
            if (i == 1)
                lblmsg3.Text = "Data Save Successfuly.";
            txttechnology.Text = "";
            BindCheckBoxList();
        }
    }
}