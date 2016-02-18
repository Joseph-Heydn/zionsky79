<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="captcha.ascx.cs" Inherits="_12sky2.web.include.captcha" %>
<div class="t_center">
    <center>
        <recaptcha:RecaptchaControl id="recaptcha" runat="server"
			Theme="clean" Language="en"
			PublicKey="6Lcg4hUTAAAAAOpGl7m13StAl_Uz7j_ILOKLUQLi" 
			PrivateKey="6Lcg4hUTAAAAAGiULyTdytakNxgSDJlJE9-WbMd6"/>
    </center>
</div>
