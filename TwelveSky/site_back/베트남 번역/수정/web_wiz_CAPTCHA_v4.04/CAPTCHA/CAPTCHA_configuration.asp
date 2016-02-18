<!-- #include file="CAPTCHA_functions.asp" -->
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




'Initialise variables
Dim blnCAPTCHAabout
Dim strDisplayLicense
Dim strLicense
Dim strCanvasColour, strBorderColour, strCharacterColour1, strCharacterColour2
Dim blnRandomLinePlacement, blnSkewing
Dim intNoiseLevel1, strNoiseColour1, intNoiseLevel2, strNoiseColour2
Dim intNoiseLines1, strNoiseLinesColour1, intNoiseLines2, strNoiseLinesColour2



'*****  Change this if to False if you do NOT want the CAPTCHA code to be case sensitive *****
Const blnCAPTCHAcaseSensitive = False



'***** This is the name of the page you want users redirected to if CAPTCHA is entered incorrectly *****
'Place the page to be redirected to between the quote marks below
Const strIncorrectCAPTCHApage = "" 



'*****  Change this if you wish to change the displayed text text *****
Const strTxtLoadNewCode = "Refresh Image"
Const strTxtCodeEnteredIncorrectly = "The security code entered was incorrect.<br /><a href=""javascript:history.go(-1)"">Please go back and resubmit the form</a>"






'************************************************
'****		CAPTCHA Image Settings	     ****
'************************************************

'The settings below allow you to configure the colours, noise level, distortion type, etc. of the CAPTCHA image


'Background Colour
strCanvasColour = "FFFFFF"

'Border Colour
strBorderColour = "999999"

'Character Colour
'Use two colours for the characters to make it harder for OCR software that use colour filering to remove noise
strCharacterColour1 = "003366"
strCharacterColour2 = "AAAAAA"


'Random Character Line Placement
'This places the characters at different line levels on the canvas, this is good at preventing OCR software reading the image but still allows the image to be readable for humans
blnRandomLinePlacement = True


'Random Character Skewing
'Random Skewing is good at preventing OCR software recognising characters
blnSkewing = True


'Making one of the noise levels and line noise the same as the background colour and the other the same as the character colour
'is good at preventing OCR software recognised characters by using colour filters to remove noise

'Pixelation Noise #1
'This is the pixelation noise level, random pixels which prevent OCR software recognising characters
intNoiseLevel1 = 8
strNoiseColour1 = "AAAAAA"

'Pixelation Noise #2
intNoiseLevel2 = 8
strNoiseColour2 = "003366"


'Noise Lines #1
'Random lines overlaying image, prevents OCR software recognising characters, but can quickly make the image difficult for a human to read
intNoiseLines1 = 5 
strNoiseLinesColour1 = "003366"

'Noise Lines #2
intNoiseLines2 = 9 
strNoiseLinesColour2 = "FFFFFF"

'*********************************************************************








Const strCAPTCHAversion = "4.04"
blnCAPTCHAabout = True
If Request.QueryString("about") Then Call captchaInfo()  


%>