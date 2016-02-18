using System;
using System.IO;
using Microsoft.VisualBasic.Logging;
using System.Diagnostics;
using System.Reflection;

namespace Field.Framework.Logging {
	public sealed class LogHelper {
		#region Pivate Variables
		private static readonly LogHelper gInstance = new LogHelper();
		private string _FileName, _FileLocation;
		private bool _FileAppend = true;
		private static bool _logType, _loggingOn = true;
		private string _nameSpace;
		private string _methodName;
		private string _className;
		private string _methodArgs;
		private StreamWriter Writer;
		#endregion


		#region Public Properties
		public string FileName {
			get { return _FileName; }
			set { _FileName = value; }
		}

		public string FileLocation {
			get { return _FileLocation; }
			set { _FileLocation = value; }
		}

		public bool FileAppend {
			get { return _FileAppend; }
			set { _FileAppend = value; }
		}

		public static bool LoggingOn {
			get { return _loggingOn; }
			set { _loggingOn = value; }
		}

		/// <summary>
		/// Set True to use FileLogTraceListener & False to StreamWriter
		/// </summary>
		public static bool LogType {
			get { return _logType; }
			set { _logType = value; }
		}
		#endregion


		#region Private Properties
		private string NameSpace {
			get {
				InitializeName();
				return _nameSpace;
			}
			set { _nameSpace = value; }
		}

		private string MethodName {
			get {
				InitializeName();
				return _methodName;
			}
			set { _methodName = value; }
		}

		private string MethodArguments {
			get {
				InitializeName();
				return _methodArgs;
			}
			set { _methodArgs = value; }
		}

		private string ClassName {
			get {
				InitializeName();
				return _className;
			}
			set { _className = value; }
		}

		private StreamWriter MyWriter {
			get { return Writer; }
			set { Writer = value; }
		}
		#endregion


		#region Public Static Method
		public static LogHelper GetLogHelper() {
			return gInstance;
		}
		#endregion


		#region Public Methods
		/// <summary>
		/// Should Called at the Start Point of Log
		/// </summary>
		/// <returns>Boolean</returns>
		public bool StartLog() {
			if ( !LoggingOn )
				return true;


			if ( LogType ) {
				FileLogTraceListener vLogInfo = new FileLogTraceListener();
				try {
					vLogInfo = AssignProperty();

					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("======================Logging Started At:"+ DateTime.Now +"======================");
					//logInfo.Close();
				} catch ( Exception ex ) {
					EventLog.WriteEntry("Application", ex.Message);
				} finally {
					vLogInfo.Close();
				}
			} else {
				lock ( this ) {
					GetWriter();
					try {
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("======================Logging Started At:"+ DateTime.Now +"======================");
						//MyWriter.Close();
					} finally {
						MyWriter.Close();
					}
				}
			}

			return true;
		}

		/// <summary>
		/// Should Called at the Start Point of Log
		/// </summary>
		/// <param name="strMsg">Message to Be passed with the StartLog</param>
		/// <returns>Boolean</returns>
		public bool StartLog(string strMsg) {
			if ( !LoggingOn )
				return true;


			if ( LogType ) {
				FileLogTraceListener vLogInfo = new FileLogTraceListener();
				try {
					vLogInfo = AssignProperty();

					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("======================Logging for "+ strMsg +" Started At:"+ DateTime.Now +"======================");
					//logInfo.Close();
				} finally {
					vLogInfo.Close();
				}
			} else {
				lock ( this ) {
					GetWriter();
					try {
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("======================Logging for "+ strMsg +" Started At:"+ DateTime.Now +"======================");
						//MyWriter.Close();
					} finally {
						MyWriter.Close();
					}
				}
			}
			return true;
		}

		/// <summary>
		/// Should Called at different points in method
		/// </summary>
		/// <param name="strMsg">Message</param>
		/// <returns>Boolean</returns>
		public bool CreateLog(string strMsg) {
			if ( !LoggingOn )
				return true;


			if ( LogType ) {
				FileLogTraceListener vLogInfo = new FileLogTraceListener();
				try {
					vLogInfo = new FileLogTraceListener();
					vLogInfo = AssignProperty();

					//logInfo.WriteLine("=====Log Start DateTime:"+ DateTime.Now+"=======");
					//logInfo.WriteLine(strMsg);
					//logInfo.WriteLine("=====Log End=======");
					vLogInfo.WriteLine("============"+ strMsg +" At "+ DateTime.Now +"============");
					vLogInfo.WriteLine("");
					//logInfo.Close();
				} finally {
					vLogInfo.Close();
				}
			} else {
				lock ( this ) {
					GetWriter();
					try {
						//logInfo = new StreamWriter(FileLocation +"/"+ FileName, true);

						MyWriter.WriteLine("============"+ strMsg +" At "+ DateTime.Now +"============");
						MyWriter.WriteLine("");

					} finally {
						MyWriter.Close();
					}
				}
			}
			return true;
		}

