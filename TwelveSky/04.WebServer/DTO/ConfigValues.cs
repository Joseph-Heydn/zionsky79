using System;
using System.Configuration;

public class DTO_ConfigValues {
	public struct EnvTime {
		// commandTimeOut
		public static int cmdTimeOutBasic	= Convert.ToInt32(ConfigurationManager.AppSettings["TimeOut_Basic"]);
		public static int cmdTimeOutLong	= Convert.ToInt32(ConfigurationManager.AppSettings["TimeOut_Long"]);
	}
}
