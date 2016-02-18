namespace Field.Framework.Data.Logic {
	interface IDataAccessTransaction {
		void BeginTran();
		void CommitTran();
		void RollbackTran();
		bool LivedTransaction { get; }
		System.Data.Common.DbTransaction Transaction { get; }
	}
}