		/// <summary>
		/// Creates a Log for Exception Raised, can be used in Catch Blocks
		/// </summary>
		/// <param name="ex">Exception object</param>
		/// <returns>Boolean</returns>
		public bool CreateLog(Exception ex) {
			if ( !LoggingOn )
				return true;


			if ( LogType ) {
				FileLogTraceListener vLogInfo = new FileLogTraceListener();
				try {
					vLogInfo = new FileLogTraceListener();
					vLogInfo = AssignProperty();

					vLogInfo.WriteLine("=====Exception Log Start DateTime:"+ DateTime.Now +"=======");
					vLogInfo.WriteLine("");

					vLogInfo.WriteLine("NameSpace : "+ NameSpace);
					vLogInfo.WriteLine("ClassName : "+ ClassName);
					vLogInfo.WriteLine("MethodName : "+ MethodName);
					vLogInfo.WriteLine("MethodArguments : "+ MethodArguments);

					vLogInfo.WriteLine("SOURCE    : "+ ex.Source);
					vLogInfo.WriteLine("Type      : "+ ex.GetType().FullName);
					vLogInfo.WriteLine("MESSAGE   : "+ ex.Message);
					vLogInfo.WriteLine("TARGETSITE: "+ ex.TargetSite);
					vLogInfo.WriteLine("STACKTRACE: "+ ex.StackTrace);
					if ( ex.InnerException != null ) {
						vLogInfo.WriteLine("InnerException: " + ex.InnerException);
					}
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("=====Exception Log End=======");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
					//logInfo.Close();
				} finally {
					vLogInfo.Close();
				}
			} else {
				lock ( this ) {
					GetWriter();
					try {
						MyWriter.WriteLine("=====Exception Log Start DateTime:"+ DateTime.Now +"=======");
						MyWriter.WriteLine("");

						MyWriter.WriteLine("NameSpace : "+ NameSpace);
						MyWriter.WriteLine("ClassName : "+ ClassName);
						MyWriter.WriteLine("MethodName : "+ MethodName);
						MyWriter.WriteLine("MethodArguments : "+ MethodArguments);

						MyWriter.WriteLine("SOURCE    : "+ ex.Source);
						MyWriter.WriteLine("Type      : "+ ex.GetType().FullName);
						MyWriter.WriteLine("MESSAGE   : "+ ex.Message);
						MyWriter.WriteLine("TARGETSITE: "+ ex.TargetSite);
						MyWriter.WriteLine("STACKTRACE: "+ ex.StackTrace);
						if ( ex.InnerException != null ) {
							MyWriter.WriteLine("InnerException: " + ex.InnerException);
						}
						MyWriter.WriteLine("");
						MyWriter.WriteLine("=====Exception Log End=======");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
					} finally {
						MyWriter.Close();
					}
				}
			}

			return true;
		}

		/// <summary>
		/// Creates a Log for Exception Raised
		/// </summary>
		/// <param name="ex">Exception Raised</param>
		/// <param name="strExceptionMsg">Exception Name or UserDefined Message</param>
		/// <returns>Boolean</returns>
		public bool CreateLog(Exception ex, string strExceptionMsg) {
			if ( !LoggingOn )
				return true;


			if ( LogType ) {
				FileLogTraceListener vLogInfo = new FileLogTraceListener();
				try {
					vLogInfo = new FileLogTraceListener();
					vLogInfo = AssignProperty();

					vLogInfo.WriteLine("=====Exception Log DateTime:"+ DateTime.Now +"=======");
					vLogInfo.WriteLine(strExceptionMsg);
					vLogInfo.WriteLine("");

					vLogInfo.WriteLine("NameSpace : "+ NameSpace);
					vLogInfo.WriteLine("ClassName : "+ ClassName);
					vLogInfo.WriteLine("MethodName : "+ MethodName);
					vLogInfo.WriteLine("MethodArguments : "+ MethodArguments);

					vLogInfo.WriteLine("SOURCE    : "+ ex.Source);
					vLogInfo.WriteLine("MESSAGE   : "+ ex.Message);
					vLogInfo.WriteLine("TARGETSITE: "+ ex.TargetSite);
					vLogInfo.WriteLine("STACKTRACE: "+ ex.StackTrace);
					if ( ex.InnerException != null )
						vLogInfo.WriteLine("InnerException: "+ ex.InnerException);
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("=====Exception Log End=======");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
				} finally {
					vLogInfo.Close();
				}
			} else {
				lock ( this ) {
					GetWriter();
					try {
						MyWriter.WriteLine("=====Exception Log DateTime:"+ DateTime.Now +"=======");
						MyWriter.WriteLine(strExceptionMsg);
						MyWriter.WriteLine("");

						MyWriter.WriteLine("NameSpace : "+ NameSpace);
						MyWriter.WriteLine("ClassName : "+ ClassName);
						MyWriter.WriteLine("MethodName : "+ MethodName);
						MyWriter.WriteLine("MethodArguments : "+ MethodArguments);

						MyWriter.WriteLine("SOURCE    : "+ ex.Source);
						MyWriter.WriteLine("Type      : "+ ex.GetType().FullName);
						MyWriter.WriteLine("MESSAGE   : "+ ex.Message);
						MyWriter.WriteLine("TARGETSITE: "+ ex.TargetSite);
						MyWriter.WriteLine("STACKTRACE: "+ ex.StackTrace);
						if ( ex.InnerException != null )
							MyWriter.WriteLine("InnerException: "+ ex.InnerException);
						MyWriter.WriteLine("");
						MyWriter.WriteLine("=====Exception Log End=======");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
					} finally {
						MyWriter.Close();
					}
				}
			}
			return true;
		}

