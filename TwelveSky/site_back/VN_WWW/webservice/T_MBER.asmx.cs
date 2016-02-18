using System;
using System.Web;
using System.Web.Services;
using System.Data.Common;
using System.Configuration;
using System.Web.Security;
using System.Data;


namespace _12sky2.webservice {
	/// <summary>
	/// T_MBER의 요약 설명입니다.
	/// </summary>
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.ComponentModel.ToolboxItem(false)]
	// ASP.NET AJAX를 사용하여 스크립트에서 이 웹 서비스를 호출하려면 다음 줄의 주석 처리를 제거합니다.
	// [System.Web.Script.Services.ScriptService]
	public class T_MBER : WebService {
		/*********************************************************************************************************************/
		/* total count
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public int getTotalCnt(string NAT_CD, string USE_AUTH, string SCH_TXT) {
			int ret = 0;
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (getTotalCnt)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						COUNT(A.SEQ)
					FROM T_MBER A
					, T_MBER_INFO B
					WHERE A.SEQ = B.MBER_SEQ
					AND A.USE_AUTH NOT IN ('1')
					AND (CASE WHEN A.USE_AUTH = '8' THEN '" + NAT_CD + @"' ELSE B.ENTR_NAT_CD END) = '" + NAT_CD + @"'
				";

				if ( !SYS.is_null(USE_AUTH) ) {
					tmpSQL += "AND A.USE_AUTH = '" + USE_AUTH + "'";
				}

				if ( !SYS.is_null(SCH_TXT) ) {
					tmpSQL += @"AND (A.USER_ID like '%" + SCH_TXT + @"%'
									OR A.NICK_NM like '%" + SCH_TXT + @"%'
									OR A.USER_NO like '%" + SCH_TXT + @"%')";
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
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
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
		public DataTable getList(string NAT_CD, string USE_AUTH, int NOW_PAGE, string SCH_TXT) {
			DataTable result = new DataTable("DataTable");
			string tmpSQL = null, msg = null;

			int LIST_CNT = int.Parse(SYS.LIST_EA);

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (getList)--
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
							A.SEQ
							, A.USER_ID
							, A.USER_NO
							, A.NICK_NM
							, A.USE_AUTH
							, A.REG_DTM
							, A.REG_IP
							, B.SCRT_EMAIL
							, B.BRDD
							, B.SEX
							, B.EMAIL_RECV_YN
							, B.REPR_IMGE_PATH
							, B.REPR_IMGE_NM
							, B.LAST_LOG_IN_IP
							, B.LAST_LOG_IN_DTM
							, row_number() over(order by A.SEQ desc) as ROWNO
							, row_number() over(order by A.SEQ asc) as ROWNUM
							, CASE
								WHEN A.USE_AUTH = '1' THEN 'Temporary Member'
								WHEN A.USE_AUTH = '2' THEN 'Active Member'
								WHEN A.USE_AUTH = '8' THEN 'Administrator'
								WHEN A.USE_AUTH = '9' THEN 'Withdrawal Member'
								ELSE ''
							END AS USE_AUTH_NM
						FROM T_MBER A
						, T_MBER_INFO B
						WHERE A.SEQ = B.MBER_SEQ
						AND A.USE_AUTH NOT IN ('1')
						AND (CASE WHEN A.USE_AUTH = '8' THEN '" + NAT_CD + @"' ELSE B.ENTR_NAT_CD END) = '" + NAT_CD + @"'
				";

				if ( !SYS.is_null(USE_AUTH) ) {
					tmpSQL += "AND A.USE_AUTH = '" + USE_AUTH + "'";
				}

				if ( !SYS.is_null(SCH_TXT) ) {
					tmpSQL += @"AND (A.USER_ID like '%" + SCH_TXT + @"%'
									OR A.NICK_NM like '%" + SCH_TXT + @"%'
									OR A.USER_NO like '%" + SCH_TXT + @"%')";
				}

				tmpSQL += @"
					) A
				) A
				WHERE PAGE = " + NOW_PAGE + @"
				ORDER BY SEQ DESC";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				adapter.SelectCommand = command;
				adapter.Fill(result);

				Trans.Commit();
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
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
		/* user check
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public int getUserCheck(string USER_ID, string NICK_NM) {
			int ret = 0;
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (getTotalCnt)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						COUNT(SEQ)
					FROM T_MBER
					WHERE SEQ = SEQ
				";
				if ( !SYS.is_null(USER_ID) ) {
					tmpSQL += "AND USER_ID = '" + USER_ID + "'";
				}

				if ( !SYS.is_null(NICK_NM) ) {
					tmpSQL += "AND NICK_NM = '" + NICK_NM + "'";
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
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
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
		/* user info
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public DataTable getUserInfo(string USER_ID) {
			DataTable result = new DataTable("DataTable");
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (getUserInfo)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						REG_DTM as RegisterDate
						, '1' as Result
						, NICK_NM as Nickname
						, USER_NO as UserNo
						, USER_ID as UserID
						, SUBSTRING(USER_NO, 1, 2) as JoinNation
					FROM T_MBER
					--WHERE SEQ = SEQ
					WHERE SEQ = (SELECT MAX(SEQ) FROM T_MBER WHERE USER_ID = '" + USER_ID + @"')
					AND USER_ID = '" + USER_ID + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				adapter.SelectCommand = command;
				adapter.Fill(result);

				Trans.Commit();
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
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
		/* getRead
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public DataTable getRead(string USER_ID) {
			DataTable result = new DataTable("DataTable");
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (getUserInfo)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						A.SEQ
						, A.USER_ID
						, A.USER_NO
						, A.NICK_NM
						, A.USE_AUTH
						, A.REG_DTM
						, A.REG_IP
						, B.SCRT_EMAIL
						, B.BRDD
						, B.SEX
						, B.EMAIL_RECV_YN
						, B.REPR_IMGE_PATH
						, B.REPR_IMGE_NM
						, B.LAST_LOG_IN_IP
						, B.LAST_LOG_IN_DTM
					FROM T_MBER A
					, T_MBER_INFO B
					WHERE A.SEQ = B.MBER_SEQ
					AND A.SEQ = (SELECT MAX(SEQ) FROM T_MBER WHERE USER_ID = '" + USER_ID + @"')
					AND A.USER_ID = '" + USER_ID + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				adapter.SelectCommand = command;
				adapter.Fill(result);

				Trans.Commit();
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
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
		[WebMethod(EnableSession = true)]
		public Exception insert(string USER_ID, string NICK_NM, string PSWD, string USE_AUTH, string NAT_CD, string SCRT_EMAIL, string EMAIL_RECV_YN) {
			string tmpSQL = null, msg = null;
			int NOW_SEQ = 0;
			string USER_NO = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				if ( getUserCheck(USER_ID, null) > 0 ) {
					return null;
				} else {
					tmpSQL = @"
-- " + @" (NEXT SEQ)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

							SELECT ISNULL(MAX(SEQ)+1, 1) FROM T_MBER
							";

					command.Parameters.Clear();
					command.CommandText = tmpSQL;

					DbDataReader reader = command.ExecuteReader();
					if ( !reader.HasRows )
						throw new Exception(); //다음 SEQ를 가져오지 못함
					if ( reader.Read() ) {
						NOW_SEQ = int.Parse(reader[0].ToString());
					}
					reader.Close();

					tmpSQL = @"
-- " + this.ToString() + @" (NEXT USER_NO)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

							SELECT isnull('" + NAT_CD + @"'
									+ replicate('0', 11 - LEN(cast(cast(replace(MAX(USER_NO), '" + NAT_CD + @"', '') as bigint) + 1 as varchar)))
									+ cast(cast(replace(MAX(USER_NO), '" + NAT_CD + @"', '') as bigint) + 1 as varchar)
									, '" + NAT_CD + @"' + replicate('0', 11 - LEN('1'))  + '1')
							FROM T_MBER
							WHERE USER_NO LIKE '" + NAT_CD + @"%'
							";

					command.Parameters.Clear();
					command.CommandText = tmpSQL;

					reader = command.ExecuteReader();
					if ( !reader.HasRows )
						throw new Exception(); //다음 SEQ를 가져오지 못함
					if ( reader.Read() ) {
						USER_NO = reader[0].ToString();
					}
					reader.Close();

					tmpSQL = @"
-- " + this.ToString() + @" (insert)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					INSERT INTO T_MBER
					(
						SEQ
						, USER_ID
						, USER_NO
						, NICK_NM
						, PSWD
						, TMPR_PSWD_YN
						, USE_AUTH
						, REG_DTM
						, REG_IP
					)
					VALUES
					(
						@SEQ
						, @USER_ID
						, @USER_NO
						, @NICK_NM
						, @PSWD
						, 'N'
						, @USE_AUTH
						, GETDATE()
						, @REG_IP
					)";

					command.Parameters.Clear();
					command.CommandText = tmpSQL;

					connect.CreateParameter(command, "@SEQ", SYS.nullToSpace(NOW_SEQ));
					connect.CreateParameter(command, "@USER_ID", SYS.nullToSpace(USER_ID));
					connect.CreateParameter(command, "@USER_NO", SYS.nullToSpace(USER_NO));
					connect.CreateParameter(command, "@NICK_NM", SYS.nullToSpace(NICK_NM));
					connect.CreateParameter(command, "@PSWD", SYS.GetMD5Hash(PSWD));
					connect.CreateParameter(command, "@USE_AUTH", SYS.nullToSpace(USE_AUTH));
					connect.CreateParameter(command, "@REG_IP", Context.Request.UserHostAddress);

					for ( int i = 0; i < command.Parameters.Count; i++ ) {
						msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
					}

					command.ExecuteNonQuery();

					tmpSQL = @"
-- " + this.ToString() + @" (insert)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					INSERT INTO T_MBER_INFO
					(
						SEQ
						, MBER_SEQ
						, USER_NO
						, SCRT_EMAIL
						, EMAIL_RECV_YN
						, REG_DTM
						, ENTR_NAT_CD
					)
					VALUES
					(
						@SEQ
						, @MBER_SEQ
						, @USER_NO
						, @SCRT_EMAIL
						, @EMAIL_RECV_YN
						, GETDATE()
						, @ENTR_NAT_CD
					)";

					command.Parameters.Clear();
					command.CommandText = tmpSQL;

					connect.CreateParameter(command, "@SEQ", SYS.nullToSpace(NOW_SEQ));
					connect.CreateParameter(command, "@MBER_SEQ", SYS.nullToSpace(NOW_SEQ));
					connect.CreateParameter(command, "@USER_NO", SYS.nullToSpace(USER_NO));
					connect.CreateParameter(command, "@SCRT_EMAIL", SYS.nullToSpace(SCRT_EMAIL));
					connect.CreateParameter(command, "@EMAIL_RECV_YN", SYS.nullToSpace(EMAIL_RECV_YN));
					connect.CreateParameter(command, "@ENTR_NAT_CD", SYS.nullToSpace(NAT_CD));

					for ( int i = 0; i < command.Parameters.Count; i++ ) {
						msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
					}

					command.ExecuteNonQuery();


					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					//                if(USE_AUTH.Equals("1"))
					//                {
					//                    string _TO = USER_ID;
					//                    string titl = "Verify your new TwelveSky2 account";
					//                    string CheckCode = SYS.Base64Encode(USER_ID);
					//                    string subject = @"
					//                        You are almost ready to play our enjoyable online games!<br>
					//                        Click the button below to verify your email and finish your registration.<br>
					//                        <a href='" + SYS.DOMAIN + "/web/emailcheck/joincheck.aspx?CheckCode=" + CheckCode + @"' target='_blank'>Finish registration</a><br>
					//                        - KJ Games support team";
					//                    // 메일 보내기.
					//                    SYS.mailTo(titl, subject, _TO);
					//                }
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

					Trans.Commit();

					return null;
				}
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw ex;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* joinCheck
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception joinCheck(string USER_ID) {
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + this.ToString() + @" (joinCheck)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER SET
						USE_AUTH = '2'
					WHERE USER_ID = '" + USER_ID + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();


				tmpSQL = @"
-- " + this.ToString() + @" (joinCheck)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER_INFO SET
						MAJCMBER_CERTI_DTM = GETDATE()
					WHERE MBER_SEQ
						= (SELECT SEQ
							FROM T_MBER
							WHERE USER_ID = '" + USER_ID + "')";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();

				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw ex;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* update T_MBER_INFO
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception updateMberInfo(string BRDD, string SEX, string EMAIL_RECV_YN, string REPR_IMGE_PATH, string USER_ID, string USE_AUTH) {
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + this.ToString() + @" (updateMberInfo)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER_INFO SET
					   BRDD = '" + BRDD + @"'
						, SEX = '" + SEX + @"'
						, EMAIL_RECV_YN = '" + EMAIL_RECV_YN + @"'
						, REPR_IMGE_PATH = '" + REPR_IMGE_PATH + @"'
					WHERE MBER_SEQ = (SELECT MAX(SEQ)
									FROM T_MBER
									WHERE USER_ID = '" + USER_ID + "')";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();

				if ( !SYS.is_null(USE_AUTH) ) {
					tmpSQL = @"
-- " + this.ToString() + @" (updateMberInfo)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER SET
					   USE_AUTH = '" + USE_AUTH + @"'
					WHERE USER_ID = '" + USER_ID + "'";

					command.Parameters.Clear();
					command.CommandText = tmpSQL;
					command.ExecuteNonQuery();
				}

				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw ex;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* login
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Boolean login(string ID, string PSWD, string NAT_CD) {
			bool ret = false;
			string tmpSQL = null, msg = null;
			string SEQ = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
		//	DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (login)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						A.SEQ
						, A.USER_ID
						, A.USER_NO
						, A.NICK_NM
						, A.USE_AUTH
						, A.REG_DTM
						, A.REG_IP
						, B.ENTR_NAT_CD
						, B.LAST_LOG_IN_DTM
						, B.SCRT_EMAIL
					FROM T_MBER A
						, T_MBER_INFO B
					WHERE A.SEQ = B.MBER_SEQ
					AND A.USE_AUTH NOT IN ('1','9')
					AND A.USER_ID = @ID
					AND A.PSWD = @PSWD
				--	AND (CASE WHEN A.USE_AUTH = '8' THEN @NAT_CD ELSE B.ENTR_NAT_CD END) = @NAT_CD
				";
				// 1: 가회원, 9:탈퇴회원

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				connect.CreateParameter(command, "@ID", ID);
				connect.CreateParameter(command, "@PSWD", SYS.GetMD5Hash(PSWD));
			//	connect.CreateParameter(command, "@NAT_CD", NAT_CD);

				for ( int i = 0; i < command.Parameters.Count; i++ ) {
					msg += "\r\n    - " + command.Parameters[i].ParameterName + "               :    " + command.Parameters[i].Value;
				}

				DbDataReader reader = command.ExecuteReader();

				if ( !reader.HasRows ) {
					ret = false;
				}

				if ( reader.Read() ) {
				//	bool isCookiePersistent = true;
					FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket
						(	1
						,	reader["USER_ID"].ToString().Trim()
						,	DateTime.Now
						,	DateTime.Now.AddMinutes(1440*7)
						,	true
						,	"Users"
						);
					string enctyptedTicket = FormsAuthentication.Encrypt(authTicket);
					HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, enctyptedTicket);
					HttpContext.Current.Response.Cookies.Add(authCookie);

					Session["USER_ID"] = reader["USER_ID"].ToString().Trim();
					Session["USER_NICK_NM"] = reader["NICK_NM"].ToString().Trim();
					Session["USE_AUTH"] = reader["USE_AUTH"].ToString().Trim();
					Session["USER_NO"] = reader["USER_NO"].ToString().Trim();
					Session["SCRT_EMAIL"] = reader["SCRT_EMAIL"].ToString().Trim();
					SEQ = reader["SEQ"].ToString().Trim();

					string tmpUser = SYS.Base64Encode(reader["USER_ID"].ToString());
					HttpCookie userid = new HttpCookie("tmpUSER", tmpUser) {
						Expires = DateTime.Now.AddDays(1),
						Domain = SYS.COOKIE_DOMAIN
					};
					HttpContext.Current.Response.Cookies.Add(userid);
				}

				reader.Close();

				if ( !SYS.is_null(Session["USER_ID"]) ) {
					tmpSQL = @"
-- " + this.ToString() + @" (login log)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					INSERT INTO T_LOG_IN_LOGX
					(
						SEQ
						, USER_ID
						, LOG_IN_DTM
						, LOG_IN_RSN
						, AccessType
					)
					VALUES
					(
						(SELECT ISNULL(MAX(SEQ) + 1,1) FROM T_LOG_IN_LOGX)
						, '" + ID + @"'
						, GETDATE()
						, '0'
						, '1'
					)";

					command.Parameters.Clear();
					command.CommandText = tmpSQL;
					command.ExecuteNonQuery();

					tmpSQL = @"
-- " + this.ToString() + @" (login last log in date update)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER_INFO SET
						LAST_LOG_IN_IP = '" + Context.Request.UserHostAddress + @"'
						, LAST_LOG_IN_DTM = GETDATE()
					WHERE SEQ = '" + SEQ + "'";

					command.Parameters.Clear();
					command.CommandText = tmpSQL;
					command.ExecuteNonQuery();

					ret = true;
				} else {
					tmpSQL = @"
-- " + this.ToString() + @" (get User Check)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						COUNT(SEQ)
					FROM T_MBER
					WHERE SEQ = SEQ
					AND USER_ID = '" + ID + "'";

					command.Parameters.Clear();
					command.CommandText = tmpSQL;

					DbDataReader readerId = command.ExecuteReader();

					int cnt = 0;

					if ( readerId.Read() ) {
						cnt = int.Parse(readerId[0].ToString());
					}
					readerId.Close();

					if ( cnt == 0 ) {
						tmpSQL = @"
-- " + this.ToString() + @" (login log)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

						INSERT INTO T_LOG_IN_LOGX
						(
							SEQ
							, USER_ID
							, LOG_IN_DTM
							, LOG_IN_RSN
						)
						VALUES
						(
							(SELECT ISNULL(MAX(SEQ) + 1,1) FROM T_LOG_IN_LOGX)
							, '" + ID + @"'
							, GETDATE()
							, '1'
						)";

						command.Parameters.Clear();
						command.CommandText = tmpSQL;
						command.ExecuteNonQuery();
					} else {
						tmpSQL = @"
-- " + this.ToString() + @" (login log)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

						INSERT INTO T_LOG_IN_LOGX
						(
							SEQ
							, USER_ID
							, LOG_IN_DTM
							, LOG_IN_RSN
						)
						VALUES
						(
							(SELECT ISNULL(MAX(SEQ) + 1,1) FROM T_LOG_IN_LOGX)
							, '" + ID + @"'
							, GETDATE()
							, '2'
						)";

						command.Parameters.Clear();
						command.CommandText = tmpSQL;
						command.ExecuteNonQuery();
					}

					ret = false;
				}

				Trans.Commit();
			} catch ( DbException ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
			} finally {
				cnn.Close();
			}

			return ret;
		}

		/*********************************************************************************************************************/
		/* passwordChange
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception passwordChange(string USER_ID, string CurrentPSWD, string NewPSWD) {
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + this.ToString() + @" (passwordChange)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER SET
						PSWD = '" + SYS.GetMD5Hash(NewPSWD) + @"'
						, TMPR_PSWD_YN = 'N'
					WHERE USER_ID = '" + USER_ID + @"'
					AND PSWD = '" + SYS.GetMD5Hash(CurrentPSWD) + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();

				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw ex;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* passwordChange 2
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception passwordChange2(string USER_ID, string NewPSWD) {
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + this.ToString() + @" (passwordChange2)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER SET
						PSWD = '" + SYS.GetMD5Hash(NewPSWD) + @"'
						, TMPR_PSWD_YN = 'N'
					WHERE USER_ID = '" + USER_ID + @"'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();

				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw ex;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* find id
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Boolean findid(string NICK_NM) {
			Boolean ret = false;
			string tmpSQL = null, msg = null;
			string USER_ID = null;
			string SCRT_EMAIL = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (findid)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						A.SEQ
						, A.USER_ID
						, A.USER_NO
						, A.NICK_NM
						, A.USE_AUTH
						, A.REG_DTM
						, A.REG_IP
						, B.SCRT_EMAIL
						, B.BRDD
						, B.SEX
						, B.EMAIL_RECV_YN
						, B.REPR_IMGE_PATH
						, B.REPR_IMGE_NM
						, B.LAST_LOG_IN_IP
						, B.LAST_LOG_IN_DTM
					FROM T_MBER A
					, T_MBER_INFO B
					WHERE A.SEQ = B.MBER_SEQ
					AND A.NICK_NM = '" + NICK_NM + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				DbDataReader reader = command.ExecuteReader();

				if ( !reader.HasRows )
					ret = false;

				if ( reader.Read() ) {
					USER_ID = reader["USER_ID"].ToString().Trim();
					SCRT_EMAIL = reader["SCRT_EMAIL"].ToString().Trim();

					ret = true;
				}
				reader.Close();

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				string _TO = SCRT_EMAIL;
				string titl = "The id that you using in TwelveSky2";
				string subject = @"
					Dear, <span>" + NICK_NM + @"</span><br>	You have requested a User ID.<br>Here is your User ID.<br>
					User ID. : <span><a href='mailto:'>" + USER_ID + @"</a></span><br>
					If you need more information or can't login, please send us email to <a href='mailto:kjgames15@gmail.com'>kjgames15@gmail.com</a>
					- KJ Games support team";

				// 메일 보내기.
				SYS.mailTo(titl, subject, _TO);
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


				Trans.Commit();

				ret = true;
			} catch ( DbException ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
			} finally {
				cnn.Close();
			}

			return ret;
		}

		/*********************************************************************************************************************/
		/* find password
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Boolean findpassword(string USER_ID) {
			Boolean ret = false;
			string tmpSQL = null, msg = null;
			string TMP_PSWD = null, NICK_NM = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (findpassword)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						A.SEQ
						, A.USER_ID
						, A.USER_NO
						, A.NICK_NM
						, A.USE_AUTH
						, A.REG_DTM
						, A.REG_IP
						, B.SCRT_EMAIL
						, B.BRDD
						, B.SEX
						, B.EMAIL_RECV_YN
						, B.REPR_IMGE_PATH
						, B.REPR_IMGE_NM
						, B.LAST_LOG_IN_IP
						, B.LAST_LOG_IN_DTM
					FROM T_MBER A
					, T_MBER_INFO B
					WHERE A.SEQ = B.MBER_SEQ
					AND A.USER_ID = '" + USER_ID + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				DbDataReader reader = command.ExecuteReader();

				if ( !reader.HasRows )
					ret = false;

				if ( reader.Read() ) {
					NICK_NM = reader["NICK_NM"].ToString().Trim();
					TMP_PSWD = SYS.CreateTempPassword();

					ret = true;
				}

				reader.Close();


				tmpSQL = @"
-- " + this.ToString() + @" (tmppassword)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER SET
						PSWD = '" + SYS.GetMD5Hash(TMP_PSWD) + @"'
						, TMPR_PSWD_YN = 'Y'
					WHERE USER_ID = '" + USER_ID + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();

				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				string _TO = USER_ID;
				string titl = "A temporary password that you use in TwelveSky2";
				string subject = @"
					Dear, <span>" + NICK_NM + @"</span><br>	You have requested a password.<br>Here is your User password.<br>
					Password : <span> " + TMP_PSWD + @"</span><br>
					If you need more information or can't login, please send us email to <a href='mailto:kjgames15@gmail.com'>kjgames15@gmail.com</a>
					- KJ Games support team";

				// 메일 보내기.
				SYS.mailTo(titl, subject, _TO);
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

				Trans.Commit();

				ret = true;
			} catch ( DbException ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
			} finally {
				cnn.Close();
			}

			return ret;
		}

		/*********************************************************************************************************************/
		/* Member Withdrawal
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public Exception memberWithdrawal(string USER_ID, string PSWD) {
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;


			try {
				tmpSQL = @"
-- " + this.ToString() + @" (memberWithdrawal)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					UPDATE T_MBER SET
						USE_AUTH = '9'
					WHERE USER_ID = '" + USER_ID + @"'
					AND PSWD = '" + SYS.GetMD5Hash(PSWD) + "'";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;
				command.ExecuteNonQuery();

				Trans.Commit();

				return null;
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw ex;
			} finally {
				cnn.Close();
			}
		}

		/*********************************************************************************************************************/
		/* user count
		/*********************************************************************************************************************/
		[WebMethod(EnableSession = true)]
		public DataTable getUserCount(string STRT_DT, string END_DT, string NAT_CD) {
			DataTable result = new DataTable("DataTable");
			string tmpSQL = null, msg = null;

			DbConnection cnn = connect.CreateConnection(ConfigurationManager.AppSettings["WWW_DATA"]);
			DbCommand command = cnn.CreateCommand();
			DbDataAdapter adapter = connect.Factory(ConfigurationManager.AppSettings["WWW_DATA"]).CreateDataAdapter();
			DbTransaction Trans = cnn.BeginTransaction();
			command.Transaction = Trans;

			try {
				tmpSQL = @"
-- " + this.ToString() + @" (getList)--
-- ■ 호출위치     : " + Context.Request.UserHostAddress + @" --
-- ■ API          : " + Context.Request.Path + @" --

					SELECT
						DT
						, (SELECT COUNT(SEQ)
							FROM T_MBER
							WHERE USE_AUTH = '1' AND USER_NO LIKE '" + NAT_CD + @"%'
							AND CONVERT(VARCHAR(10), REG_DTM, 120) = A.DT) as CNT1
						, (SELECT COUNT(SEQ)
							FROM T_MBER
							WHERE USE_AUTH = '2' AND USER_NO LIKE '" + NAT_CD + @"%'
							AND CONVERT(VARCHAR(10), REG_DTM, 120) = A.DT) as CNT2
					FROM
					(
						SELECT
						CONVERT(VARCHAR(10), REG_DTM, 120) as DT
						FROM T_MBER
						WHERE USE_AUTH IN ('1', '2') AND USER_NO LIKE '" + NAT_CD + @"%'
						AND CONVERT(VARCHAR(10), REG_DTM, 120) between '" + STRT_DT + @"' AND '" + END_DT + @"'
						GROUP BY CONVERT(VARCHAR(10), REG_DTM, 120)
					) A
					ORDER BY DT DESC";

				command.Parameters.Clear();
				command.CommandText = tmpSQL;

				adapter.SelectCommand = command;
				adapter.Fill(result);

				Trans.Commit();
			} catch ( Exception ex ) {
				Trans.Rollback();
				msg = @"
■ query           :
" + tmpSQL + @"
■ parameter       :
" + msg + @"
■ error Message   :
" + ex.Message;
				SYS.Save_Log(msg);
				throw SYS.Log(Context, ex);
			} finally {
				cnn.Close();
			}

			return result;
		}
	}
}
