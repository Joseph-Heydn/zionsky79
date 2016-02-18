/*********************************************************************************
 * Class	: BusinessLogic
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/
using System;

namespace Field.Framework.Data.Logic {
	public abstract class BusinessLogic<T> : IDisposable where T : DataAccess {
		private T dataAccess;
		protected bool disposed = false;

		protected T DataAccess {
			get { return dataAccess; }
		}

		protected BusinessLogic(T dataAccess) {
			this.dataAccess = dataAccess;
		}


		#region IDisposable 멤버
		public virtual void Dispose() {
			Dispose(true);
		}

		protected virtual void Dispose(bool disposing) {
			if ( dataAccess == null ) return;

			dataAccess.Dispose();
			dataAccess = null;
		}
		#endregion
	}
}
