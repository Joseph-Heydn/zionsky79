using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Configuration;
using System.Data.Common;
using System.Web.UI;

namespace _12sky2.web.mypage {
	public partial class profile : Page {
		readonly webservice.T_MBER T_MBER = new webservice.T_MBER();

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};
			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}
			if ( IsPostBack ) {
				return;
			}


			if ( !SYS.is_login(Page) ) {
				string[] REMOVE = {};
				Response.Redirect(SYS.makeURL(this, "/", REMOVE));

				return;
			}

			for ( int i = 1940; i <= DateTime.Now.Year; i++ ) {
				if ( i == 1940 ) {
					ListItem item1 = new ListItem {
						Value = "",
						Text = "-"
					};
					YYYY.Items.Add(item1);
				}

				ListItem item = new ListItem {
					Value = i.ToString(),
					Text = i.ToString()
				};
				YYYY.Items.Add(item);
			}
			for ( int i = 1; i <= 12; i++ ) {
				if ( i == 1 ) {
					ListItem item1 = new ListItem {
						Value = "",
						Text = "-"
					};
					MM.Items.Add(item1);
				}

				ListItem item = new ListItem();
				if ( i < 10 ) {
					item.Value = "0" + i;
				} else {
					item.Value = i.ToString();
				}
				item.Text = i.ToString();
				MM.Items.Add(item);
			}
			for ( int i = 1; i <= 31; i++ ) {
				if ( i == 1 ) {
					ListItem item1 = new ListItem {
						Value = "",
						Text = "-"
					};
					DD.Items.Add(item1);
				}

				ListItem item = new ListItem();
				if ( i < 10 ) {
					item.Value = "0" + i;
				} else {
					item.Value = i.ToString();
				}
				item.Text = i.ToString();
				DD.Items.Add(item);
			}

			getRead();
		}

		/*********************************************************************************************************************/
		/* getRead
        /*********************************************************************************************************************/
		//
		private void getRead() {
			try {
				DataTable info = T_MBER.getRead(Session["USER_ID"].ToString());

				if ( info.Rows.Count != 1 ) {
					SYS.errScript(this);
					return;
				}

				if ( !SYS.is_null(info.Rows[0]["REPR_IMGE_PATH"]) ) {
					REPR_IMGE_PATH.InnerHtml = "<img src='" + info.Rows[0]["REPR_IMGE_PATH"] + "' alt=''/>";
					FILE_PATH.Value = info.Rows[0]["REPR_IMGE_PATH"].ToString();
				} else {
					REPR_IMGE_PATH.InnerHtml = "<img src='/resources/images/con_img/my/profile.jpg' alt='' />";
				}

				if ( !SYS.is_null(info.Rows[0]["NICK_NM"]) )
					NICK_NM.Text = info.Rows[0]["NICK_NM"].ToString();
				if ( !SYS.is_null(info.Rows[0]["SEX"]) )
					SEX.SelectedValue = info.Rows[0]["SEX"].ToString();

				if ( !SYS.is_null(info.Rows[0]["BRDD"]) ) {
					YYYY.SelectedValue = info.Rows[0]["BRDD"].ToString().Substring(0, 4);
					MM.SelectedValue = info.Rows[0]["BRDD"].ToString().Substring(4, 2);
					DD.SelectedValue = info.Rows[0]["BRDD"].ToString().Substring(6, 2);
				}

				if ( !SYS.is_null(info.Rows[0]["EMAIL_RECV_YN"]) ) {
					EMAIL_RECV_YN.Checked = info.Rows[0]["EMAIL_RECV_YN"].ToString().Trim().Equals("Y");
				}
			} catch ( Exception ) {
				//SYS.Save_Log(ex.Message);
				SYS.errScript(this);
			}
		}

		/*********************************************************************************************************************/
		/* save
        /*********************************************************************************************************************/
		protected void btn_save_Click(object sender, EventArgs e) {
			try {
				string _EMAIL_RECV_YN = "N";

				if ( EMAIL_RECV_YN.Checked ) {
					_EMAIL_RECV_YN = "Y";
				}
				if ( DEL_IMG.Checked ) {
					FILE_PATH.Value = null;
				}

				T_MBER.updateMberInfo(YYYY.SelectedValue + MM.SelectedValue + DD.SelectedValue, SEX.SelectedValue, _EMAIL_RECV_YN,
					FILE_PATH.Value, Session["USER_ID"].ToString(), null);

				string[] REMOVE = {};
				Response.Redirect(SYS.makeURL(Page, Page.Request.Path, REMOVE));
			} catch ( Exception ) {
				//SYS.Save_Log(ex.Message);
				SYS.Javascript(Page, "alert('Failed to save!');");
			}
		}

		/*********************************************************************************************************************/
		/* image
        /*********************************************************************************************************************/
		//
		protected void imageSelect_Click(object sender, EventArgs e) {
			string seq;

			if ( imageFile.PostedFile.ContentLength > 0 ) {
				seq = imageSave(imageFile.PostedFile, "userimage");
			} else {
				return;
			}

			REPR_IMGE_PATH.InnerHtml = "<img src='/resources/file/image.aspx?seq=" + seq + "' alt=''/>";
			FILE_PATH.Value = "/resources/file/image.aspx?seq=" + seq;
		}

		private string imageSave(HttpPostedFile tmpFile, string folder) {
			string seq = null;
			FileInfo nowFile = null;

			try {
				string savePath = ConfigurationManager.AppSettings["PATH_DATA"] + folder; // 저장경로
				string fileExeName = null;
				var FILE_NM = tmpFile.FileName.Substring(tmpFile.FileName.LastIndexOf("\\", StringComparison.Ordinal) + 1);

				var FILE_TYP = Path.GetExtension(FILE_NM);

				if ( tmpFile.ContentLength > 0 ) {
					if ( !Directory.Exists(savePath) ) {
						Directory.CreateDirectory(savePath);
					}

					string tmpFilePath = savePath + "/" + FILE_NM;
					FileInfo fileInfo = new FileInfo(tmpFilePath);
					var CHNG_NM = fileInfo.Name;

					bool bExist = fileInfo.Exists;
					int nNumbering = 1;
					int indexDot = CHNG_NM.LastIndexOf(".", StringComparison.Ordinal);

					if ( indexDot != -1 ) {
						fileExeName = CHNG_NM.Substring(0, indexDot);
					}

					while ( bExist ) {
						string newName = fileExeName + "_reName(" + nNumbering + ")";
						tmpFilePath = fileInfo.DirectoryName + "\\" + newName + fileInfo.Extension;
						CHNG_NM = newName + fileInfo.Extension;
						bExist = File.Exists(tmpFilePath);
						nNumbering++;
					}

					tmpFile.SaveAs(tmpFilePath);
					nowFile = new FileInfo(tmpFilePath);

					seq = insertDB(folder, "IMAGE", FILE_NM, CHNG_NM, FILE_TYP, tmpFile.ContentLength);
				}
			} catch ( Exception err ) {
				nowFile?.Delete();
				SYS.Save_Log("[에디터 image 처리 실패] " + err.Message);
				return seq;
			}

			return seq;
		}

		private string insertDB(string RELT_DIV, string FILE_DIV, string FILE_NM, string CHNG_NM, string FILE_TYP,
			int FILE_SIZE) {
			string USER_ID = Session["USER_ID"].ToString();
			string tmpSQL = null, SEQ = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_FILE_INFO";
				command.CommandText = tmpSQL;

				DbDataReader reader = command.ExecuteReader();
				if ( reader.Read() ) {
					SEQ = reader[0].ToString();
				}
				reader.Close();

				tmpSQL = @"
                        INSERT INTO T_FILE_INFO
                            (SEQ, RELT_DIV, RELT_SEQ, FILE_NM, CHNG_NM, FILE_SIZE, FILE_TYP, FILE_DIV, REG_ID, REG_DTM) 
                        VALUES
                            (" + SEQ + ", '" + RELT_DIV + "', 0,'" + FILE_NM + "', '" + CHNG_NM + "', '" + FILE_SIZE +
					"', '" + FILE_TYP + "', '" + FILE_DIV + "', '" + USER_ID + "', GETDATE())";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();
				Trans.Commit();
			} catch ( DataException err ) {
				Trans.Rollback();
				SYS.Save_Log(@"[" + Request.Path + " 에디터 data 처리후 insert 오류]" + @"
tmpSQL     : " + tmpSQL + @"
FILE_NM    : " + FILE_NM + @"
CHNG_NM      : " + CHNG_NM + @"
FILE_TYP   : " + FILE_TYP + @"
FILE_SIZE  : " + FILE_SIZE + @"
error          : " + err.Message);
				SEQ = null;
			} finally {
				cnn.Close();
			}

			return SEQ;
		}
	}
}
