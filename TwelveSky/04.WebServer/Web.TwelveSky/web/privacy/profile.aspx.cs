using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;

using Field.AuthorityAppTier.Dal;

namespace Web.TwelveSky.web.privacy {
	public partial class profile : BasePage {
		private const string gThisPage = "profile.aspx?m=1000018";
		private readonly string gConnStr = ConnString.fnGetName("Authority");

		protected void Page_Load(object sender, EventArgs e) {
			C_WEB_RESOURCE = "/web/privacy/profile.aspx";

			if ( IsPostBack ) {
				return;
			}


			try {
				fnInitParameter();
				fnInitDefaultSetting();
				fnInitDropList();

				fnDisplayProfile();
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_01")} [{ex.Message}]";
				fnMessageBack(vMessage, "/");
				fnWriterLog(ex);
			}
		}


		#region initialize layer
		// initialize parameter
		private void fnInitParameter() {
			pMenu.Value = Request.QueryString["m"];

			if ( string.IsNullOrEmpty(pMenu.Value) ) {
				Response.Redirect("/");
			}
			if ( pMenu.Value != "1000018" ) {
				Response.Redirect("/");
			}
		}

		// 게시판 기본 세팅
		private void fnInitDefaultSetting() {
			if ( AuthInfo.pAccountNo < 10 ) {
				Response.Redirect("/");
				return;
			}


			// 메뉴 정보 로드
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenu.Value);

			lblNavTitle.Text	= vMenuInfo[0]["cMenuName"].ToString();
			lblGroup.Text		= vMenuInfo[0]["cFolder"].ToString();
			lblPageTitle.Text	= lblNavTitle.Text;
		}

		// 생년월일 drop list 초기화
		private void fnInitDropList() {
			const string vHypen = "-";
			ListItem vItem = new ListItem
			{	Value	= ""
			,	Text	= vHypen
			};

			drpYear.Items.Add(vItem);
			drpMonth.Items.Add(vItem);
			drpDay.Items.Add(vItem);

			for ( int i = 1940; i <= DateTime.Now.Year - 8; ++i ) {
				string vItems = i.ToString();
				drpYear.Items.Add(new ListItem(vItems, vItems));
			}
			for ( int i = 1; i <= 12; ++i ) {
				string vItems = i.ToString().PadLeft(2,'0');
				drpMonth.Items.Add(new ListItem(vItems, vItems));
			}
			for ( int i = 1; i <= 31; ++i ) {
				string vItems = i.ToString().PadLeft(2,'0');
				drpDay.Items.Add(new ListItem(vItems, vItems));
			}
		}
		#endregion initialize layer


		#region binding layer
		// 회원 정보 로드
		private void fnDisplayProfile() {
			uspGetAccountInfo oDTO = new uspGetAccountInfo
			{	pAccountNo = AuthInfo.pAccountNo
			};
			int vReturn = oDTO.fnGetResultInfo(gConnStr);

			if ( vReturn != 0 ) {
				return;
			}


			txtNickName.Text	= oDTO.oNickName;
			txtFileExts.Value	= oDTO.oExts;
			txtNickOrgnl.Value	= oDTO.oNickName;
			txtImageFile.Value	= "/_common/_images/con_img/my/profile.jpg";

			if ( oDTO.oIsPhoto ) {
				txtImageFile.Value	= $"/FileUp/1000018/{oDTO.pAccountNo}-s.{oDTO.oExts}";
			}
			if ( $"{oDTO.oBirthDay:yyyy}" != "1900" ) {
				drpYear.SelectedValue	= $"{oDTO.oBirthDay:yyyy}";
				drpMonth.SelectedValue	= $"{oDTO.oBirthDay:MM}";
				drpDay.SelectedValue	= $"{oDTO.oBirthDay:dd}";
			}

			string vGender = fnRight($"{oDTO.oBirthDay:HH}",1);
			if ( vGender != "0" ) {
				rdoGender.SelectedValue	= vGender;
			}

			imgProfile.ImageUrl		= txtImageFile.Value;
			chkReceiveMail.Checked	= oDTO.oIsEmail;
		}
		#endregion binding layer


		#region control layer
		// 프로파일 저장하기
		private void fnSaveProfile() {
			if ( txtBirthDay.Value.Length < 10 ) {
				throw new Exception(fnLabelText("msgAlert_06"));
			}
			if ( txtNickName.Text != txtNickOrgnl.Value && txtNickCheck.Value == "N" ) {
				throw new Exception(fnLabelText("msgAlert_05"));
			}


			if ( txtFileExts.Value == "" ) {
				chkDeleteImage.Checked = true;
			}

			uspSetFixAccountInfo oDTO = new uspSetFixAccountInfo
			{	pAccountNo	= AuthInfo.pAccountNo
			,	pNickName	= txtNickName.Text
			,	pExts		= txtFileExts.Value
			,	pBirthDay	= Convert.ToDateTime(txtBirthDay.Value)
			,	pIsEmail	= chkReceiveMail.Checked
			,	pIsPhoto	= !chkDeleteImage.Checked
			};
			int vResult = oDTO.fnSetModifyInfo(gConnStr);

			if ( vResult != 0 ) {
				throw new Exception(vResult.ToString());
			}


			// 이미지 파일 이동
			if ( chkDeleteImage.Checked || txtCheckImg.Value == "Y" ) {
				fnMoveFile();
			}
		}

		// 이미지 파일 이동
		private void fnMoveFile() {
			fileProcess vProcess = new fileProcess();
			string vPath = Server.MapPath("~/FileUp");

			vProcess.fnDeleteFile(vPath, txtImageFile.Value.Replace("-s","{0}").Replace("/temp/",$"/{pMenu.Value}/"));
			vProcess.fnMoveFile(vPath, pMenu.Value, txtImageFile.Value.Replace("-s","{0}"));
		}

		// 임시 저장된 쿠키 삭제
		private void fnDropCookie() {
			if ( Request.Cookies["pNickName"] == null ) {
				return;
			}


			HttpCookie vCookie = new HttpCookie("pNickName")
			{	Expires = DateTime.Now.AddDays(-1d)
			};
			Response.Cookies.Add(vCookie);
		}
		#endregion control layer


		#region button event layer
		protected void btnSave_Click(object sender, EventArgs e) {
			try {
				fnSaveProfile();
				fnDropCookie();
				Response.Redirect(gThisPage);
			} catch ( Exception ex ) {
				string vMessage = $"{fnLabelText("msgError_02")} [{ex.Message}]";
				fnMessageBack(vMessage, gThisPage);
				fnWriterLog(ex);
			}
		}
		#endregion button event layer
	}
}
