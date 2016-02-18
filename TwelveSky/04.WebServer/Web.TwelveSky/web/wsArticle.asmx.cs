using System;
using System.Data;
using System.Web;
using System.Web.Services;

using Field.Framework;
using Field.TwelveWebAppTier.Dal;

namespace Web.TwelveSky.web {
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.Web.Script.Services.ScriptService]
	public class wsArticle : WebService {
		private readonly AuthAccountInfo gAuthInfo = AuthorityManager.GetAuthAccountInfo();
		private readonly string gConnStr = ConnString.fnGetName("FieldWeb");
		private readonly byte gPublisher = Convert.ToByte(ConfigValues.EnvText.cNation);

		// 게시물 소유자 권한 체크
		[WebMethod]
		public bool fnCheckAuthority(int pMenuNo, long pWriteNo) {
			if ( gAuthInfo.pAccountNo == 0 ) {
				return false;
			}


			uspGetArticleInfo oDTO = new uspGetArticleInfo
			{	pMenuNo		= pMenuNo
			,	pWriteNo	= pWriteNo
			,	pAccountNo	= gAuthInfo.pAccountNo
			};

			return oDTO.fnGetResultInfo(gConnStr) == 0;
		}


		#region binding layer
		// js Ajax 덧글 목록 조회 메소드
		[WebMethod]
		public string fnReplyList(string pMenuNo, long pWriteNo, short pPageNo, sbyte pJumpSize, sbyte pIsNext, long pBaseMoveNo, int pRowCnt) {
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenuNo);
			if ( !Convert.ToBoolean(vMenuInfo[0]["cIsReply"]) ) {
				return "false";
			}


			byte vBlockSize = Convert.ToByte(ConfigValues.EnvPage.nBlockSize);
			byte vPageSize = Convert.ToByte(ConfigValues.EnvPage.nPageSize);
			int vCheckNext = (vPageSize * vBlockSize) + 1;

			Paging cPaging = new Paging
			{	pPageNo		= pPageNo
			,	pPageSize	= vPageSize
			,	pJumpSize	= pJumpSize
			,	pBlockSize	= vBlockSize
			,	pIsNext		= pIsNext
			,	pCheckNext	= vCheckNext
			};
			cPaging.fnSetParam();

			// seek를 시작할 게시물 번호
			if ( pBaseMoveNo == 0 ) {
				pBaseMoveNo = 9223372036854775807;
			}


			uspGetReplyList oDTO = new uspGetReplyList
			{	pWriteNo		= pWriteNo
			,	pPageSize		= cPaging.pPageSize
			,	pJumpSize		= cPaging.pJumpSize
			,	pCheckNext		= cPaging.pCheckNext
			,	pLastCommtNo	= pBaseMoveNo
			};
			DataTable vReplyList = oDTO.fnGetResultSet(gConnStr);

			// JSON 스트링으로 변환하여 넘기기 위한 데이터 셋 변환
			DataSet vDataSet = new DataSet();
			vDataSet.Merge(fnReplyListConvert(ref vReplyList));

			// 블록카운트가 0보다 클때 페이징 데이터 조회
			if ( vReplyList.Rows.Count <= 0 ) {
				return Extends.GetJsonString(vDataSet);
			}


			// 페이징 데이터 가져오기
			cPaging.pRecordCnt = pRowCnt;
			cPaging.pCheckBlock = 1;
			cPaging.pFirstNo = Convert.ToInt64(vReplyList.Rows[0][0]);
			cPaging.pLimitNo = Convert.ToInt64(vReplyList.Rows[vReplyList.Rows.Count-1][0]);

			DataTable vTable = cPaging.fnPagingReply(oDTO.oBlockCnt);
			vDataSet.Merge(vTable);

			return Extends.GetJsonString(vDataSet);
		}

		// 덧글 목록 계정에 따른 버튼 조정
		private DataTable fnReplyListConvert(ref DataTable pTable) {
			DataTable oTable = new DataTable();

			oTable.Columns.Add("cCommtNo"	, typeof(long));
			oTable.Columns.Add("cAccountNo"	, typeof(long));
			oTable.Columns.Add("cWriter"	, typeof(string));
			oTable.Columns.Add("cComments"	, typeof(string));
			oTable.Columns.Add("cHostIp"	, typeof(string));
			oTable.Columns.Add("cView"		, typeof(bool));
			oTable.Columns.Add("cIsWriter"	, typeof(bool));
			oTable.Columns.Add("cRecmdCnt"	, typeof(int));
			oTable.Columns.Add("cAgnstCnt"	, typeof(int));
			oTable.Columns.Add("cRepotCnt"	, typeof(int));
			oTable.Columns.Add("cCreateTime", typeof(string));

			foreach ( DataRow vRow in pTable.Rows ) {
				DataRow vNewRow = oTable.NewRow();

				vNewRow["cCommtNo"]		= vRow["cCommtNo"];
				vNewRow["cAccountNo"]	= vRow["cAccountNo"];
				vNewRow["cWriter"]		= vRow["cWriter"];
				vNewRow["cComments"]	= vRow["cComments"];
				vNewRow["cHostIp"]		= vRow["cHostIp"];
				vNewRow["cView"]		= vRow["cView"];
				vNewRow["cIsWriter"]	= Convert.ToBoolean(gAuthInfo.pAccountNo == Convert.ToInt64(vRow["cAccountNo"]));
				vNewRow["cRecmdCnt"]	= vRow["cRecmdCnt"];
				vNewRow["cAgnstCnt"]	= vRow["cAgnstCnt"];
				vNewRow["cRepotCnt"]	= vRow["cRepotCnt"];
				vNewRow["cCreateTime"]	= $"{vRow["cCreateTime"]:yyyy-MM-dd hh:mm:ss}";

				oTable.Rows.Add(vNewRow);
			}

			return oTable;
		}
		#endregion binding layer


		#region control layer
		// Js Ajax 덧글 입력
		[WebMethod]
		public string fnReplyWrite(string pMenuNo, long pWriteNo, string pContents) {
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenuNo);

			if ( !Convert.ToBoolean(vMenuInfo[0]["cIsReply"]) ) {
				return "false";
			}
			// 로그인 체크
			if ( string.IsNullOrEmpty(gAuthInfo.pAccountNm) ) {
				return "loginError";
			}


			// 아이피 가져오기
			HttpCookie vCookie = HttpContext.Current.Request.Cookies["fnHostInfo"];
			string vHostIp = vCookie != null ? vCookie.Value : HttpContext.Current.Request.ServerVariables["remote_addr"];

			uspSetReplyWrite oDTO = new uspSetReplyWrite
			{	pMenuNo		= Convert.ToInt32(pMenuNo)
			,	pWriteNo	= pWriteNo
			,	pPublisher	= gPublisher
			,	pAccountNo	= gAuthInfo.pAccountNo
			,	pAccountId	= gAuthInfo.pAccountId
			,	pWriter		= gAuthInfo.pAccountNm
			,	pHostIp		= vHostIp
			,	pContents	= fnReplaceXSS(pContents)
			};
			int vReturn = oDTO.fnSetWriteInfo(gConnStr);

			return vReturn == 0 ? "success" : $"error [{vReturn}]";
		}

		// Js AJax 덧글 수정
		[WebMethod]
		public string fnReplyModify(string pMenuNo, long pWriteNo, int pCommtNo, string pContents) {
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenuNo);
			if ( !Convert.ToBoolean(vMenuInfo[0]["cIsReply"]) ) {
				return "false";
			}
			// 로그인 체크
			if ( string.IsNullOrEmpty(gAuthInfo.pAccountNm) ) {
				return "loginError";
			}


			uspSetReplyModify oDTO = new uspSetReplyModify
			{	pMenuNo		= Convert.ToInt32(pMenuNo)
			,	pWriteNo	= pWriteNo
			,	pPublisher	= gPublisher
			,	pCommtNo	= pCommtNo
			,	pContents	= fnReplaceXSS(pContents)
			,	pAccountNo	= gAuthInfo.pAccountNo
			};
			int vReturn = oDTO.fnSetModifyInfo(gConnStr);

			return vReturn == 0 ? "success" : $"error [{vReturn}]";
		}

		// Js AJax 덧글 삭제
		[WebMethod]
		public string fnReplyDelete(string pMenuNo, long pWriteNo, int pCommtNo) {
			DataRow[] vMenuInfo = MenuList.fnMenuName(pMenuNo);

			if ( !Convert.ToBoolean(vMenuInfo[0]["cIsReply"]) ) {
				return "false";
			}
			// 로그인 체크
			if ( string.IsNullOrEmpty(gAuthInfo.pAccountNm) ) {
				return "loginError";
			}


			uspSetReplyDelete oDTO = new uspSetReplyDelete
			{	pMenuNo		= Convert.ToInt32(pMenuNo)
			,	pWriteNo	= pWriteNo
			,	pPublisher	= gPublisher
			,	pCommtNo	= pCommtNo
			,	pAccountNo	= gAuthInfo.pAccountNo
			};
			int vReturn = oDTO.fnSetDeleteInfo(gConnStr);

			return vReturn == 0 ? "success" : $"error [{vReturn}]";
		}
		#endregion control layer


		// XSS 막기
		private static string fnReplaceXSS(string pText) {
			return pText.Replace("<", "&lt;")
						.Replace(">", "&gt;")
						.Replace("//", "&#47;&#47;")
						.Replace("/*", "&#47;&#42;")
						.Replace("*/", "&#42;&#47;")
						.Replace("--", "&#45;&#45;");
		}
	}
}
