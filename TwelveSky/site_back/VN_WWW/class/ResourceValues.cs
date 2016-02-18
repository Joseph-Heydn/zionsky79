/*********************************************************************************
 * Class    : ResourceValues
 * Remarks  :
 * History  :
 *
 * Ver	Date		Author			Description
 *----	----------	--------------	----------------------------------------------
 * 1.0	2013-03-12	Hoon-Sik,Jin    1.Create
*********************************************************************************
 * 1. [참고] App_LocalResources의 리소스파일포멧은 "페이지명.aspx.resx" 가 되어야 한다.
 * 2. [참고] App_LocalResources의 폴더는 해당페이지와 같은 폴더상에 위치해야 한다.
 * 3. [참고] 차후 확장은 데이터베이스 관리 리소스를 사용할 예정 입니다.
 * 4. [참고] 현재 리소스 클래스는 ASP.NET2.0 이전 버전에서는 호환되지 않습니다.
 * 5. [참고] 현재 리소스 클래스는 외부리소스의 경우 호환되지 않습니다. (외부리소스란 지역화를 사용하지 않는경우)
 ********************************************************************************/
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// ResourceValues에 대한 요약 설명입니다.
/// </summary>
public class ResourceValues {
//	private const string C_CLASS_VERSION = "1.0.0";
	private static void SetControlsResource(Control pObject, string pPath) {
		string vText = AppResourceText(pPath, pObject.ID);

		if ( vText == null ) {
			return;
		}


		switch ( pObject.ToString() ) {
			case "Label":
				((Label) pObject).Text = vText;
				break;
			case "CheckBox":
				((CheckBox) pObject).Text = vText;
				break;
			case "Button":
				((Button) pObject).Text = vText;
				break;
			case "RadioButton":
				((RadioButton) pObject).Text = vText;
				break;
		}

/*		sResourceText = AppResourceText(pPath, pObj.ID);
		if ( sResourceText == null ) return;

		if ( pObj is Label ) {
			((Label) pObj).Text = sResourceText;
		} else if ( pObj is CheckBox ) {
			((CheckBox) pObj).Text = sResourceText;
		} else if ( pObj is RadioButton ) {
			((RadioButton) pObj).Text = sResourceText;
		} else if ( pObj is Button ) {
			((Button) pObj).Text = sResourceText;
		}
*/	}

	private static string AppResourceValue(string pPath, string pKey) {
		string oValue;

		// 전역리소스 API 사용
		try {
			oValue = (string) System.Web.HttpContext.GetGlobalResourceObject(pPath, pKey);
		} catch ( Exception ) {
			oValue = "";
		}

		if ( !string.IsNullOrEmpty(oValue) ) {
			return oValue;
		}


		// 로컬리소스 API 사용
		try {
			oValue = ((string) System.Web.HttpContext.GetLocalResourceObject(pPath, pKey));
		} catch ( Exception ) {
			oValue = "";
		}

		return oValue;

		//--------------------------------------------------------------------------------------------------------------
		// ※ 참고용 주석
		//--------------------------------------------------------------------------------------------------------------
		// MEMO: ASP.NET 2.0 리소스 동적호출방법 (APP_LOCAL) - [가상경로지정]
		//string sValue = (string)System.Web.HttpContext.GetLocalResourceObject("~/App/Login.aspx", "msgLoginSuccess");

		// MEMO: ASP.NET 2.0 리소스 동적호출방법 (APP_GLOBAL)
		//string sValue = (string)System.Web.HttpContext.GetGlobalResourceObject("Login.aspx", psKey);

		// MEMO: ASP.NET 2.0 리소스 명시적호출방법 (APP_GLOBAL)
		//oResValues.moResource = new System.Resources.ResourceManager("Resources.Login", typeof(Resources.Login).Assembly);
		//--------------------------------------------------------------------------------------------------------------
	}


	#region init control
	/// <summary>
	/// 목적 : 마스터페이지를 참조하지않는 경우 자동으로 리소스를 매핑해주는 함수
	/// </summary>
	/// <param name="pPage"></param>
	/// <param name="pPath"></param>
	public static void InitWebPageResource(Page pPage, string pPath) {
		for ( int i = 0; i < pPage.Controls.Count; i++ ) {
			Control vControl = pPage.Controls[i];

			for ( int m = 0; m < vControl.Controls.Count; m++ ) {
				Control vConSub = vControl.Controls[m];

				if ( vConSub is Panel ) {
					for ( int k = 0; k < vConSub.Controls.Count; k++ ) {
						Control vPanSub = vConSub.Controls[k];
						SetControlsResource(vPanSub, pPath);
					}
				} else {
					SetControlsResource(vConSub, pPath);
				}
			}
		}
	}

	/// <summary>
	/// 목적 : 마스터페이지를 참조하는 Content페이지의 경우 자동으로 리소스를 매핑해주는 함수
	/// </summary>
	/// <param name="pContent"></param>
	/// <param name="pPath"></param>
	public static void InitContentPageResource(ContentPlaceHolder pContent, string pPath) {
		for ( int i = 0; i < pContent.Controls.Count; i++ ) {
			Control vContorl = pContent.Controls[i];

		//	if ( pContent is UserControl ) { }
			if ( vContorl is LiteralControl ) {
				continue;
			}


			if ( vContorl is Panel ) {
				for ( int m = 0; m < vContorl.Controls.Count; m++ ) {
					Control vPanSub = vContorl.Controls[m];
					SetControlsResource(vPanSub, pPath);
				}
			} else {
				SetControlsResource(vContorl, pPath);
			}
		}
	}
	#endregion init control


	#region external interface
	public static string AppResourceText(string pPath, string pKey) {
		return AppResourceValue(pPath, pKey);
	}

	public static void fnInitBindControlResource(object pObj, string pXmlPath, string pXmlName) {
		DataSet vTable = new DataSet();
		vTable.ReadXml(pXmlPath + pXmlName);

		switch ( pObj.ToString() ) {
			case "DropDownList":
				((DropDownList) pObj).DataSource		= vTable;
				((DropDownList) pObj).DataTextField		= "Text";
				((DropDownList) pObj).DataValueField	= "value";
				((DropDownList) pObj).DataBind();
				break;
			case "RadioButtonList":
				((RadioButtonList) pObj).DataSource		= vTable;
				((RadioButtonList) pObj).DataTextField	= "Text";
				((RadioButtonList) pObj).DataValueField = "value";
				((RadioButtonList) pObj).DataBind();
				break;
			case "CheckBoxList":
				((CheckBoxList) pObj).DataSource		= vTable;
				((CheckBoxList) pObj).DataTextField		= "Text";
				((CheckBoxList) pObj).DataValueField	= "value";
				((CheckBoxList) pObj).DataBind();
				break;
			case "ListBox":
				((ListBox) pObj).DataSource				= vTable;
				((ListBox) pObj).DataTextField			= "Text";
				((ListBox) pObj).DataValueField			= "value";
				((ListBox) pObj).DataBind();
				break;
		}
	}
	#endregion external interface
}
