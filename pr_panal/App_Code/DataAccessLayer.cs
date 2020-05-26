using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.UI;

/// <summary>
/// Summary description for DataAccessLayer
/// </summary> 
public class DataAccessLayer
{
    public DataAccessLayer()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string constr
    {
        get
        {
            return (System.Configuration.ConfigurationManager.AppSettings["conString"].ToString());
        }
    }

    public DataSet retDataset(string procnamwe)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand(procnamwe, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 2000;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        con.Close();
        con.Dispose();
        return ds;
    }

    public DataTable retDatatable(string procnamwe)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand(procnamwe, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 2000;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.SelectCommand = cmd;
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        con.Dispose();
        return dt;
    }

    public int execute(string procnamwe, string[] col, object[] val)
    {   
        SqlConnection con = new SqlConnection(constr);
        con.Open();
        SqlCommand cmd = new SqlCommand(procnamwe, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 2000;
        for (int i = 0; i < col.Length; i++)
        {
            cmd.Parameters.AddWithValue(col[i], val[i]);
        }
        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataSet ds = new DataSet();
        //da.Fill(ds); 
        //return ds; 
        int j = cmd.ExecuteNonQuery();
        con.Close();
        con.Dispose();
        return j; 
    } 
    public int retOutParameterValue(string procnamwe, string[] col, object[] val)
    {

        SqlConnection con = new SqlConnection(constr);
        con.Open();
        SqlCommand cmd = new SqlCommand(procnamwe, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 2000;
        for (int i = 0; i < col.Length; i++)
        {
            cmd.Parameters.AddWithValue(col[i], val[i]);
        }
        SqlParameter outParam = new SqlParameter();
        outParam.SqlDbType = System.Data.SqlDbType.Int;
        outParam.ParameterName = "@sessionid";
        outParam.Direction = System.Data.ParameterDirection.Output;
        cmd.Parameters.Add(outParam);
        int j = cmd.ExecuteNonQuery();
        int paramvalue = Convert.ToInt32(outParam.Value);
        con.Close();
        con.Dispose();
        return paramvalue;
    }


    public DataSet getDataSet(string procnamwe, string[] col, object[] val)
    {

        SqlConnection con = new SqlConnection(constr); 
        
        con.Open();
        SqlCommand cmd = new SqlCommand(procnamwe, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 2000;
        for (int i = 0; i < col.Length; i++)
        {
            cmd.Parameters.AddWithValue(col[i], val[i]);
        }
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        return ds;
    }

    public DataTable getDataSet1(string procnamwe, string[] col, object[] val)
    { 

        SqlConnection con = new SqlConnection(constr);
        con.Open();
        SqlCommand cmd = new SqlCommand(procnamwe, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 2000;
        for (int i = 0; i < col.Length; i++)
        {
            cmd.Parameters.AddWithValue(col[i], val[i]);
        }
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        return ds;
    }
    public DataTable getdataTable(string stpro, SqlParameter[] para)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand(stpro, con);
        cmd.CommandType = CommandType.StoredProcedure;
        for (int i = 0; i < para.Length; i++)
        {
            cmd.Parameters.Add(para[i]);
        }
        if (con.State == ConnectionState.Closed)
        {
            //SqlConnection.ClearAllPools();
            con.Open();
        }
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        con.Close();
        return dt;
    }


    public DataSet retDatasetByquery(string query)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.CommandType = CommandType.Text;
        cmd.CommandTimeout = 2000;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        con.Close();
        con.Dispose();
        return ds;

    }

    public int ExecuteQuery(string query)
    {
        SqlConnection con = new SqlConnection(constr);
        con.Open();
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.CommandType = CommandType.Text;
        cmd.CommandTimeout = 2000;
        int i = cmd.ExecuteNonQuery();
        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataSet ds = new DataSet();
        //da.Fill(ds);

        con.Close();
        con.Dispose();
        return i;

    }


    public void genID(string procname, HiddenField hdn, string format, string[] col, object[] val)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = procname;
        cmd.CommandTimeout = 2000;
        for (int i = 0; i < col.Length; i++)
        {
            cmd.Parameters.AddWithValue(col[i], val[i]);
        }
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        string a = ds.Tables[0].Rows[0]["sn"].ToString();
        if (a == "0" || a == null || a == "")
        {

            hdn.Value = format + "1";
        }
        else
        {
            int aa = Convert.ToInt32(a);
            aa++;
            hdn.Value = format + Convert.ToString(aa);
        }

    }

    public string executescalar(string query)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.CommandType = CommandType.Text;
        cmd.CommandTimeout = 2000;

        if (con.State == ConnectionState.Closed)
            con.Open();
        string str = "";
        if (cmd.ExecuteScalar() == null)
        {
            con.Close();
            con.Dispose();
            return "";
        }
        else
        {
            str = cmd.ExecuteScalar().ToString();
            con.Close();
            con.Dispose();
            return str;
        }
    }

    public int executescalarint(string query)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand(query, con);
        cmd.CommandType = CommandType.Text;
        cmd.CommandTimeout = 2000;

        if (con.State == ConnectionState.Closed)
            con.Open();
        int str = 0;
        object value = cmd.ExecuteScalar();
        if (!string.IsNullOrEmpty(value.ToString()))
        {
            str = Convert.ToInt32(value);
            con.Close();
            con.Dispose();
            return str;
        }
        else
        {
            str = 0;
            con.Close();
            con.Dispose();
            return str;
        }

    }


    public int retDataset(string procnamwe, string[] col, object[] val)
    {

        SqlConnection con = new SqlConnection(constr);
        con.Open();
        SqlCommand cmd = new SqlCommand(procnamwe, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandTimeout = 2000;
        for (int i = 0; i < col.Length; i++)
        {
            cmd.Parameters.AddWithValue(col[i], val[i]);
        }
        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataSet ds = new DataSet();
        //da.Fill(ds);

        //return ds;
        int j = cmd.ExecuteNonQuery();
        con.Close();
        con.Dispose();
        return j;
    }

    public string RandomString(int size, bool lowerCase)
    {
        StringBuilder builder = new StringBuilder();
        Random random = new Random();
        char ch;
        for (int i = 0; i < size; i++)
        {
            ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
            builder.Append(ch);
        }
        if (lowerCase)
            return builder.ToString().ToLower();
        return builder.ToString();
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
                {
                    if (_ChildControl is CheckBox)
                    {
                        ((CheckBox)_ChildControl).Checked = false;
                    }
                    if (_ChildControl is CheckBoxList)
                    { 
                        for (int i = 0; i < ((CheckBoxList)_ChildControl).Items.Count; i++)
                        {
                            ((CheckBoxList)_ChildControl).Items[i].Selected = false;

                        } 
                    }
                }

            }
        }
    }
}