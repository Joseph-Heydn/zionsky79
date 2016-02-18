<%@ Control
	Language="C#"
	AutoEventWireup="true"
	CodeBehind="ucCaptcha.ascx.cs"
	Inherits="Web.TwelveSky.App_Common.ucCaptcha"
%>
<%@ Register
	TagPrefix="rc"
	Namespace="Recaptcha"
	Assembly="Recaptcha, Version=1.0.5.0, Culture=neutral, PublicKeyToken=9afc4d65b28c38c2"
%>
<div class="recaptcha">
	<div class="recaptcha_center">
		<rc:RecaptchaControl id="recaptcha" Theme="clean" Language="en"
			PublicKey="<%$ appSettings:recaptchaPublicKey %>"
			PrivateKey="<%$ appSettings:recaptchaPrivateKey %>"
			runat="server"/>
	</div>
</div>
