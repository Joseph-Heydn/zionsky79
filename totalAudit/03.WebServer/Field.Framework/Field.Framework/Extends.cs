using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Newtonsoft.Json.Linq;
using System.Web.Script.Serialization;

namespace Field.Framework {
	/// <summary>
	/// 확장 메서드 모음
	/// </summary>
	public static class Extends {
		#region System.Collections.Generic.Dictionary<string, object>
		public static DataSet ToDataSet(this Dictionary<string, object> pDic) {
			DataSet oDataSet = new DataSet();

			// 테이블 루프
			foreach ( KeyValuePair<string, object> vTables in pDic ) {
				DataTable vTable = oDataSet.Tables.Add(vTables.Key);

				// Row 루프
				foreach ( object vRow in (object[]) vTables.Value ) {
					DataRow vNewRow = vTable.NewRow();

					foreach ( KeyValuePair<string, object> vCols in (Dictionary<string, object>) vRow ) {
						// 컬럼 추가
						if ( vTable.Columns[vCols.Key] == null ) {
							vTable.Columns.Add(vCols.Key, typeof(string));
						}

						vNewRow[vCols.Key] = vCols.Value ?? DBNull.Value;
					}

					vTable.Rows.Add(vNewRow);
				}
			}

			return oDataSet;
		}
		#endregion


		#region object[]
		public static DataTable ToDataTable(this object[] pObj) {
			// 테이블 루프
			DataTable oTable = new DataTable();

			// Row 루프
			foreach ( object vRow in pObj ) {
				DataRow vNewRow = oTable.NewRow();

				foreach ( KeyValuePair<string, object> vCols in (Dictionary<string, object>) vRow ) {
					// 컬럼 추가
					if ( oTable.Columns[vCols.Key] == null ) {
						oTable.Columns.Add(vCols.Key, typeof(string));
					}

					vNewRow[vCols.Key] = vCols.Value ?? DBNull.Value;
				}

				oTable.Rows.Add(vNewRow);
			}

			return oTable;
		}
		#endregion


		#region System.Data.DataSet
		/// <summary>
		/// 데이터 셋을 IDictionary&lt;string, object&gt; 객체로 변환
		/// </summary>
		/// <param name="pDataSet">데이터 셋</param>
		/// <returns></returns>
		public static Dictionary<string, object> ToJsonObject(this DataSet pDataSet) {
			Dictionary<string, object> oTableDic = new Dictionary<string, object>();

			foreach ( DataTable vTable in pDataSet.Tables ) {
				List<object> vRowDic = (
					from DataRow vRow in vTable.Rows
					select vRow.Table.Columns.Cast<DataColumn>().ToDictionary(col => col.ColumnName, col => vRow[col])
				).Cast<object>().ToList();

				oTableDic.Add(vTable.TableName, vRowDic);
			}

			return oTableDic;
		}

		/// <summary>
		/// 데이터 셋을 Dictionary로 변경한다. (=ToJSONObject)
		/// </summary>
		/// <param name="pDataSet"></param>
		/// <returns></returns>
		public static Dictionary<string, object> ToDictionary(this DataSet pDataSet) {
			return pDataSet.Tables.Cast<DataTable>().ToDictionary(t => t.TableName, t => t.RowsToDictionary());
		}

		/// <summary>
		/// 데이터 셋을 JSON 스트링으로 변환한다.
		/// </summary>
		/// <param name="pDataSet"></param>
		/// <returns></returns>
		public static string GetJsonString(DataSet pDataSet) {
			JavaScriptSerializer oSerializer = new JavaScriptSerializer();
			return oSerializer.Serialize(pDataSet.ToDictionary());
		}

		/// <summary>
		/// 데이터 테이블을 합친다.
		/// </summary>
		/// <param name="oDataSet">소스 데이터셋</param>
		/// <param name="pTableName">테이블명</param>
		/// <param name="pTable">데이터 테이블</param>
		/// <returns>데이터셋</returns>
		public static DataSet MergeTable(this DataSet oDataSet, string pTableName, DataTable pTable) {
			pTable.TableName = pTableName;
			oDataSet.Tables.Add(pTable.Copy());
			//pTable.Dispose();

			return oDataSet;
		}

		/// <summary>
		/// 데이터 테이블을 합친다.
		/// </summary>
		/// <param name="oDataSet">소스 데이터셋</param>
		/// <param name="pTableName">테이블명</param>
		/// <param name="pDataSet">합칠 데이터셋</param>
		/// <returns>데이터셋</returns>
		public static DataSet MergeTable(this DataSet oDataSet, string pTableName, DataSet pDataSet) {
			for ( int i = 0; i < pDataSet.Tables.Count; ++i ) {
				pDataSet.Tables[i].TableName = (i > 0) ? pTableName + (i + 1) : "";
				oDataSet.Tables.Add(pDataSet.Tables[i].Copy());
			}
			pDataSet.Dispose();

			return oDataSet;
		}
		#endregion


		#region System.Data.DataTable
		/// <summary>
		/// 테이블 Row를 Dictionary 객체로 변경한다.
		/// </summary>
		/// <param name="pTable"></param>
		/// <returns></returns>
		static object RowsToDictionary(this DataTable pTable) {
			var vColumns = pTable.Columns.Cast<DataColumn>().ToArray();
			return pTable.Rows.Cast<DataRow>().Select(r => vColumns.ToDictionary(c => c.ColumnName, c => r[c]));
		}

