using System;
using System.Web;
using System.Web.UI;

namespace Web.Manage._common._smartEditor.photo_uploader.popup {
	public partial class file_uploader : Page {
		protected void Page_Load(object sender, EventArgs e) {
			if ( !IsPostBack ) {
				HttpFileCollection uploadedFiles = Request.Files;

				string vCallbackFunc = Request.Form["callback_func"];

				for ( int i = 0; i < uploadedFiles.Count; ++i ) {
					HttpPostedFile vUserPostedFile = uploadedFiles[i];

					if ( vUserPostedFile.ContentLength > 0 ) {
											
					}
				}
			}
		}
	}
}
