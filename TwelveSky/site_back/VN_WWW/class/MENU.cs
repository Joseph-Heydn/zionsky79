using System.Collections;

public class MENU {
	private const string C_WEB_RESOURCE = "/web/include/head.ascx";

	public static string getPageTItle(string TITL, string SUB_TITL) {
		string resultStr = null;
		ArrayList vMenuList = getAdminMenu(TITL);

		foreach ( var vMenu in vMenuList ) {
			string[] _menu = vMenu.ToString().Split(',');
			if ( _menu[0].Trim().Equals(SUB_TITL) ) {
				resultStr = _menu[2].Trim();
			}
		}

		return resultStr;
	}

	// 라벨에 텍스트 입력
	private static string fnLabelText(string pKey) {
		return ResourceValues.AppResourceText(C_WEB_RESOURCE, pKey);
	}

	public static ArrayList getMenu(string TITL) {
		string vMenu;
		ArrayList resultList = new ArrayList();

		switch ( TITL ) {
			case "News":
				vMenu = "announcement,  /web/news/announcement.aspx,   "+ fnLabelText("announcement");
				resultList.Add(vMenu);
				vMenu = "notice,        /web/news/notice.aspx,         "+ fnLabelText("notice");
				resultList.Add(vMenu);

				break;
			case "Game Guides":
				vMenu = "story,         /web/guide/story.aspx,              "+ fnLabelText("story");
				resultList.Add(vMenu);
				vMenu = "introduction,  /web/guide/introduction.aspx,       "+ fnLabelText("introduction");
				resultList.Add(vMenu);
				vMenu = "feature,       /web/guide/feature.aspx,            "+ fnLabelText("feature");
				resultList.Add(vMenu);
				vMenu = "requirements,  /web/guide/requirements.aspx,       "+ fnLabelText("requirements");
				resultList.Add(vMenu);
				vMenu = "questions,     /web/guide/questions.aspx,          "+ fnLabelText("questions");
				resultList.Add(vMenu);
				vMenu = "start,         /web/guide/start.aspx,              "+ fnLabelText("start");
				resultList.Add(vMenu);
				vMenu = "info,          /web/guide/info.aspx,               "+ fnLabelText("info");
				resultList.Add(vMenu);
				vMenu = "play,          /web/guide/play.aspx,               "+ fnLabelText("play");
				resultList.Add(vMenu);
				vMenu = "pet,           /web/guide/pet.aspx,                "+ fnLabelText("pet");
				resultList.Add(vMenu);
				vMenu = "item,         /web/guide/item.aspx,                "+ fnLabelText("item");
				resultList.Add(vMenu);
				vMenu = "pvp,          /web/guide/pvp.aspx,                 "+ fnLabelText("pvp");
				resultList.Add(vMenu);
				vMenu = "player,       /web/guide/player.aspx,              "+ fnLabelText("player");
				resultList.Add(vMenu);
				vMenu = "government,   /web/guide/government.aspx,          "+ fnLabelText("government");
				resultList.Add(vMenu);
				vMenu = "npcs,         /web/guide/npcs.aspx,                "+ fnLabelText("npcs");
				resultList.Add(vMenu);

				break;
			case "Community":
				vMenu = "discussion,    /web/community/list.aspx?DIV=discussion,     "+ fnLabelText("discussion");
				resultList.Add(vMenu);
				vMenu = "tips,          /web/community/list.aspx?DIV=tips,           "+ fnLabelText("tips");
				resultList.Add(vMenu);
				vMenu = "problem,       /web/community/list.aspx?DIV=problem,        "+ fnLabelText("problem");
				resultList.Add(vMenu);
				vMenu = "trade,         /web/community/list.aspx?DIV=trade,          "+ fnLabelText("trade");
				resultList.Add(vMenu);

				break;
			case "Media":
				vMenu = "video,         /web/media/video.aspx,                       "+ fnLabelText("video");
				resultList.Add(vMenu);
				vMenu = "artwork,       /web/media/list.aspx?DIV=artwork,            "+ fnLabelText("artwork");
				resultList.Add(vMenu);
				vMenu = "screenshots,   /web/media/list.aspx?DIV=screenshots,        "+ fnLabelText("screenshots");
				resultList.Add(vMenu);

				break;
		}

		return resultList;
	}

	public static ArrayList getAdminMenu(string TITL) {
		string vMenu;
		ArrayList resultList = new ArrayList();

		switch ( TITL ) {
			case "Main":
				vMenu = "main_image,    /admin/main/main_image.aspx,   Main Image";
				resultList.Add(vMenu);
				vMenu = "main_movie,    /admin/main/main_movie.aspx,   Main Movie";
				resultList.Add(vMenu);
				vMenu = "main_banner,   /admin/main/main_banner.aspx,  Main Banner";
				resultList.Add(vMenu);

				break;
			case "News":
				vMenu = "announcement,  /admin/news/list.aspx?DIV=announcement,     Announcements";
				resultList.Add(vMenu);
				vMenu = "notice,        /admin/news/list.aspx?DIV=notice,           Notice";
				resultList.Add(vMenu);

				break;
			case "Community":
				vMenu = "discussion,    /admin/community/list.aspx?DIV=discussion,  General Discussion";
				resultList.Add(vMenu);
				vMenu = "tips,          /admin/community/list.aspx?DIV=tips,        Tips / Knowhow";
				resultList.Add(vMenu);
				vMenu = "problem,       /admin/community/list.aspx?DIV=problem,     Problem Solution";
				resultList.Add(vMenu);
				vMenu = "trade,         /admin/community/list.aspx?DIV=trade,       Item Trade";
				resultList.Add(vMenu);

				break;
			case "Media":
				vMenu = "video,         /admin/media/video.aspx,                    Video";
				resultList.Add(vMenu);
				vMenu = "artwork,       /admin/media/list.aspx?DIV=artwork,         Artwork";
				resultList.Add(vMenu);
				vMenu = "screenshots,   /admin/media/list.aspx?DIV=screenshots,     Screenshots";
				resultList.Add(vMenu);

				break;
			case "Shop":
				vMenu = "upgrading,     /admin/shop/list.aspx?DIV=upgrading,        Upgrading";
				resultList.Add(vMenu);
				vMenu = "buffs,         /admin/shop/list.aspx?DIV=buffs,            Buffs";
				resultList.Add(vMenu);
				vMenu = "vanity,        /admin/shop/list.aspx?DIV=vanity,           Vanity";
				resultList.Add(vMenu);
				vMenu = "miscellaeous,  /admin/shop/list.aspx?DIV=miscellaeous,     Miscellaeous";
				resultList.Add(vMenu);

				break;
			case "Support":
				vMenu = "questions,     /admin/support/list.aspx,                   Contatct Us";
				resultList.Add(vMenu);
				vMenu = "code,          /admin/support/code/list.aspx,              Category Type";
				resultList.Add(vMenu);

				break;
			case "User":
				vMenu = "user,          /admin/user/list.aspx,        User Admin";
				resultList.Add(vMenu);
				vMenu = "password,      /admin/user/password.aspx,    Password Change";
				resultList.Add(vMenu);
				vMenu = "stat,          /admin/user/stat.aspx,        Signup User Count";
				resultList.Add(vMenu);

				break;
		}

		return resultList;
	}
}
