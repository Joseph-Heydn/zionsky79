<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="captcha.ascx.cs" Inherits="_12sky2.web.include.captcha" %>
<div class="t_center">
    <center>
        <recaptcha:RecaptchaControl ID="recaptcha" runat="server"
			Theme="clean" Language="en"
			PublicKey="6LdgihITAAAAAPUA0oNBXG2PjP-T49iBvCyx3Wup" 
			PrivateKey="6LdgihITAAAAACx_PMOvdiEmtxA2f-uhhP6iyQV4" />
    </center>
</div>
