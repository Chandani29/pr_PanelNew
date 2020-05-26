using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Net.Mail;
using System.Net.Configuration;
using System.Net;
using System.IO;
using System.Text;

/// <summary>
/// Summary description for MainClass
/// </summary>
public class MainClass
{
    public MainClass()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region All class variables
    //Declare all class variables here
    SqlConnection mCon;
    SqlCommand mDataCom;
    SqlDataAdapter mDa;
    string mstr_injectionbody = "";
    #endregion

    #region All private methods
    ///<summary>
    ///this is to use for open,close and dispose connection and command objects
    ///</summary>
    private void OpenConnection()
    {
        if (mCon == null)
        {
            mCon = new SqlConnection(ConfigurationManager.AppSettings["conString"]);
        }
        if (mCon.State == ConnectionState.Closed)
        {
            mCon.Open();
        }
        mDataCom = new SqlCommand();
        mDataCom.Connection = mCon;

    }

    private void CloseConnection()
    {
        if (mCon.State == ConnectionState.Open)
            mCon.Close();
    }
    private void DisposeConnection()
    {
        if (mCon != null)
        {
            mCon.Dispose();
            mCon = null;
        }
    }
    #endregion

    #region all public methods
    ///<summary>
    ///this is to use for executing sql DML statements and stored procedures
    ///</summary>
    public int ExecuteSql(String Sql)
    {
        OpenConnection();
        //Set command object properties
        mDataCom.CommandType = CommandType.Text;
        mDataCom.CommandText = Sql;
        mDataCom.CommandTimeout = 2000;
        int result = mDataCom.ExecuteNonQuery();
        CloseConnection();
        DisposeConnection();
        return result;
    }

    ///<summary>
    ///this is to use for executing sql DQL statements and stored procedures
    ///</summary>
    public int ExecuteProcedure(SqlCommand cmd)
    {
        try
        {
            OpenConnection();
            cmd.Connection = mCon;
            int x = cmd.ExecuteNonQuery();
            return x;
        }
        catch (Exception exp)
        {
            throw exp;
        }
        finally
        {
            CloseConnection();
            DisposeConnection();
        }
    }///

