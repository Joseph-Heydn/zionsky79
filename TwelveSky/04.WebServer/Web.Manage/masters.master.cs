using System;
using System.IO;
using System.Web.UI;

namespace Web.Manage {
	public partial class masters : MasterPage {
		private bool gSelected;
		protected void Page_Load(object sender, EventArgs e) {
			AuthAccountInfo vAuthInfo = AuthorityManager.GetAuthAccountInfo();
			if ( vAuthInfo.pAuthrity < 2001009 ) {
				return;
			}


			AuthorityManager.ClearCookie();
			Response.Redirect("/login.aspx");
		}

		// 선택된 메뉴 하이라이트 class 추가
		internal string fnSelected(object pExecUrl) {
			if ( gSelected ) {
				return "";
			}


			string vMenuNo	= Request.QueryString["m"];
			string vWriteNo	= Request.QueryString["w"];

			if ( string.IsNullOrEmpty(vMenuNo) ) {
				gSelected = true;
				return "";
			}


			try {
				string[] vArray	= pExecUrl.ToString().Replace("?","=").Replace("&","=").Split('=');
				int vWrite = Array.IndexOf(vArray,"w");
				int vMenus = Array.IndexOf(vArray,"m");

				if ( vWrite > 0 && vArray[vWrite + 1] == vWriteNo ) {
					gSelected = true;
					return " active";
				}
				if ( vMenus > 0 && vArray[vMenus + 1] == vMenuNo ) {
					gSelected = true;
					return " active";
				}

				return "";
			} catch ( Exception ex ) {
				fnWriterLog(ex);
				return "";
			}
		}

		internal void fnSetSelected() {
			gSelected = false;
		}

		internal void fnWriterLog(Exception pExcept) {
			try {
				const string vLine = "--------------------------------------------------------------------------------";
				string vPath = Server.MapPath("~/error");
				string vCreateTime = $"{DateTime.Now:yyyy-MM-dd HH:mm:ss}";
				string vFile = $"{vPath}\\[{DateTime.Now:yyyy-MM-dd}] error.txt";

				FileStream fs = new FileStream(vFile, FileMode.OpenOrCreate, FileAccess.ReadWrite);
				StreamWriter sw = new StreamWriter(fs);

				sw.BaseStream.Seek(0, SeekOrigin.End);
				sw.Write($"{vCreateTime}\r\n{Page.Request.Url}\r\n{pExcept.Message}\r\n{vLine}\r\n{pExcept.StackTrace}\r\n{vLine}\r\n\r\n");

				sw.Flush();
				sw.Close();


				// 2주일 지난 파일 삭제
				for ( int i = -15; i < -31; --i ) {
					vFile = $"{vPath}\\[{DateTime.Now.AddDays(i):yyyy-MM-dd}] error.txt";

					if ( File.Exists(vFile) ) {
						File.Delete(vFile);
					} else {
						break;
					}
				}
			} catch ( Exception ) {
				throw new Exception();
			}
		}
	}
}
