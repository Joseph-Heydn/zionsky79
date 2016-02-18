/*********************************************************************************
 * Class    : ICryptoEncoding
 * Remarks  :
 * History
 *
 * Ver  Date        Author          Description
 * ---  ----------  --------------  ----------------------------------------------
 * 1.0  2013-03-04  Hoon-Sik,Jin    1.Create
 ********************************************************************************/
using System.Text;

namespace Field.Framework.Security.Cryptography {
	public interface ICryptoEncoding {
		Encoding Encoding { get; }

		byte[] GetDecryptInput(string pInput);
		string GetDecryptOutput(byte[] pOutput);

		byte[] GetEncryptInput(string pInput);
		string GetEncryptOutput(byte[] pOutput);
	}
}
