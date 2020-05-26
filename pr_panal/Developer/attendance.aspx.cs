using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Developer_Default : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string ComingTime = "";
    public string GoingTime = "";
    public static string WorkDoneorNot="", WorkDoneorNotMsg="";
    public string dv_name, PendingTask, ReminderPanel= string.Empty;
    public int numberOfPendingApprovalLeave = 0;
    public int numberOfSeenStatus = 0;
    public int leaveApplyFormStatus = 0;
    protected void Page_Load(object sender, EventArgs e)
    {


        if (Request.Cookies["developer_srno"] != null)
        {
            var value = Request.Cookies["developer_srno"].Value;
            if (value == "")
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
            Session["developer_srno"] = value;
        }
        if (Session["developer_srno"] == null)
        {
            Response.Redirect("~/Pr-Admin-Log");
        }
        if (!IsPostBack)
        {
            checkAnyWorkDoneorNotBeforeLeave();
            checkAnyWorkDoneorNot();
            checkLeaveGrant();
            checkSeenStatus();
            checkApplyFormStatus();
            txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
            comingtime();
            int User_Id = int.Parse(Session["developer_srno"].ToString());
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
                                   Hr_Permission = Convert.ToBoolean(dr["Hr_Permission"].ToString())
                               }).ToList();

                foreach (var item in listdt1)
                {
                    if (Convert.ToDateTime(item.Going_Time).Ticks != Convert.ToDateTime(item.Coming_Time).Ticks && item.Status == "Come" && item.Hr_Permission == false)
                    {
                        btnmorning.Visible = false;
                        btnnight.Visible = false;
                        txtmessage.Visible = false;
                        //txt_date.Visible = false;
                        if (item.Hr_Permission == false)
                            txtmsg.Text = "Wait for manager's approval &#9995;";
                        else
                        {
                            txtmsg.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                        }
                    }
                    //else if (Convert.ToDateTime(item.Going_Time).Ticks == Convert.ToDateTime(item.Coming_Time).Ticks && item.Status == "Come" && !(item.Going_Time.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy"))))
                    //{
                    //    btnmorning.Visible = true;
                    //    btnnight.Visible = false;
                    //    txtmessage.Visible = true;
                    //    //txt_date.Visible = false;
                    //    txtmsg.Text = "";
                    //}

                    else if (item.Going_Time.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy")) && item.Status == "Come")
                    {
                        btnmorning.Visible = false;
                        btnnight.Visible = true;
                        txtmessage.Visible = true;
                        txtmsg.Text = "";
                    }

                    else if (item.Going_Time.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy")) && item.Status == "Go")
                    {
                        btnmorning.Visible = false;
                        btnnight.Visible = false;
                        txtmessage.Visible = false;
                        //txt_date.Visible = false;
                        if (item.Hr_Permission == false)
                            txtmsg.Text = "Wait for manager's approval &#9995;";
                        else
                        {
                            txtmsg.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                        }
                    }
                    else if (Convert.ToDateTime(item.Going_Time).Ticks == Convert.ToDateTime(item.Coming_Time).Ticks && item.Status == "Come")
                    {
                        btnmorning.Visible = false;
                        btnnight.Visible = false;
                        txtmessage.Visible = false;
                        //txt_date.Visible = false;
                        //if (item.Hr_Permission == false)
                        txtmsg.Text = "Sorry for the inconvenience, You did not say goodnight previously, So You please contact with admin.";
                        //else
                        //{
                        //    txtmsg.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                        //}
                    }
                    else
                    {
                        btnmorning.Visible = true;
                        btnnight.Visible = false;
                        txtmessage.Visible = true;
                        //txt_date.Visible = false;
                        txtmsg.Text = "";
                    }
                }
            }
            else
            {
                btnmorning.Visible = true;
                btnnight.Visible = false;
                txtmessage.Visible = true;
            }
        }
    }
    private void checkAnyWorkDoneorNot()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]) };
                DataSet ds4 = dal.getDataSet("USPcheckAnyWorkDoneorNot", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    WorkDoneorNotMsg = Convert.ToString(ds4.Tables[0].Rows[0]["msg"]);
                }
            }
        }

        catch (Exception ex)
        {

        }

    }
    //Code for pending task approval by HR start

    //int status = CheckGoodNightAppearsOrNot();
    //if (status == 2)
    //{
    //    btnmorning.Visible = true;
    //    btnnight.Visible = false;
    //}
    //else if (status == 1 || status == 3)
    //{
    //    btnmorning.Visible = false;
    //    btnnight.Visible = false;
    //}
    //else if (status == 0)
    //{
    //    btnmorning.Visible = false;
    //    btnnight.Visible = true;
    //}

    //Code for pending task approval by HR end
    private void checkApplyFormStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "checkinstanceleave" };
                DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    leaveApplyFormStatus = ds4.Tables[0].Rows.Count;
                }
            }
        }

        catch (Exception ex)
        {

        }
    }

    private void checkSeenStatus()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "checkseenstatusbyemployee" };
                DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    numberOfSeenStatus = ds4.Tables[0].Rows.Count;
                }
            }
        }

        catch (Exception ex)
        {

        }
    }
    private void checkLeaveGrant()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno", "@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]), "showpendingleavestatus" };
                DataSet ds4 = dal.getDataSet("ManageLeave", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    numberOfPendingApprovalLeave = ds4.Tables[0].Rows.Count;
                }
            }
        }

        catch (Exception ex)
        {

        }
    }

    protected int CheckGoodNightAppearsOrNot()
    {
        int status = -1;
        try
        {
            if (Session["developer_srno"] != null)
            {
                int User_Id = int.Parse(Session["developer_srno"].ToString());
                string[] col1 = { "@srno" };
                object[] val1 = { User_Id };
                DataSet ds4 = dal.getDataSet("USPCheckGoodNightAppearsOrNot", col1, val1);
                if (ds4.Tables[0].Rows.Count > 0)
                {

                    status = Convert.ToInt32(ds4.Tables[0].Rows[0]["found"]);
                }

                return status;
            }
            else
            {
                Response.Redirect("~/Pr-Admin-Log");
            }
        }
        catch (Exception ex)
        {
            status = -1;
            lblmsg.Text = ex.Message.ToString();
        }
        return status;
    }
    protected void btnmorning_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                comingtime();
                int User_Id = int.Parse(Session["developer_srno"].ToString());
                string[] col1 = { "@Id", "@User_Id", "@Coming_Time", "@Going_Time", "@Status", "@Coming_Message", "@Actiontype" };
                object[] val1 = { "0", User_Id, DateTime.Now, DateTime.Now, "Come", txtmessage.Text, "Coming" };
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

    private void checkAnyWorkDoneorNotBeforeLeave()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@srno" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]) };
                DataSet ds4 = dal.getDataSet("USPcheckAnyWorkDoneorNotBeforeGoodNight", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    WorkDoneorNot = Convert.ToString(ds4.Tables[0].Rows[0]["msg"]);
                }
            }
        }

        catch (Exception ex)
        {

        }

    }
    private string checkForGoodNight()
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string[] col4 = { "@id","@Actiontype" };
                object[] val4 = { Convert.ToInt32(Session["developer_srno"]),"checkForGoodNight" };
                DataSet ds4 = dal.getDataSet("ManageAttendance", col4, val4);
                if (ds4.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToString(ds4.Tables[0].Rows[0]["msg"]);
                }
            }
            return "";
        }

        catch (Exception ex)
        {
            return "";
        }

    }
    protected void btnnight_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["developer_srno"] != null)
            {
                string msg=checkForGoodNight();
                if (msg=="No")
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Kindly say goodnight after spending 8 working hours on your own assigned task atleast.')", true);

                }
                else if (msg == "UpTask")
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Kindly submit work status about the task that you started.')", true);

                }

                else
                {
                    //checkAnyWorkDoneorNotBeforeLeave();
                    //if (WorkDoneorNot.Contains(":"))
                    //{
                    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Kindly Submit your work before leave.')", true);

                    //}
                    //else
                    //{
                        WorkDoneorNot = "Yes";


                        int User_Id = int.Parse(Session["developer_srno"].ToString());

                        int Attendance_Id = 0;
                        bool Hr_Permission = false;
                        string Status = "";
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
                                Hr_Permission = LastUpdateDate.Hr_Permission;
                                numberOfMonth = LastUpdateDate.numberOfMonth;
                            }
                        }
                        //if (Hr_Permission==false)
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

                                        //object[] val1 = { Attendance_Id, User_Id, DateTime.Now, DateTime.Now, ((numberOfMonth >= 10) ? "Go" : "Come"), txtmessage.Text, ((numberOfMonth >= 10) ? 1 : 0), "Going" };
                                        object[] val1 = { Attendance_Id, User_Id, DateTime.Now, DateTime.Now, ((numberOfMonth >= 10) ? "Go" : "Go"), txtmessage.Text, ((numberOfMonth >= 10) ? 1 : 1), "Going" };
                                        int i = dal.execute("ManageAttendance", col1, val1);
                                        if (i == 1)
                                        {
                                            btnnight.Visible = false;
                                            lblmsg.Text = "";
                                            txtmessage.Visible = false;
                                            txtmsg.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                                            //if (numberOfMonth >= 10)
                                            //{
                                            //    txtmsg.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                                            //}
                                            //else
                                            //{

                                            //    txtmsg.Text = "Wait for manager's approval &#9995;";
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
                                // object[] val1 = { Attendance_Id, User_Id, DateTime.Now, DateTime.Now, ((numberOfMonth >= 10) ? "Go" : "Come"), txtmessage.Text, ((numberOfMonth >= 10) ? 1 : 0), "Going" };
                                object[] val1 = { Attendance_Id, User_Id, DateTime.Now, DateTime.Now, ((numberOfMonth >= 10) ? "Go" : "Go"), txtmessage.Text, ((numberOfMonth >= 10) ? 1 : 1), "Going" };
                                int i = dal.execute("ManageAttendance", col1, val1);
                                if (i == 1)
                                {
                                    btnnight.Visible = false;
                                    lblmsg.Text = "";
                                    txtmessage.Visible = false;
                                    txtmsg.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                                    //if (numberOfMonth >= 10)
                                    //{
                                    //    txtmsg.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
                                    //}
                                    //else
                                    //{

                                    //    txtmsg.Text = "Wait for manager's approval &#9995;";
                                    //}
                                }

                                //Response.Redirect("attendance.aspx");
                                btnnight.Visible = false;
                                txt_date.Text = System.DateTime.Now.ToString("MM/dd/yy H:mm:ss");
                            }
                            //} 
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
    private void comingtime()
    {
        int User_Id = int.Parse(Session["developer_srno"].ToString());
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
    class MyModelClass
    {
        public int Id { get; set; }
        public int User_Id { get; set; }
        public string Status { get; set; }
        public bool Hr_Permission { get; set; }
        public DateTime Coming_Time { get; set; }
        public DateTime Going_Time { get; set; }
        public int numberOfMonth { get; set; }
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        int User_Id = int.Parse(Session["developer_srno"].ToString());
        int Attendance_Id = 0;
        bool Hr_Permission = false;
        string Status = "";
        var list = new List<SqlParameter>();
        list.Add(new SqlParameter("@Id", "0"));
        list.Add(new SqlParameter("@User_Id", User_Id));
        list.Add(new SqlParameter("@Actiontype", "select1"));
        DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
        DateTime comingTime = new DateTime();
        DateTime goingTime = new DateTime();
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
                           }).ToList();

            if (listdt1.Count > 0)
            {
                var LastUpdateDateCome = (from c in listdt1 where c.Status == "Come" || c.Status == "Go" select c).LastOrDefault();
                if (LastUpdateDateCome != null)
                {
                    Attendance_Id = LastUpdateDateCome.Id;
                    Hr_Permission = LastUpdateDateCome.Hr_Permission;
                    comingTime = LastUpdateDateCome.Coming_Time;
                    goingTime = LastUpdateDateCome.Going_Time;
                }
                //var LastUpdateDateGo = (from c in listdt1 where c.Status == "Go" select c).LastOrDefault();
                //if (LastUpdateDateGo != null)
                //{
                //    Attendance_Id = LastUpdateDateGo.Id;
                //    Hr_Permission = LastUpdateDateGo.Hr_Permission;
                //    comingTime = LastUpdateDateGo.Coming_Time;
                //    goingTime = LastUpdateDateGo.Going_Time;
                //}
            }
        }
        string time1 = comingTime.ToString("dd/MM/yy");
        string time2 = goingTime.ToString("dd/MM/yy");
        string[] times3 = txt_date.Text.ToString().Split('-');
        string time3 = times3[1] + "-" + times3[0] + "-" + times3[2].Substring(0, 2);
        if (time1 == time2 && time1 == time3)
        {
            if (Hr_Permission == true)
            {
                lblmsg.Text = "";
                txtmsg.Text = "Great ! you my leave now, Good Night &#128522;&#128075;";
            }
            else if (comingTime == goingTime)
            {
                lblmsg.Text = "";
                txtmsg.Text = "";
            }
            else
            {
                lblmsg.Text = "";
                txtmsg.Text = "Wait for manager's approval &#9995;";
            }
        }
        else if (comingTime.Ticks != goingTime.Ticks && Hr_Permission == false && time1 != time3)
        {
            lblmsg.Text = "";
            txtmsg.Text = "Wait for manager's approval &#9995;";
        }


        else
        {
            lblmsg.Text = "";
            txtmsg.Text = "";
        }
    }
}
