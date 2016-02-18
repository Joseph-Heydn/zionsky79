using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.IO;
using System.Configuration;
using System.Data.Common;

namespace _12sky2.web.mypage {
	public partial class contact : Page {
		private string gFullName;
		private readonly webservice.T_QUST_CD T_QUST_CD = new webservice.T_QUST_CD();
		private readonly webservice.T_QUST T_QUST = new webservice.T_QUST();

		private readonly string NAT_CD = SYS.NAT_CD;
		private const string C_WEB_RESOURCE = "/web/mypage/contact.aspx";

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};

			if ( !SYS.is_check(Page, KEY) ) {
				return;
			}


			if ( !IsPostBack ) {
				if ( !SYS.is_login(Page) ) {
					string[] REMOVE = {};
					Response.Redirect(SYS.makeURL(this, "/", REMOVE));

					return;
				}

				setCode();
			}


			const string DIV = "contatct";

			NAV_TITL.InnerHtml = fnMainText(DIV);
			PAGE_TITL.InnerHtml = fnMainText(DIV);

			CNTN.config.toolbar = new object[] {new object[] {"Source"}, new object[] {"Cut", "Copy", "Paste", "PasteText", "PasteFromWord", "-", "Undo", "Redo"}, new object[] {"Find", "Replace", "-", "SelectAll"}, new object[] {"Link", "Unlink", "Anchor"}, "/", new object[] {"Bold", "Italic", "Underline", "Strike", "-", "RemoveFormat"}, new object[] {"NumberedList", "BulletedList", "-", "Outdent", "Indent", "-", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyBlock", "-", "BidiLtr", "BidiRtl"}, new object[] {"Table", "HorizontalRule", "SpecialChar"}, "/", new object[] {"Styles", "Format", "Font", "FontSize"}, new object[] {"TextColor", "BGColor"}, new object[] {"Maximize", "ShowBlocks"}};
			CNTN.Language = SYS.NAT_LANG;
			CNTN.UIColor = SYS.EDITOR_COLOR;
		}

		// 라벨에 텍스트 입력
		protected static string fnLabelText(string pKey) {
			return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
		}

		// 라벨에 텍스트 입력
		protected static string fnMainText(string pKey) {
			const string V_WEB_RESOURCE = "/web/include/head.ascx";
			return ResourceValues.AppResourceText(V_WEB_RESOURCE, pKey);
		}

		/*********************************************************************************************************************/
		/* setCode
		/*********************************************************************************************************************/
		private void setCode() {
			try {
				DataTable result = T_QUST_CD.getList("0", NAT_CD);
				QUST_CD_1.Items.Clear();

				for ( int i = 0; i < result.Rows.Count; i++ ) {
					ListItem item = new ListItem {
						Value = result.Rows[i]["CD_NO"].ToString(),
						Text = result.Rows[i]["CD_NM"].ToString()
					};
					QUST_CD_1.Items.Add(item);
				}

				if ( result.Rows.Count > 0 ) {
					DataTable result2 = T_QUST_CD.getList(result.Rows[0]["CD_NO"].ToString(), NAT_CD);
					QUST_CD_2.Items.Clear();

					for ( int i = 0; i < result2.Rows.Count; i++ ) {
						ListItem item = new ListItem {
							Value = result2.Rows[i]["CD_NO"].ToString(),
							Text = result2.Rows[i]["CD_NM"].ToString()
						};
						QUST_CD_2.Items.Add(item);
					}
				}

				NICK_NM.Text = Session["USER_NICK_NM"].ToString();
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.Message);
				SYS.errScript(this);
			}
		}

		/*********************************************************************************************************************/
		/* 카테고리 1 선택시
		/*********************************************************************************************************************/
		protected void QUST_CD_1_SelectedIndexChanged(object sender, EventArgs e) {
			DropDownList DD = (DropDownList) sender;
			DataTable result2 = T_QUST_CD.getList(DD.SelectedValue, NAT_CD);

			QUST_CD_2.Items.Clear();

			for ( int i = 0; i < result2.Rows.Count; i++ ) {
				ListItem item = new ListItem {
					Value = result2.Rows[i]["CD_NO"].ToString(),
					Text = result2.Rows[i]["CD_NM"].ToString()
				};
				QUST_CD_2.Items.Add(item);
			}
		}

		/*********************************************************************************************************************/
		/* file
		/*********************************************************************************************************************/
		private string fileSave(HttpPostedFile pFileName, string pFolder) {
			const double vLimitSize = (1024*1024)*1.01;
			string vSeq;


			try {
				string vFilePath = $"{Server.MapPath("~/web_data")}\\{pFolder}\\";

				// 폴더 없으면 생성
				if ( !Directory.Exists(vFilePath) ) {
					Directory.CreateDirectory(vFilePath);
				}

				// 파일 번호 배열로 전환
				string vExt;
				string vFileName = pFileName.FileName;
				int vSize = pFileName.ContentLength;

				vFileName = vFileName.Substring(vFileName.LastIndexOf("\\", StringComparison.Ordinal) + 1);
				vFileName = vFileName.Substring(0, vFileName.IndexOf(".", StringComparison.Ordinal));

				if ( vSize > vLimitSize || vSize == 0 ) {
					return null;
				}


				switch ( pFileName.ContentType ) {
					case "image/bmp":
						vExt = ".bmp";
						break;
					case "image/gif":
						vExt = ".gif";
						break;
					case "image/jpeg":
					case "image/pjpeg":
						vExt = ".jpg";
						break;
					case "image/png":
					case "image/x-png":
						vExt = ".png";
						break;
					default:
						return null;
				}


				// 파일 읽기
				byte[] vFile = new byte[vSize];
				pFileName.InputStream.Read(vFile, 0, vSize);


				/**
				 * 파일 업로드
				 * 클라이언트에서 웹서버로 파일 업로드
				 * 원본 크기로 저장
				 * vFullName 데이터를 처리하던 중 오류 발생시 삭제를 위한 값
				**/
				gFullName = $"{vFilePath}{vFileName}{vExt}";
				string vNewFile = vFileName;
				bool vExist = File.Exists(gFullName);
				int vNumber = 1;

				while ( vExist ) {
					vFileName = $"{vNewFile}_rename({vNumber})";
					gFullName = $"{vFilePath}{vFileName}{vExt}";
					vExist = File.Exists(gFullName);
					vNumber++;
				}

				fnWriteFile(gFullName, vFile);
				vSeq = insertDB(pFolder, "FILE", vFileName + vExt, vFileName + vExt, vExt, vSize);
			} catch ( Exception ex ) {
				fnOnError_DeleteFile();
				SYS.Save_Log($"[처리 실패] {ex.Message} - {gFullName}");
				return null;
			}

			return vSeq;
		}

