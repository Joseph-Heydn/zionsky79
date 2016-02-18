/*********************************************************************************
 * Class	: DatabaseProviderFactory
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;
using System.Configuration;
using System.Collections.Specialized;
using System.Data.Common;

namespace Field.Framework.Data {
	public class DatabaseProviderFactory {
		private const string DEFAULT_CONNECTION_STRING_KEYNAME = "DefaultConnectionString";
		private readonly ConnectionStringSettingsCollection connectionStrings;
		private readonly NameValueCollection appSettings;

		public DatabaseProviderFactory() {
			connectionStrings = ConfigurationManager.ConnectionStrings;
			appSettings = ConfigurationManager.AppSettings;
		}

		public Database Create(string name) {
			if ( string.IsNullOrEmpty(name) )
				throw new ArgumentException(Resource.ExceptionNullOrEmptyString, "name");

			ConnectionStringSettings connStrSettings = connectionStrings[name];
			if ( connStrSettings == null )
				throw new DatabaseException("'{0}' connection string not found. check Web.Config(or App.config)", name);

			DbProviderFactory factory = DbProviderFactories.GetFactory(connStrSettings.ProviderName);
			return new GenericDatabase(connStrSettings.ConnectionString, factory);
		}

		public Database CreateDefault() {
			string defaultName = appSettings[DEFAULT_CONNECTION_STRING_KEYNAME];
			if ( string.IsNullOrEmpty(defaultName) )
				throw new DatabaseException("<AppSettings> Section : default connection string not found. check Web.Config(or App.config)");
			return Create(defaultName);
		}
	}
}
