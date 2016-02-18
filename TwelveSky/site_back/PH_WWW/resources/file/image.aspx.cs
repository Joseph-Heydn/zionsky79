using System;
using System.Configuration;
using System.Web.UI;

using System.IO;
using System.Data.Common;
using System.Drawing;
using System.Drawing.Imaging;

namespace _12sky2.resources.file {
	public partial class image : Page {
		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {"seq"};

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}


			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				var tmpSQL = @"select relt_div, relt_seq, chng_nm, file_typ from t_file_info where seq = "+ Request.QueryString["seq"].Trim();
				command.CommandText = tmpSQL;
				DbDataReader reader = command.ExecuteReader();

				if ( reader.Read() ) {
					// 대문자, 소문자 모두 소문자로 변환
					string fileTyp = reader["FILE_TYP"].ToString().Trim().ToLower();

					if ( fileTyp.Equals(".jpg") || fileTyp.Equals(".png") || fileTyp.Equals(".gif") || fileTyp.Equals(".bmp") ) {
						string savePath = ConfigurationManager.AppSettings["PATH_DATA"] + "editor";

						if ( !SYS.is_null(reader["RELT_DIV"].ToString()) ) {
							savePath = ConfigurationManager.AppSettings["PATH_DATA"] + reader["RELT_DIV"].ToString().Trim();
							if ( reader["RELT_DIV"].ToString().Trim().Equals("banner_left") ) {
							} else if ( reader["RELT_DIV"].ToString().Trim().Equals("banner_right") ) {
							} else {
								if ( !reader["RELT_SEQ"].ToString().Trim().Equals("0") ) {
									savePath += "/" + reader["RELT_SEQ"].ToString().Trim();
								}
							}
						}

						string file_name = reader["CHNG_NM"].ToString().Trim();
						Bitmap img = new Bitmap(Path.Combine(savePath, file_name));
						MemoryStream ms = new MemoryStream();

						img.Save(ms, ImageFormat.Bmp);
						byte[] b = ms.ToArray();

						Context.Response.OutputStream.Write(b, 0, b.Length);

						ms.Dispose();
						img.Dispose();
					} else {
						SYS.Javascript(Page, "alert('잘못된 접근입니다'); history.back();");
					}
				} else {
					SYS.Javascript(Page, "alert('잘못된 접근입니다'); history.back();");
				}

				reader.Close();
				Trans.Commit();
			} catch ( DbException ex ) {
				Trans.Rollback();
				SYS.Save_Log($"[{Request.Path} 에디터 image 불러오기 실패] {ex}");
			} finally {
				cnn.Close();
			}
		}
	}
}
