<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="captcha.ascx.cs" Inherits="_12sky2.web.include.captcha" %>

<div class="t_center" >
    <center>
        <recaptcha:RecaptchaControl ID="recaptcha" runat="server"
            Theme="clean" Language="en"
            PublicKey="6Lf_vAcTAAAAAGcIt-oBFb_RMyhIfWlGi7LdK_Tq" 
            PrivateKey="6Lf_vAcTAAAAADK-IHwotenUvI8WZ7-okXCGS_Tt" />
    </center>
</div>