using System;

namespace Field.Framework.Data {
	/// <summary>
	/// Summary description for DatabaseException.
	/// </summary>
	[Serializable]
	public class DatabaseException : ApplicationException {
		public DatabaseException() { }

		public DatabaseException(string message)
			: base(message) {
		}

		public DatabaseException(string message, params object[] messageArgs)
			: base(string.Format(message, messageArgs)) {
		}

		public DatabaseException(Exception innerException, string message)
			: base(message, innerException) {
		}

		public DatabaseException(Exception innerException, string message, params object[] messageArgs)
			: base(string.Format(message, messageArgs), innerException) {
		}
	}
}
