/*********************************************************************************
 * Class	: ConvertHelper
 * History
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/

namespace Field.Framework {
	public class EnumHelper {
		public emSQLDATA eSqlData;

		//private const string MAPPING_FILENAME = "EnumMapping.xml";
		//private static XmlDocument _mappingXml;

		//static EnumHelper() {
		//    _mappingXml.Load(MAPPING_FILENAME);
		//}

		//public static object GetEnum(Type enumType, object dbCode) {
		//    string typeName = enumType.FullName;
		//    string xpathQuery = string.Format("/*/EnumMapping[@type='{0}']/Item[@dbCode='{1}']", typeName, dbCode);

		//    string value = GetAttributeValue(xpathQuery, "key");
		//    return Enum.Parse(enumType, value);
		//}

		//public static object GetDBCode(Enum enumValue) {
		//    string typeName = enumValue.GetType().FullName;
		//    string xpathQuery = string.Format("/*/EnumMapping[@type='{0}']/Item[@key='{1}']", typeName, enumValue.ToString());

		//    return GetAttributeValue(xpathQuery, "dbCode");
		//}

		//public static string GetDescription(Enum enumValue) {
		//    string typeName = enumValue.GetType().FullName;
		//    string xpathQuery = string.Format("/*/EnumMapping[@type='{0}']/Item[@key='{1}']", typeName, enumValue.ToString());

		//    return GetAttributeValue(xpathQuery, "description");
		//}

		//public static string GetDescription(Type enumType, object dbCode) {
		//    string typeName = enumType.FullName;
		//    string xpathQuery = string.Format("/*/EnumMapping[@type='{0}']/Item[@dbCode='{1}']", typeName, dbCode);

		//    return GetAttributeValue(xpathQuery, "description");
		//}

		//private static string GetAttributeValue(string xpathQuery, string attributeName) {
		//    XmlNode itemNode = _mappingXml.SelectSingleNode(xpathQuery);

		//    if (itemNode != null) {
		//        return itemNode.Attributes[attributeName].Value;
		//    }

		//    return null;
		//}
	}
}
