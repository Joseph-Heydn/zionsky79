/*********************************************************************************
 * Class	: URLHelper
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

namespace Field.Framework.Web {
	public class URLHelper {
		/// <summary>
		/// System.Web.HttpRequest로 넘어온 Key - Value 값으로 QueryString 을 생성한다.
		/// Hashtable인 exeptKeys에서 QueryString에서 제외시킬 Key값들을 정의한다.
		/// </summary>
		/// <param name="exeptKeys">예외처리할 Key Generic Collection </param>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <param name="isAppend">예외처리할 Key값들을 QueryString에서 제외시킬지 여부, true의 경우 exeptKeys에 정의된 Value로 셋팅된다</param>
		/// <returns>System.Web.HttpRequest상의 key-value로 구성된 URL QueryString</returns>
		public static string GetQueryString(Dictionary<string, string> exeptKeys, System.Web.HttpRequest objRequest, bool isAppend) {
			StringBuilder queryString = new StringBuilder();

			if ( objRequest != null ) {
				if ( exeptKeys == null ) {
					queryString.Append(GetQueryString(objRequest));
				} else {
					foreach ( string key in objRequest.QueryString ) {
						if ( key == null ) continue;

						if ( exeptKeys.ContainsKey(key) ) {
							if ( isAppend && exeptKeys[key] != "" ) {
								queryString.Append(key);
								queryString.Append("=");
								queryString.Append(exeptKeys[key]);
								queryString.Append("&");
							}
						} else {
							queryString.Append(key);
							queryString.Append("=");
							queryString.Append(objRequest.QueryString[key]);
							queryString.Append("&");
						}
					}

					foreach ( KeyValuePair<string, string> exeptKey in exeptKeys ) {
						if ( objRequest.QueryString[exeptKey.Key] != null ) continue;
						if ( !isAppend || exeptKey.Value == "" ) continue;

						queryString.Append(exeptKey.Key);
						queryString.Append("=");
						queryString.Append(exeptKey.Value);
						queryString.Append("&");
					}
				}
			}


			string rtn = queryString.ToString();
			if ( rtn.Length > 0 ) {
				rtn = rtn.Substring(0, rtn.Length - 1);
			}

			return rtn;
		}

		/// <summary>
		/// System.Web.HttpRequest로 넘어온 Key - Value 값으로 QueryString 을 생성한다.
		/// Hashtable인 exeptKeys에서 QueryString에서 제외시킬 Key값들을 정의한다.
		/// </summary>
		/// <param name="exeptKeys">예외처리할 Key Collection</param>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <param name="isAppend">예외처리할 Key값들을 QueryString에서 제외시킬지 여부, true의 경우 exeptKeys에 정의된 Value로 셋팅된다</param>
		/// <param name="rtnString">System.Web.HttpRequest상의 key-value로 구성된 URL QueryString</param>
		public static void GetQueryString(Dictionary<string, string> exeptKeys, System.Web.HttpRequest objRequest, bool isAppend, ref string rtnString) {
			StringBuilder queryString = new StringBuilder();

			if ( objRequest != null ) {
				if ( exeptKeys == null ) {
					queryString.Append(GetQueryString(objRequest));
				} else {
					foreach ( string key in objRequest.QueryString ) {
						if ( key == null ) continue;

						if ( exeptKeys.ContainsKey(key) ) {
							if ( isAppend ) {
								queryString.Append(key);
								queryString.Append("=");
								queryString.Append(exeptKeys[key]);
								queryString.Append("&");
							}
						} else {
							queryString.Append(key);
							queryString.Append("=");
							queryString.Append(objRequest.QueryString[key]);
							queryString.Append("&");
						}
					}
				}
			}
			if ( rtnString == null ) {
				throw new ArgumentNullException("rtnString");
			}

			string rtn = queryString.ToString();
			if ( rtn.Length > 0 ) {
				rtn = rtn.Substring(0, rtn.Length - 1);
			}

			rtnString = rtn;
		}

		/// <summary>
		/// System.Web.HttpRequest로 넘어온 Key - Value 값으로 QueryString 을 생성한다.
		/// </summary>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <returns>System.Web.HttpRequest상의 key-value로 구성된 URL QueryString</returns>
		public static string GetQueryString(System.Web.HttpRequest objRequest) {
			StringBuilder queryString = new StringBuilder();

			if ( objRequest != null ) {
				foreach ( string key in objRequest.QueryString ) {
					if ( key == null ) continue;

					queryString.Append(key);
					queryString.Append("=");
					queryString.Append(objRequest.QueryString[key]);
					queryString.Append("&");
				}
			}


			string rtn = queryString.ToString();
			if ( rtn.Length > 0 ) {
				rtn = rtn.Substring(0, rtn.Length - 1);
			}

			return rtn;
		}

		/// <summary>
		/// System.Web.HttpRequest로 넘어온 Key - Value 값으로 QueryString 을 생성한다.
		/// </summary>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <param name="rtnString">System.Web.HttpRequest상의 key-value로 구성된 URL QueryString</param>
		public static void GetQueryString(System.Web.HttpRequest objRequest, ref string rtnString) {
			StringBuilder queryString = new StringBuilder();

			if ( objRequest != null ) {
				foreach ( string key in objRequest.QueryString ) {
					if ( key == null ) continue;

					queryString.Append(key);
					queryString.Append("=");
					queryString.Append(objRequest.QueryString[key]);
					queryString.Append("&");
				}
			}

			if ( rtnString == null ) {
				throw new ArgumentNullException("rtnString");
			}

			string rtn = queryString.ToString();
			if ( rtn.Length > 0 ) {
				rtn = rtn.Substring(0, rtn.Length - 1);
			}

			rtnString = rtn;
		}

		/// <summary>
		/// 지정된 키값을 수정해서 QueryString을 리턴한다.
		/// </summary>
		/// <param name="exceptKey">변경할 Key</param>
		/// <param name="exceptValue">변경할 key의 Value</param>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <returns>System.Web.HttpRequest상의 key-value로 구성된 URL QueryString</returns>
		public static string GetQueryString(string exceptKey, string exceptValue, System.Web.HttpRequest objRequest) {
			StringBuilder queryString = new StringBuilder();

			exceptKey = exceptKey ?? "";
			exceptValue = exceptValue ?? "";

			if ( objRequest != null ) {
				foreach ( string key in objRequest.QueryString ) {
					if ( key == null ) continue;

					if ( key.ToLower().Trim().Equals(exceptKey.ToLower().Trim()) ) {
						queryString.Append(key);
						queryString.Append("=");
						queryString.Append(exceptValue);
						queryString.Append("&");
					} else {
						queryString.Append(key);
						queryString.Append("=");
						queryString.Append(objRequest.QueryString[key]);
						queryString.Append("&");
					}
				}
			}

			string rtn = queryString.ToString();
			if ( rtn.Length > 0 ) {
				rtn = rtn.Substring(0, rtn.Length - 1);
			}

			return rtn;
		}

		/// <summary>
		/// 지정된 키값을 수정해서 QueryString을 리턴한다.
		/// </summary>
		/// <param name="exceptKey">변경할 Key</param>
		/// <param name="exceptValue">변경할 key의 Value</param>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <param name="rtnString">System.Web.HttpRequest상의 key-value로 구성된 URL QueryString</param>
		public static void GetQueryString(string exceptKey, string exceptValue, System.Web.HttpRequest objRequest, ref string rtnString) {
			StringBuilder queryString = new StringBuilder();

			exceptKey = exceptKey != null ? exceptKey.Trim() : "";
			exceptValue = exceptValue != null ? exceptValue.Trim() : "";

			if ( objRequest != null ) {
				foreach ( string key in objRequest.QueryString ) {
					if ( key == null ) continue;

					if ( key.ToLower().Trim().Equals(exceptKey.ToLower().Trim()) ) {
						queryString.Append(key);
						queryString.Append("=");
						queryString.Append(exceptValue);
						queryString.Append("&");
					} else {
						queryString.Append(key);
						queryString.Append("=");
						queryString.Append(objRequest.QueryString[key]);
						queryString.Append("&");
					}
				}
			}

			if ( rtnString == null ) {
				throw new ArgumentNullException("rtnString");
			}

			string rtn = queryString.ToString();
			if ( rtn.Length > 0 ) {
				rtn = rtn.Substring(0, rtn.Length - 1);
			}

			rtnString = rtn;
		}

		/// <summary>
		/// 인자로 받은 key 값이 HttpRequest 객체에 있는지 검사하고 있다면 Value를 리턴한다.
		/// 실패 또는 데이터가 존재 하지 않을시 빈 스트링을 리턴.
		/// </summary>
		/// <param name="key">HttpRequest_Key</param>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <returns>HttpReqeust에서 Key에 해당하는 Value, 실패시 빈스트링</returns>
		public static string GetQueryStringValue(string key, System.Web.HttpRequest objRequest) {
			string rtn = "";

			if ( key != null ) {
				rtn = objRequest.QueryString[key] ?? "";
			}

			return rtn.Trim();
		}

		/// <summary>
		/// 인자로 받은 key 값이 HttpRequest 객체에 있는지 검사하고 있다면 Value를 리턴한다.
		/// 실패 또는 데이터가 존재 하지 않을시 빈 스트링을 리턴.
		/// </summary>
		/// <param name="key">HttpRequest_Key</param>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <param name="rtnString">HttpReqeust에서 Key에 해당하는 Value, 실패시 빈스트링</param>
		public static void GetQueryStringValue(string key, System.Web.HttpRequest objRequest, ref string rtnString) {
			string rtn = "";

			if ( key != null ) {
				rtn = objRequest.QueryString[key] ?? "";
			}
			if ( rtnString == null ) {
				throw new ArgumentNullException("rtnString");
			}

			rtnString = rtn.Trim();
		}

		/// <summary>
		/// 인자로 받은 key 값이 HttpRequest 객체에 있는지 검사하고 있다면 Value를 리턴한다.
		/// key에 해당하는 값이 존재하지 않을 경우 DefaultValue를 리턴한다.
		/// </summary>
		/// <param name="key">HttpRequest_Key</param>
		/// <param name="objRequest">System.Web.HttpRequest</param>
		/// <param name="defaultValue">Key에 해당하는 값이 존재 하지 않을 시 기본적으로 리턴할 값</param>
		public static string GetQueryStringDefaultValue(string key, System.Web.HttpRequest objRequest, string defaultValue) {
			string rtn = "";

			if ( key != null ) {
				rtn = objRequest.QueryString[key] ?? defaultValue;
			}

			return rtn;
		}
	}
}