		/// <summary>
		/// 테이블을 Dictnoary로 변경한다.
		/// </summary>
		/// <param name="pTable"></param>
		/// <returns></returns>
		static Dictionary<string, object> ToDictionary(this DataTable pTable) {
			return new Dictionary<string, object> { { pTable.TableName, pTable.RowsToDictionary() } };
		}

		/// <summary>
		/// 테이블의 JSON 스트링을 얻는다.
		/// </summary>
		/// <param name="pTable"></param>
		/// <returns></returns>
		public static string GetJsonString(DataTable pTable) {
			JavaScriptSerializer oSerializer = new JavaScriptSerializer();
			return oSerializer.Serialize(pTable.ToDictionary());
		}

		/// <summary>
		/// 테이블을 List로 변경한다.
		/// </summary>
		/// <param name="pTable"></param>
		/// <returns></returns>
		public static List<Dictionary<string, object>> ToList(this DataTable pTable) {
			//return (List<Dictionary<string, object>>)table.RowsToDictionary();
			var vColumns = pTable.Columns.Cast<DataColumn>().ToArray();
			var oList = new List<Dictionary<string, object>>();

			foreach ( DataRow vRow in pTable.Rows ) {
				oList.Add(new Dictionary<string, object>());

				foreach ( var vCol in vColumns ) {
					oList[oList.Count-1][vCol.ColumnName] = vRow[vCol.ColumnName];
				}
			}

			return oList;
		}
		#endregion


		#region Newtonsoft.Json.Linq.JObject
		public static DataSet ToDataSet(this JObject pObjJson) {
			DataSet oDataSet = new DataSet();

			// 테이블 루프
			foreach ( KeyValuePair<string, JToken> vTables in pObjJson ) {
				DataTable vTable = oDataSet.Tables.Add(vTables.Key);

				// Row 루프
				foreach ( var jToken in vTables.Value ) {
					var vRow = (JObject) jToken;
					DataRow vNewRow = vTable.NewRow();

					foreach ( KeyValuePair<string, JToken> cols in vRow ) {
						// 컬럼 추가
						if ( vTable.Columns[cols.Key] == null ) {
							vTable.Columns.Add(cols.Key, typeof(string));
						}

						vNewRow[cols.Key] = ((JValue) cols.Value).Value ?? DBNull.Value;
					}

					vTable.Rows.Add(vNewRow);
				}
			}

			return oDataSet;
		}

		public static DataTable ToDataTable(this JArray pObjJson) {
			DataTable oTable = new DataTable();

			// Row 루프
			foreach ( var jToken in pObjJson ) {
				var vRow = (JObject) jToken;
				DataRow vNewRow = oTable.NewRow();

				foreach ( KeyValuePair<string, JToken> vCols in vRow ) {
					// 컬럼 추가
					if ( oTable.Columns[vCols.Key] == null ) {
						oTable.Columns.Add(vCols.Key, typeof(string));
					}

					vNewRow[vCols.Key] = ((JValue) vCols.Value).Value ?? DBNull.Value;
				}

				oTable.Rows.Add(vNewRow);
			}

			return oTable;
		}

		public static Dictionary<string, object> ToDictionary(this JObject pObjJson) {
			Dictionary<string, object> oDic = new Dictionary<string, object>();

			// 테이블 루프
			foreach ( KeyValuePair<string, JToken> vTables in pObjJson ) {
				List<object> vRowsList = new List<object>();

				// Row 루프
				foreach ( var jToken in vTables.Value ) {
					var vRow = (JObject) jToken;
					Dictionary<string, object> vColsDic = new Dictionary<string, object>();

					foreach ( KeyValuePair<string, JToken> vCols in vRow ) {
						vColsDic.Add(vCols.Key, ((JValue) vCols.Value).Value ?? DBNull.Value);
					}

					vRowsList.Add(vColsDic);
				}

				oDic.Add(vTables.Key, vRowsList);
			}

			return oDic;
		}

		public static Dictionary<string, object> ToDictionaryRow(this JObject pObjJson) {
			Dictionary<string, object> oDic = new Dictionary<string, object>();

			foreach ( KeyValuePair<string, JToken> vCols in pObjJson ) {
				oDic.Add(vCols.Key, ((JValue) vCols.Value).Value ?? DBNull.Value);
			}

			return oDic;
		}

		public static List<Dictionary<string, object>> ToList(this JArray pObjJson) {
			List<Dictionary<string, object>> oList = new List<Dictionary<string, object>>();

			// Row 루프
			foreach ( var jToken in pObjJson ) {
				var vRow = (JObject) jToken;
				Dictionary<string, object> vListRow = new Dictionary<string, object>();

				foreach ( KeyValuePair<string, JToken> vCols in vRow ) {
					vListRow[vCols.Key] = ((JValue) vCols.Value).Value ?? DBNull.Value;
				}

				oList.Add(vListRow);
			}

			return oList;
		}
		#endregion


		#region Dictionary<string, object>
		public static object Value(this Dictionary<string, object> pDic, string pKey) {
			return pDic.ContainsKey(pKey) ? pDic[pKey] : null;
		}
		#endregion
	}
}
