using System;
using System.Configuration;

public class DTO_ConfigValues {
	public struct EnvTime {
		// commandTimeOut
		public static int cmdTimeOutBasic	= Convert.ToInt32(ConfigurationManager.AppSettings["commandTimeOut_Default"]);
		public static int cmdTimeOutLong	= Convert.ToInt32(ConfigurationManager.AppSettings["commandTimeOut_Long"]);
	}
}
