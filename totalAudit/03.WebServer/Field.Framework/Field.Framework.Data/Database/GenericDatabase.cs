/*********************************************************************************
 * Class	: GenericDatabase
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System.Data.Common;

namespace Field.Framework.Data {
	public class GenericDatabase : Database {
		public GenericDatabase(string connectionString, DbProviderFactory dbProviderFactory)
			: base(connectionString, dbProviderFactory) {
		}
	}
}
