/*********************************************************************************
 * Class	:
 * History	:
 * Remark	: 사용하지 않습니다. (유효기간 생성일로부터 3개월)
 *
 * Ver	Date		Author			Description
 * ---	----------	--------------	----------------------------------------------
 * 1.0	2013-03-04	Hoon-Sik,Jin	1.Create
 ********************************************************************************/

namespace Field.Framework {
	// [SQL SERVER DATA TYPE - 2000]
	public enum emSQLDATA {
			eBIGINT_TYPE = 0		// DBTYPE_I8
		,	eBINARY_TYPE			// DBTYPE_BYTES
		,	eBIT_TYPE				// DBTYPE_BOOL
		,	eCHAR_TYPE				// DBTYPE_STR
		,	eDATETIME_TYPE			// DBTYPE_DBTIMESTAMP
		,	eDECIMAL_TYPE			// DBTYPE_NUMERIC
		,	eFLOAT_TYPE				// DBTYPE_R8
		,	eIMAGE_TYPE				// DBTYPE_BYTES
		,	eINT_TYPE				// DBTYPE_I4
		,	eMONEY_TYPE				// DBTYPE_CY
		,	eNCHAR_TYPE				// DBTYPE_WSTR
		,	eNTEXT_TYPE				// DBTYPE_WSTR
		,	eNUMERIC_TYPE			// DBTYPE_NUMERIC
		,	eNVARCHAR_TYPE			// DBTYPE_WSTR
		,	eREAL_TYPE				// DBTYPE_R4
		,	eSMALLDATETIME_TYPE		// DBTYPE_DBTIMESTAMP
		,	eSMALLINT_TYPE			// DBTYPE_I2
		,	eSMALLMONEY_TYPE		// DBTYPE_CY
		,	eSQL_VARIANT_TYPE		// DBTYPE_VARIANT	DBTYPE_SQLVARIANT*
		,	eSYSNAME_TYPE			// DBTYPE_WSTR
		,	eTEXT_TYPE				// DBTYPE_STR
		,	eTIMESTAMP_TYPE			// DBTYPE_BYTES
		,	eTINYINT_TYPE			// DBTYPE_UI1
		,	eUNIQUEIDENTIFIER_TYPE	// DBTYPE_GUID
		,	eVARBINARY_TYPE			// DBTYPE_BYTES
		,	eVARCHAR_TYPE			// DBTYPE_STR
	};
}
