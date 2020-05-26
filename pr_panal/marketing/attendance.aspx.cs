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
    public string srno = "P-1";
    public string ComingTime = "";
    public string GoingTime = "";
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
        if (!IsPostBack)
        {
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
            comingtime();
            int User_Id = int.Parse(Session["marketing_srno"].ToString());
            var list = new List<SqlParameter>();
            list.Add(new SqlParameter("@Id", "0"));
            list.Add(new SqlParameter("@User_Id", User_Id));
            list.Add(new SqlParameter("@Actiontype", "select1"));
            DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
            if (dt.Rows.Count > 0)
            {
                var listdt1 = (from DataRow dr in dt.Rows
                               select new MyModelClass()
                               {
                                   Id = Convert.ToInt32(dr["Id"]),
                                   Going_Time = Convert.ToDateTime(dr["Going_Time"].ToString()),
                                   Coming_Time = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                                   User_Id = Convert.ToInt32(dr["User_Id"]),
                                   Status = dr["Status"].ToString(),
                                   Hr_Permission = Convert.ToBoolean(dr["Hr_Permission"].ToString()),
                                   numberOfMonth = Convert.ToInt32(dr["numberOfMonth"]),
                               }).ToList();

                foreach (var item in listdt1)
                {


                    if (Convert.ToDateTime(item.Going_Time).Ticks != Convert.ToDateTime(item.Coming_Time).Ticks && item.Status == "Come" && item.Hr_Permission == false)
                    {
                        btnmorning.Visible = false;
                        btnnight.Visible = false;
                        txtmsg.Visible = false;
                        btnmeetingmorning.Visible = false;
                        btnmeetingnight.Visible = false;
                        //txt_date.Visible = false;
                        if (item.Hr_Permission == false)
                            txtmsg1.Text = "Wait for manager's approval &#9995;";
                        else
                        {
                            txtmsg1.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                        }
                    }
                    else if (Convert.ToDateTime(item.Going_Time).Ticks == Convert.ToDateTime(item.Coming_Time).Ticks && item.Status == "Come" && !(item.Going_Time.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy"))))
                    {
                        txtmsg.Visible = true;
                        btnmorning.Visible = true;
                        btnnight.Visible = false;
                        btnmeetingmorning.Visible = true;
                        btnmeetingnight.Visible = false;
                    }

                    else if (item.Going_Time.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy")) && item.Status == "Come")
                    {
                        btnmorning.Visible = false;
                        txtmsg.Visible = true;
                        btnnight.Visible = true;

                        btnmeetingmorning.Visible = false;
                        btnmeetingnight.Visible = true;
                        txtmsg1.Text = "";

                    }
                    //else if (item.Going_Time.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy")) && item.Status == "Go")
                    //{
                    //    btnmorning.Visible = false; 
                    //    txtmsg.Visible = false;
                    //    btnnight.Visible = false;

                    //    btnmeetingmorning.Visible = false;
                    //    btnmeetingnight.Visible = false; 
                    //}
                    else if (item.Going_Time.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy")) && item.Status == "Go")
                    {
                        btnmorning.Visible = false;
                        btnnight.Visible = false;
                        txtmsg.Visible = false;
                        btnmeetingmorning.Visible = false;
                        btnmeetingnight.Visible = false;
                        //txt_date.Visible = false;
                        if (item.Hr_Permission == false)
                            txtmsg1.Text = "Wait for manager's approval &#9995;";
                        else
                        {
                            txtmsg1.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                        }
                    }
                    else
                    {
                        txtmsg.Visible = true;
                        btnmorning.Visible = true;
                        btnnight.Visible = false;
                        txtmsg1.Text = "";
                        btnmeetingmorning.Visible = true;
                        btnmeetingnight.Visible = false;
                    }
                }
            }
            else
            {
                txtmsg.Visible = true;
                btnmorning.Visible = true;
                btnnight.Visible = false;
                btnmeetingmorning.Visible = true;
                btnmeetingnight.Visible = false;
            }
        }
    }
    protected void btnmorning_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                int User_Id = int.Parse(Session["marketing_srno"].ToString());
                string[] col1 = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Status", "@Coming_Message", "@Actiontype" };
                object[] val1 = { "0", User_Id, DateTime.Now, DateTime.Now, "Come", txtmsg.Text, "Coming" };
                int i = dal.execute("ManageAttendance", col1, val1);
                if (i == 1)
                    lblmsg.Text = "Data Save Successfuly.";

                Response.Redirect("attendance.aspx");
                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
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
    protected void btnnight_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                int User_Id = int.Parse(Session["marketing_srno"].ToString());
                string Status = "";
                int Attendance_Id = 0;
                bool Hr_Permission = false;
                int numberOfMonth = 0;
                var list = new List<SqlParameter>();
                list.Add(new SqlParameter("@Id", "0"));
                list.Add(new SqlParameter("@User_Id", User_Id));
                list.Add(new SqlParameter("@Actiontype", "select1"));
                DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
                if (dt.Rows.Count > 0)
                {
                    var listdt1 = (from DataRow dr in dt.Rows
                                   select new MyModelClass()
                                   {
                                       Id = Convert.ToInt32(dr["Id"]),
                                       Going_Time = Convert.ToDateTime(dr["Going_Time"].ToString()),
                                       Coming_Time = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                                       User_Id = Convert.ToInt32(dr["User_Id"]),
                                       Status = dr["Status"].ToString(),
                                       Hr_Permission = Convert.ToBoolean(dr["Hr_Permission"].ToString()),
                                       numberOfMonth = Convert.ToInt32(dr["numberOfMonth"]),
                                   }).ToList();

                    if (listdt1.Count > 0)
                    {
                        var LastUpdateDate = (from c in listdt1 where c.Status == "Come" select c).FirstOrDefault();
                        Attendance_Id = LastUpdateDate.Id;
                        numberOfMonth = LastUpdateDate.numberOfMonth;
                    }
                }
                //if (Hr_Permission == false)
                //{
                //    lblmsg.Text = "Hr Not Give You Permission";
                //}
                //else
                //{
                if (Attendance_Id > 0)
                {
                    var list1 = new List<SqlParameter>();
                    list1.Add(new SqlParameter("@Id", "0"));
                    list1.Add(new SqlParameter("@User_Id", User_Id));
                    list1.Add(new SqlParameter("@Actiontype", "Select2"));
                    DataTable dt1 = dal.getdataTable("TimeCalculator", list1.ToArray());
                    if (dt1.Rows.Count > 0)
                    {
                        var listdt1 = (from DataRow dr in dt1.Rows
                                       select new MyModelClass()
                                       {
                                           Id = Convert.ToInt32(dr["Id"]),
                                           Going_Time = Convert.ToDateTime(dr["Timing"].ToString()),
                                           User_Id = Convert.ToInt32(dr["User_Id"]),
                                           Status = dr["Status"].ToString(),
                                       }).ToList();
                        if (listdt1.Count > 0)
                        {
                            var LastUpdateDate = (from c in listdt1 select c).LastOrDefault();
                            Status = LastUpdateDate.Status;
                            if (Status != "Out")
                            {
                                string[] col1 = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Status", "@Going_Message", "@Hr_Permission", "@Actiontype" };
                                // object[] val1 = { Attendance_Id, User_Id, DateTime.Now, DateTime.Now, ((numberOfMonth >= 10) ? "Go" : "Come"), txtmsg.Text, ((numberOfMonth >= 10) ? 1 : 0), "Going" };
                                object[] val1 = { Attendance_Id, User_Id, DateTime.Now, DateTime.Now, "Go", txtmsg.Text, 1, "Going" };

                                int i = dal.execute("ManageAttendance", col1, val1);
                                if (i == 1)
                                {
                                    btnnight.Visible = false;
                                    btnmeetingnight.Visible = false;
                                    lblmsg.Text = "";
                                    txtmsg.Visible = false;
                                    txtmsg1.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                                    //if (numberOfMonth >= 10)
                                    //{
                                    //    txtmsg1.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                                    //}
                                    //else
                                    //{

                                    //    txtmsg1.Text = "Wait for manager's approval &#9995;";
                                    //}
                                }
                                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                            }
                            else
                            {
                                lberror.Text = "Please Inside First";
                            }
                        }
                    }
                    else
                    {
                        string[] col1 = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Status", "@Going_Message", "@Hr_Permission", "@Actiontype" };
                        //object[] val1 = { Attendance_Id, User_Id, DateTime.Now, DateTime.Now, ((numberOfMonth >= 10) ? "Go" : "Come"), txtmsg.Text, ((numberOfMonth >= 10) ? 1 : 0), "Going" };
                        object[] val1 = { Attendance_Id, User_Id, DateTime.Now, DateTime.Now, "Go", txtmsg.Text, 1, "Going" };

                        int i = dal.execute("ManageAttendance", col1, val1);
                        if (i == 1)
                        {
                            btnnight.Visible = false;
                            btnmeetingnight.Visible = false;
                            lblmsg.Text = "";
                            txtmsg.Visible = false;
                            txtmsg1.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                            //if (numberOfMonth >= 10)
                            //{
                            //    txtmsg1.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                            //}
                            //else
                            //{

                            //    txtmsg1.Text = "Wait for manager's approval &#9995;";
                            //}
                        }
                        txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                    }
                }
                //}  
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
    class MyModelClass
    {
        public int Id { get; set; }
        public int User_Id { get; set; }
        public string Status { get; set; }
        public DateTime Coming_Time { get; set; }

        public bool Hr_Permission { get; set; }
        public DateTime Going_Time { get; set; }
        public int numberOfMonth { get; set; }
    }
    private void comingtime()
    {
        int User_Id = int.Parse(Session["marketing_srno"].ToString());
        var list = new List<SqlParameter>();
        list.Add(new SqlParameter("@Id", "0"));
        list.Add(new SqlParameter("@User_Id", User_Id));
        list.Add(new SqlParameter("@Actiontype", "Select2"));
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
            ComingTime = LastUpdateDate.Coming_Time.ToString("hh:mm tt");
            if (LastUpdateDate.Status == "Go")
            {
                GoingTime = "(Going Time" + LastUpdateDate.Going_Time.ToString("hh:mm tt") + ")";
            }
        }
    }
    protected void btnmeetingmorning_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string Full_Coming_Date = DateTime.Now.ToString().Split(' ').ElementAt(0) + " " + "10:00";
                DateTime Coming_Date = DateTime.Parse(Full_Coming_Date);
                int User_Id = int.Parse(Session["marketing_srno"].ToString());
                string[] col1 = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Status", "@Coming_Message", "@isMeetingGoodMorning", "@Actiontype" };
                object[] val1 = { "0", User_Id, Coming_Date, Coming_Date, "Come", txtmsg.Text, 1, "Coming" };
                int i = dal.execute("ManageAttendance", col1, val1);
                if (i == 1)
                    lblmsg.Text = "Data Save Successfuly.";


                Response.Redirect("attendance.aspx");
                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
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
    protected void btnmeetingnight_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["marketing_srno"] != null)
            {
                string Full_Coming_Date = DateTime.Now.ToString().Split(' ').ElementAt(0) + " " + "07:00";
                DateTime Going_Date = DateTime.Parse(Full_Coming_Date);

                int User_Id = int.Parse(Session["marketing_srno"].ToString());
                int Attendance_Id = 0;
                string Status = "";
                var list = new List<SqlParameter>();
                list.Add(new SqlParameter("@Id", "0"));
                list.Add(new SqlParameter("@User_Id", User_Id));
                list.Add(new SqlParameter("@Actiontype", "select1"));
                DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
                if (dt.Rows.Count > 0)
                {
                    var listdt1 = (from DataRow dr in dt.Rows
                                   select new MyModelClass()
                                   {
                                       Id = Convert.ToInt32(dr["Id"]),
                                       Going_Time = Convert.ToDateTime(dr["Going_Time"].ToString()),
                                       Coming_Time = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                                       User_Id = Convert.ToInt32(dr["User_Id"]),
                                       Status = dr["Status"].ToString(),
                                   }).ToList();

                    if (listdt1.Count > 0)
                    {
                        var LastUpdateDate = (from c in listdt1 where c.Status == "Come" select c).FirstOrDefault();
                        Attendance_Id = LastUpdateDate.Id;
                    }
                }
                if (Attendance_Id > 0)
                {
                    var list1 = new List<SqlParameter>();
                    list1.Add(new SqlParameter("@Id", "0"));
                    list1.Add(new SqlParameter("@User_Id", User_Id));
                    list1.Add(new SqlParameter("@Actiontype", "Select2"));
                    DataTable dt1 = dal.getdataTable("TimeCalculator", list1.ToArray());
                    if (dt1.Rows.Count > 0)
                    {
                        var listdt1 = (from DataRow dr in dt1.Rows
                                       select new MyModelClass()
                                       {
                                           Id = Convert.ToInt32(dr["Id"]),
                                           Going_Time = Convert.ToDateTime(dr["Timing"].ToString()),
                                           User_Id = Convert.ToInt32(dr["User_Id"]),
                                           Status = dr["Status"].ToString(),
                                       }).ToList();
                        if (listdt1.Count > 0)
                        {
                            var LastUpdateDate = (from c in listdt1 select c).LastOrDefault();
                            Status = LastUpdateDate.Status;
                            if (Status != "Out")
                            {
                                string[] col1 = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Status", "@Going_Message", "@Actiontype" };
                                object[] val1 = { Attendance_Id, User_Id, DateTime.Now, Going_Date, "Go", txtmsg.Text, "Going" };
                                int i = dal.execute("ManageAttendance", col1, val1);
                                if (i == 1)
                                    lblmsg.Text = "Data Save Successfuly.";

                                Response.Redirect("attendance.aspx");
                                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                            }
                            else
                            {
                                lberror.Text = "Please Inside First";
                            }
                        }
                    }
                    else
                    {
                        string[] col1 = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Status", "@Going_Message", "@Actiontype" };
                        object[] val1 = { Attendance_Id, User_Id, DateTime.Now, Going_Date, "Go", txtmsg.Text, "Going" };
                        int i = dal.execute("ManageAttendance", col1, val1);
                        if (i == 1)
                            lblmsg.Text = "Data Save Successfuly.";

                        Response.Redirect("attendance.aspx");
                        txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
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
    //protected void Timer1_Tick(object sender, EventArgs e)
    //{
    //    int User_Id = int.Parse(Session["marketing_srno"].ToString());
    //    int Attendance_Id = 0;
    //    bool Hr_Permission = false;
    //    string Status = "";
    //    var list = new List<SqlParameter>();
    //    list.Add(new SqlParameter("@Id", "0"));
    //    list.Add(new SqlParameter("@User_Id", User_Id));
    //    list.Add(new SqlParameter("@Actiontype", "select1"));
    //    DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
    //    DateTime comingTime = new DateTime();
    //    DateTime goingTime = new DateTime();
    //    if (dt.Rows.Count > 0)
    //    {
    //        var listdt1 = (from DataRow dr in dt.Rows
    //                       select new MyModelClass()
    //                       {
    //                           Id = Convert.ToInt32(dr["Id"]),
    //                           Going_Time = Convert.ToDateTime(dr["Going_Time"].ToString()),
    //                           Coming_Time = Convert.ToDateTime(dr["Coming_Time"].ToString()),
    //                           User_Id = Convert.ToInt32(dr["User_Id"]),
    //                           Status = dr["Status"].ToString(),
    //                           Hr_Permission = Convert.ToBoolean(dr["Hr_Permission"].ToString()),
    //                       }).ToList();

    //        if (listdt1.Count > 0)
    //        {
    //            var LastUpdateDateGo = (from c in listdt1 where c.Status == "Go" || c.Status == "Come" select c).LastOrDefault();
    //            if (LastUpdateDateGo != null)
    //            {
    //                Attendance_Id = LastUpdateDateGo.Id;
    //                Hr_Permission = LastUpdateDateGo.Hr_Permission;
    //                comingTime = LastUpdateDateGo.Coming_Time;
    //                goingTime = LastUpdateDateGo.Going_Time;
    //            }

    //        }
    //    }
    //    string time1 = comingTime.ToString("dd/MM/yy");
    //    string time2 = goingTime.ToString("dd/MM/yy");
    //    string[] times3 = txt_date.Text.ToString().Split('-');
    //    string time3 = times3[1] + "-" + times3[0] + "-" + times3[2].Substring(0, 2);
    //    if (time1 == time2 && time1 == time3)
    //    {
    //        if (Hr_Permission == true)
    //        {
    //            lblmsg.Text = "";
    //            txtmsg1.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
    //        }
    //        else if (comingTime == goingTime)
    //        {
    //            lblmsg.Text = "";
    //            txtmsg1.Text = "";
    //        }
    //        else
    //        {
    //            lblmsg.Text = "";
    //            txtmsg1.Text = "Wait for manager's approval &#9995;";
    //        }
    //    }
    //    else if (comingTime.Ticks != goingTime.Ticks && Hr_Permission == false && time1 != time3)
    //    {
    //        lblmsg.Text = "";
    //        txtmsg1.Text = "Wait for manager's approval &#9995;";
    //    }
    //    else
    //    {
    //        lblmsg.Text = "";
    //        txtmsg1.Text = "";
    //    }
    //}

}