		// 클라이언트에서 웹서버로 파일 업로드
		private static void fnWriteFile(string pFileName, byte[] pBuf) {
			if ( File.Exists(pFileName) ) {
				File.Delete(pFileName);
			}

			FileStream fs = new FileStream(pFileName, FileMode.CreateNew);
			fs.Write(pBuf, 0, pBuf.Length);
			fs.Close();
		}

		// 글 작성 중 오류로 업로드 된 파일 삭제
		private void fnOnError_DeleteFile() {
			if ( File.Exists(gFullName) ) {
				File.Delete(gFullName);
			}
		}

		private string insertDB(string RELT_DIV, string FILE_DIV, string FILE_NM, string CHNG_NM, string FILE_TYP, int FILE_SIZE) {
			string USER_ID = Session["USER_ID"].ToString();
			string tmpSQL = null, SEQ = null;

			DbConnection vConn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand vCmd = vConn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction vTrans = vConn.BeginTransaction();
			vCmd.Transaction = vTrans;

			try {
				tmpSQL = @"select isnull(max(seq)+1, 1) from dbo.t_file_info";
				vCmd.CommandText = tmpSQL;
				DbDataReader reader = vCmd.ExecuteReader();

				if ( reader.Read() ) {
					SEQ = reader[0].ToString();
				}
				reader.Close();

				tmpSQL = @"
					insert into dbo.t_file_info
						(	seq
						,	relt_div
						,	relt_seq
						,	file_nm
						,	chng_nm
						,	file_size
						,	file_typ
						,	file_div
						,	reg_id
						,	reg_dtm
						)
					values
						(	{0}
						,	'{1}'
						,	0
						,	N'{2}'
						,	N'{3}'
						,	'{4}'
						,	'{5}'
						,	'{6}'
						,	'{7}'
						,	getdate()
						)";
				tmpSQL = string.Format(tmpSQL, SEQ, RELT_DIV, FILE_NM, CHNG_NM, FILE_SIZE, FILE_TYP, FILE_DIV, USER_ID);

				vCmd.Parameters.Clear();
				vCmd.CommandText = tmpSQL;
				vCmd.ExecuteNonQuery();
				vTrans.Commit();
			} catch ( DataException err ) {
				SEQ = null;
				vTrans.Rollback();

				SYS.Save_Log(@"[" + Request.Path + " data 처리후 insert 오류]" + @"
tmpSQL		: " + tmpSQL + @"
FILE_NM		: " + FILE_NM + @"
CHNG_NM		: " + CHNG_NM + @"
FILE_TYP	: " + FILE_TYP + @"
FILE_SIZE	: " + FILE_SIZE + @"
error		: " + err.Message);
			} finally {
				vConn.Close();
			}

			return SEQ;
		}

		/*********************************************************************************************************************/
		/* submit
		/*********************************************************************************************************************/
		protected void btn_submit_Click(object sender, EventArgs e) {
			try {
				string seq;

				if ( FileUpload1.PostedFile.ContentLength > 0 ) {
					seq = fileSave(FileUpload1.PostedFile, "contactUs");
					FILE_PATH_1.Value = seq;
				}
				if ( FileUpload2.PostedFile.ContentLength > 0 ) {
					seq = fileSave(FileUpload2.PostedFile, "contactUs");
					FILE_PATH_2.Value = seq;
				}
				if ( FileUpload3.PostedFile.ContentLength > 0 ) {
					seq = fileSave(FileUpload3.PostedFile, "contactUs");
					FILE_PATH_3.Value = seq;
				}
				if ( FileUpload4.PostedFile.ContentLength > 0 ) {
					seq = fileSave(FileUpload4.PostedFile, "contactUs");
					FILE_PATH_4.Value = seq;
				}
				if ( FileUpload5.PostedFile.ContentLength > 0 ) {
					seq = fileSave(FileUpload5.PostedFile, "contactUs");
					FILE_PATH_5.Value = seq;
				}


				T_QUST.insert(Session["USER_ID"].ToString(), Session["USER_NO"].ToString(), Session["USER_NICK_NM"].ToString(), QUST_CD_1.SelectedValue, QUST_CD_2.SelectedValue, TITL.Text, CNTN.Text, FILE_PATH_1.Value, FILE_PATH_2.Value, FILE_PATH_3.Value, FILE_PATH_4.Value, FILE_PATH_5.Value, NAT_CD, Session["SCRT_EMAIL"].ToString());

				string[] REMOVE = {};
				Response.Redirect(SYS.makeURL(Page, "myquestions.aspx", REMOVE));
			} catch ( Exception ex ) {
				SYS.Save_Log(ex.Message);
				SYS.Javascript(Page, $"alert('{fnLabelText("msgError_01")}');");
			}
		}
	}
}