    public bool IsExist(String Sql)
    {
        OpenConnection();
        mDataCom.CommandType = CommandType.Text;
        mDataCom.CommandText = Sql;
        mDataCom.CommandTimeout = 2000;
        int result = (int)mDataCom.ExecuteScalar();
        CloseConnection();
        DisposeConnection();
        if (result > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    ///<summary>
    ///this is to use for executing DataReader
    ///</summary>
    public SqlDataReader GetDataReader(String Sql)
    {
        SqlDataReader dReader;
        OpenConnection();
        mDataCom.CommandType = CommandType.Text;
        mDataCom.CommandText = Sql;
        mDataCom.CommandTimeout = 2000;
        dReader = mDataCom.ExecuteReader(CommandBehavior.CloseConnection);

        return dReader;

    }
    ///<summary>
    ///this is to use for executing DataReader
    ///</summary>
    public DataTable GetDataTable(string Sql)
    {
        DataTable dt = new DataTable();
        OpenConnection();
        mDataCom.CommandType = CommandType.Text;
        mDataCom.CommandText = Sql;
        mDataCom.CommandTimeout = 2000;
        mDa = new SqlDataAdapter();
        mDa.SelectCommand = mDataCom;
        mDa.Fill(dt);
        CloseConnection();

        DisposeConnection();
        return dt;
    }
    ///<summary>
    ///this is to use for executing DataSet
    ///</summary>
    public DataSet GetDataSet(string Sql)
    {
        DataSet ds = new DataSet();
        OpenConnection();
        mDataCom.CommandType = CommandType.Text;
        mDataCom.CommandText = Sql;
        mDataCom.CommandTimeout = 2000;
        mDa = new SqlDataAdapter();
        mDa.SelectCommand = mDataCom;

        mDa.Fill(ds);
        CloseConnection();

        DisposeConnection();
        return ds;
    }
    ///<summary>
    ///code for sending email
    ///</summary>

    public bool sendemail(string from, string fromName, string to, string toName, string sub, string bodytext)
    {
        SmtpClient client = new SmtpClient("mail.webdevelopdelhi.com", 25);
        client.DeliveryMethod = SmtpDeliveryMethod.Network;


        //Some SMTP server will require that you first 
        //authenticate against the server.

        NetworkCredential oCredential = new NetworkCredential("testing@webdevelopdelhi.com", "Testing@32");
        client.UseDefaultCredentials = false;
        client.Credentials = oCredential;

        //Let's send it already


        MailAddress sendfrom = new MailAddress(from, fromName);
        MailAddress sendto = new MailAddress(to, toName);
        MailMessage message = new MailMessage(sendfrom, sendto);

        message.IsBodyHtml = true;
        message.Subject = sub;
        //message.CC.Add(cc);
        //string fullText = "<font face=verdana color=navy>Hi Dear :" + (string)Session["name"] + "<br>your file is:" + strFileName + "</font>";
        message.Body = bodytext;

        try
        {
            client.Send(message);

            return true;
        }
        catch (Exception ex)
        {
            //using some log component, you can remove this lines if you want
            return false;
        }
    }

    public bool sendssemail(string from, string fromName, string to, string toName, string sub, string bodytext)
    {
        SmtpClient client = new SmtpClient("mail.webdesignseodelhi.com", 587);
        client.DeliveryMethod = SmtpDeliveryMethod.Network;

        //Some SMTP server will require that you first 
        //authenticate against the server.

        NetworkCredential oCredential = new NetworkCredential("test@webdesignseodelhi.com", "testing123");
        client.UseDefaultCredentials = false;
        client.Credentials = oCredential;

        //Let's send it already

        MailAddress sendfrom = new MailAddress(from, fromName);
        MailAddress sendto = new MailAddress(to, toName);
        MailMessage message = new MailMessage(sendfrom, sendto);
        //message.IsBodyHtml = false;
        message.IsBodyHtml = true;
        message.Subject = sub;
        string cc = "shambhusharansweet@gmail.com";
        message.CC.Add(cc);
        //message.CC.Add(cc);
        //string fullText = "<font face=verdana color=navy>Hi Dear :" + (string)Session["name"] + "<br>your file is:" + strFileName + "</font>";
        message.Body = bodytext;

        try
        {
            client.Send(message);
            return true;
        }
        catch (Exception ex)
        {
            //using some log component, you can remove this lines if you want
            return false;
        }
    }
    ///<summary>
    ///code for appending strings in stringbuilder for body of the email
    ///</summary>    
    public string appendstrings(string[] strArray)
    {
        StringBuilder SB = new StringBuilder();
        foreach (string str in strArray)
        {
            SB.Append(str + "\n");
        }
        return SB.ToString();
    }
    ///<summary>
    ///code for sql injection
    ///</summary>
    ///
    public void CheckInjectionChars(string strWords)
    {
        string mstr_newChars = "";

        string[] mstr_badChars = new string[] { "select", "select ", "select%20", "truncate", "truncate ", "truncate%20", "drop", "drop ", "drop%20", "information", "information ", "information%20", "schema", "schema ", "schema%20", "database", "database ", "database%20", "TABLES", "TABLES ", "TABLES%20", "columns", "columns ", "columns%20", ";", "; ", ";%20", "%2A", "%2B", "%2C", "%2D", "%2E", "%2F", "--", "-- ", "--%20", "insert", "insert ", "insert%20", "delete", "delete ", "delete%20", "xp_", "xp_ ", "xp_%20", "sp_", "sp_ ", "sp_%20", "update", "update ", "update%20", "ntext", "ntext ", "ntext%20", "nchar", "nchar ", "nchar%20", "varchar", "varchar ", "varchar%20", "char", "char ", "char%20", "nvarchar", "nvarchar ", "nvarchar%20", "alter", "alter ", "alter%20", "begin", "begin ", "begin%20", "create", "create ", "create%20", "cursor", "cursor ", "cursor%20", "declare", "declare ", "declare%20", "exec", "exec ", "exec%20", "execute", "execute ", "execute%20", "fetch", "fetch ", "fetch%20", "kill", "kill ", "kill%20", "open", "open ", "open%20", "sys", "sys ", "sys%20", "sysobjects", "sysobjects ", "sysobjects%20", "syscolumns", "syscolumns ", "syscolumns%20", "rsquo", "rsquo ", "rsquo%20", "<", ">", "<script>", "</script>", "&lt;", "&gt;", "^*", "<script", "</script", "script", "title", "<title>", "</title>", "<title", "</title", "php", "&#60;", "&#62;" };

        mstr_newChars = strWords;

        for (int i_quick = 0; i_quick < mstr_badChars.Length; i_quick++)
        {
            if ((mstr_newChars.ToUpper().IndexOf(mstr_badChars[i_quick].ToUpper())) > 0)
            {
                mstr_injectionbody = "It seems that SQL Injection is being attempted by a viewer at " + System.DateTime.Now.ToLocalTime().ToString() + " (" + mstr_badChars[i_quick] + "). The viewer details are as under. The action perfoprmed by the viewer, if any, was not restricted. The complete details of the viewer is as under: <br>";
                mstr_injectionbody = mstr_injectionbody + "<b>Referred by : </b>" + HttpContext.Current.Request.ServerVariables["HTTP_REFERRER"] + "<br><br>";
                mstr_injectionbody = mstr_injectionbody + "<b>CLIENT IP: </b>" + HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] + "<br><br>";

                foreach (string x in HttpContext.Current.Request.ServerVariables)
                {
                    mstr_injectionbody = mstr_injectionbody + "<br><b>" + x + "</b>::::" + HttpContext.Current.Request.ServerVariables[x];
                }

                string[] strArrayMail = { "Injection Details: " + mstr_injectionbody.ToString().Trim() };

                string fullTextMail = appendstrings(strArrayMail);

                //if (sendemail("Injection@ScriptInjection.com", "Script Injection", "sandeep@aksindia.com", "Sandeep", "Mail From Script Injection (rwajaypeegreens.com)", fullTextMail))
                //{
                //lblerrMsg.ForeColor = System.Drawing.Color.Green;
                //lblerrMsg.Text = "Mail Sent Successfully.";
                //}
                //else
                //{
                //lblerrMsg.ForeColor = System.Drawing.Color.Red;
                //lblerrMsg.Text = "Email not sent.";
                //}

                HttpContext.Current.Response.Redirect("thanks.aspx");
                break;
            }
        }
    }

    public void ClearControls(Control parent)
    {
        foreach (Control _ChildControl in parent.Controls)
        {
            if ((_ChildControl.Controls.Count > 0))
            {
                ClearControls(_ChildControl);
            }
            else
            {
                if (_ChildControl is TextBox)
                {
                    ((TextBox)_ChildControl).Text = string.Empty;
                }
                else
                    if (_ChildControl is CheckBox)
                    {
                        ((CheckBox)_ChildControl).Checked = false;
                    }

            }
        }
    }


    #endregion
}