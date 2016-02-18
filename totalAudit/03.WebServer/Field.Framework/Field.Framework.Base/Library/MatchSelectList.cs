using System;
using System.Data;

public class MatchSelectList {
	private static string WEB_RESOURCE_PATH;

	// 드랍다운 리스트 아이템 채우기
	public static DataTable fnSetSelectList(string pObjName, string pResource) {
		int i = 0;
		string[] cColumns = new string[2];
		const string vTexts = "{0}_{1}.Text";
		const string vValue = "{0}_{1}.Value";
		DataTable dt = new DataTable();

		WEB_RESOURCE_PATH = pResource;

		dt.Columns.Add("cValue"	, typeof(string));	// 0
		dt.Columns.Add("cText"	, typeof(string));	// 1

		while ( true ) {
			string vNo = Convert.ToString(i++);

			try {
				cColumns[0] = fnLabelText(string.Format(vValue, pObjName, vNo.PadLeft(2,'0')));
				cColumns[1] = fnLabelText(string.Format(vTexts, pObjName, vNo.PadLeft(2,'0')));
			} catch {
				break;
			}

			if ( string.IsNullOrEmpty(cColumns[0]) ) {
				break;
			}


			// BoardType 아이템 추가
			dt.Rows.Add
			(	cColumns[0]
			,	cColumns[1]
			);
		}

		return dt;
	}


	// 라벨에 텍스트 입력
	private static string fnLabelText(string pParam) {
		return ResourceValues.AppResourceText(WEB_RESOURCE_PATH, pParam);
	}
}
