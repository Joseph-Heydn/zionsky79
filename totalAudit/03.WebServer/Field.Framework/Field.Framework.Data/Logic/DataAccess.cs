/*********************************************************************************
 * Class	: BusinessLogic
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.Data;
using System.Data.Common;

namespace Field.Framework.Data.Logic {
	public abstract class DataAccess : IDisposable, IDataAccessTransaction {
		#region Member field
		private Database database;
		private DbTransaction transaction;
		private bool livedTransaction;
		#endregion


		#region Property
		/// <summary>
		/// true = 트랜잭션이 살아있는 상태. / false=트랜잭션이 시작되지 않았거나, rollbak/commit된 상태.
		/// </summary>
		public bool LivedTransaction {
			get { return livedTransaction; }
		}

		/// <summary>
		/// 트랜잭션 객체.
		/// BeginTran이 호출되면 생성된다.
		/// </summary>
		public DbTransaction Transaction {
			get { return transaction; }
		}

		protected Database Database {
			get { return database; }
		}
		#endregion


		protected DataAccess(string connectionStringName) {
			database = DatabaseFactory.CreateDatabase(connectionStringName);
		}


		#region IDataAccessTransaction member
		public void BeginTran() {
			transaction = database.BeginTran();
			livedTransaction = true;
			OnBeginTran();
		}

		public void BeginTran(IsolationLevel isolationLevel) {
			transaction = database.BeginTran(isolationLevel);
			livedTransaction = true;
			OnBeginTran();
		}

		public void CommitTran() {
			database.CommitTran(transaction);
			livedTransaction = false;
			EndTransaction();
			OnCommitTran();
		}

		public void RollbackTran() {
			database.RollbakTran(transaction);
			livedTransaction = false;
			EndTransaction();
			OnRollbackTran();
		}
		#endregion


		protected void OnBeginTran() {
		}

		protected void OnCommitTran() {
		}

		protected void OnRollbackTran() {
		}

		private void EndTransaction() {
			if ( transaction == null ) return;

			transaction.Dispose();
			transaction = null;
		}


		#region IDisposable member
		public virtual void Dispose() {
			Dispose(true);
		}
		#endregion


		protected virtual void Dispose(bool disposing) {
			if ( database != null ) {
				database.Dispose();
				database = null;
			}

			EndTransaction();
		}
	}
}
