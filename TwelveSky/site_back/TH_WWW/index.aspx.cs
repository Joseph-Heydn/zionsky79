using System;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.Security;

namespace _12sky2 {
	public partial class index : Page {
		private readonly webservice.T_REPR_IMGE T_REPR_IMGE = new webservice.T_REPR_IMGE();
		private readonly webservice.T_REPR_ANIM T_REPR_ANIM = new webservice.T_REPR_ANIM();
		private readonly webservice.T_FILE_INFO T_FILE_INFO = new webservice.T_FILE_INFO();
		private readonly webservice.T_MBER T_MBER = new webservice.T_MBER();

		private readonly string NAT_CD = SYS.NAT_CD;

		protected void Page_Load(object sender, EventArgs e) {
			if ( IsPostBack ) {
				return;
			}


			getList();

			if ( !SYS.is_login(this.Page) ) {
				LOGIN_PAGE.Visible = true;
				USER_PAGE.Visible = false;

				DOWN1.Visible = false;
				DOWN2.Visible = true;
			} else {
				LOGIN_PAGE.Visible = false;
				USER_PAGE.Visible = true;

				DOWN1.Visible = true;
				DOWN2.Visible = false;

				setLogin();
			}
		}

		/*********************************************************************************************************************/
		/* get list
        /*********************************************************************************************************************/
		private void getList() {
			try {
				string DIV = "main";

				DataTable result = T_REPR_IMGE.getList(DIV, NAT_CD);

				for ( int i = 0; i < result.Rows.Count; i++ ) {
					DataTable fileList = T_FILE_INFO.getList(DIV, result.Rows[i]["SEQ"].ToString(), "IMAGE");

					for ( int j = 0; j < fileList.Rows.Count; j++ ) {
						if ( fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE") ) {
							switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
								case ".png":
								case ".jpg":
								case ".gif":
								case ".bmp":
									result.Rows[i]["IMG_SRC"] = "/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString() + "";
									break;
							}
						}
					}

					if ( i != 0 ) {
						result.Rows[i]["CSS1"] = "display:none;";
					}
					if ( i == 0 ) {
						result.Rows[i]["CSS2"] = "on";
					}
				}

				LIST1.DataSource = result;
				LIST1.DataBind();
				LIST2.DataSource = result;
				LIST2.DataBind();

				DataTable result2 = T_REPR_ANIM.getRead(NAT_CD);

				for ( int i = 0; i < result2.Rows.Count; i++ ) {
					string path = result2.Rows[i]["ANIM_PATH"].ToString();
					string movie_id = path.Substring(path.LastIndexOf('/'));
					MAIN_MOVIE.InnerHtml = "<iframe width='230' height='235' src='https://www.youtube.com/embed" + movie_id + "' frameborder='0' allowfullscreen></iframe>";
				}


				DataTable result_l = T_REPR_IMGE.getList("banner_left", NAT_CD);

				for ( int i = 0; i < result_l.Rows.Count; i++ ) {
					DataTable fileList = T_FILE_INFO.getList("banner_left", result_l.Rows[i]["SEQ"].ToString(), "IMAGE");

					for ( int j = 0; j < fileList.Rows.Count; j++ ) {
						if ( fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE") ) {
							switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
								case ".png":
								case ".jpg":
								case ".gif":
								case ".bmp":
									result_l.Rows[i]["IMG_SRC"] = "/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString() + "";
									break;
							}
						}
					}
				}



				L_LIST.DataSource = result_l;
				L_LIST.DataBind();

				DataTable result_r = T_REPR_IMGE.getList("banner_right", NAT_CD);

				for ( int i = 0; i < result_r.Rows.Count; i++ ) {
					DataTable fileList = T_FILE_INFO.getList("banner_right", result_r.Rows[i]["SEQ"].ToString(), "IMAGE");

					for ( int j = 0; j < fileList.Rows.Count; j++ ) {
						if ( fileList.Rows[j]["FILE_DIV"].ToString().Equals("IMAGE") ) {
							switch ( fileList.Rows[j]["FILE_TYP"].ToString().ToLower() ) {
								case ".png":
								case ".jpg":
								case ".gif":
								case ".bmp":
									result_r.Rows[i]["IMG_SRC"] = "/resources/file/image.aspx?seq=" + fileList.Rows[j]["SEQ"].ToString() + "";
									break;
							}
						}
					}
				}

				R_LIST.DataSource = result_r;
				R_LIST.DataBind();
			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
			}

		}

		/*********************************************************************************************************************/
		/* get list
        /*********************************************************************************************************************/
		private void setLogin() {
			try {
				USER_NM.InnerHtml = Session["USER_NICK_NM"].ToString();

				if ( SYS.is_admin(this.Page) ) {
					MY_PAGE.InnerHtml = "<a href='/admin/' target='_blank'>Admin Page <span>GO ></span></a>";

				} else {
					MY_PAGE.InnerHtml = "<a href='/web/mypage/profile.aspx'>My Page <span>GO ></span></a>";
				}

			} catch ( Exception ex ) {
				//SYS.Save_Log(ex.Message);
			}

		}

		/*********************************************************************************************************************/
		/* login
        /*********************************************************************************************************************/
		protected void btn_login_Click(object sender, EventArgs e) {
			if ( SYS.is_null(ID.Text) ) {
				SYS.Javascript(this.Page, "alert('เอ็นเตอร์ไปยังไอดี!');");
				ID.Focus();
				return;
			}

			if ( SYS.is_null(PSWD.Text) ) {
				SYS.Javascript(this.Page, "alert('ป้อนรหัสผ่าน!');");
				PSWD.Focus();
				return;
			}


			if ( T_MBER.login(ID.Text, PSWD.Text, NAT_CD) ) {
				string[] REMOVE = {};
				Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
			} else {
				SYS.Javascript(this.Page, "alert('Failed to ID or Password!');");
				PSWD.Focus();
				return;
			}
		}

		/*********************************************************************************************************************/
		/* logout
        /*********************************************************************************************************************/
		protected void btn_logout_Click(object sender, EventArgs e) {
			FormsAuthentication.SignOut();
			Session.Clear();
			Session.Abandon();

			if ( Request.Cookies["tmpUSER"] != null ) {
				HttpCookie myCookie = new HttpCookie("tmpUSER") {
					Expires = DateTime.Now.AddDays(-1),
					Domain = SYS.COOKIE_DOMAIN
				};
				Response.Cookies.Add(myCookie);
			}

			if ( Request.Cookies["KJGAMES_BILL"] != null ) {
				HttpCookie myCookie = new HttpCookie("KJGAMES_BILL") {
					Expires = DateTime.Now.AddDays(-1),
					Domain = SYS.COOKIE_DOMAIN
				};
				Response.Cookies.Add(myCookie);
			}

			foreach ( String str in Request.Cookies.AllKeys ) {
				Response.Cookies[str].Expires = DateTime.Now.AddDays(-1);
			}

			string[] REMOVE = {};
			Response.Redirect(SYS.makeURL(this.Page, this.Page.Request.Path, REMOVE));
		}
	}
}
