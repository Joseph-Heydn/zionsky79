<%
'****************************************************************************************
'**  Copyright Notice    
'**
'**  Web Wiz CAPTCHA(TM)
'**  http://www.webwizCAPTCHA.com
'**                                                              
'**  Copyright (C)2005-2014 Web Wiz Ltd. All rights reserved.  
'**  
'**  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS UNDER LICENSE FROM WEB WIZ LTD.
'**  
'**  IF YOU DO NOT AGREE TO THE LICENSE AGREEMENT THEN WEB WIZ LTD. IS UNWILLING TO LICENSE 
'**  THE SOFTWARE TO YOU, AND YOU SHOULD DESTROY ALL COPIES YOU HOLD OF 'WEB WIZ' SOFTWARE
'**  AND DERIVATIVE WORKS IMMEDIATELY.
'**  
'**  If you have not received a copy of the license with this work then a copy of the latest
'**  license contract can be found at:-
'**
'**  http://www.webwiz.co.uk/license
'**
'**  For more information about this software and for licensing information please contact
'**  'Web Wiz' at the address and website below:-
'**
'**  Web Wiz Ltd, Unit B10, 9 Nimrod Way, East Dorset Trade Park, Wimborne, Dorset, BH21 7UH, England
'**  http://www.webwiz.co.uk
'**
'**  Removal or modification of this copyright notice will violate the license contract.
'**
'****************************************************************************************          



'*************************** SOFTWARE AND CODE MODIFICATIONS **************************** 
'**
'** MODIFICATION OF THE FREE EDITIONS OF THIS SOFTWARE IS A VIOLATION OF THE LICENSE  
'** AGREEMENT AND IS STRICTLY PROHIBITED
'**
'** If you wish to modify any part of this software a license must be purchased
'**
'****************************************************************************************





'Get about status
Private Function about()

	about = 1 

	'Calulate the lentgh
	If LEN(strLicense) > 47 Then
		
		Dim intAbout
		intAbout = 1
		
		
	End If
End Function
 

'Get CAPTCHA info
Private Sub captchaInfo()

	Response.Write("" & _
	vbCrLf & "<pre>" & _
	vbCrLf & "*********************************************************" & _
	vbCrLf & "Software: Web Wiz CAPTCHA(TM)" & _
	vbCrLf & "Version: " & strCAPTCHAversion & _
	vbCrLf & "License: " & strDisplayLicense & _
	vbCrLf & "Author: Web Wiz Ltd." & _
	vbCrLf & "Address: Unit 10B, 9 Nimrod Way, East Dorset Trade Park, Ferndown, Dorset, UK" & _
	vbCrLf & "Info: http://www.webwizCAPTCHA.com" & _
	vbCrLf & "Copyright: (C)2005-2014 Web Wiz Ltd. All rights reserved" & _
	vbCrLf & "*********************************************************" & _
	vbCrLf & "</pre")
	
	Response.Flush
	Response.End
End Sub

%>