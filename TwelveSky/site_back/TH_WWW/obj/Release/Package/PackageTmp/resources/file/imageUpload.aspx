<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="imageUpload.aspx.cs" Inherits="_12sky2.resources.file.imageUpload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Insert Image</title>
    
    <common:layout id="common" runat="server" />
    
    <style type="text/css">
        .preView_area { float:left; width:100%; margin:10px auto; text-align:center;}
        .preView { width:150px; height:150px; text-align:center; border:1px solid silver;margin:0px auto; }
    </style>
    <script type="text/javascript">
        var _mockdata = "";
        function setImg(seq, imageurl, filename, filesize, originalurl, thumburl) {
            _mockdata = {
                'seq': seq,
                'imageurl': imageurl,
                'filename': filename,
                'filesize': filesize,
                'imagealign': 'C',
                'originalurl': originalurl,
                'thumburl': thumburl
            };
        }

        function done() {
            opener.parent.setImg(_mockdata);
            closeWindow();
        }
        function closeWindow() {
            self.close();
        }

        function fileUploadPreview() {

            var thisObj = document.getElementById("imageFile");
            var preViewer = document.getElementById("preView");

            if (!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(thisObj.value)) {
                alert("이미지 형식의 파일을 선택하십시오");
                return;
            }


            preViewer = (typeof (preViewer) == "object") ? preViewer : document.getElementById(preViewer);

            var ua = window.navigator.userAgent;

            if (ua.indexOf("MSIE") > -1) {
                var img_path = "";
                if (thisObj.value.indexOf("\\fakepath\\") < 0) {
                    img_path = thisObj.value;
                } else {
                    thisObj.select();
                    var selectionRange = document.selection.createRange();
                    img_path = selectionRange.text.toString();
                    thisObj.blur();
                }
                preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='fi" + "le://" + img_path + "', sizingMethod='crop')";
            } else {
                preViewer.innerHTML = "";
                var W = preViewer.offsetWidth;
                var H = preViewer.offsetHeight;
                var tmpImage = document.createElement("img");
                preViewer.appendChild(tmpImage);

                tmpImage.onerror = function() {
                    return preViewer.innerHTML = "";
                }

                tmpImage.onload = function() {
                    if (this.width > W) {
                        this.height = this.height / (this.width / W);
                        this.width = W;
                    }
                    if (this.height > H) {
                        this.width = this.width / (this.height / H);
                        this.height = H;
                    }
                }
                if (ua.indexOf("Firefox/3") > -1) {
                    var picData = thisObj.files.item(0).getAsDataURL();
                    tmpImage.src = picData;
                } else {
                    tmpImage.src = "file://" + thisObj.value;
                }
            }

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background:#fff;width:390px;height:210px;margin:5px auto;">
            <div class="preView_area">
                <asp:Image ID="Image1" runat="server" CssClass="preView" />
            </div>
            <div class="preView_area">
                <asp:FileUpload ID="imageFile" runat="server" onchange="__doPostBack('imageSelect','')" />
            </div>
        </div>
        <div class="btn">
            <ul>
                <li><a href="#" onclick="done();">INSERT</a></li>
                <li><a href="#" onclick="closeWindow();">CANCEL</a></li>
            </ul>
        </div>
        <asp:LinkButton ID="imageSelect" runat="server" OnClick="imageSelect_Click"></asp:LinkButton>
    </form>
</body>
</html>
