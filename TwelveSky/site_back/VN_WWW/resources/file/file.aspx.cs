using System;
using System.Configuration;
using System.Data.Common;
using System.IO;

namespace _12sky2.resources.file {
	public partial class file : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {
				"seq"
			};
			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}


			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				var tmpSQL = @"select relt_div, relt_seq, file_nm, chng_nm from dbo.t_file_info where seq = "+ Request.QueryString["seq"].Trim();
				command.CommandText = tmpSQL;
				DbDataReader reader = command.ExecuteReader();

				if ( reader.Read() ) {
					string savePath = ConfigurationManager.AppSettings["PATH_DATA"] + "editor";

					if ( !SYS.is_null(reader["RELT_DIV"].ToString()) ) {
						savePath = ConfigurationManager.AppSettings["PATH_DATA"] + reader["RELT_DIV"].ToString().Trim();
						if ( !reader["RELT_SEQ"].ToString().Trim().Equals("0") && !reader["RELT_SEQ"].ToString().Trim().Equals("") )
							savePath += "/" + reader["RELT_SEQ"].ToString().Trim();
					}
					string file_name = reader["CHNG_NM"].ToString().Trim();

					Response.Clear();
					Response.ClearHeaders();
					Response.ClearContent();

					Response.ContentType = "Application/Octet-Stream";

					FileInfo myfile = new FileInfo(savePath + "/" + file_name);
					var urlEncode = Server.UrlEncode(reader["FILE_NM"].ToString().Trim());
					if ( urlEncode != null ) {
						Response.AppendHeader("Content-Disposition", "attachment;filename=" + urlEncode.Replace("+", "%20"));
					}
				//	Path.GetFileName(myfile.FullName);
					Response.WriteFile(myfile.FullName);
					Response.TransmitFile(savePath + "/" + file_name);
					Response.Flush();
					Response.End();
				} else {
					SYS.Javascript(Page, "alert('error!');history.back();");
				}
			} catch ( DbException ex ) {
				SYS.Save_Log("[" + Request.Path + " error " + ex.Message);
			}
		}
	}
}
