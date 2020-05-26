using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class marketing_Default : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string TimeSpend = "0"; 
    public string DoneReminders = string.Empty;
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
        if (Session["marketing_srno"] == null)
        {
            Response.Redirect("~/Pr-Admin-Log");
        }
        BindSpendTime();
        BindData();
        if (!IsPostBack)
        {
            BindData();
            BindSpendTime();
            int User_Id = int.Parse(Session["marketing_srno"].ToString());
            var list = new List<SqlParameter>();
            list.Add(new SqlParameter("@Id", "0"));
            list.Add(new SqlParameter("@User_Id", User_Id));
            list.Add(new SqlParameter("@Actiontype", "select1"));
            DataTable dt = dal.getdataTable("TimeCalculator", list.ToArray());
            if (dt.Rows.Count > 0)
            {   
                var listdt1 = (from DataRow dr in dt.Rows
                               select new MyModelClass()
                               {
                                   Id = Convert.ToInt32(dr["Id"]),
                                   Timing = Convert.ToDateTime(dr["Timing"].ToString()),
                                   Company_Purpose = dr["Company_Purpose"].ToString(),
                                   Spend_time = dr["Spend_time"].ToString(),
                                   User_Id = Convert.ToInt32(dr["User_Id"]), 
                                   Status = dr["Status"].ToString(),
                               }).ToList();

                foreach (var item in listdt1)
                {
                    if (item.Timing.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy")) && item.Status == "Out")
                    {
                        btnout.Visible = false;
                        btncmp.Visible = false;

                        btnin.Visible = true;
                    }
                    else
                    {
                        btnout.Visible = true;
                        btncmp.Visible = true;
                        btnin.Visible = false;
                    }
                }
            }
            else
            {
                btnout.Visible = true;
                btncmp.Visible = true;
                btnin.Visible = false;
            }
        }
    } 
    protected void btncmp_Click(object sender, EventArgs e)
    {
        BindSpendTime();
        btncmp.Visible = false;
        btnout.Text = "Company Purpose";
        txtcomypor.Visible = true;
        btnhidetext.Visible = true;
    }
    private void BindData()
    {
        int User_Id = int.Parse(Session["marketing_srno"].ToString());
        DoneReminders = "";
        string[] col2 = { "@Id", "@User_Id", "@Actiontype" };
        object[] val2 = { "0", User_Id, "Select2" };
        DataSet ds2 = dal.getDataSet("TimeCalculator", col2, val2);
        if (ds2.Tables[0].Rows.Count > 0)
        {

              //<tr>
              //      <td width="199" align="right" class="Tab3"><strong><%# Eval("Status")%></strong></td>
              //      <td width="199" align="right" class="Tab3"><strong><%# Eval("Timing", "{0: h:mm tt}")%></strong></td>
              //  </tr>

            string strDoneReminders = string.Empty;
            for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
            {
                
                    strDoneReminders += "<tr>";
                    string status = "";
                    string CmpPor = "";
                    status = ds2.Tables[0].Rows[k]["Status"].ToString();
                    if (status == "In") 
                    {
                        CmpPor = ds2.Tables[0].Rows[k - 1]["Company_Purpose"].ToString();
                        if (CmpPor != "")
                        {
                            strDoneReminders += "<td width='199' align='right' class='Tab3'><strong>" + ds2.Tables[0].Rows[k]["Status"] + " (" + (double.Parse(ds2.Tables[0].Rows[k]["Company_Purpose_S_Time"].ToString()) / 60).ToString("N0") + " Mins Company purpose) </strong></td>";
                             
                        }
                        else
                        {
                            strDoneReminders += "<td width='199' align='right' class='Tab3'><strong>" + ds2.Tables[0].Rows[k]["Status"] + "</strong></td>"; 
                        }
                    }
                    else
                    {
                        strDoneReminders += "<td width='199' align='right' class='Tab3'><strong>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</strong></td>"; 
 
                    }
                    strDoneReminders += "<td width='199' align='right' class='Tab3'><strong>" + DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("h:mm tt") + " </strong></td>";

                    strDoneReminders += "</tr>";  
            }       
            DoneReminders += strDoneReminders;
        }


        //if (ds2.Tables[0].Rows.Count > 0)
        //{
        //    Repeater1.DataSource = ds2.Tables[0];
        //    Repeater1.DataBind(); 
        //}
    }
    private void BindSpendTime()
    {
        int User_Id = int.Parse(Session["marketing_srno"].ToString());
        double TotalTime = 0;
        var list = new List<SqlParameter>();
        list.Add(new SqlParameter("@Id", "0"));
        list.Add(new SqlParameter("@User_Id", User_Id));
        list.Add(new SqlParameter("@Actiontype", "select1"));
        DataTable dt = dal.getdataTable("TimeCalculator", list.ToArray());
        if (dt.Rows.Count > 0)
        {
            var listdt1 = (from DataRow dr in dt.Rows
                           select new MyModelClass()
                           {
                               Id = Convert.ToInt32(dr["Id"]),
                               Timing = Convert.ToDateTime(dr["Timing"].ToString()),
                               Company_Purpose = dr["Company_Purpose"].ToString(),
                               Spend_time = dr["Spend_time"].ToString(),
                               User_Id = Convert.ToInt32(dr["User_Id"]),
                               Status = dr["Status"].ToString(),
                           }).ToList();

            foreach (var item in listdt1)
            {
                if (item.Timing.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy")))
                {
                    TotalTime = TotalTime + double.Parse(item.Spend_time);
                }
            }

            TimeSpend = (TotalTime / 60).ToString("N0");
        }
    }
    class MyModelClass
    {
        public int Id { get; set; }
        public int User_Id { get; set; }
        public DateTime Timing { get; set; }
        public string Status { get; set; }
        public string Company_Purpose { get; set; }
        public string Spend_time { get; set; }
    }
    protected void btnout_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {  
                int User_Id = int.Parse(Session["marketing_srno"].ToString());  
                var list1 = new List<SqlParameter>();
                list1.Add(new SqlParameter("@Id", "0"));
                list1.Add(new SqlParameter("@User_Id", User_Id));
                list1.Add(new SqlParameter("@Actiontype", "Select2"));
                DataTable dt1 = dal.getdataTable("ManageAttendance", list1.ToArray()); 
                if (dt1.Rows.Count > 0)
                {
                    var listdt1 = (from DataRow dr in dt1.Rows
                                   select new MyModelClass()
                                   {
                                       Id = Convert.ToInt32(dr["Id"]),
                                       Timing = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                                       User_Id = Convert.ToInt32(dr["User_Id"]),
                                       Status = dr["Status"].ToString(),
                                   }).ToList();
                    if (listdt1.Count > 0)
                    {
                        string[] col1 = { "@Id", "@User_Id", "@Timing", "@Status", "@Spend_time", "@Company_Purpose", "Company_Purpose_S_Time", "@Actiontype" };

                        object[] val1 = { "0", User_Id, DateTime.Now, "Out", "0", txtcomypor.Text, "0", "Out" };
                        int i = dal.execute("TimeCalculator", col1, val1);
                        if (i == 1)
                            lblmsg.Text = "Data Save Successfuly.";
                        BindData();
                        Response.Redirect("OutsideInside.aspx");
                    }
                }
                else
                {
                    errormsg.Text = "Please say first good morning";
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
    protected void btnhidetext_Click(object sender, EventArgs e)
    {
        BindSpendTime();
        txtcomypor.Text = "";
        btnout.Text = " Out";
        btncmp.Visible = true;
        btnhidetext.Visible = false;
        txtcomypor.Visible = false; 
    }
    protected void btnin_Click(object sender, EventArgs e)
    {
        try
        { 
            if (Session["marketing_srno"] != null) 
            {
                DateTime OutSideGoingDate;
                double totalSec = 0;
                double CompanyPortotalSec = 0;
                int User_Id = int.Parse(Session["marketing_srno"].ToString());
                var list = new List<SqlParameter>();
                list.Add(new SqlParameter("@Id", "0")); 
                list.Add(new SqlParameter("@User_Id", User_Id));
                list.Add(new SqlParameter("@Actiontype", "select1"));
                DataTable dt = dal.getdataTable("TimeCalculator", list.ToArray());
                if (dt.Rows.Count > 0)
                {
                    var listdt1 = (from DataRow dr in dt.Rows
                                   select new MyModelClass() 
                                   {
                                       Id = Convert.ToInt32(dr["Id"]),
                                       Timing = Convert.ToDateTime(dr["Timing"].ToString()),
                                       Company_Purpose = dr["Company_Purpose"].ToString(),
                                       Spend_time = dr["Spend_time"].ToString(),
                                       User_Id = Convert.ToInt32(dr["User_Id"]), 
                                       Status = dr["Status"].ToString(),
                                   }).ToList();

                    var LastUpdateDate = (from c in listdt1 where c.Status == "Out" orderby c.Id descending select c).FirstOrDefault();
                    if (LastUpdateDate != null)
                    { 
                        if (LastUpdateDate.Company_Purpose != "")
                        {
                            totalSec = 0;
                            OutSideGoingDate = LastUpdateDate.Timing;
                            CompanyPortotalSec = System.Math.Abs((OutSideGoingDate - DateTime.Now).TotalSeconds);
                        }
                        else
                        {
                            OutSideGoingDate = LastUpdateDate.Timing;
                            totalSec = System.Math.Abs((OutSideGoingDate - DateTime.Now).TotalSeconds);
                        }
                    }
                }
                string[] col1 = { "@Id", "@User_Id", "@Timing", "@Status", "@Spend_time", "Company_Purpose","@Company_Purpose_S_Time", "@Actiontype" };

                object[] val1 = { "0", User_Id, DateTime.Now, "In", totalSec, "",CompanyPortotalSec, "In" };
                int i = dal.execute("TimeCalculator", col1, val1);
                if (i == 1)
                    lblmsg.Text = "Data Save Successfuly.";

                BindData();
                BindSpendTime();
                Response.Redirect("OutsideInside.aspx");
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