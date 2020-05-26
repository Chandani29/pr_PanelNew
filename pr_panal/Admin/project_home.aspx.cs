using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_project_home : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCheckBoxList();
        }
    }
    private void BindCheckBoxList()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col = { "@srno", "@Actiontype" };
                object[] val = { "0", "select3" };
                DataSet ds = dal.getDataSet("ManageLogin", col, val);
                dd_person.DataSource = ds.Tables[0];
                dd_person.DataTextField = "name";
                dd_person.DataValueField = "user_id";
                dd_person.DataBind();
                dd_person.Items.Insert(0, new ListItem("All", "0"));

                string[] col2 = { "@srno", "@Actiontype" };
                object[] val2 = { "0", "select11" };
                DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                lbProjectName.DataSource = ds2.Tables[0];
                lbProjectName.DataTextField = "proj_name";
                lbProjectName.DataValueField = "srno";
                lbProjectName.DataBind();
                lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                lbProjectName.Items.FindByValue("0").Selected = true;


                string[] col3 = { "@srno", "@ProjectType", "@Actiontype" };
                object[] val3 = { "0", "0", "select3" };
                DataSet ds3 = dal.getDataSet("ManageProjectType", col3, val3);
                if (ds3.Tables[0].Rows.Count > 0)
                {
                    ddprotype.DataSource = ds3.Tables[0];
                    ddprotype.DataTextField = "ProjectType";
                    ddprotype.DataValueField = "srno";
                    ddprotype.DataBind();
                    ddprotype.Items.Insert(0, new ListItem("Select Type", "0"));
                }
                string[] col4 = { "@srno", "@ProjectTechnologyN", "@Actiontype" };
                object[] val4 = { "0", "0", "select3" };
                DataSet ds4 = dal.getDataSet("ManageProjectTechnology", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    ddprotechnology.DataSource = ds4.Tables[0];
                    ddprotechnology.DataTextField = "TechnologyName";
                    ddprotechnology.DataValueField = "srno";
                    ddprotechnology.DataBind();
                    ddprotechnology.Items.Insert(0, new ListItem("Select Technology", "0"));
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
            if (Session["admin_srno"] != null)
            {
                //Response.Cookies["ProjectList"]["ProjectStatus"] = dd_type.SelectedValue;
                //Response.Cookies["ProjectList"]["MarketingPerson"] = dd_person.SelectedValue;
                Response.Cookies["ProjectList"]["ProjectName"] = lbProjectName.SelectedValue;
                Response.Cookies["ProjectList"].Expires = DateTime.Now.AddDays(1);
                Response.Redirect("project_list.aspx");
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
    protected void dd_type_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                if (dd_type.SelectedValue != "none")
                {
                    string[] col2 = { "@srno", "@workstatus", "@Actiontype" };
                    object[] val2 = { "0", dd_type.SelectedValue, "select12" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                else
                {
                    string[] col2 = { "@srno", "@Actiontype" };
                    object[] val2 = { "0", "select11" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    protected void dd_person_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                if (dd_type.SelectedValue != "none")
                {
                    if (dd_person.SelectedValue != "0")
                    {
                        string[] col2 = { "@srno", "@workstatus", "@mp_id", "@Actiontype" };
                        object[] val2 = { "0", dd_type.SelectedValue, dd_person.SelectedValue, "select13" };
                        DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                        lbProjectName.DataSource = ds2.Tables[0];
                        lbProjectName.DataTextField = "proj_name";
                        lbProjectName.DataValueField = "srno";
                        lbProjectName.DataBind();
                        lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                        lbProjectName.Items.FindByValue("0").Selected = true;
                    }
                    else
                    {
                        string[] col2 = { "@srno", "@workstatus", "@Actiontype" };
                        object[] val2 = { "0", dd_type.SelectedValue, "select12" };
                        DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                        lbProjectName.DataSource = ds2.Tables[0];
                        lbProjectName.DataTextField = "proj_name";
                        lbProjectName.DataValueField = "srno";
                        lbProjectName.DataBind();
                        lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                        lbProjectName.Items.FindByValue("0").Selected = true;
                    }
                }
                else if (dd_person.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@mp_id", "@Actiontype" };
                    object[] val2 = { "0", dd_person.SelectedValue, "select9" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                else
                {
                    string[] col2 = { "@srno", "@Actiontype" };
                    object[] val2 = { "0", "select11" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    protected void ddprotype_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                if (dd_person.SelectedValue == "0" && dd_type.SelectedValue == "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue == "0")
                {
                    string[] col2 = { "@srno", "@type_proj ", "@Actiontype" };
                    object[] val2 = { "0", ddprotype.SelectedValue, "select15" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue == "0" && dd_type.SelectedValue != "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue == "0")
                {
                    string[] col2 = { "@srno", "@type_proj", "@workstatus", "@Actiontype" };
                    object[] val2 = { "0", ddprotype.SelectedValue, dd_type.SelectedValue, "select17" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue != "0" && dd_type.SelectedValue == "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue == "0")
                {
                    string[] col2 = { "@srno", "@type_proj", "@mp_id", "@Actiontype" };
                    object[] val2 = { "0", ddprotype.SelectedValue, dd_person.SelectedValue, "select20" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue == "0" && dd_type.SelectedValue == "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@type_proj", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", ddprotype.SelectedValue, ddprotechnology.SelectedValue, "select21" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue == "0" && dd_type.SelectedValue != "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@workstatus", "@type_proj", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", dd_type.SelectedValue, ddprotype.SelectedValue, ddprotechnology.SelectedValue, "select22" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue != "0" && dd_type.SelectedValue == "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = {"@srno", "@mp_id", "@type_proj", "@project_technology", "@Actiontype"};
                    object[] val2 = {"0", dd_person.SelectedValue, ddprotype.SelectedValue, ddprotechnology.SelectedValue, "select23"};
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue != "0" && dd_type.SelectedValue != "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue == "0")
                {
                    string[] col2 = { "@srno", "@mp_id", "@type_proj", "@workstatus", "@Actiontype" };
                    object[] val2 = { "0", dd_person.SelectedValue, ddprotype.SelectedValue, dd_type.SelectedValue, "select24" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue != "0" && dd_type.SelectedValue != "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@mp_id", "@type_proj", "@workstatus", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", dd_person.SelectedValue, ddprotype.SelectedValue, dd_type.SelectedValue, ddprotechnology.SelectedValue, "select25" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
    protected void ddprotechnology_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                if (dd_person.SelectedValue == "0" && dd_type.SelectedValue == "none" && ddprotype.SelectedValue == "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@project_technology ", "@Actiontype" };
                    object[] val2 = { "0", ddprotechnology.SelectedValue, "select26" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue == "0" && dd_type.SelectedValue != "none" && ddprotype.SelectedValue == "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@workstatus", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", dd_type.SelectedValue, ddprotechnology.SelectedValue, "select27" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue != "0" && dd_type.SelectedValue == "none" && ddprotype.SelectedValue == "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@project_technology", "@mp_id", "@Actiontype" };
                    object[] val2 = { "0", ddprotechnology.SelectedValue, dd_person.SelectedValue, "select28" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue == "0" && dd_type.SelectedValue == "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@type_proj", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", ddprotype.SelectedValue, ddprotechnology.SelectedValue, "select21" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue == "0" && dd_type.SelectedValue != "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@workstatus", "@type_proj", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", dd_type.SelectedValue, ddprotype.SelectedValue, ddprotechnology.SelectedValue, "select22" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue != "0" && dd_type.SelectedValue == "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@mp_id", "@type_proj", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", dd_person.SelectedValue, ddprotype.SelectedValue, ddprotechnology.SelectedValue, "select23" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue != "0" && dd_type.SelectedValue != "none" && ddprotype.SelectedValue == "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@mp_id", "@type_proj", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", dd_person.SelectedValue, dd_type.SelectedValue, ddprotechnology.SelectedValue, "select29" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
                if (dd_person.SelectedValue != "0" && dd_type.SelectedValue != "none" && ddprotype.SelectedValue != "0" && ddprotechnology.SelectedValue != "0")
                {
                    string[] col2 = { "@srno", "@mp_id", "@type_proj", "@workstatus", "@project_technology", "@Actiontype" };
                    object[] val2 = { "0", dd_person.SelectedValue, ddprotype.SelectedValue, dd_type.SelectedValue, ddprotechnology.SelectedValue, "select25" };
                    DataSet ds2 = dal.getDataSet("ManageProject", col2, val2);
                    lbProjectName.DataSource = ds2.Tables[0];
                    lbProjectName.DataTextField = "proj_name";
                    lbProjectName.DataValueField = "srno";
                    lbProjectName.DataBind();
                    lbProjectName.Items.Insert(0, new ListItem("Select Type", "0"));
                    lbProjectName.Items.FindByValue("0").Selected = true;
                }
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message.ToString();
        }
    }
}