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




'***** START WARNING - REMOVAL OR MODIFICATION OF THIS CODE WILL VIOLATE THE LICENSE AGREEMENT ******
Response.Write(vbCrLf & vbCrLf & "<!--//" & _
vbCrLf & "/* *******************************************************" & _
vbCrLf & "Software: Web Wiz CAPTCHA(TM) ver. " & strCAPTCHAversion & "" & _
vbCrLf & "Info: http://www.WebWizCAPTCHA.com" & _
vbCrLf & "Copyright: (C)2005-2014 Web Wiz Ltd. All rights reserved" & _
vbCrLf & "******************************************************* */" & _
vbCrLf & "//-->")
'***** END WARNING - REMOVAL OR MODIFICATION OF THIS CODE WILL VIOLATE THE LICENSE AGREEMENT ******              


%>
<script language="javaScript">
function reloadCAPTCHA() {
	document.getElementById('CAPTCHA').src='CAPTCHA/CAPTCHA_image.asp?'+Date();
}
</script>           
<table width="100%" border="0" cellspacing="1" cellpadding="3">
 <tr>
  <td><img src="CAPTCHA/CAPTCHA_image.asp" alt="Code Image - Please contact webmaster if you have problems seeing this image code" id="CAPTCHA" width="120" height="50" />&nbsp;&nbsp;<img src="CAPTCHA/images/refresh.png" alt="Refresh" style="vertical-align: text-bottom"> <a href="javascript:reloadCAPTCHA();"><% = strTxtLoadNewCode %></a></td>
 </tr>
 <tr>
  <td>
   <input type="hidden" name="CAPTCHA_Postback" id="CAPTCHA_Postback" value="true" />
   <input type="text" name="securityCode" id="securityCode" size="12" maxlength="12" autocomplete="off" />
  </td>
 </tr><%

'***** START WARNING - REMOVAL OR MODIFICATION OF THIS CODE WILL VIOLATE THE LICENSE AGREEMENT ******
If blnCAPTCHAabout Then
	Response.Write("<tr><td><span style=""font-size: 10px; font-family: Arial, Helvetica, sans-serif;"">Powered by <a href=""http://www.webwizcaptcha.com"" target=""_blank"" style=""font-size:10px"">Web Wiz CAPTCHA</a> version " & strCAPTCHAversion & "<br />Copyright &copy;2005-2014 Web Wiz</span></td></tr>")
End If 
'***** END WARNING - REMOVAL OR MODIFICATION OF THIS CODE WILL VIOLATE THE LICENSE AGREEMENT ******      
      
      %>
</table>