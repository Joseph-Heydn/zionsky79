using System;

public class RandomValues {
	// 랜덤 문자열 생성
	public static string fnGetRandomString(int pLength) {
		const string C_RANDOM_STRING = "1234567890abcdefghijklnmopqrstuvwxyz~!@#$^*?ABCDEFGHIJKLNMOPQRSTUVWXYZ";
		string oString = "";
		Random vRandom = new Random();

		for ( int i = 0; i < pLength; ++i ) {
			int vResult = vRandom.Next(0, C_RANDOM_STRING.Length - 1);
			oString += C_RANDOM_STRING[vResult].ToString();
		}

		return oString;
	}
}
