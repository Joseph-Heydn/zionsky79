using System;
using System.Web;
using System.Web.UI;
using System.Data;
using System.IO;
using System.Configuration;
using System.Data.Common;

namespace _12sky2.admin.main {
	public partial class main_banner : Page {
		readonly webservice.T_REPR_IMGE T_REPR_IMGE = new webservice.T_REPR_IMGE();
		readonly webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();

		private readonly string NAT_CD = SYS.NAT_CD;

		private string F_FILE_NM = null;
		private string F_FILE_SIZE = null;

		protected void Page_Load(object sender, EventArgs e) {
			string[] KEY = {};
			if ( !SYS.is_check(this.Page, KEY) )
				return;

			if ( !IsPostBack ) {
				NAV_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);
				PAGE_TITL.InnerHtml = MENU.getPageTItle(admin_left.TITL, admin_left.SUB_TITL);

				getList1();
				getList2();
			}
		}

		/*********************************************************************************************************************/
		/* get list
        /*********************************************************************************************************************/
		//
		private void getList1() {
			try {
				DataTable result = T_REPR_IMGE.getList("banner_left", NAT_CD);

				for ( int i = 0; i < result.Rows.Count; i++ ) {
					DataTable fileList = T_FILE_INFO.getList("banner_left", result.Rows[i]["SEQ"].ToString(), "IMAGE");
					SEQ1.Value = result.Rows[i]["SEQ"].ToString();
					for ( int j = 0; j < fileList.Rows.Count; j++ ) {
						if ( fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE") ) {
							switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
								case ".png":
								case ".jpg":
								case ".gif":
								case ".bmp":
									Image1.ImageUrl = "/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString();
									break;
							}
						}
					}
				}
			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
			}

		}

		private void getList2() {
			try {
				DataTable result = T_REPR_IMGE.getList("banner_right", NAT_CD);

				for ( int i = 0; i < result.Rows.Count; i++ ) {
					DataTable fileList = T_FILE_INFO.getList("banner_right", result.Rows[i]["SEQ"].ToString(), "IMAGE");
					SEQ2.Value = result.Rows[i]["SEQ"].ToString();
					for ( int j = 0; j < fileList.Rows.Count; j++ ) {
						if ( fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE") ) {
							switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
								case ".png":
								case ".jpg":
								case ".gif":
								case ".bmp":
									Image2.ImageUrl = "/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString();
									break;
							}
						}
					}
				}
			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
			}

		}

		/*********************************************************************************************************************/
		/* delete
        /*********************************************************************************************************************/
		//
		protected void btn_del1_Click(object sender, EventArgs e) {
			try {
				T_REPR_IMGE.delete(SEQ1.Value, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString());

				string[] REMOVE = {
				};
				Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
			}
		}

		protected void btn_del2_Click(object sender, EventArgs e) {
			try {
				T_REPR_IMGE.delete(SEQ2.Value, Session["USER_ID"].ToString(), Session["USER_NICK_NM"].ToString());

				string[] REMOVE = {
				};
				Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
			}
		}

		/*********************************************************************************************************************/
		/* image
        /*********************************************************************************************************************/
		//
		protected void imageSelect1_Click(object sender, EventArgs e) {
			string seq = "";

			if ( imageFile1.PostedFile.ContentLength > 0 ) {
				seq = imageSave(imageFile1.PostedFile, "banner_left");
			} else {
				return;
			}

			Image1.ImageUrl = "/resources/file/image.aspx?seq=" + seq;
		}

		protected void imageSelect2_Click(object sender, EventArgs e) {
			string seq = "";

			if ( imageFile2.PostedFile.ContentLength > 0 ) {
				seq = imageSave(imageFile2.PostedFile, "banner_right");
			} else {
				return;
			}

			Image2.ImageUrl = "/resources/file/image.aspx?seq=" + seq;
		}

		private string imageSave(HttpPostedFile tmpFile, string folder) {
			string seq = null;

			FileInfo nowFile = null;

			try {
				string savePath = ConfigurationManager.AppSettings["PATH_DATA"] + folder; // 저장경로

				string fileExeName = null, FILE_NM = null, CHNG_NM = null, FILE_TYP = null;
				FILE_NM = tmpFile.FileName.Substring(tmpFile.FileName.LastIndexOf("\\", StringComparison.Ordinal) + 1);

				FILE_TYP = System.IO.Path.GetExtension(FILE_NM);

				if ( tmpFile.ContentLength > 0 ) {
					if ( !Directory.Exists(savePath) ) {
						Directory.CreateDirectory(savePath);
					}

					string tmpFilePath = savePath + "/" + FILE_NM;
					System.IO.FileInfo fileInfo = new System.IO.FileInfo(tmpFilePath);

					CHNG_NM = fileInfo.Name;

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

					F_FILE_NM = FILE_NM;
					F_FILE_SIZE = tmpFile.ContentLength.ToString();
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
			string USER_NICK_NM = Session["USER_NICK_NM"].ToString();
			string tmpSQL = null, SEQ = null;
			int NOW_SEQ = 0;

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
-- " + this.ToString() + @" (NEXT SEQ)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                            SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_REPR_IMGE
                            ";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				DbDataReader reader2 = command.ExecuteReader();
				if ( !reader2.HasRows )
					throw new Exception(); //다음 SEQ를 가져오지 못함
				if ( reader2.Read() ) {
					NOW_SEQ = int.Parse(reader2[0].ToString());
				}
				reader2.Close();

				tmpSQL = @"
                        INSERT INTO T_FILE_INFO
                            (SEQ, RELT_DIV, RELT_SEQ, FILE_NM, CHNG_NM, FILE_SIZE, FILE_TYP, FILE_DIV, REG_ID, REG_DTM) 
                        VALUES
                            (" + SEQ + ", '" + RELT_DIV + "', " + NOW_SEQ + ",N'" + FILE_NM + "', N'" + CHNG_NM + "', '" +
					FILE_SIZE + "', '" + FILE_TYP + "', '" + FILE_DIV + "', '" + USER_ID + "', GETDATE())";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();


				tmpSQL = @"
-- " + this.ToString() + @" (delete)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_REPR_IMGE SET
                        DEL_YN = 'Y'
                        , UPDT_ID = '" + SYS.nullToSpace(USER_ID) + @"'
                        , UPDT_NICK_NM = '" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , UPDT_DTM = GETDATE()
                    WHERE IMGE_DIV = '" + RELT_DIV + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();

				tmpSQL = @"
-- " + this.ToString() + @" (insert)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    INSERT INTO T_REPR_IMGE
                    (
                        SEQ
                        , IMGE_DIV
                        , TITL
                        , RELT_LINK
                        , REG_ID
                        , REG_NICK_NM
                        , REG_DTM
                        , UPDT_ID
                        , UPDT_NICK_NM
                        , UPDT_DTM
                        , DEL_YN
                        , NAT_CD
                        , SORT_ORD
                    )
                    VALUES
                    (
                        " + NOW_SEQ + @"
                        , '" + SYS.nullToSpace(RELT_DIV) + @"'
                        , '" + SYS.nullToSpace(RELT_DIV) + @"'
                        , ''                       
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , N'" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , '" + SYS.nullToSpace(USER_ID) + @"'
                        , N'" + SYS.nullToSpace(USER_NICK_NM) + @"'
                        , GETDATE()
                        , 'N'
                        , '" + SYS.nullToSpace(NAT_CD) + @"'
                        , '0'
                    )";

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
