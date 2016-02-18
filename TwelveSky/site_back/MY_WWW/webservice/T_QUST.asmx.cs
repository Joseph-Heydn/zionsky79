using System;
using System.Web.Services;
using System.Data.Common;
using System.Configuration;
using System.Data;

namespace _12sky2.webservice {
	/// <summary>
	/// T_QUST의 요약 설명입니다.
	/// </summary>
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.ComponentModel.ToolboxItem(false)]
	// ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다. 
	// [System.Web.Script.Services.ScriptService]
	public class T_QUST : WebService {
		/*********************************************************************************************************************/
		/* total count
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public int getTotalCnt(string USER_ID, string NAT_CD, string SCH_TXT) {
			int ret = 0;
			string tmpSQL = null;
			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + @" (getTotalCnt)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                                SELECT
                                    COUNT(SEQ)
                                FROM T_QUST
                                WHERE DEL_YN = 'N'
                                AND NAT_CD = '" + NAT_CD + @"'
";
				if ( !SYS.is_null(SCH_TXT) ) {
					tmpSQL += @"AND (USER_ID like '%" + SCH_TXT + @"%'
                                    OR NICK_NM like '%" + SCH_TXT + @"%'
                                    OR SCRT_EMAIL like '%" + SCH_TXT + @"%')";
				}

				if ( !SYS.is_null(USER_ID) ) {
					tmpSQL += "AND USER_ID = '" + USER_ID + "'";
				}


				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				DbDataReader reader = command.ExecuteReader();
				if ( reader.Read() ) {
					ret = int.Parse(reader[0].ToString());
				}
				reader.Close();
				Trans.Commit();
			} catch ( Exception ex ) {
				Trans.Rollback();
				var msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + USER_ID + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw SYS.Log(Context, ex);
			} finally {
				cnn.Close();
			}

			return ret;
		}

		/*********************************************************************************************************************/
		/* list
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public DataTable getList(string USER_ID, string NAT_CD, int NOW_PAGE, string SCH_TXT) {
			DataTable result = new DataTable("DataTable");
			string tmpSQL = null;
			int LIST_CNT = int.Parse(SYS.LIST_EA);

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + @" (getList)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                SELECT *
                FROM
                (
                    SELECT 
                        A.*
                        , ((ROWNO + " + LIST_CNT + " - 1)  / " + LIST_CNT + @") as PAGE
                    FROM
                    (
                        SELECT
                            SEQ
                            , USER_ID
                            , USER_NO
                            , NICK_NM
                            , QUST_CD_1
                            , QUST_CD_2
                            , TITL
                            , CNTN
                            , FILE_PATH_1
                            , FILE_PATH_2
                            , FILE_PATH_3
                            , FILE_PATH_4
                            , FILE_PATH_5
                            , REG_IP
                            , REG_DTM
                            , DEL_YN
                            , DEAL_STAT
                            , DEAL_CNTN
                            , DEAL_DTM
                            , DEAL_ID
                            , DEAL_NICK_NM
                            , FNSH_DTM
                            , FNSH_ID
                            , CONVERT(VARCHAR(10), REG_DTM, 120) as REG_DT
                            , CONVERT(VARCHAR(10), UPDT_DTM, 120) as UPDT_DT
                            , row_number() over(order by UPDT_DTM desc) as ROWNO
                            , row_number() over(order by UPDT_DTM asc) as ROWNUM
                             , CASE 
                                    WHEN (SELECT COUNT(SEQ) FROM T_CMMT WHERE RELT_DIV = 'myquestions' AND RELT_SEQ = A.SEQ) > 0
                                    THEN ' (' + CONVERT(VARCHAR, (SELECT COUNT(SEQ) FROM T_CMMT WHERE RELT_DIV = 'myquestions' AND RELT_SEQ = A.SEQ)) + ')'
                                    ELSE ''
                                END AS CMMT_CNT
                            , CASE 
                                WHEN FILE_PATH_1 IS NOT NULL OR FILE_PATH_2 IS NOT NULL OR FILE_PATH_2 IS NOT NULL 
                                    OR FILE_PATH_4 IS NOT NULL OR FILE_PATH_5 IS NOT NULL 
                                THEN '" + SYS.ICON_FILE + @"'
                                ELSE ''
                            END as ICON_FILE
                            , CASE 
                                WHEN GETDATE() - A.REG_DTM <= " + SYS.NEW_DAY + @"
                                THEN '" + SYS.ICON_NEW + @"'
                                ELSE ''
                            END as ICON_NEW
                            , CASE
                                WHEN DEAL_STAT = '0' THEN 'Of receipt'
                                WHEN DEAL_STAT = '1' THEN 'Receipt complete'
                                WHEN DEAL_STAT = '2' THEN 'Processing'
                                WHEN DEAL_STAT = '3' THEN 'Processing complete'
                                ELSE ''
                            END as DEAL_STAT_NM
                            , UPDT_DTM
                            , SCRT_EMAIL
                        FROM T_QUST A
                        WHERE DEL_YN = 'N' AND NAT_CD = '" + NAT_CD + @"'
";
				if ( !SYS.is_null(SCH_TXT) ) {
					tmpSQL += @"AND (USER_ID like '%" + SCH_TXT + @"%'
                                    OR NICK_NM like '%" + SCH_TXT + @"%'
                                    OR SCRT_EMAIL like '%" + SCH_TXT + @"%')";
				}

				if ( !SYS.is_null(USER_ID) ) {
					tmpSQL += "AND USER_ID = '" + USER_ID + "'";
				}
				tmpSQL += @"
                    ) A
                ) A
                WHERE PAGE = " + NOW_PAGE + @"
                ORDER BY UPDT_DTM DESC";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				if ( adapter != null ) {
					adapter.SelectCommand = command;
					adapter.Fill(result);
				}
				Trans.Commit();
			} catch ( Exception ex ) {
				Trans.Rollback();
				var msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + USER_ID + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw SYS.Log(Context, ex);
			} finally {
				cnn.Close();
			}

			return result;
		}

		/*********************************************************************************************************************/
		/* read
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public DataTable getRead(string SEQ) {
			DataTable result = new DataTable("DataTable");
			string tmpSQL = null;
			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + @" (getRead)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                SELECT
                    SEQ
                    , USER_ID
                    , USER_NO
                    , NICK_NM
                    , QUST_CD_1, (SELECT CD_NM FROM T_QUST_CD WHERE CD_NO = QUST_CD_1) as QUST_CD_1_NM
                    , QUST_CD_2, (SELECT CD_NM FROM T_QUST_CD WHERE CD_NO = QUST_CD_2) as QUST_CD_2_NM
                    , TITL
                    , CNTN
                    , FILE_PATH_1, (SELECT FILE_NM FROM T_FILE_INFO WHERE SEQ = FILE_PATH_1) AS FILE_PATH_1_NM
                    , FILE_PATH_2, (SELECT FILE_NM FROM T_FILE_INFO WHERE SEQ = FILE_PATH_2) AS FILE_PATH_2_NM
                    , FILE_PATH_3, (SELECT FILE_NM FROM T_FILE_INFO WHERE SEQ = FILE_PATH_3) AS FILE_PATH_3_NM
                    , FILE_PATH_4, (SELECT FILE_NM FROM T_FILE_INFO WHERE SEQ = FILE_PATH_4) AS FILE_PATH_4_NM
                    , FILE_PATH_5, (SELECT FILE_NM FROM T_FILE_INFO WHERE SEQ = FILE_PATH_5) AS FILE_PATH_5_NM
                    , REG_IP
                    , REG_DTM
                    , DEL_YN
                    , DEAL_STAT
                    , DEAL_CNTN
                    , DEAL_DTM
                    , DEAL_ID
                    , DEAL_NICK_NM
                    , FNSH_DTM
                    , FNSH_ID
                    , CONVERT(VARCHAR, REG_DTM, 106) as REG_DT
                    , CASE
                        WHEN DEAL_STAT = '0' THEN 'Of receipt'
                        WHEN DEAL_STAT = '1' THEN 'Receipt complete'
                        WHEN DEAL_STAT = '2' THEN 'Processing'
                        WHEN DEAL_STAT = '3' THEN 'Processing complete'
                        ELSE ''
                    END as DEAL_STAT_NM
                    , UPDT_DTM
                    , SCRT_EMAIL
                FROM T_QUST
                WHERE DEL_YN = 'N'
                AND SEQ = '" + SEQ + @"'
                ";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				if ( adapter != null ) {
					adapter.SelectCommand = command;
					adapter.Fill(result);
				}
				Trans.Commit();
			} catch ( Exception ex ) {
				Trans.Rollback();
				var msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + SEQ + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw SYS.Log(Context, ex);
			} finally {
				cnn.Close();
			}

			return result;
		}

		/*********************************************************************************************************************/
		/* insert
        /*********************************************************************************************************************/
		//
		[WebMethod(EnableSession = true)]
		public Exception insert(string USER_ID, string USER_NO, string NICK_NM, string QUST_CD_1, string QUST_CD_2,
			string TITL, string CNTN, string FILE_PATH_1, string FILE_PATH_2, string FILE_PATH_3, string FILE_PATH_4,
			string FILE_PATH_5, string NAT_CD, string SCRT_EMAIL) {
			string tmpSQL = null;
			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + @" (insert)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    INSERT INTO T_QUST
                    (
                        SEQ
                        , USER_ID
                        , USER_NO
                        , NICK_NM
                        , QUST_CD_1
                        , QUST_CD_2
                        , TITL
                        , CNTN
                        , FILE_PATH_1
                        , FILE_PATH_2
                        , FILE_PATH_3
                        , FILE_PATH_4
                        , FILE_PATH_5
                        , REG_IP
                        , REG_DTM
                        , DEL_YN
                        , DEAL_STAT
                        , NAT_CD
                        , UPDT_DTM
                        , SCRT_EMAIL
                    )
                    VALUES
                    (
                        (SELECT ISNULL(MAX(CONVERT(int, SEQ))+1, 1) FROM T_QUST)
                        , @USER_ID
                        , @USER_NO
                        , @NICK_NM
                        , @QUST_CD_1
                        , @QUST_CD_2
                        , @TITL
                        , @CNTN
                        , @FILE_PATH_1
                        , @FILE_PATH_2
                        , @FILE_PATH_3
                        , @FILE_PATH_4
                        , @FILE_PATH_5
                        , @REG_IP
                        , GETDATE()
                        , 'N'
                        , '0'
                        , @NAT_CD
                        , GETDATE()
                        , @SCRT_EMAIL
                    )";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				connect.CreateParameter(command, "@USER_ID", USER_ID);
				connect.CreateParameter(command, "@USER_NO", USER_NO);
				connect.CreateParameter(command, "@NICK_NM", NICK_NM);
				connect.CreateParameter(command, "@QUST_CD_1", QUST_CD_1);
				connect.CreateParameter(command, "@QUST_CD_2", QUST_CD_2);
				connect.CreateParameter(command, "@TITL", TITL);
				connect.CreateParameter(command, "@CNTN", CNTN);
				connect.CreateParameter(command, "@FILE_PATH_1", FILE_PATH_1);
				connect.CreateParameter(command, "@FILE_PATH_2", FILE_PATH_2);
				connect.CreateParameter(command, "@FILE_PATH_3", FILE_PATH_3);
				connect.CreateParameter(command, "@FILE_PATH_4", FILE_PATH_4);
				connect.CreateParameter(command, "@FILE_PATH_5", FILE_PATH_5);
				connect.CreateParameter(command, "@REG_IP", Context.Request.UserHostAddress);
				connect.CreateParameter(command, "@NAT_CD", NAT_CD);
				connect.CreateParameter(command, "@SCRT_EMAIL", SCRT_EMAIL);

				command.ExecuteNonQuery();

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// 메일 보내기.
			//	SYS.mailFrom(TITL, CNTN, USER_ID);
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				var msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + USER_ID + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* update : 접수완료
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception updateStat1(string SEQ) {
			string tmpSQL = null;
			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + @" (update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_QUST SET
                        DEAL_STAT = '1'
                    WHERE DEL_YN = 'N'
                    AND SEQ = '" + SEQ + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();
				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				var msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + SEQ + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* update : 처리
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception updateStat2(string SEQ, string USER_ID, string USER_NICK_NM, string DEAL_STAT, string DEAL_CNTN) {
			string tmpSQL = null;
			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + @" (update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_QUST SET
                        DEAL_STAT = '" + DEAL_STAT + @"'
                        , DEAL_CNTN = @DEAL_CNTN
                        , DEAL_DTM = GETDATE()
                        , DEAL_ID = '" + USER_ID + @"'
                        , DEAL_NICK_NM = '" + USER_NICK_NM + @"'
                    WHERE DEL_YN = 'N'
                    AND SEQ = '" + SEQ + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				connect.CreateParameter(command, "@DEAL_CNTN", DEAL_CNTN);

				command.ExecuteNonQuery();
				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				var msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + USER_ID + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* update : 완료
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception updateStat3(string SEQ, string USER_ID) {
			string tmpSQL = null;
			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + @" (update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_QUST SET
                        DEAL_STAT = '3'
                        , FNSH_DTM = GETDATE()
                        , FNSH_ID = '" + USER_ID + @"'
                    WHERE DEL_YN = 'N'
                    AND SEQ = '" + SEQ + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();
				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				var msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + SEQ + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* delete
        /*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception delete(string SEQ) {
			string tmpSQL = null;
			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["NAT_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["NAT_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + @" (update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

                    UPDATE T_QUST SET
                        DEL_YN = 'Y'
                        , UPDT_DTM = GETDATE()
                    WHERE DEL_YN = 'N'
                    AND SEQ = '" + SEQ + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();
				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				var msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + SEQ + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw;
			} finally {
				cnn.Close();
			}
		}
	}
}
