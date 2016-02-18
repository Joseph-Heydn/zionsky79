using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Linq;

public class ImageHandler {
	/// <summary>
	/// Method to resize, convert and save the image.
	/// </summary>
	/// <param name="pFilePath">image file path.</param>
	/// <param name="pFileName">file name.</param>
	/// <param name="pFileExt">file extension.</param>
	/// <param name="pSize">s - small, m - medium</param>
	/// <param name="pMaxWidth">resize width.</param>
	/// <param name="pMaxHeight">resize height.</param>
	/// <param name="pQuality">quality setting value.</param>
	public static void fnSaveImage(string pFilePath, string pFileName, string pFileExt, string pSize, int pMaxWidth, int pMaxHeight, int pQuality) {
		const string vTmp = "{0}{1}{2}.{3}";
		string vFileName = string.Format(vTmp, pFilePath, pFileName, "", pFileExt);
		Bitmap vImages = new Bitmap(vFileName);

		// Get the image's original width and height
		int vWidth	= vImages.Width;
		int vHeight	= vImages.Height;

		// To preserve the aspect ratio
		float vRatioX	= pMaxWidth / (float) vWidth;
		float vRatioY	= pMaxHeight / (float) vHeight;
		float vRatio	= Math.Min(vRatioX, vRatioY);

		// New width and height based on aspect ratio
		int vNewWidth	= (int) (vWidth * vRatio);
		int vNewHeight	= (int) (vHeight * vRatio);

		// 크기 보정 - 원래 이미지 보다 커진 경우
		if ( (vWidth * vHeight) < (vNewWidth * vNewHeight) ) {
			vNewWidth	= vWidth;
			vNewHeight	= vHeight;
		}

		// Convert other formats (including CMYK) to RGB.
		Bitmap vNewImage = new Bitmap(vNewWidth, vNewHeight, PixelFormat.Format24bppRgb);

		// Draws the image in the specified size with quality mode set to HighQuality
		using ( Graphics vImage = Graphics.FromImage(vNewImage) ) {
			vImage.CompositingQuality	= CompositingQuality.HighQuality;
			vImage.InterpolationMode	= InterpolationMode.HighQualityBicubic;
			vImage.SmoothingMode		= SmoothingMode.HighQuality;
			vImage.DrawImage(vImages, 0, 0, vNewWidth, vNewHeight);
		}

		// Get an ImageCodecInfo object that represents the JPEG codec.
		ImageCodecInfo vImageCodecInfo = fnGetEncoderInfo(ImageFormat.Jpeg);
		// Create an EncoderParameters object.
		// Save the image as a JPEG file with quality level.
		EncoderParameters vEncoderParameters = new EncoderParameters(1)
		{	Param = { [0] = new EncoderParameter(Encoder.Quality, pQuality) }
		};

		vFileName = string.Format(vTmp, pFilePath, pFileName, pSize, pFileExt);
		vNewImage.Save(vFileName, vImageCodecInfo, vEncoderParameters);

		vImages.Dispose();
		vNewImage.Dispose();
	}

	/// <summary>
	/// Method to get encoder infor for given image format.
	/// </summary>
	/// <param name="pFormat">Image format</param>
	/// <returns>image codec info.</returns>
	private static ImageCodecInfo fnGetEncoderInfo(ImageFormat pFormat) {
		return ImageCodecInfo.GetImageDecoders().SingleOrDefault(c => c.FormatID == pFormat.Guid);
	}

	public static string fnFileExt(string pFileType) {
		switch ( pFileType ) {
			case "image/bmp":
				return "bmp";
			case "image/gif":
				return "gif";
			case "image/jpeg":
			case "image/pjpeg":
				return "jpg";
			case "image/png":
			case "image/x-png":
				return "png";
			default:
				return "error";
		}
	}
}
