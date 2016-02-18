/*********************************************************************************
 * Class    : DatabaseFactory
 * History
 *
 * Ver  Date        Author          Description
 * ---  ----------  --------------  ----------------------------------------------
 * 1.0  2013-03-04  Hoon-Sik,Jin    1.Create
 ********************************************************************************/

namespace Field.Framework.Data {
	public static class DatabaseFactory {
		public static Database CreateDatabase() {
			DatabaseProviderFactory factory = new DatabaseProviderFactory();
			return factory.CreateDefault();
		}

		public static Database CreateDatabase(string name) {
			DatabaseProviderFactory factory = new DatabaseProviderFactory();
			return factory.Create(name);
		}
	}
}
