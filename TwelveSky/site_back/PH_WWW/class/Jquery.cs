using System;
using System.Collections;
using System.Configuration;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.Common;
using System.Text;
using System.Web.Security;
using System.Web.SessionState;
using System.IO;
using System.Web.Script.Services;
using System.Web.Script.Serialization;

using System.Collections.Generic;

public class Jquery
{
    public static string listData(DataTable data)
    {
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row = null;

        foreach (DataRow dr in data.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in data.Columns)
            {
                row.Add(col.ColumnName, dr[col].ToString());
            }
            rows.Add(row);
        }

        return serializer.Serialize(rows);
    }
}
