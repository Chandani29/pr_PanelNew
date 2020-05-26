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
            btnsubmits.Visible = false;
            BinddropdownList();
        }
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
        ddlusers.Items.Insert(0, new ListItem("All", "0"));
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int User_Id = int.Parse(ddlusers.SelectedValue);
        bindDoneReminders(User_Id, DateTime.Parse(txt_from.Text));
        Session["User_Id"] = User_Id;
        Session["Update_Date"] = txt_from.Text;
        lblMsg.Text = "";
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
                string notsayGoodNight = "";

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
                        string ComingMessage = "";
                        string GoingMessage = "";
                        string status = "";
                        string comingtime1 = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate, out ComingMessage, out GoingMessage, out status) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate, out ComingMessage, out GoingMessage, out status)).ToString("HH:mm TT");
                        string Date = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate, out ComingMessage, out GoingMessage, out status) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate, out ComingMessage, out GoingMessage, out status)).ToString("dddd, dd MMMM yyyy"); ;
                        string GoingTime1 = goingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), StartDate);

                        strDoneReminders += "<table class='table table-bordered cart_summary' id='missAttendance'> <thead><tr>";
                        strDoneReminders += " <th style='text-align: left;'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</th>";
                        strDoneReminders += "<th align='right'>Timing</th><th align='right'>Messages :</th></tr> </thead>";
                        strDoneReminders += "<tbody>";

                        strDoneReminders += "<tr>";
                        strDoneReminders += "<td><strong>Good Morning</strong></td>";
                        strDoneReminders += "<td><input type='time' id='comingTime' name='Coming_Time' value=" + comingtime1 + " required>" + "</td><td><textarea Columns='50' width='200' Rows='3' name='ComingMessage'>" + ComingMessage + "</textarea></td></tr>";

                        strDoneReminders += "<tr>";
                        strDoneReminders += "<td><strong> Good Night</strong></td>";
                        //if (GoingTime1 == "")
                        //{
                        //    notsayGoodNight = "User not say good night";
                        //}
                        strDoneReminders += "<td>" + notsayGoodNight + "<input type='time' id='goingTime' name='Going_Time' value=" + GoingTime1 + " required>" +
                            "</td><td><textarea Columns='50' width='200' Rows='3' name='GoodNightMesssage'>" + GoingMessage + "</textarea></td><tr>";

                        string[] col2 = { "@Id", "@User_Id", "@ByTime", "@Actiontype" };
                        object[] val2 = { "0", ds.Tables[0].Rows[j]["srno"], StartDate, "select7" };
                        DataSet ds2 = dal.getDataSet("TimeCalculator", col2, val2);
                        for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
                        {

                            strDoneReminders += "<tr><td>" + ds2.Tables[0].Rows[k]["Status"].ToString() + "</td>";
                            //string status = "";
                            string CmpPor = "";

                            strDoneReminders += "<td>" + DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("h:mm tt") + "</td>";
                            strDoneReminders += "<td></td></tr>";


                        }

                        strDoneReminders += "</tbody>";
                        strDoneReminders += "</table>";
                        DoneReminders += strDoneReminders;
                        if (((GoingTime1 == "" && (status == "Come" || status == "")) || comingtime1 == ""))
                        {
                            btnsubmits.Visible = true;
                        }
                        else
                        {
                            btnsubmits.Visible = false;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }


    protected void btnsubmits_Click(object sender, EventArgs e)
    {
        if (Session["User_Id"] == null)
        {
            Response.Redirect("~/Pr-Admin-Log");
        }
        int User_Id = int.Parse(Session["User_Id"].ToString());
        DateTime Date = DateTime.Parse(Session["Update_Date"].ToString());
        string Coming_Time = Request.Form["Coming_Time"];
        string GoodMorningMesssage = Request.Form["GoodMorningMesssage"];
        string GoodNightMesssage = Request.Form["GoodNightMesssage"];
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
            string[] col = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Status", "@ByDate", "@Coming_Message", "@Going_Message", "@Actiontype" };
            object[] val = { 0, User_Id, Coming_Date, Going_Date, "Go", Coming_Date, GoodMorningMesssage, GoodNightMesssage, "update4" };
            int i = dal.execute("ManageAttendance", col, val);
            if (i == 1)
            {
                bindDoneReminders(User_Id, Date);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Missing attandance updated";
            }
        }
        else
        {
            string[] col = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Coming_Message", "@Going_Message", "@Status", "@isMeetingGoodMorning", "@Actiontype" };
            object[] val = { 0, User_Id, Coming_Date, Going_Date, GoodMorningMesssage, GoodNightMesssage, "Go", 0, "Insert1" };
            int i = dal.execute("ManageAttendance", col, val);
            if (i == 1)
            {
                bindDoneReminders(User_Id, Date);
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Missing attandance updated";
            }
        }
    }


    [System.Web.Services.WebMethod]
    public static string UpdateGoodNight(string time, string date, string user)
    {

        //int User_Id = int.Parse(user);
        //DateTime Date = DateTime.Parse(date);
        //string Going_Time = time;

        //string OnlyDate = Date.ToString();
        //string Coming_date = OnlyDate.Split(' ').ElementAt(0);


        //string Going_date = OnlyDate.Split(' ').ElementAt(0);
        //string Full_Going_Date = Going_date + " " + Going_Time;
        //DateTime Going_Date = DateTime.Parse(Full_Going_Date);


        //    string[] col = { "@Id", "@User_Id", "@ByDate", "@Going_Time", "@Coming_Message", "@Status", "@isMeetingGoodMorning", "@Actiontype" };
        //    object[] val = { 0, User_Id, Going_Date, Going_Date, "", "Go", 0, "nightU" };
        //    int i = dal.execute("ManageAttendance", col, val);
        //    if (i == 1)
        //    {

        //    }
        //}
        return "Hello ";
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
    private string comingtime(int User_Id, DateTime date, out string comingMessage, out string GoingMessage, out string status)
    {
        ComingTime = "";
        comingMessage = "";
        GoingMessage = "";
        status = "";
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
                               ComingMessage = dr["Coming_Message"].ToString(),
                               GoingMessage = dr["Going_Message"].ToString(),
                           }).ToList();

            var LastUpdateDate = (from c in listdt1 select c).FirstOrDefault();
            ComingTime = LastUpdateDate.Coming_Time.ToString();
            comingMessage = LastUpdateDate.ComingMessage;        
            GoingMessage = LastUpdateDate.GoingMessage;
            status = LastUpdateDate.Status;
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
        public string ComingMessage { get; set; }
        public string GoingMessage { get; set; }
        public string Company_Purpose { get; set; }
        public string Spend_time { get; set; }
        public DateTime Coming_Time { get; set; }
        public DateTime Going_Time { get; set; }
    }
}
