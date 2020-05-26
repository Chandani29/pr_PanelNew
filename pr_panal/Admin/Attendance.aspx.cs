using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
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
        download_XL.Visible = true;
        if (!IsPostBack)
        {

            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");

            bindDoneReminders();
            BinddropdownList();
            GetoutsideEmp();
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
    private void bindDoneReminders()
    {
        try
        {
            if (Session["admin_srno"] != null)
            {
                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { "0", "select8" };
                DataSet ds = dal.getDataSet("ManageLogin", col1, val1);

                DataSet tableCollection = new DataSet();
                tableCollection.Clear();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    string strDoneReminders = string.Empty;
                    for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                    {
                        string tableName = ds.Tables[0].Rows[j]["name"].ToString().Length > 30 ? ds.Tables[0].Rows[j]["name"].ToString().Substring(0, 30) : ds.Tables[0].Rows[j]["name"].ToString();
                        DataTable table = new DataTable(tableName);
                        table.Clear();
                        table.Columns.Add("Coming Time", typeof(string));
                        table.Columns.Add("Coming Message", typeof(string));
                        table.Columns.Add("Going Time", typeof(string));
                        table.Columns.Add("Going Message", typeof(string));
                        table.Columns.Add("Total Company Time", typeof(string));
                        table.Columns.Add("Total Time Spend", typeof(string));
                        DataRow _dr = table.NewRow();
                        string Time = BindSpendTime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()));
                        string comingMessage;
                        string goingMessage;
                        int isMeetingGoodMorning;
                        string Company_Time = "0";
                        DateTime Coming_Time;
                        DateTime Going_Time;
                        string comingtime1 = comingtimess(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), out comingMessage, out isMeetingGoodMorning, out Coming_Time);
                        string goingtime1 = goingtimess(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), out goingMessage, out Going_Time);

                        if (Going_Time.ToString() == Coming_Time.ToString())
                        {
                            Company_Time = "User not say good night";
                        }
                        else
                        {
                            double double_minutes = Going_Time.Subtract(Coming_Time).TotalMinutes;
                            if (double_minutes > 60)
                            {
                                double Hours = double_minutes / 60;
                                double Min = double_minutes % 60;
                                Company_Time = Hours.ToString().Split('.').ElementAt(0) + " Hours " + Min.ToString("N0") + " Mins";
                            }
                            else
                            {
                                Company_Time = double_minutes.ToString("N0") + " Mins";
                            }
                        }



                        strDoneReminders += "<table class='table table-bordered cart_summary'> <thead><tr>";
                        strDoneReminders += " <th style='text-align: left;'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</th>";
                        strDoneReminders += "<th align='right'>Coming Time :</th><th>" + comingtime1 + "</th></tr> </thead>";
                        strDoneReminders += "<tbody>";
                        _dr["Coming Time"] = comingtime1;
                        //For Coming Message display, if any start
                        if (!String.IsNullOrEmpty(comingMessage))
                        {
                            strDoneReminders += "<tr><td>&nbsp;</td>";
                            if (isMeetingGoodMorning == 1)
                            {
                                strDoneReminders += "<td>Meeting Good Morning Message</td>";
                                _dr["Coming Message"] = "M " + comingMessage;
                            }
                            else
                            {
                                strDoneReminders += "<td>Coming Message</td>";
                                _dr["Coming Message"] = comingMessage;
                            }
                            strDoneReminders += "<td>" + comingMessage + "</td></tr>";
                        }
                        //For Coming Message display, if any end 
                        string[] col2 = { "@Id", "@User_Id", "@Actiontype" };
                        object[] val2 = { "0", ds.Tables[0].Rows[j]["srno"], "Select2" };
                        DataSet ds2 = dal.getDataSet("TimeCalculator", col2, val2);
                        for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
                        {
                            strDoneReminders += "<tr><td>&nbsp;</td>";
                            string status = "";
                            string CmpPor = "";
                            status = ds2.Tables[0].Rows[k]["Status"].ToString();
                            if (status == "In")
                            {
                                CmpPor = ds2.Tables[0].Rows[k - 1]["Company_Purpose"].ToString();
                                if (CmpPor != "")
                                {
                                    strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " (" + (double.Parse(ds2.Tables[0].Rows[k]["Company_Purpose_S_Time"].ToString()) / 60).ToString("N0") + " Mins Company purpose) </td>";
                                }
                                else
                                {
                                    strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</td>";
                                }
                            }
                            else
                            {
                                strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</td>";

                            }
                            strDoneReminders += "<td>" + DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("h:mm tt") + "</td>";
                        }
                        strDoneReminders += "<tr><td>&nbsp;</td>";
                        strDoneReminders += "<td><strong> Total time spend</strong></td>";
                        strDoneReminders += "<td>" + Time + " mins</td>";

                        if(Convert.ToString(ds.Tables[0].Rows[j]["user_id"]).Substring(0,1).ToLower()=="d" && Convert.ToString(ds.Tables[0].Rows[j]["runningProjectName"])=="")
                        {
                            strDoneReminders += "<tr><td>&nbsp;</td>";
                            strDoneReminders += "<td><strong> Current Startd Project & Task</strong></td>";
                            strDoneReminders += "<td><span style='color:red;'>Not Yet Startd.</span></td></tr>";
                        }
                        else if (Convert.ToString(ds.Tables[0].Rows[j]["user_id"]).Substring(0, 1).ToLower() == "d" && Convert.ToString(ds.Tables[0].Rows[j]["runningProjectName"]) != "")
                        {
                            strDoneReminders += "<tr><td>&nbsp;</td>";
                            strDoneReminders += "<td><strong> Current Startd Project & Time</strong></td>";
                            strDoneReminders += "<td><span style='color:green;'>"+Convert.ToString(ds.Tables[0].Rows[j]["runningProjectName"])+" & "+ DateTime.Parse(ds.Tables[0].Rows[j]["runningTaskStartTime"].ToString()).ToString("h:mm tt")+"</span></td></tr>";
                        }

                        if (goingtime1 != "")
                        {
                            strDoneReminders += "<tr><td>&nbsp;</td>";
                            strDoneReminders += "<td><strong> Going Time</strong></td>";
                            strDoneReminders += "<td>" + goingtime1 + "</td>";
                            _dr["Going Time"] = goingtime1;
                        }

                        //For Going Message display, if any start
                        if (!String.IsNullOrEmpty(goingMessage))
                        {
                            strDoneReminders += "<tr><td>&nbsp;</td>";
                            if (isMeetingGoodMorning == 1)
                            {
                                strDoneReminders += "<td>Meeting Good Night Message</td>";
                                _dr["Going Message"] = "M " + goingMessage;
                            }
                            else
                            {
                                strDoneReminders += "<td>Going Message</td>";
                                _dr["Going Message"] = "M " + goingMessage;
                            }
                            strDoneReminders += "<td>" + goingMessage + "</td></tr>";
                        }
                        _dr["Total Company Time"] = Company_Time;
                        _dr["Total Time Spend"] = Time;
                        //For Going Message display, if any end

                        strDoneReminders += "</tbody>";
                        strDoneReminders += "</table>";
                        table.Rows.Add(_dr);
                        tableCollection.Tables.Add(table);
                    }
                    Session["table"] = tableCollection;
                    DoneReminders += strDoneReminders;
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    private string BindSpendTime(int User_Id)
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
                if (item.Timing.ToString("MM/dd/yyyy").Equals(DateTime.Now.ToString("MM/dd/yyyy")))
                {
                    TotalTime = TotalTime + double.Parse(item.Spend_time);
                }
            }
            TimeSpend = (TotalTime / 60).ToString("N0");
        }
        return TimeSpend;
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
    private string comingtimess(int User_Id, out string comingMessage, out int isMeetingGoodMorning, out DateTime Coming_Time)
    {
        ComingTime = "";
        comingMessage = "";
        isMeetingGoodMorning = 0;
        Coming_Time = new DateTime();
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
                               Coming_Message = dr["Coming_Message"].ToString(),
                               isMeetingGoodMorning = Convert.ToInt32(dr["isMeetingGoodMorning"])
                           }).ToList();

            var LastUpdateDate = (from c in listdt1 select c).FirstOrDefault();
            ComingTime = LastUpdateDate.Coming_Time.ToString("hh:mm tt");
            Coming_Time = LastUpdateDate.Coming_Time;
            comingMessage = LastUpdateDate.Coming_Message;
            isMeetingGoodMorning = LastUpdateDate.isMeetingGoodMorning;
        }
        return ComingTime;
    }
    private string comingtime(int User_Id, DateTime date, out string comingMessage, out int isMeetingGoodMorning)
    {
        ComingTime = "";
        comingMessage = "";
        isMeetingGoodMorning = 0;
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
                               Coming_Message = dr["Coming_Message"].ToString(),
                               isMeetingGoodMorning = Convert.ToInt32(dr["isMeetingGoodMorning"])
                           }).ToList();

            var LastUpdateDate = (from c in listdt1 select c).FirstOrDefault();
            ComingTime = LastUpdateDate.Coming_Time.ToString();
            comingMessage = LastUpdateDate.Coming_Message;
            isMeetingGoodMorning = LastUpdateDate.isMeetingGoodMorning;
        }
        return ComingTime;
    }
    private string goingtime(int User_Id, DateTime date, out string goingMessage)
    {
        GoingTime = "";
        goingMessage = "";
        //Going_Time = new DateTime();
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
                               Going_Message = dr["Going_Message"].ToString(),
                           }).ToList();
            //var dd = (from c in listdt1  select c).FirstOrDefault();
            //Going_Time = dd.Going_Time;

            var LastUpdateDate = (from c in listdt1 where c.Status == "Go" select c).FirstOrDefault();
            if (LastUpdateDate != null)
            {
                GoingTime = LastUpdateDate.Going_Time.ToString("hh:mm tt");
                goingMessage = LastUpdateDate.Going_Message;
            }
        }
        return GoingTime;
    }
    private string goingtimess(int User_Id, out string goingMessage, out DateTime Going_Time)
    {
        GoingTime = "";
        goingMessage = "";
        Going_Time = new DateTime();
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
                               Going_Message = dr["Going_Message"].ToString()
                           }).ToList();
            var dd = (from c in listdt1 select c).FirstOrDefault();
            Going_Time = dd.Going_Time;
            var LastUpdateDate = (from c in listdt1 where c.Status == "Go" select c).FirstOrDefault();
            if (LastUpdateDate != null)
            {
                GoingTime = LastUpdateDate.Going_Time.ToString("hh:mm tt");
                goingMessage = LastUpdateDate.Going_Message;
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

        public string Coming_Message { get; set; }

        public string Going_Message { get; set; }
        public int isMeetingGoodMorning { get; set; }
    }
    protected void ddlusers_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["admin_srno"] == null)
            Response.Redirect("~/Pr-Admin-Log");

        int User_Id = int.Parse(ddlusers.SelectedValue);
        txt_from.Text = "";
        txt_to.Text = "";
        if (User_Id > 0)
        {
            bindDoneReminders(User_Id);
            //download_XL.Visible = true;
        }
        else
        {
            bindDoneReminders();
            // download_XL.Visible = false;
        }
    }
    protected void download_XL_Click(object sender, EventArgs e)
    {
        if (ddlusers.SelectedValue == "0" && txt_from.Text != "" && txt_to.Text != "")
        {
            try
            {

                string[] col1 = { "@dateFrom", "@dateTo" };
                object[] val1 = { txt_from.Text, txt_to.Text };
                DataSet ds = dal.getDataSet("USPAttendanceReport", col1, val1);
                ClosedXML.Excel.XLWorkbook wb = new ClosedXML.Excel.XLWorkbook();
                var ws = wb.Worksheets.Add("Attendance");
                int col = ds.Tables[1].Rows.Count * 2;
                ws.Cell(1, 1).Value = "Attendance from " + txt_from.Text + " to " + txt_to.Text;
                ws.Range(1, 1, 1, col + 1).Merge();
                //ws.Range(ws.Cell(row, col++), ws.Cell(row, col++)).Merge();
                ws.Range(1, 1, 1, col + 1).AddToNamed("Titles");
                // styles
                var titlesStyle = wb.Style;
                titlesStyle.Font.Bold = true;
                titlesStyle.Alignment.Horizontal = ClosedXML.Excel.XLAlignmentHorizontalValues.Left;
                titlesStyle.Fill.BackgroundColor = ClosedXML.Excel.XLColor.GreenPigment;

                // style titles row
                wb.NamedRanges.NamedRange("Titles").Ranges.Style = titlesStyle;
                ws.Cell(2, 1).Value = "dd-mm-yyyy";
                ws.Cell(2, 1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.GreenPigment;
                int k = 2;
                //Table Created for manage leave for each Employee start
                DataTable dtEmployee = new DataTable();
                dtEmployee.Columns.Add(new DataColumn("srno", typeof(int)));
                dtEmployee.Columns.Add(new DataColumn("name", typeof(string)));
                dtEmployee.Columns.Add(new DataColumn("FFF933-Counter", typeof(int)));  //Time between 9:30 to 10:00   Calculation 1/4 = 0.25 days leave after 6 
                dtEmployee.Columns.Add(new DataColumn("FFB233-Counter", typeof(int)));  //Time between 10:01 to 10:30  Calculation 1/2 = 0.50 days leave
                dtEmployee.Columns.Add(new DataColumn("FF8633-Counter", typeof(int)));  //Time between 10:31 to 11:30  Calculation 1 days leave
                dtEmployee.Columns.Add(new DataColumn("FF6E33-Counter", typeof(int)));  //Time between 11:31 to 01:59  Calculation 2 days  leave
                dtEmployee.Columns.Add(new DataColumn("9AE33C-Counter", typeof(int)));  //Time after 2:00 PM or 2:00 PM Calculation 2 days  leave
                dtEmployee.Columns.Add(new DataColumn("FF33F6-Counter", typeof(int)));  ////For Spend time less than 9 hours Calculation 1/2 = 0.50 days  leave
                //Table Created for manage leave for each Employee end
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    DataRow row = dtEmployee.NewRow();
                    row["srno"] = Convert.ToInt32(ds.Tables[1].Rows[i]["srno"]);
                    row["name"] = ds.Tables[1].Rows[i]["name"].ToString();
                    row["FFF933-Counter"] = 0;
                    row["FFB233-Counter"] = 0;
                    row["FF8633-Counter"] = 0;
                    row["FF6E33-Counter"] = 0;
                    row["9AE33C-Counter"] = 0;
                    row["FF33F6-Counter"] = 0;
                    dtEmployee.Rows.Add(row);
                    ws.Cell(2, k).Value = ds.Tables[1].Rows[i]["name"].ToString();
                    ws.Cell(2, k).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.GreenPigment;
                    ws.Range(2, k, 2, k + 1).Merge();
                    k = k + 2;

                }

                ws.Cell(3, 1).Value = "";
                ws.Cell(3, 1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.GreenPigment;
                k = 2;
                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    ws.Cell(3, k).Value = "In";
                    ws.Cell(3, k).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.GreenPigment;
                    ws.Cell(3, k + 1).Value = "Out";
                    ws.Cell(3, k + 1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.GreenPigment;
                    k = k + 2;

                }
                //For display date start
                k = 4;
                //double[] totalSalary = new double[ds.Tables[0].Rows.Count];
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)   //days between two selected date loop using datepicker
                {
                    ws.Cell(k, 1).Value = ds.Tables[0].Rows[i]["Coming_Time"].ToString();
                    ws.Cell(k, 1).Style.NumberFormat.Format = "dd-mm-yy";
                    ws.Column(1).AdjustToContents();
                    int columnCtr = 2;
                    for (int ctrEmployee = 0; ctrEmployee < ds.Tables[1].Rows.Count; ctrEmployee++)
                    {
                        //int perDayCostForParticularEmployee = Convert.ToInt32(ds.Tables[1].Rows[ctrEmployee]["per_cost"]);  //Per day cost for each employee
                        //int perDayCostForParticularEmployeeSelected = 0;
                        DataRow[] rowsFiltered = ds.Tables[2].Select("Coming_Time='" + ds.Tables[0].Rows[i]["Coming_Time"].ToString() + "' AND User_Id=" + Convert.ToInt32(ds.Tables[1].Rows[ctrEmployee]["srno"]));

                        //DataRow[] salaryFound = ds.Tables[1].Select("srno=" + Convert.ToInt32(ds.Tables[1].Rows[ctrEmployee]["srno"]));
                        //foreach (DataRow rowss in salaryFound)
                        //{
                        //    perDayCostForParticularEmployeeSelected = Convert.ToInt32(rowss.ItemArray[2].ToString());
                        //}

                        int presenetFlag = 0;
                        foreach (DataRow rowss in rowsFiltered)
                        {
                            presenetFlag = 1;
                            ws.Cell(k, columnCtr).Value = rowss.ItemArray[2].ToString();   //Coming Time
                            ws.Cell(k, columnCtr).Style.NumberFormat.Format = "h:mm AM/PM";

                            if (rowss.ItemArray[2].ToString() != "" && rowss.ItemArray[2].ToString().Contains("AM"))
                            {
                                if ((rowss.ItemArray[2].ToString().Split(':')[0] == "9" && Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[1].Replace("AM", "")) > 30)
                                    || (rowss.ItemArray[2].ToString().Split(':')[0] == "10" && Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[1].Replace("AM", "")) == 0))
                                {
                                    DataRow[] rows = dtEmployee.Select("srno =" + Convert.ToInt32(rowss.ItemArray[0]));
                                    if (rows.Length > 0)
                                    {
                                        foreach (DataRow row in rows)
                                        {

                                            row[2] = Convert.ToInt32((row[2] == null) ? 0 : row[2]) + 1;
                                            dtEmployee.AcceptChanges();
                                            row.SetModified();
                                        }
                                    }
                                    ws.Cell(k, columnCtr).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FFF933");//Time between 9:30 to 10:00
                                }

                                else if (rowss.ItemArray[2].ToString().Split(':')[0] == "10" && Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[1].Replace("AM", "")) <= 30)
                                {


                                    DataRow[] rows = dtEmployee.Select("srno =" + Convert.ToInt32(rowss.ItemArray[0]));
                                    if (rows.Length > 0)
                                    {
                                        foreach (DataRow row in rows)
                                        {

                                            row[3] = Convert.ToInt32((row[3] == null) ? 0 : row[3]) + 1;
                                            dtEmployee.AcceptChanges();
                                            row.SetModified();
                                        }
                                    }
                                    ws.Cell(k, columnCtr).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FFB233");//Time between 10:01 to 10:30
                                }

                                else if ((rowss.ItemArray[2].ToString().Split(':')[0] == "10" && Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[1].Replace("AM", "")) > 30) || (rowss.ItemArray[2].ToString().Split(':')[0] == "11" && Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[1].Replace("AM", "")) <= 30))
                                {
                                    DataRow[] rows = dtEmployee.Select("srno =" + Convert.ToInt32(rowss.ItemArray[0]));
                                    if (rows.Length > 0)
                                    {
                                        foreach (DataRow row in rows)
                                        {

                                            row[4] = Convert.ToInt32((row[4] == null) ? 0 : row[4]) + 1;
                                            dtEmployee.AcceptChanges();
                                            row.SetModified();
                                        }
                                    }
                                    ws.Cell(k, columnCtr).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FF8633");//Time between 10:31 to 11:30
                                }

                                //else if ((rowss.ItemArray[2].ToString().Split(':')[0] == "10" && Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[1].Replace("AM", "")) > 30) || (rowss.ItemArray[2].ToString().Split(':')[0] == "11" && Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[1].Replace("AM", "")) <= 30))
                                //{
                                //    ws.Cell(k, columnCtr).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FF8633");//Time between 10:31 to 11:30
                                //}

                                else if (Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[0]) >= 11)
                                {
                                    DataRow[] rows = dtEmployee.Select("srno =" + Convert.ToInt32(rowss.ItemArray[0]));
                                    if (rows.Length > 0)
                                    {
                                        foreach (DataRow row in rows)
                                        {

                                            row[5] = Convert.ToInt32((row[5] == null) ? 0 : row[5]) + 1;
                                            dtEmployee.AcceptChanges();
                                            row.SetModified();
                                        }
                                    }
                                    ws.Cell(k, columnCtr).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FF6E33");//Time between 11:31 to 12:00
                                }
                            }
                            else if (rowss.ItemArray[2].ToString() != "" && rowss.ItemArray[2].ToString().Contains("PM"))
                            {
                                if (Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[0]) == 12 || Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[0]) < 2)
                                {
                                    DataRow[] rows = dtEmployee.Select("srno =" + Convert.ToInt32(rowss.ItemArray[0]));
                                    if (rows.Length > 0)
                                    {
                                        foreach (DataRow row in rows)
                                        {

                                            row[5] = Convert.ToInt32((row[5] == null) ? 0 : row[5]) + 1;
                                            dtEmployee.AcceptChanges();
                                            row.SetModified();
                                        }
                                    }
                                    ws.Cell(k, columnCtr).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FF6E33");//Time between 12:01 to 1:59
                                }
                                else if (Convert.ToInt32(rowss.ItemArray[2].ToString().Split(':')[0]) >= 2)
                                {
                                    DataRow[] rows = dtEmployee.Select("srno =" + Convert.ToInt32(rowss.ItemArray[0]));
                                    if (rows.Length > 0)
                                    {
                                        foreach (DataRow row in rows)
                                        {

                                            row[6] = Convert.ToInt32((row[6] == null) ? 0 : row[6]) + 1;
                                            dtEmployee.AcceptChanges();
                                            row.SetModified();
                                        }
                                    }
                                    ws.Cell(k, columnCtr).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#9AE33C");//Time after 2:00 PM
                                }
                            }
                            ws.Cell(k, columnCtr + 1).Value = rowss.ItemArray[3].ToString();    //Going Time
                            ws.Cell(k, columnCtr + 1).Style.NumberFormat.Format = "h:mm AM/PM";

                            if (Convert.ToInt32(Convert.ToString(rowss.ItemArray[5]) == "" ? "0" : Convert.ToString(rowss.ItemArray[5])) < 9)
                            {

                                DataRow[] rows = dtEmployee.Select("srno =" + Convert.ToInt32(rowss.ItemArray[0]));
                                if (rows.Length > 0)
                                {
                                    foreach (DataRow row in rows)
                                    {

                                        row[7] = Convert.ToInt32((row[7] == null) ? 0 : row[7]) + 1;
                                        dtEmployee.AcceptChanges();
                                        row.SetModified();
                                    }
                                }
                                ws.Cell(k, columnCtr + 1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FF33F6");//For Spend time less than 9 hours
                            }
                        }
                        if (presenetFlag == 0)
                        {
                            ws.Cell(k, columnCtr).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#3CB8E3");//In Case Of Leave
                            ws.Cell(k, columnCtr + 1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#3CB8E3");//In Case Of Leave

                        }


                        columnCtr = columnCtr + 2;


                    }

                    if (i < ds.Tables[0].Rows.Count - 1)
                    {
                        int checkForLeave = Convert.ToInt32(ds.Tables[0].Rows[i + 1]["Coming_Time"].ToString().Split('/')[0]) - Convert.ToInt32(ds.Tables[0].Rows[i]["Coming_Time"].ToString().Split('/')[0]);
                        if (checkForLeave > 1)
                        {
                            for (int j = 0; j < checkForLeave - 1; j++)
                            {
                                k = k + 1;
                                ws.Range(k, 1, k, col + 1).Merge().Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.Red;
                            }
                        }
                        k = k + 1;
                    }

                }

                int columnCtr1 = 1;
                k = k + 2;
                ws.Cell(k, columnCtr1).Value = "Deducted Leave";
                columnCtr1 = columnCtr1 + 1;
                double totalLeave = 0;
                for (int i = 0; i < dtEmployee.Rows.Count; i++)
                {
                    totalLeave = 0;
                    ws.Cell(k, columnCtr1).Value = dtEmployee.Rows[i]["name"];
                    ws.Range(k, columnCtr1, k, columnCtr1 + 1).Merge();
                    ws.Cell(k, columnCtr1 + 1).Comment.Style.Alignment.SetAutomaticSize();

                    ws.Cell(k + 1, columnCtr1).Value = dtEmployee.Rows[i]["FFF933-Counter"];
                    ws.Cell(k + 1, columnCtr1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FFF933");
                    totalLeave += (Convert.ToInt32(dtEmployee.Rows[i]["FFF933-Counter"]) > 6 ? ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FFF933-Counter"]) - 6) * (double)0.25) : 0);
                    ws.Cell(k + 1, columnCtr1 + 1).Value = (Convert.ToInt32(dtEmployee.Rows[i]["FFF933-Counter"]) > 6 ? ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FFF933-Counter"]) - 6) * (double)0.25) : 0);

                    ws.Cell(k + 2, columnCtr1).Value = dtEmployee.Rows[i]["FFB233-Counter"];
                    ws.Cell(k + 2, columnCtr1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FFB233");
                    totalLeave += ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FFB233-Counter"])) * (double)0.50);
                    ws.Cell(k + 2, columnCtr1 + 1).Value = ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FFB233-Counter"])) * (double)0.50);

                    ws.Cell(k + 3, columnCtr1).Value = dtEmployee.Rows[i]["FF8633-Counter"];
                    ws.Cell(k + 3, columnCtr1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FF8633");
                    totalLeave += ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FF8633-Counter"])) * (double)1);
                    ws.Cell(k + 3, columnCtr1 + 1).Value = ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FF8633-Counter"])) * (double)1);

                    ws.Cell(k + 4, columnCtr1).Value = dtEmployee.Rows[i]["FF6E33-Counter"];
                    ws.Cell(k + 4, columnCtr1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FF6E33");
                    totalLeave += ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FF6E33-Counter"])) * (double)2);
                    ws.Cell(k + 4, columnCtr1 + 1).Value = ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FF6E33-Counter"])) * (double)2);

                    ws.Cell(k + 5, columnCtr1).Value = dtEmployee.Rows[i]["9AE33C-Counter"];
                    ws.Cell(k + 5, columnCtr1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#9AE33C");
                    totalLeave += ((double)(Convert.ToInt32(dtEmployee.Rows[i]["9AE33C-Counter"])) * (double)2);
                    ws.Cell(k + 5, columnCtr1 + 1).Value = ((double)(Convert.ToInt32(dtEmployee.Rows[i]["9AE33C-Counter"])) * (double)2);

                    ws.Cell(k + 6, columnCtr1).Value = dtEmployee.Rows[i]["FF33F6-Counter"];
                    ws.Cell(k + 6, columnCtr1).Style.Fill.BackgroundColor = ClosedXML.Excel.XLColor.FromHtml("#FF33F6");
                    totalLeave += ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FF33F6-Counter"])) * (double)0.50);
                    ws.Cell(k + 6, columnCtr1 + 1).Value = ((double)(Convert.ToInt32(dtEmployee.Rows[i]["FF33F6-Counter"])) * (double)0.50);

                    ws.Cell(k + 8, columnCtr1).Value = "Total Leave";
                    ws.Cell(k + 8, columnCtr1 + 1).Value = totalLeave;

                    columnCtr1 = columnCtr1 + 2;
                    //ws.Cell(k, columnCtr).Style.NumberFormat.Format = "h:mm AM/PM";
                }

                //For display date end

                //ws.Rows().AdjustToContents();
                //ws.Columns().AdjustToContents();
                // Prepare the response
                HttpResponse httpResponse = Response;
                httpResponse.Clear();
                httpResponse.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                //Provide you file name here
                httpResponse.AddHeader("content-disposition", "attachment;filename=\"" + "Attendance" + ".xlsx\"");
                // Flush the workbook to the Response.OutputStream
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    wb.SaveAs(memoryStream);
                    memoryStream.WriteTo(httpResponse.OutputStream);
                    memoryStream.Close();
                }

                HttpContext.Current.Response.Flush(); // Sends all currently buffered output to the client.
                HttpContext.Current.Response.SuppressContent = true;  // Gets or sets a value indicating whether to send HTTP content to the client.
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {

            }

        }
        else
        {
            DataSet dataset = Session["table"] as DataSet;
            ClosedXML.Excel.XLWorkbook wbook = new ClosedXML.Excel.XLWorkbook();
            for (int i = 0; i < dataset.Tables.Count; i++)
            {
                wbook.Worksheets.Add(dataset.Tables[i], dataset.Tables[i].TableName);
            }

            // Prepare the response
            HttpResponse httpResponse = Response;
            httpResponse.Clear();
            httpResponse.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            //Provide you file name here
            httpResponse.AddHeader("content-disposition", "attachment;filename=\"" + "Attendance" + ".xlsx\"");
            // Flush the workbook to the Response.OutputStream
            using (MemoryStream memoryStream = new MemoryStream())
            {
                wbook.SaveAs(memoryStream);
                memoryStream.WriteTo(httpResponse.OutputStream);
                memoryStream.Close();
            }

            HttpContext.Current.Response.Flush(); // Sends all currently buffered output to the client.
            HttpContext.Current.Response.SuppressContent = true;  // Gets or sets a value indicating whether to send HTTP content to the client.
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }


    }

   







    private void bindDoneReminders(int User_Id)
    {
        try
        {
            DoneReminders = "";
            if (Session["admin_srno"] != null)
            {
                string[] col1 = { "@srno", "@Actiontype" };
                object[] val1 = { User_Id, "select9" };
                DataSet ds = dal.getDataSet("ManageLogin", col1, val1);
                string tableName = ds.Tables[0].Rows[0]["name"].ToString().Length > 30 ? ds.Tables[0].Rows[0]["name"].ToString().Substring(0, 30) : ds.Tables[0].Rows[0]["name"].ToString();
                DataTable table = new DataTable(tableName);
                table.Clear();
                table.Columns.Add("Coming Time", typeof(string));
                table.Columns.Add("Coming Message", typeof(string));
                table.Columns.Add("Going Time", typeof(string));
                table.Columns.Add("Going Message", typeof(string));
                table.Columns.Add("Total Company Time", typeof(string));
                table.Columns.Add("Total Time Spend", typeof(string));
                var list = new List<SqlParameter>();
                list.Add(new SqlParameter("@Id", "0"));
                list.Add(new SqlParameter("@User_Id", User_Id));
                list.Add(new SqlParameter("@Actiontype", "select6"));
                DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
                if (dt.Rows.Count > 0)
                {
                    var listdt1 = (from DataRow dr in dt.Rows
                                   select new MyModelClass()
                                   {
                                       Id = Convert.ToInt32(dr["Id"]),
                                       User_Id = Convert.ToInt32(dr["User_Id"]),
                                       Status = dr["Status"].ToString(),
                                       Timing = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                                       Going_Time = Convert.ToDateTime(dr["Going_Time1"].ToString()),
                                       Coming_Time = Convert.ToDateTime(dr["Coming_Time1"].ToString()),
                                   }).ToList();

                    var list1 = listdt1.GroupBy(n => new { n.Timing }).Select(g => g.FirstOrDefault()).OrderByDescending(c => c.Timing).ToList();

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string strDoneReminders = string.Empty;
                        for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                        {
                            foreach (var item in list1)
                            {
                                string Time = BindSpendTime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing);
                                string comingMessage1;
                                string goingMessage1;
                                string Company_Time = "0";
                                int isMeetingGoodMorning;
                                DataRow _dr = table.NewRow();
                                string comingtime1 = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning)).ToString("hh:mm tt");
                                string Date = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning)).ToString("dddd, dd MMMM yyyy");
                                string GoingTime1 = goingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out goingMessage1);
                                if (item.Going_Time.ToString() == item.Coming_Time.ToString())
                                {
                                    Company_Time = "User not say good night";
                                }
                                else
                                {
                                    double double_minutes = item.Going_Time.Subtract(item.Coming_Time).TotalMinutes;
                                    if (double_minutes > 60)
                                    {
                                        double Hours = double_minutes / 60;
                                        double Min = double_minutes % 60;
                                        Company_Time = Hours.ToString().Split('.').ElementAt(0) + " Hours " + Min.ToString("N0") + " Mins";
                                    }
                                    else
                                    {
                                        Company_Time = double_minutes.ToString("N0") + " Mins";
                                    }
                                }
                                strDoneReminders += "<table class='table table-bordered cart_summary'> <thead><tr>";
                                strDoneReminders += " <th style='text-align: left;'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</th>";
                                strDoneReminders += "<th align='right'>Coming Time :</th><th>" + comingtime1 + "(" + Date + ")</th></tr> </thead>";
                                strDoneReminders += "<tbody>";

                                _dr["Coming Time"] = comingtime1 + "(" + Date + ")";
                                //For Coming Message display, if any start
                                if (!String.IsNullOrEmpty(comingMessage1))
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    if (isMeetingGoodMorning == 1)
                                    {
                                        strDoneReminders += "<td>Meeting Good Morning Message</td>";
                                        _dr["Coming Message"] = "M " + comingMessage1;
                                    }
                                    else
                                    {
                                        strDoneReminders += "<td>Coming Message</td>";
                                        _dr["Coming Message"] = comingMessage1;
                                    }
                                    strDoneReminders += "<td>" + comingMessage1 + "</td></tr>";
                                }

                                string[] col2 = { "@Id", "@User_Id", "@Actiontype" };
                                object[] val2 = { "0", User_Id, "select1" };
                                DataSet ds2 = dal.getDataSet("TimeCalculator", col2, val2);
                                for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
                                {
                                    if (item.Timing.ToString("MM/dd/yyyy") == DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("MM/dd/yyyy"))
                                    {
                                        strDoneReminders += "<tr><td>&nbsp;</td>";
                                        string status = "";
                                        string CmpPor = "";
                                        status = ds2.Tables[0].Rows[k]["Status"].ToString();
                                        if (status == "In")
                                        {
                                            CmpPor = ds2.Tables[0].Rows[k - 1]["Company_Purpose"].ToString();
                                            if (CmpPor != "")
                                            {
                                                strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " (" + (double.Parse(ds2.Tables[0].Rows[k]["Company_Purpose_S_Time"].ToString()) / 60).ToString("N0") + " Mins Company purpose) </td>";
                                            }
                                            else
                                            {
                                                strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</td>";
                                            }
                                        }
                                        else
                                        {
                                            strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</td>";

                                        }
                                        strDoneReminders += "<td>" + DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("h:mm tt") + "</td>";
                                    }
                                }
                                strDoneReminders += "<tr><td>&nbsp;</td>";
                                strDoneReminders += "<td><strong> Total time spend</strong></td>";
                                strDoneReminders += "<td>" + Time + " mins</td>";
                                if (GoingTime1 != "")
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";

                                    strDoneReminders += "<td><strong> Going Time</strong></td>";
                                    strDoneReminders += "<td>" + GoingTime1 + "</td>";
                                    _dr["Going Time"] = GoingTime1;
                                }


                                //For Going Message display, if any start
                                if (!String.IsNullOrEmpty(goingMessage1))
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    if (isMeetingGoodMorning == 1)
                                    {
                                        strDoneReminders += "<td>Meeting Good Night Message</td>";
                                        _dr["Going Message"] = "M " + goingMessage1;
                                    }
                                    else
                                    {
                                        strDoneReminders += "<td>Going Message</td>";
                                        _dr["Going Message"] = goingMessage1;
                                    }

                                    strDoneReminders += "<td>" + goingMessage1 + "</td></tr>";
                                }
                                _dr["Total Company Time"] = Company_Time;
                                _dr["Total Time Spend"] = Time;
                                //For Going Message display, if any end

                                strDoneReminders += "</tbody>";
                                strDoneReminders += "</table>";
                                table.Rows.Add(_dr);
                            }

                        }
                        DoneReminders += strDoneReminders;
                        if (table.Rows.Count > 0)
                        {
                            download_XL.Visible = true;
                        }
                        else
                        {
                            download_XL.Visible = false;
                        }
                        DataSet tableCollection = new DataSet();
                        tableCollection.Clear();
                        tableCollection.Tables.Add(table);
                        Session["table"] = tableCollection;
                    }
                }
                else
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string strDoneReminders = string.Empty;
                        for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                        {
                            string[] col2 = { "@Id", "@User_Id", "@Actiontype" };
                            object[] val2 = { "0", User_Id, "select1" };
                            DataSet ds2 = dal.getDataSet("ManageAttendance", col2, val2);

                            for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
                            {
                                string Time = BindSpendTime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()));
                                string comingMessage1;
                                string goingMessage1;
                                string Company_Time = "0";
                                int isMeetingGoodMorning;

                                DataRow _dr = table.NewRow();

                                string comingtime1 = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out comingMessage1, out isMeetingGoodMorning)).ToString("hh:mm tt");
                                string Date = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out comingMessage1, out isMeetingGoodMorning)).ToString("dddd, dd MMMM yyyy");
                                string GoingTime1 = goingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out goingMessage1);

                                strDoneReminders += "<table class='table table-bordered cart_summary'> <thead><tr>";
                                strDoneReminders += " <th style='text-align: left;'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</th>";
                                strDoneReminders += "<th align='right'>Coming Time :</th><th>" + comingtime1 + "(" + Date + ")</th></tr> </thead>";
                                strDoneReminders += "<tbody>";
                                _dr["Coming Time"] = comingtime1 + "(" + Date + ")";

                                //For Coming Message display, if any start
                                if (!String.IsNullOrEmpty(comingMessage1))
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    if (isMeetingGoodMorning == 1)
                                    {
                                        strDoneReminders += "<td>Meeting Good Morning Message</td>";
                                        _dr["Coming Message"] = "M " + comingMessage1;
                                    }
                                    else
                                    {
                                        strDoneReminders += "<td>Coming Message</td>";
                                        _dr["Coming Message"] = comingMessage1;
                                    }
                                    strDoneReminders += "<td>" + comingMessage1 + "</td></tr>";
                                }
                                //For Coming Message display, if any end  
                                strDoneReminders += "<tr><td>&nbsp;</td>";
                                strDoneReminders += "<td><strong> Total time spend</strong></td>";
                                strDoneReminders += "<td>" + Time + " mins</td>";

                                if (GoingTime1 != "")
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    strDoneReminders += "<td><strong> Going Time</strong></td>";
                                    strDoneReminders += "<td>" + GoingTime1 + "</td>";
                                    _dr["Going Time"] = GoingTime1;
                                }


                                //For Going Message display, if any start
                                if (!String.IsNullOrEmpty(goingMessage1))
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    if (isMeetingGoodMorning == 1)
                                    {
                                        strDoneReminders += "<td>Meeting Good Night Message</td>";
                                        _dr["Going Message"] = "M " + goingMessage1;
                                    }
                                    else
                                    {
                                        strDoneReminders += "<td>Going Message</td>";
                                        _dr["Going Message"] = goingMessage1;
                                    }
                                    strDoneReminders += "<td>" + goingMessage1 + "</td></tr>";
                                }
                                _dr["Total Company Time"] = Company_Time;
                                _dr["Total Time Spend"] = Time;
                                //For Going Message display, if any end

                                strDoneReminders += "</tbody>";
                                strDoneReminders += "</table>";
                                table.Rows.Add(_dr);
                            }
                        }
                        DoneReminders += strDoneReminders;
                        if (table.Rows.Count > 0)
                        {
                            download_XL.Visible = true;
                        }
                        else
                        {
                            download_XL.Visible = false;
                        }
                        DataSet tableCollection = new DataSet();
                        tableCollection.Clear();
                        tableCollection.Tables.Add(table);
                        Session["table"] = tableCollection;
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    private void bindDoneReminders(int User_Id, DateTime? StartDate, DateTime? EndDate=null)
    {
        try
        {
            DoneReminders = "";
            if (Session["admin_srno"] != null)
            {
                string[] col1 = { "@srno", "@Actiontype","@StartDate","@EndDate" };
                object[] val1 = { User_Id, "select9", StartDate, EndDate };
                DataSet ds = dal.getDataSet("ManageLogin", col1, val1);

                string tableName = ds.Tables[0].Rows[0]["name"].ToString().Length > 30 ? ds.Tables[0].Rows[0]["name"].ToString().Substring(0, 30) : ds.Tables[0].Rows[0]["name"].ToString();
                DataTable table = new DataTable(tableName);
                table.Clear();
                table.Columns.Add("Coming Time", typeof(string));
                table.Columns.Add("Coming Message", typeof(string));
                table.Columns.Add("Going Time", typeof(string));
                table.Columns.Add("Going Message", typeof(string));
                table.Columns.Add("Total Company Time", typeof(string));
                table.Columns.Add("Total Time Spend", typeof(string));

                var list = new List<SqlParameter>();
                list.Add(new SqlParameter("@Id", "0"));
                list.Add(new SqlParameter("@StartDate", StartDate));
                list.Add(new SqlParameter("@EndDate", EndDate));
                list.Add(new SqlParameter("@User_Id", User_Id));
                list.Add(new SqlParameter("@Actiontype", "select7"));
                DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
                if (dt.Rows.Count > 0)
                {
                    var listdt1 = (from DataRow dr in dt.Rows
                                   select new MyModelClass()
                                   {
                                       Id = Convert.ToInt32(dr["Id"]),
                                       User_Id = Convert.ToInt32(dr["User_Id"]),
                                       Status = dr["Status"].ToString(),
                                       Timing = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                                       Going_Time = Convert.ToDateTime(dr["Going_Time1"].ToString()),
                                       Coming_Time = Convert.ToDateTime(dr["Coming_Time1"].ToString()),
                                   }).ToList();

                    var list1 = listdt1.GroupBy(n => new { n.Timing }).Select(g => g.FirstOrDefault()).OrderByDescending(c => c.Timing).ToList();


                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string strDoneReminders = string.Empty;
                        for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                        {
                            foreach (var item in list1)
                            {
                                string Time = BindSpendTime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing);
                                string comingMessage1;
                                string goingMessage1;
                                string Company_Time = "0";
                                int isMeetingGoodMorning;
                                DataRow _dr = table.NewRow();
                                string comingtime1 = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning)).ToString("hh:mm tt");
                                string Date = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning)).ToString("dddd, dd MMMM yyyy"); ;
                                string GoingTime1 = goingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out goingMessage1);
                                if (item.Going_Time.ToString() == item.Coming_Time.ToString())
                                {
                                    Company_Time = "User not say good night";
                                }
                                else
                                {
                                    double double_minutes = item.Going_Time.Subtract(item.Coming_Time).TotalMinutes;
                                    if (double_minutes > 60)
                                    {
                                        double Hours = double_minutes / 60;
                                        double Min = double_minutes % 60;
                                        Company_Time = Hours.ToString().Split('.').ElementAt(0) + " Hours " + Min.ToString("N0") + " Mins";
                                    }
                                    else
                                    {
                                        Company_Time = double_minutes.ToString("N0") + " Mins";
                                    }
                                }
                                strDoneReminders += "<table class='table table-bordered cart_summary'> <thead><tr>";
                                strDoneReminders += " <th style='text-align: left;'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</th>";
                                strDoneReminders += "<th align='right'>Coming Time :</th><th>" + comingtime1 + " (" + Date + ")</th></tr> </thead>";
                                strDoneReminders += "<tbody>";
                                _dr["Coming Time"] = comingtime1 + "(" + Date + ")";
                                //For Coming Message display, if any start
                                if (!String.IsNullOrEmpty(comingMessage1))
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    if (isMeetingGoodMorning == 1)
                                    {
                                        strDoneReminders += "<td>Meeting Good Morning Message</td>";
                                        _dr["Coming Message"] = "M" + comingMessage1;
                                    }
                                    else
                                    {
                                        strDoneReminders += "<td>Coming Message</td>";
                                        _dr["Coming Message"] = comingMessage1;
                                    }
                                    strDoneReminders += "<td>" + comingMessage1 + "</td></tr>";
                                }
                                //For Coming Message display, if any end

                                string[] col2 = { "@Id", "@User_Id", "@Actiontype" };
                                object[] val2 = { "0", ds.Tables[0].Rows[j]["srno"], "Select1" };
                                DataSet ds2 = dal.getDataSet("TimeCalculator", col2, val2);
                                for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
                                {
                                    if (item.Timing.ToString("MM/dd/yyyy") == DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("MM/dd/yyyy"))
                                    {
                                        strDoneReminders += "<tr><td>&nbsp;</td>";
                                        string status = "";
                                        string CmpPor = "";
                                        status = ds2.Tables[0].Rows[k]["Status"].ToString();
                                        if (status == "In")
                                        {
                                            CmpPor = ds2.Tables[0].Rows[k - 1]["Company_Purpose"].ToString();
                                            if (CmpPor != "")
                                            {
                                                strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " (" + (double.Parse(ds2.Tables[0].Rows[k]["Company_Purpose_S_Time"].ToString()) / 60).ToString("N0") + " Mins Company purpose) </td>";
                                            }
                                            else
                                            {
                                                strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</td>";
                                            }
                                        }
                                        else
                                        {
                                            strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</td>";
                                        }
                                        strDoneReminders += "<td>" + DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("h:mm tt") + "</td>";
                                    }
                                }
                                strDoneReminders += "<tr><td>&nbsp;</td>";
                                strDoneReminders += "<td><strong> Total time spend</strong></td>";
                                strDoneReminders += "<td>" + Time + " mins</td>";
                                if (GoingTime1 != "")
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    strDoneReminders += "<td><strong> Going Time</strong></td>";
                                    strDoneReminders += "<td>" + GoingTime1 + "</td>";
                                    _dr["Going Time"] = GoingTime1;
                                }

                                //For Going Message display, if any start
                                if (!String.IsNullOrEmpty(goingMessage1))
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    if (isMeetingGoodMorning == 1)
                                    {
                                        strDoneReminders += "<td>Meeting Good Night Message</td>";
                                        _dr["Going Message"] = "M" + goingMessage1;
                                    }
                                    else
                                    {
                                        strDoneReminders += "<td>Going Message</td>";
                                        _dr["Going Message"] = goingMessage1;
                                    }
                                    strDoneReminders += "<td>" + goingMessage1 + "</td></tr>";
                                }
                                _dr["Total Company Time"] = Company_Time;
                                _dr["Total Time Spend"] = Time;
                                //For Going Message display, if any end

                                strDoneReminders += "</tbody>";
                                strDoneReminders += "</table>";
                                table.Rows.Add(_dr);
                            }
                        }
                        DoneReminders += strDoneReminders;
                        if (table.Rows.Count > 0)
                        {
                            download_XL.Visible = true;
                        }
                        else
                        {
                            download_XL.Visible = false;
                        }
                        DataSet tableCollection = new DataSet();
                        tableCollection.Clear();
                        tableCollection.Tables.Add(table);
                        Session["table"] = tableCollection;
                    }
                }
                else
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string strDoneReminders = string.Empty;
                        for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                        {
                            string[] col2 = { "@Id", "@User_Id", "@StartDate", "@EndDate", "@Actiontype" };
                            object[] val2 = { "0", User_Id, StartDate, EndDate, "select5" };
                            DataSet ds2 = dal.getDataSet("ManageAttendance", col2, val2);

                            for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
                            {
                                string Time = BindSpendTime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()));
                                string comingMessage1;
                                string goingMessage1;
                                string Company_Time = "0";
                                int isMeetingGoodMorning;
                                DataRow _dr = table.NewRow();
                                string comingtime1 = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out comingMessage1, out isMeetingGoodMorning)).ToString("hh:mm tt");
                                string Date = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out comingMessage1, out isMeetingGoodMorning)).ToString("dddd, dd MMMM yyyy");
                                string GoingTime1 = goingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), DateTime.Parse(ds2.Tables[0].Rows[k]["Coming_Time"].ToString()), out goingMessage1);

                                strDoneReminders += "<table class='table table-bordered cart_summary'> <thead><tr>";
                                strDoneReminders += " <th style='text-align: left;'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</th>";
                                strDoneReminders += "<th align='right'>Coming Time :</th><th>" + comingtime1 + "(" + Date + ")</th></tr> </thead>";
                                strDoneReminders += "<tbody>";
                                _dr["Coming Time"] = comingtime1 + "(" + Date + ")";
                                //For Coming Message display, if any start
                                if (!String.IsNullOrEmpty(comingMessage1))
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";

                                    if (isMeetingGoodMorning == 1)
                                    {
                                        strDoneReminders += "<td>Meeting Good Morning Message</td>";
                                        _dr["Coming Message"] = "M " + comingMessage1;
                                    }
                                    else
                                    {
                                        strDoneReminders += "<td>Coming Message</td>";
                                        _dr["Coming Message"] = comingMessage1;
                                    }
                                    strDoneReminders += "<td>" + comingMessage1 + "</td></tr>";
                                }
                                //For Coming Message display, if any end  
                                strDoneReminders += "<tr><td>&nbsp;</td>";
                                strDoneReminders += "<td><strong> Total time spend</strong></td>";
                                strDoneReminders += "<td>" + Time + " mins</td>";
                                if (GoingTime1 != "")
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    strDoneReminders += "<td><strong> Going Time</strong></td>";
                                    strDoneReminders += "<td>" + GoingTime1 + "</td>";
                                    _dr["Going Time"] = GoingTime1;
                                }

                                //For Going Message display, if any start
                                if (!String.IsNullOrEmpty(goingMessage1))
                                {
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    if (isMeetingGoodMorning == 1)
                                    {
                                        strDoneReminders += "<td>Meeting Good Night Message</td>";
                                        _dr["Going Message"] = "M " + goingMessage1;
                                    }
                                    else
                                    {
                                        strDoneReminders += "<td>Going Message</td>";
                                        _dr["Going Message"] = goingMessage1;
                                    }
                                    strDoneReminders += "<td>" + goingMessage1 + "</td></tr>";
                                }
                                _dr["Total Company Time"] = Company_Time;
                                _dr["Total Time Spend"] = Time;
                                //For Going Message display, if any end

                                strDoneReminders += "</tbody>";
                                strDoneReminders += "</table>";
                                table.Rows.Add(_dr);
                            }
                        }
                        DoneReminders += strDoneReminders;
                        if (table.Rows.Count > 0)
                        {
                            download_XL.Visible = true;
                        }
                        else
                        {
                            download_XL.Visible = false;
                        }
                        DataSet tableCollection = new DataSet();
                        tableCollection.Clear();
                        tableCollection.Tables.Add(table);
                        Session["table"] = tableCollection;
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    private void bindDoneReminders(DateTime StartDate,DateTime? EndDate=null)
    {
        DataSet tableCollection = new DataSet();
        tableCollection.Clear();
        try
        {
            DoneReminders = "";
            if (Session["admin_srno"] != null)
            {
                string[] col1 = { "@srno", "@Actiontype", "@StartDate", "@EndDate" };
                object[] val1 = { "0", "bindUser1", StartDate, EndDate };
                DataSet ds = dal.getDataSet("ManageLogin", col1, val1);
                
                var list = new List<SqlParameter>();
                list.Add(new SqlParameter("@Id", "0"));
                list.Add(new SqlParameter("@StartDate", StartDate));
                list.Add(new SqlParameter("@EndDate", EndDate));
                list.Add(new SqlParameter("@Actiontype", "select8"));
                DataTable dt = dal.getdataTable("ManageAttendance", list.ToArray());
                if (dt.Rows.Count > 0)
                {
                    var listdt1 = (from DataRow dr in dt.Rows
                                   select new MyModelClass()
                                   {
                                       Id = Convert.ToInt32(dr["Id"]),
                                       User_Id = Convert.ToInt32(dr["User_Id"]),
                                       Status = dr["Status"].ToString(),
                                       Timing = Convert.ToDateTime(dr["Coming_Time"].ToString()),
                                   }).ToList();

                    var list1 = listdt1.GroupBy(n => new { n.Timing }).Select(g => g.FirstOrDefault()).ToList();

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string strDoneReminders = string.Empty;
                        for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                        {
                            string tableName = ds.Tables[0].Rows[j]["name"].ToString().Length > 30 ? ds.Tables[0].Rows[j]["name"].ToString().Substring(0, 30) : ds.Tables[0].Rows[j]["name"].ToString();
                            DataTable table = new DataTable(tableName+j);
                            table.Clear();
                            table.Columns.Add("Coming Time", typeof(string));
                            table.Columns.Add("Coming Message", typeof(string));
                            table.Columns.Add("Going Time", typeof(string));
                            table.Columns.Add("Going Message", typeof(string));
                            table.Columns.Add("Total Company Time", typeof(string));
                            table.Columns.Add("Total Time Spend", typeof(string));

                            foreach (var item in list1)
                            {
                                DataRow _dr = table.NewRow();
                                string comingMessage1;
                                string goingMessage1;
                                int isMeetingGoodMorning;
                                string Company_Time = "0";
                                string Time = BindSpendTime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing);
                                string comingtime1 = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning)).ToString("hh:mm tt");
                                string Date = comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning) == "" ? "" : DateTime.Parse(comingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out comingMessage1, out isMeetingGoodMorning)).ToString("dddd, dd MMMM yyyy"); ;
                                string GoingTime1 = goingtime(int.Parse(ds.Tables[0].Rows[j]["srno"].ToString()), item.Timing, out goingMessage1);
                                if (item.Going_Time.ToString() == item.Coming_Time.ToString())
                                {
                                    Company_Time = "User not say good night";
                                }
                                else
                                {
                                    double double_minutes = item.Going_Time.Subtract(item.Coming_Time).TotalMinutes;
                                    if (double_minutes > 60)
                                    {
                                        double Hours = double_minutes / 60;
                                        double Min = double_minutes % 60;
                                        Company_Time = Hours.ToString().Split('.').ElementAt(0) + " Hours " + Min.ToString("N0") + " Mins";
                                    }
                                    else
                                    {
                                        Company_Time = double_minutes.ToString("N0") + " Mins";
                                    }
                                }
                                if (comingtime1 != "")
                                {
                                    strDoneReminders += "<table class='table table-bordered cart_summary'> <thead><tr>";
                                    strDoneReminders += " <th style='text-align: left;'>" + ds.Tables[0].Rows[j]["name"].ToString() + "</th>";
                                    strDoneReminders += "<th align='right'>Coming Time :</th><th>" + comingtime1 + "(" + Date + ")</th></tr> </thead>";
                                    strDoneReminders += "<tbody>";
                                    _dr["Coming Time"] = comingtime1 + "(" + Date + ")";

                                    //For Coming Message display, if any start
                                    if (!String.IsNullOrEmpty(comingMessage1))
                                    {
                                        strDoneReminders += "<tr><td>&nbsp;</td>";

                                        if (isMeetingGoodMorning == 1)
                                        {
                                            strDoneReminders += "<td>Meeting Good Morning Message</td>";
                                            _dr["Coming Message"] = "M " + comingMessage1;
                                        }
                                        else
                                        {
                                            strDoneReminders += "<td>Coming Message</td>";
                                            _dr["Coming Message"] = comingMessage1;
                                        }
                                        strDoneReminders += "<td>" + comingMessage1 + "</td></tr>";
                                    }
                                    //For Coming Message display, if any end

                                    string[] col2 = { "@Id", "@User_Id", "@Actiontype" };
                                    object[] val2 = { "0", ds.Tables[0].Rows[j]["srno"], "Select1" };
                                    DataSet ds2 = dal.getDataSet("TimeCalculator", col2, val2);
                                    for (int k = 0; k < ds2.Tables[0].Rows.Count; k++)
                                    {
                                        if (item.Timing.ToString("MM/dd/yyyy") == DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("MM/dd/yyyy"))
                                        {
                                            strDoneReminders += "<tr><td>&nbsp;</td>";
                                            string status = "";
                                            string CmpPor = "";
                                            status = ds2.Tables[0].Rows[k]["Status"].ToString();
                                            if (status == "In")
                                            {
                                                CmpPor = ds2.Tables[0].Rows[k - 1]["Company_Purpose"].ToString();
                                                if (CmpPor != "")
                                                {
                                                    strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " (" + (double.Parse(ds2.Tables[0].Rows[k]["Company_Purpose_S_Time"].ToString()) / 60).ToString("N0") + " Mins Company purpose) </td>";
                                                }
                                                else
                                                {
                                                    strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</td>";
                                                }
                                            }
                                            else
                                            {
                                                strDoneReminders += "<td>" + ds2.Tables[0].Rows[k]["Status"] + " " + ds2.Tables[0].Rows[k]["Company_Purpose"] + " " + "</td>";

                                            }
                                            strDoneReminders += "<td>" + DateTime.Parse(ds2.Tables[0].Rows[k]["Timing"].ToString()).ToString("h:mm tt") + "</td>";
                                        }
                                    }
                                    strDoneReminders += "<tr><td>&nbsp;</td>";
                                    strDoneReminders += "<td><strong> Total time spend</strong></td>";
                                    strDoneReminders += "<td>" + Time + " mins</td>";

                                    if (GoingTime1 != "")
                                    {
                                        strDoneReminders += "<tr><td>&nbsp;</td>";
                                        strDoneReminders += "<td><strong> Going Time</strong></td>";
                                        strDoneReminders += "<td>" + GoingTime1 + "</td>";
                                        _dr["Going Time"] = GoingTime1;
                                    }

                                    //For Going Message display, if any start
                                    if (!String.IsNullOrEmpty(goingMessage1))
                                    {
                                        strDoneReminders += "<tr><td>&nbsp;</td>";

                                        if (isMeetingGoodMorning == 1)
                                        {
                                            strDoneReminders += "<td>Meeting Good Night Message</td>";
                                            _dr["Going Message"] = "M " + goingMessage1;
                                        }
                                        else
                                        {
                                            strDoneReminders += "<td>Going Message</td>";
                                            _dr["Going Message"] = goingMessage1;
                                        }
                                        strDoneReminders += "<td>" + goingMessage1 + "</td></tr>";
                                    }
                                    //For Going Message display, if any end
                                    _dr["Total Company Time"] = Company_Time;
                                    _dr["Total Time Spend"] = Time;
                                    strDoneReminders += "</tbody>";
                                    strDoneReminders += "</table>";
                                    table.Rows.Add(_dr);
                                }
                                
                                
                            }
                            tableCollection.Tables.Add(table);
                        }
                        Session["table"] = tableCollection;
                        DoneReminders += strDoneReminders;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            tableCollection.Clear();
        }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        try
        {

            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");


            int User_Id = int.Parse(ddlusers.SelectedValue);
            if (User_Id > 0)
            {
                //download_XL.Visible = true;
                if (txt_to.Text != "")
                { 
                    bindDoneReminders(User_Id, DateTime.Parse(txt_from.Text), DateTime.Parse(txt_to.Text));
                    }
                else
                    bindDoneReminders(User_Id, DateTime.Parse(txt_from.Text));
            }
            else
            {//In case of All
                //download_XL.Visible = false;
                if (txt_to.Text != "")
                    bindDoneReminders(DateTime.Parse(txt_from.Text), DateTime.Parse(txt_to.Text));
                else
                    bindDoneReminders(DateTime.Parse(txt_from.Text));
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    private void GetoutsideEmp()
    {

        string[] col1 = { "@srno", "@Actiontype" };
        object[] val1 = { "0", "select8" };
        DataSet ds = dal.getDataSet("ManageLogin", col1, val1);

        if (ds.Tables[0].Rows.Count > 0)
        {
            string strDoneReminders = string.Empty;
            for (int k = 0; k < ds.Tables[0].Rows.Count; k++)
            {
                var list = new List<SqlParameter>();
                list.Add(new SqlParameter("@Id", "0"));
                list.Add(new SqlParameter("@User_Id", int.Parse(ds.Tables[0].Rows[k]["srno"].ToString())));
                list.Add(new SqlParameter("@Actiontype", "Select2"));
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
                                   }).LastOrDefault();
                    if (listdt1 != null)
                    {
                        if (listdt1.Status == "Out")
                        {
                            strDoneReminders += "<tr><th style='text-align: left;'>" + ds.Tables[0].Rows[k]["name"] + "</th><th align='right'>Out Side :</th><th>" + listdt1.Timing.ToString("h:mm tt") + "</th>";

                        }
                    }
                }
            }
            Outside += strDoneReminders;
        }
    }
}

