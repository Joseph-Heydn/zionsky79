/*********************************************************************************
 * Class	: Database
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Globalization;


namespace Field.Framework.Data {
	public abstract class Database : IDisposable {
		#region Memeber field
		private DbConnection gConnection;
		private readonly string gConnectionString;
		private DbProviderFactory gProviderFactory;
		#endregion


		#region Construnctor
		protected Database(string pConnectionString, DbProviderFactory pProviderFactory) {
			if ( string.IsNullOrEmpty(pConnectionString) )
				throw new ArgumentException(Resource.ExceptionNullOrEmptyString, "pConnectionString");
			if ( pProviderFactory == null )
				throw new ArgumentNullException(Resource.ExceptionNullOrEmptyString, "pProviderFactory");


			gConnectionString = pConnectionString;
			gProviderFactory = pProviderFactory;
		}
		#endregion


		#region Property
		public string ConnectionString {
			get { return gConnectionString; }
		}

		public DbProviderFactory DbProviderFactory {
			get { return gProviderFactory; }
		}
		#endregion


		#region Connection
		private DbConnection CreateConnection() {
			if ( gConnection == null ) {
				gConnection = gProviderFactory.CreateConnection();
			}

			//연결문자열이 리셋되는 경우 재설정 한다.
			if ( gConnection != null && string.IsNullOrEmpty(gConnection.ConnectionString) ) {
				gConnection.ConnectionString = gConnectionString;
			}

			return gConnection;
		}

		public DbConnection GetOpenedConnection() {
			DbConnection oNewConn = null;
			try {
				oNewConn = CreateConnection();
				if ( oNewConn.State == ConnectionState.Closed )
					oNewConn.Open();
			} catch ( Exception ) {
				if ( oNewConn == null )
					throw;

				if ( oNewConn.State != ConnectionState.Closed )
					oNewConn.Close();

				throw;
			}
			return oNewConn;
		}
		#endregion


		#region Command
		public DbCommand GetSProcCommand(string pProcedure) {
			if ( string.IsNullOrEmpty(pProcedure) )
				throw new ArgumentException(Resource.ExceptionNullOrEmptyString, "pProcedure");

			return CreateCommandByCommandType(CommandType.StoredProcedure, pProcedure);
		}

		public DbCommand GetSqlTextCommand(string pQuery) {
			if ( string.IsNullOrEmpty(pQuery) )
				throw new ArgumentException(Resource.ExceptionNullOrEmptyString, "pQuery");

			return CreateCommandByCommandType(CommandType.Text, pQuery);
		}

		private DbCommand CreateCommandByCommandType(CommandType pCommandType, string pCommandText) {
			DbCommand command = gProviderFactory.CreateCommand();

			if ( command == null )
				return null;


			command.CommandType = pCommandType;
			command.CommandText = pCommandText;

			return command;
		}

		protected static void PrepareCommand(DbCommand pCommand, DbConnection pConnection) {
			if ( pCommand == null )
				throw new ArgumentNullException("pCommand");
			if ( pConnection == null )
				throw new ArgumentNullException("pConnection");

			pCommand.Connection = pConnection;
		}

		protected static void PrepareCommand(DbCommand pCommand, DbTransaction pTransaction) {
			if ( pCommand == null )
				throw new ArgumentNullException("pCommand");
			if ( pTransaction == null )
				throw new ArgumentNullException("pTransaction");

			PrepareCommand(pCommand, pTransaction.Connection);
			pCommand.Transaction = pTransaction;
		}
		#endregion


		#region Parameter
		public void AddParameter(DbCommand pCommand, string pName, DbType pDbType, int pSize, ParameterDirection pDirection, bool pNullable, byte pPrecision, byte pScale, string pSourceColumn, DataRowVersion pSourceVersion, object pValue) {
			DbParameter parameter = CreateParameter(pName, pDbType, pSize, pDirection, pNullable, pPrecision, pScale, pSourceColumn, pSourceVersion, pValue);
			pCommand.Parameters.Add(parameter);
		}

		public void AddParameter(DbCommand pCommand, string pName, DbType pDbType, int pSize, ParameterDirection direction, object pValue) {
			AddParameter(pCommand, pName, pDbType, pSize, direction, true, 0, 0, String.Empty, DataRowVersion.Default, pValue);
		}

		public void AddInParameter(DbCommand pCommand, string pName, DbType pDbType, object pValue) {
			AddParameter(pCommand, pName, pDbType, 0, ParameterDirection.Input, pValue);
		}

		public void AddInParameter(DbCommand pCommand, string pName, DbType pDbType, int size, object pValue) {
			AddParameter(pCommand, pName, pDbType, size, ParameterDirection.Input, pValue);
		}

		public void AddOutParameter(DbCommand pCommand, string pName, DbType pDbType) {
			AddParameter(pCommand, pName, pDbType, 0, ParameterDirection.Output, DBNull.Value);
		}

		public void AddOutParameter(DbCommand pCommand, string pName, DbType pDbType, int pSize) {
			AddParameter(pCommand, pName, pDbType, pSize, ParameterDirection.Output, DBNull.Value);
		}

		protected DbParameter CreateParameter(string pName) {
			DbParameter param = gProviderFactory.CreateParameter();

			if ( param == null )
				return null;


			param.ParameterName = pName;

			return param;
		}

		protected DbParameter CreateParameter(string pName, DbType pDbType, int pSize, ParameterDirection pDirection, bool pNullable, byte pPrecision, byte pScale, string pSourceColumn, DataRowVersion pSourceVersion, object pValue) {
			DbParameter param = CreateParameter(pName);
			ConfigureParameter(param, pName, pDbType, pSize, pDirection, pNullable, pPrecision, pScale, pSourceColumn, pSourceVersion, pValue);
			return param;
		}

		protected void ConfigureParameter(DbParameter pParam, string pName, DbType dbType, int pSize, ParameterDirection pDirection, bool pNullable, byte pPrecision, byte pScale, string pSourceColumn, DataRowVersion pSourceVersion, object pValue) {
			pParam.DbType = dbType;
			pParam.Size = pSize;
			pParam.Value = pValue ?? DBNull.Value;
			pParam.Direction = pDirection;
			pParam.IsNullable = pNullable;
			pParam.SourceColumn = pSourceColumn;
			pParam.SourceVersion = pSourceVersion;
		}

		protected int UserParametersStartIndex() {
			return 0;
		}
		#endregion


		#region ExecuteDataSet
		public DataSet ExecuteDataSet(DbCommand pCommand) {
			DataSet oDataSet = new DataSet {
				Locale = CultureInfo.InvariantCulture
			};
			FillDataSet(pCommand, oDataSet, "Table");
			return oDataSet;
		}

		public DataSet ExecuteDataSet(DbCommand pCommand, DbTransaction pTransaction) {
			DataSet oDataSet = new DataSet {
				Locale = CultureInfo.InvariantCulture
			};
			FillDataSet(pCommand, oDataSet, "Table", pTransaction);
			return oDataSet;
		}
		#endregion


		#region ExecuteNonQuery
		public int ExecuteNonQuery(DbCommand pCommand) {
			using ( DbConnection dbConn = GetOpenedConnection() ) {
				PrepareCommand(pCommand, dbConn);
				return WrappingExecuteNonQuery(pCommand);
			}
		}

		public int ExecuteNonQuery(DbCommand pCommand, DbTransaction pTransaction) {
			PrepareCommand(pCommand, pTransaction);
			return WrappingExecuteNonQuery(pCommand);
		}

		private int WrappingExecuteNonQuery(DbCommand pCommand) {
			try {
				int rowsAffected = pCommand.ExecuteNonQuery();
				return rowsAffected;
			} catch ( Exception e ) {
				throw e;
			}
		}
		#endregion


		#region ExecuteReader
		public IDataReader ExecuteReader(DbCommand pCommand) {
			using ( DbConnection dbConn = GetOpenedConnection() ) {
				PrepareCommand(pCommand, dbConn);
				return WrappingExecuteReader(pCommand, CommandBehavior.Default);
			}
		}

		public IDataReader ExecuteReader(DbCommand pCommand, DbTransaction pTransaction) {
			PrepareCommand(pCommand, pTransaction);
			return WrappingExecuteReader(pCommand, CommandBehavior.Default);
		}

		private IDataReader WrappingExecuteReader(DbCommand pCommand, CommandBehavior pCmdBehavior) {
			try {
				IDataReader reader = pCommand.ExecuteReader(pCmdBehavior);
				return reader;
			} catch ( Exception e ) {
				throw e;
			}
		}
		#endregion


		#region ExecuteScalar
		public virtual object ExecuteScalar(DbCommand pCommand) {
			using ( DbConnection dbConn = GetOpenedConnection() ) {
				PrepareCommand(pCommand, dbConn);
				return WrappingExecuteScalar(pCommand);
			}
		}

		public virtual object ExecuteScalar(DbCommand pCommand, DbTransaction pTransaction) {
			PrepareCommand(pCommand, pTransaction);
			return WrappingExecuteScalar(pCommand);
		}

		private object WrappingExecuteScalar(DbCommand pCommand) {
			try {
				object scalarValue = pCommand.ExecuteScalar();
				return scalarValue;
			} catch ( Exception e ) {
				throw e;
			}
		}
		#endregion


		#region FillDataSet
		public void FillDataSet(DbCommand pCommand, DataSet pDataSet, string pTableName) {
			FillDataSet(pCommand, pDataSet, new[] {pTableName});
		}

		public void FillDataSet(DbCommand pCommand, DataSet pDataSet, string pTableName, DbTransaction pTransaction) {
			FillDataSet(pCommand, pDataSet, new[] {pTableName}, pTransaction);
		}

		public void FillDataSet(DbCommand pCommand, DataSet pDataSet, string[] pTableName) {
			using ( DbConnection dbConn = GetOpenedConnection() ) {
				PrepareCommand(pCommand, dbConn);
				WrappingFillDataSet(pCommand, pDataSet, pTableName);
			}
		}

		public void FillDataSet(DbCommand pCommand, DataSet pDataSet, string[] pTableName, DbTransaction pTransaction) {
			PrepareCommand(pCommand, pTransaction);
			WrappingFillDataSet(pCommand, pDataSet, pTableName);
		}

		private void WrappingFillDataSet(DbCommand pCommand, DataSet pDataSet, IList<string> pTableName) {
			if ( pTableName == null ) {
				throw new ArgumentNullException("pTableName");
			}
			if ( pTableName.Count == 0 ) {
				throw new ArgumentException(Resource.ExceptionNullOrEmptyString, "pTableName");
			}


			for ( int i = 0; i < pTableName.Count; ++i ) {
				if ( string.IsNullOrEmpty(pTableName[i]) )
					throw new ArgumentException(Resource.ExceptionNullOrEmptyString, string.Concat("pTableName[", i, "]"));
			}

			using ( DbDataAdapter adapter = GetDataAdapter() ) {
				((IDbDataAdapter) adapter).SelectCommand = pCommand;

				try {
					const string systemCreatedTableNameRoot = "Table";
					for ( int i = 0; i < pTableName.Count; ++i ) {
						string systemCreatedTableName = (i == 0) ? systemCreatedTableNameRoot : systemCreatedTableNameRoot + i;

						adapter.TableMappings.Add(systemCreatedTableName, pTableName[i]);
					}

					adapter.Fill(pDataSet);
				} catch ( Exception e ) {
					throw e;
				}
			}
		}

		protected DbDataAdapter GetDataAdapter() {
			DbDataAdapter adapter = gProviderFactory.CreateDataAdapter();
			return adapter;
		}
		#endregion


		#region Transaction
		/// <summary>
		/// 데이터베이스의 트랜잭션을 시작한다.
		/// </summary>
		/// <returns>시작되어진 트랜잭션 객체</returns>
		public DbTransaction BeginTran() {
			DbConnection dbConn = GetOpenedConnection();
			//SqlClient default : IsolationLevel.Unspecified
			//                  : 프로필러로 확인한 결과 Read Committed가 기본값.
			return dbConn.BeginTransaction();
		}

		/// <summary>
		/// 데이터베이스의 트랜잭션을 시작한다.
		/// </summary>
		/// <param name="pIsolationLevel">트랜잭션의 격리수준</param>
		/// <returns>시작되어진 트랜잭션 객체</returns>
		public DbTransaction BeginTran(IsolationLevel pIsolationLevel) {
			DbConnection dbConn = GetOpenedConnection();
			return dbConn.BeginTransaction(pIsolationLevel);
		}

		/// <summary>
		/// 보류중인 상태에서 트랜잭션을 커밋한다.
		/// </summary>
		/// <param name="pTransaction">보류중인 트랜잭션</param>
		public void CommitTran(DbTransaction pTransaction) {
			pTransaction.Commit();
			EndTransaction(true);
		}

		/// <summary>
		/// 보류중인 상태에서 트랜잭션을 롤백한다.
		/// </summary>
		/// <param name="pTransaction">보류중인 트랜잭션</param>
		public void RollbakTran(DbTransaction pTransaction) {
			pTransaction.Rollback();
			EndTransaction(true);
		}

		private void EndTransaction(bool pClosedConnection) {
			try {
				if ( gConnection == null || !pClosedConnection )
					return;


				if ( gConnection.State != ConnectionState.Closed )
					gConnection.Close();
			} catch ( Exception ) {
				throw;
			} finally {
				gConnection = null;
			}
		}
		#endregion Transcation.


		#region Pool
		public void ClearConnectionPool() {
			if ( gConnection != null )
				ConnectionPoolClearHelper.ClearPool(gConnection);
		}

		/// <summary>
		/// Empties the connection pool associated with the specified connection.(OracleClient, SqlClient)
		/// </summary>
		/// <param name="dbConnection">The DbConnection to be clered from the pool</param>
		public static void ClearConnectionPool(DbConnection dbConnection) {
			ConnectionPoolClearHelper.ClearPool(dbConnection);
		}

		/// <summary>
		/// Empties the connection pool
		/// </summary>
		/// <param name="dbConnection"></param>
		public static void ClearAllConnectionPools(DbConnection dbConnection) {
			ConnectionPoolClearHelper.ClearAllPools(dbConnection);
		}
		#endregion


		#region IDisposable implementation.
		public void Dispose() {
			Dispose(true);
			GC.SuppressFinalize(this);
		}

		protected void Dispose(bool pDisposing) {
			if ( gConnection != null ) {
				if ( gConnection.State != ConnectionState.Closed )
					gConnection.Close();
				gConnection = null;
			}
			gProviderFactory = null;
		}
		#endregion


		public static DbCommand SetSProcCommand(string pProcedure) {
			throw new Exception("The method or operation is not implemented.");
		}
	}


	#region ConnectionPoolClearHelper Class
	internal class ConnectionPoolClearHelper {
		public static void ClearAllPools(DbConnection dbConnection) {
			if ( IsSqlConnection(dbConnection) ) {
				System.Data.SqlClient.SqlConnection.ClearAllPools();
			} else if ( IsOracleConnection(dbConnection) ) {
				System.Data.OracleClient.OracleConnection.ClearAllPools();
			}
		}

		public static void ClearPool(DbConnection dbConnection) {
			if ( IsSqlConnection(dbConnection) ) {
				System.Data.SqlClient.SqlConnection.ClearPool((System.Data.SqlClient.SqlConnection) dbConnection);
			} else if ( IsOracleConnection(dbConnection) ) {
				System.Data.OracleClient.OracleConnection.ClearPool((System.Data.OracleClient.OracleConnection) dbConnection);
			}
		}

		private static bool IsSqlConnection(DbConnection dbConnection) {
			const string SQL_TYPE_NAME = "System.Data.SqlClient.SqlConnection";
			return SQL_TYPE_NAME.Equals(GetTypeFullName(dbConnection));
		}

		private static bool IsOracleConnection(DbConnection dbConnection) {
			const string ORACLE_TYPE_NAME = "System.Data.OracleClient.OracleConnection";
			return ORACLE_TYPE_NAME.Equals(GetTypeFullName(dbConnection));
		}

		private static string GetTypeFullName(DbConnection dbConnection) {
			return dbConnection.GetType().FullName;
		}
	}
	#endregion
}


/*Connection String Attributes - pooling
 이름
 기본값
 설명

Connection Lifetime
 0
 연결이 풀로 반환되면 만든 시간을 현재 시간과 비교하여 그 간격(초)이 Connection Lifetime에서 지정한 값을 초과하면 연결이 소멸됩니다.
 실행되고 있는 서버나 온라인 상태가 된 서버 사이에서 강제로 로드 균형을 조정하는 클러스터링된 구성에 유용합니다.
 값 0은 풀링된 연결에 최대 연결 시간 제한을 갖도록 합니다.

Connection Reset
 'true'
 풀에서 제거될 때 데이터베이스 연결이 다시 설정되는지 여부를 결정합니다.
 SQL Server 버전 7.0의 경우, false로 설정하면 연결을 가져올 때 추가 서버 라운드트립이 발생하지 않지만
 데이터베이스 컨텍스트와 같은 연결 상태는 다시 설정되지 않습니다.
 Connection Reset을 false로 설정하지 않는 한 연결 풀은 ChangeDatabase 메서드의 영향을 받지 않습니다.
 풀과의 연결이 끊어지면 연결은 로그인 시간 데이터베이스로 돌아가는 서버로 다시 설정됩니다.
 새 연결이 만들어지지 않으며 재인증이 이루어지지도 않습니다. Connection Reset을 false로 설정하면 풀에서 다른 데이터베이스와 연결될 수 있습니다.

Enlist
 'true'
 true이면 풀러는 만들기 스레드의 현재 트랜잭션 컨텍스트에 연결을 자동으로 참여시킵니다.
 인식되는 값은 true, false, yes 및 no입니다.

Load Balance Timeout
 0
 연결 풀에서 연결이 소멸되기 전까지 유지되는 최소 시간(초)입니다.

Max Pool Size
 100
 풀에서 허용되는 연결의 최대 개수입니다.

Min Pool Size
 0
 풀에서 허용되는 연결의 최소 개수입니다.

Pooling
 'true'
 true이면 SQLConnection 개체가 해당 풀에서 제거되거나 필요한 경우 만들어진 다음 적합한 풀에 추가됩니다.
 인식되는 값은 true, false, yes 및 no입니다.
*/
