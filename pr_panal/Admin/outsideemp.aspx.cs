using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    MainClass dut = new MainClass();
    DataAccessLayer dal = new DataAccessLayer();
    public string Outside = string.Empty; 

    protected void Page_Load(object sender, EventArgs e) 
    {
        if (!IsPostBack)
        {
            if (Session["admin_srno"] == null)
                Response.Redirect("~/Pr-Admin-Log");
            GetoutsideEmp();
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
        public DateTime Coming_Time { get; set; }
        public DateTime Going_Time { get; set; }
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