<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="captcha.ascx.cs" Inherits="_12sky2.web.include.captcha" %>

<div class="t_center" >
    <center>
        <recaptcha:RecaptchaControl ID="recaptcha" runat="server"
            Theme="clean" Language="en"
            PublicKey="6Lf0VhATAAAAACnUdLZ1KzhzAv7qFOyPyhQVf23-" 
            PrivateKey="6Lf0VhATAAAAAHbNuElsTGDa7OppdnP0kO-vl1mB" />
    </center>
</div>