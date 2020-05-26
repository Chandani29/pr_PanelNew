using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string srno = "P-1";
    public string TimeSpend = "0"; 
    public string ComingTime = ""; 
    public string GoingTime = "";
    public string Outside = string.Empty;
    public string DoneReminders = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");

            BinddropdownList();
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int User_Id = int.Parse(ddlusers.SelectedValue);
        bindDoneReminders(User_Id, DateTime.Parse(txt_from.Text));
        Session["User_Id"] = User_Id;
        Session["Update_Date"] = txt_from.Text;
    }
    private void BinddropdownList()
    {
        string[] col1 = { "@srno", "@Actiontype" };
        object[] val1 = { "0", "bindUser" };
        DataSet ds1 = dal.getDataSet("ManageLogin", col1, val1);
        if (ds1.Tables[0].Rows.Count > 0)
        {
            ddlusers.DataSource = ds1.Tables[0];
            ddlusers.DataTextField = "name";
            ddlusers.DataValueField = "srno";
            ddlusers.DataBind();
        } 
        ddlusers.Items.Insert(0, new ListItem("Select Employee", "0"));
    }
    private void bindDoneReminders(int User_Id, DateTime StartDate)
    {
        try
        {
            DoneReminders = "";
            if (Session["admin_srno"] != null)
            {
                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { User_Id, "select9" };
                DataSet ds = dal.getDataSet("ManageLogin", col1, val1);


                var list = new List<SqlParameter>();
                list.Add(new SqlParameter("@Id", "0"));
                list.Add(new SqlParameter("@StartDate", StartDate));
                list.Add(new SqlParameter("@User_Id", User_Id));
                list.Add(new SqlParameter("@Actiontype", "select11"));

                DataTable dt = dal.getdataTable("TimeCalculator", list.ToArray());

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strDoneReminders = string.Empty;
                    for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                    {
                        string comingtime1 = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate)).ToString("HH:mm TT");
                        string Date = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate)).ToString("dddd, dd MMMM yyyy"); ;
                        string GoingTime1 = goingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate);
                        strDoneReminders += "<table class='table table-bordered cart_summary'> <thead><tr>";
                        strDoneReminders += " <th style='text-align: left;'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</th>";
                        strDoneReminders += "<th align='right'>Coming Time :</th><th> <input type='time' id='appt' name='Coming_Time' value=" + comingtime1 + " required>(" + Date + ")</th></tr> </thead>";
                        strDoneReminders += "<tbody>";
                        btnupdate.Visible = true; 
                        if (dt.Rows.Count > 0)
                        {

                            var listdt1 = (from DataRow dr in dt.Rows
                                           select new MyModelClass()
                                           {
                                               Id = Convert.ToInt32(dr["Id"]),
                                               Company_Purpose = dr["Company_Purpose"].ToString(),
                                               Spend_time = dr["Spend_time"].ToString(),
                                               User_Id = Convert.ToInt32(dr["User_Id"]),
                                               Status = dr["Status"].ToString(),
                                               Timing = Convert.ToDateTime(dr["Timing"].ToString()),
                                           }).ToList(); 

                            var list1 = listdt1.GroupBy(n => new { n.Timing }).Select(g => g.FirstOrDefault()).ToList();
                             

                            foreach (var item in list1)
                            {
                                string Time = BindSpendTime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing);  
                                string[] col2 = { "@Id", "@User_Id", "@Actiontype" };
                                object[] val2 = { "0", ds.Tables[0].Rows[j]["srno"], "Select1" };
                                DataSet ds2 = dal.getDataSet("TimeCalculator", col2, val2);
                                for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
                                {
                                    if (item.Timing.ToString("MM/dd/yyyy") == DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("MM/dd/yyyy"))
                                    {
                                        strDoneReminders += "<tr><td>&nbsp;</td>";
                                        strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + "</td>";
                                        strDoneReminders += "<td><input type='time' id='appt' name='Out_In' value=" + DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("HH:mm TT", CultureInfo.InvariantCulture) + " required></td>";
                                        strDoneReminders += "<td><input  type='hidden' name='Out_In_Id' value=" + ds2.Tables[0].Rows[k]["Id"] + "></td></tr>";

                                        //strDoneReminders += "<td><input type='button' value='Update' onclick='updateoutin(" + ds2.Tables[0].Rows[k]["Id"] + "," + DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("HH:mm TT", CultureInfo.InvariantCulture) + ")'></td>";
                                    }
                                }
                                strDoneReminders += "<tr><td>&nbsp;</td>";
                                strDoneReminders += "<td><strong> Total time spend</strong></td>";
                                strDoneReminders += "<td>" + Time + " mins</td></tr>";


                            }

                        }
                         
                            strDoneReminders += "<tr><td>&nbsp;</td>";
                            strDoneReminders += "<td><strong> Going Time</strong></td>";
                            strDoneReminders += "<td><input type='time' id='appt' name='Going_Time' value=" + GoingTime1 + " required></td></tr> ";
                        
                        strDoneReminders += "</tbody>";
                        strDoneReminders += "</table>";
                        DoneReminders += strDoneReminders;
                    }
                }
            }
        }
        catch (Exception ex)
        {

        } 
    } 

    protected void foo_OnClick(object sender, EventArgs e)
    {
        btnsubmit.Visible = false;
        int i = 0;
        var list = new List<SqlParameter>();
        list.Add(new SqlParameter("@Id", "0"));
        list.Add(new SqlParameter("@User_Id", 0));
        list.Add(new SqlParameter("@Actiontype", "select1"));
    }
    private string BindSpendTime(int User_Id, DateTime date)
    {

        double TotalTime = 0;
        TimeSpend = "0";
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
                if (item.Timing.ToString("MM/dd/yyyy").Equals(date.ToString("MM/dd/yyyy")))
                {
                    TotalTime = TotalTime + double.Parse(item.Spend_time);
                }
            }
            TimeSpend = (TotalTime / 60).ToString("N0");
        }
        return TimeSpend;
    }
    private string comingtime(int User_Id, DateTime date)
    {
        ComingTime = "";
        var list = new List<SqlParameter>();
        list.Add(new SqlParameter("@Id", "0"));
        list.Add(new SqlParameter("@ByDate", date));

        list.Add(new SqlParameter("@User_Id", User_Id));
        list.Add(new SqlParameter("@Actiontype", "Select3"));
        DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
        if (dt.Rows.Count > 0)
        {
            var listdt1 = (from DataRow dr in dt.Rows
                           select new MyModelClass()
                           {
                               Id = Convert.ToInt32(dr["Id"]),
                               Coming_Time = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                               Going_Time = Convert.ToDateTime(dr["Going_Time"].ToString()),
                               User_Id = Convert.ToInt32(dr["User_Id"]),
                               Status = dr["Status"].ToString(),
                           }).ToList();

            var LastUpdateDate = (from c in listdt1 select c).FirstOrDefault();
            ComingTime = LastUpdateDate.Coming_Time.ToString();
        }
        return ComingTime;
    }
    private string goingtime(int User_Id, DateTime date) 
    {
        GoingTime = "";
        var list = new List<SqlParameter>();
        list.Add(new SqlParameter("@Id", "0"));
        list.Add(new SqlParameter("@ByDate", date));
        list.Add(new SqlParameter("@User_Id", User_Id));
        list.Add(new SqlParameter("@Actiontype", "Select3"));
        DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
        if (dt.Rows.Count > 0)
        {
            var listdt1 = (from DataRow dr in dt.Rows
                           select new MyModelClass()
                           {
                               Id = Convert.ToInt32(dr["Id"]),
                               Coming_Time = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                               Going_Time = Convert.ToDateTime(dr["Going_Time"].ToString()),
                               User_Id = Convert.ToInt32(dr["User_Id"]),
                               Status = dr["Status"].ToString(),
                           }).ToList();

            var LastUpdateDate = (from c in listdt1 where c.Status == "Go" select c).FirstOrDefault();
            if (LastUpdateDate != null)
            {
                GoingTime = LastUpdateDate.Going_Time.ToString("HH:mm TT");
            }
        }
        return GoingTime;
    }
    class MyModelClass
    {
        public int Id { get; set; }
        public int User_Id { get; set; }
        public DateTime Timing { get; set; }
        public string Status { get; set; }
        public string Company_Purpose { get; set; }
        public string Spend_time { get; set; }
        public DateTime Coming_Time { get; set; }
        public DateTime Going_Time { get; set; }
    }
    protected void btnupdate_Click(object sender, EventArgs e)
    {
        if(Session["User_Id"] == null)
        {
            Response.Redirect("~/Pr-Admin-Log");
        }
        int User_Id = int.Parse(Session["User_Id"].ToString());
        DateTime Date = DateTime.Parse(Session["Update_Date"].ToString());
        string Coming_Time = Request.Form["Coming_Time"];
        string Going_Time = ((Request.Form["Going_Time"] == null) ? Coming_Time : Request.Form["Going_Time"]);

        string OnlyDate = Date.ToString();
        string Coming_date = OnlyDate.Split(' ').ElementAt(0); 

        string Full_Coming_Date = Coming_date + " " + Coming_Time;
        DateTime Coming_Date = DateTime.Parse(Full_Coming_Date);


        string Going_date = OnlyDate.Split(' ').ElementAt(0);
        string Full_Going_Date = Going_date + " " + Going_Time;
        DateTime Going_Date = DateTime.Parse(Full_Going_Date);

        string[] col5 = { "@Id", "@User_Id", "@ByDate", "@Actiontype" };
        object[] val5 = { 0, User_Id, Coming_Date, "Select3" };
        DataSet ds5 = dal.getDataSet("ManageAttendance", col5, val5);
        if (ds5.Tables[0].Rows.Count > 0)
        {
            string[] col = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@ByDate", "@Actiontype" };
            object[] val = { 0, User_Id, Coming_Date, Going_Date, Coming_Date, "update3" };
            int i = dal.execute("ManageAttendance", col, val);
            if (i == 1)
            {
                 
            } 
        }
        else
        {
            string[] col = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Coming_Message", "@Status", "@isMeetingGoodMorning", "@Actiontype" };
            object[] val = { 0, User_Id, Coming_Date, Going_Date,"","Go", 0, "Insert1" };
            int i = dal.execute("ManageAttendance", col, val);
            if (i == 1)
            {

            }
        } 
       
        if (Request.Form["Out_In"] != null)
        {
            string[] Out_In = Request.Form["Out_In"].Split(',');


            string[] Out_In_Id = Request.Form["Out_In_Id"].Split(',');

            string[] Product_Id = Out_In_Id;

            int j = 0;
            foreach (var item in Out_In_Id)
            {
                if (Out_In_Id[j] != "")
                {
                    string Timing_date = OnlyDate.Split(' ').ElementAt(0);
                    string Full_Timing_Date = Timing_date + " " + Out_In[j];
                    DateTime Timing_Date = DateTime.Parse(Full_Timing_Date);

                    string[] col1 = { "@Id", "@Timing", "@Spend_time", "@Actiontype" };
                    object[] val1 = { int.Parse(Out_In_Id[j]), Timing_Date, "0", "updateData" };
                    int k = dal.execute("TimeCalculator", col1, val1);
                    if (k == 1)
                    { 
                         
                    }
                }
                j = j + 1;
            }
            double totalSec = 0;
            var list = new List<SqlParameter>();
            list.Add(new SqlParameter("@Id", "0"));
            list.Add(new SqlParameter("@ByTime", Date));
            list.Add(new SqlParameter("@User_Id", User_Id));
            list.Add(new SqlParameter("@Actiontype", "select7"));
            DataTable dt = dal.getdataTable("TimeCalculator", list.ToArray());
            if (dt.Rows.Count > 0)
            {
                var listdt1 = (from DataRow dr in dt.Rows
                               select new MyModelClass()
                               {
                                   Id = Convert.ToInt32(dr["Id"]),
                                   Company_Purpose = dr["Company_Purpose"].ToString(),
                                   Spend_time = dr["Spend_time"].ToString(),
                                   User_Id = Convert.ToInt32(dr["User_Id"]),
                                   Status = dr["Status"].ToString(),
                                   Timing = Convert.ToDateTime(dr["Timing"].ToString()),
                               }).ToList();
                int m = 0, n = 0;
                if (listdt1 != null)
                {
                    n = n + 1;
                    foreach (var iten in listdt1)
                    {
                        if ((m == 0 || (m % 2 == 0)))
                        {
                            var FirstDate = (from c in listdt1 select c).ElementAt(m);
                            var LastDate = (from c in listdt1 select c).ElementAt(n);
                            if ((FirstDate != null) && (LastDate != null))
                            {
                                totalSec = totalSec + System.Math.Abs((FirstDate.Timing - LastDate.Timing).TotalSeconds);
                            }
                        }
                        m = m + 1;
                        n = n + 1;
                    }

                    string[] col3 = { "@Id", "@Spend_time", "@Actiontype" };
                    object[] val3 = { int.Parse(Out_In_Id[0]), totalSec.ToString(), "update2" };
                    int l = dal.execute("TimeCalculator", col3, val3);
                    if (l == 1)
                    {

                    }
                }
            }

        }
        bindDoneReminders(User_Id, Date);
        lblmsg.Text = "Update Success";

    } 
}