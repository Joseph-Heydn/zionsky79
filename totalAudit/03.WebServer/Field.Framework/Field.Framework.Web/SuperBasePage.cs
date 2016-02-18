using System;
using System.Web.UI;

namespace Field.Framework.Web {
	public abstract class SuperBasePage : Page {
		protected abstract void fnWriterLog(Exception pExcept);
		public abstract void SetCacheData(string pKey, object pData, int pCachingTime);
		public abstract void GetCacheData(string pKey);

		public abstract bool IsReadableAuthority();
		public abstract bool IsWritableAuthority();
	}
}