		/// <summary>
		/// Creates User-Defined message which can be used in Exception Logs
		/// </summary>
		/// <param name="strMsg">Message</param>
		/// <returns>Boolean</returns>
		public bool CreateExMsgLog(string strMsg) {
			if ( !LoggingOn )
				return true;


			if ( LogType ) {
				FileLogTraceListener vLogInfo = new FileLogTraceListener();
				try {
					vLogInfo = AssignProperty();

					vLogInfo.WriteLine("==="+ strMsg +" At "+ DateTime.Now);
					vLogInfo.WriteLine("");
					//logInfo.Close();
				} finally {
					vLogInfo.Close();
				}
			} else {
				lock ( this ) {
					GetWriter();
					try {
						//MyWriter = new StreamWriter(FileLocation +"/"+ FileName, true);

						MyWriter.WriteLine("==="+ strMsg +" At "+ DateTime.Now);
						MyWriter.WriteLine("");
						MyWriter.Close();
					} finally {
						MyWriter.Close();
					}
				}
			}
			return true;
		}

		/// <summary>
		/// Should be used at the End of the Log
		/// </summary>
		/// <returns></returns>
		public bool EndLog() {
			if ( !LoggingOn )
				return true;


			if ( LogType ) {
				FileLogTraceListener vLogInfo = new FileLogTraceListener();
				try {
					vLogInfo = new FileLogTraceListener();
					vLogInfo = AssignProperty();

					vLogInfo.WriteLine("======================Logging Ended At:"+ DateTime.Now +"======================");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
					vLogInfo.WriteLine("");
					vLogInfo.Close();
				} finally {
					vLogInfo.Close();
				}
			} else {
				lock ( this ) {
					GetWriter();
					try {
						//MyWriter = new StreamWriter(FileLocation +"/"+ FileName, true);

						MyWriter.WriteLine("======================Logging Ended At:"+ DateTime.Now +"======================");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
						MyWriter.WriteLine("");
						//MyWriter.Close();
					} finally {
						MyWriter.Close();
					}
				}
			}

			return true;
		}
		#endregion


		#region Private Methods
		/// <summary>
		/// Creates a FileTraceListener object and assigns a File name & path to it properties.
		/// </summary>
		/// <returns>FileTraceListener Object</returns>
		private FileLogTraceListener AssignProperty() {
			try {
				FileLogTraceListener vLogInfo = new FileLogTraceListener();

				vLogInfo.Append = FileAppend;
				vLogInfo.BaseFileName = FileName;
				vLogInfo.CustomLocation = FileLocation;
				vLogInfo.Location = LogFileLocation.Custom;
				vLogInfo.AutoFlush = true;
				return vLogInfo;
			} catch ( Exception ex ) {
				throw ex;
			}
		}

		/// <summary>
		/// Assigns a StreamWriter
		/// </summary>
		private void GetWriter() {
			lock ( this ) {
				CloseFile();
				string path = FileLocation +"/"+ FileName;

				if ( !Directory.Exists(FileLocation) ) {
					throw new DirectoryNotFoundException("log file diretory not found.\nDirectory:"+ FileLocation);
				}
				MyWriter = new StreamWriter(path, FileAppend);
			}
		}

		/// <summary>
		/// Closes a StreamWriter
		/// </summary>
		private void CloseFile() {
			if ( MyWriter == null )
				return;

			try {
				MyWriter.Close();
			} catch(Exception ex) {
				throw ex;
			}
		}

		/// <summary>
		/// Gets the name of NameSpace, ClassName, MethodName and its Arguments Name
		/// </summary>
		private void InitializeName() {
			string vParam = "";

			StackTrace objSTrace = new StackTrace(true);
			if ( objSTrace.FrameCount < 3 )
				return;


			//Gets the MethodBase
			StackFrame objSFrame = objSTrace.GetFrame(3);
			MethodBase objMethodBase = objSFrame.GetMethod();
			ParameterInfo[] objParamInfo = objMethodBase.GetParameters();


			//Gets the Parameter of the Method
			foreach ( ParameterInfo objParam in objParamInfo ) {
				if ( vParam != "" )
					vParam += objParam.ParameterType.Name;
				else
					vParam += ", "+ objParam.ParameterType.Name;

				vParam += ", "+ objParam.Name;
			}

			//Gets the NameSpace Name
			if ( objMethodBase.ReflectedType != null ) {
				NameSpace = objMethodBase.ReflectedType.Namespace;
				//Gets the ClassName
				ClassName = objMethodBase.ReflectedType.Name;
			}
			//Gets the Method Name
			MethodName = objMethodBase.Name;
			//Gets the Method Parameter Name
			MethodArguments = vParam == "" ? "No Arguments" : vParam;
		}
		#endregion
	}
}
