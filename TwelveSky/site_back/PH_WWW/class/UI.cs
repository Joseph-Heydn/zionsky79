using System.Data;
using System.Web.UI;
using System.Data.Common;
using System.Web.UI.WebControls;

public class UI {
	/*********************************************************************************************************************/
	/*	페이징
    /*********************************************************************************************************************/
	// [코드셋팅]
	public static void paging(Page PAGE, Repeater target, Label TOTAL_PAGE, Label NOW_PAGE, int TOTAL_CNT, int LIST_CNT) {
		try {
			if ( !SYS.is_null(PAGE.Request.QueryString["PAGE"]) )
				NOW_PAGE.Text = PAGE.Request.QueryString["PAGE"].ToString();

			if ( SYS.is_null(NOW_PAGE.Text) )
				NOW_PAGE.Text = "1";
			int tmpNOW_PAGE = int.Parse(NOW_PAGE.Text);

			int pageCnt = 10; // 페이징 갯수 대부분 10개 기본
			bool is_first_btn = false; // 첫 페이지 가는 버튼
			bool is_prev_btn = false; // 10 페이지 전 버튼
			bool is_next_btn = false; // 10 페이지 후 버튼
			bool is_last_btn = false; // 끝 페이지 가는 버튼

			int totalPageCnt = TOTAL_CNT/LIST_CNT;
			int namerge = TOTAL_CNT%LIST_CNT;
			if ( namerge > 0 )
				totalPageCnt++;
			//if (namerge == 0) totalPageCnt = totalPageCnt;
			if ( totalPageCnt <= 0 )
				totalPageCnt = 1;

			if ( totalPageCnt != 0 ) {
				if ( tmpNOW_PAGE < 0 || tmpNOW_PAGE > totalPageCnt ) {
					if ( SYS.is_pop(PAGE) )
						SYS.Javascript(PAGE, "alert('잘못된 접근입니다!');self.close();");
					else
						SYS.Javascript(PAGE, "alert('잘못된 접근입니다!');history.back();");
					return;
				}
			}

			if ( totalPageCnt > 10 && tmpNOW_PAGE > 10 ) {
				if ( tmpNOW_PAGE > 10 )
					is_first_btn = true;
				is_prev_btn = true;
			}

			int nowId = (tmpNOW_PAGE/pageCnt);
			namerge = tmpNOW_PAGE%pageCnt;
			if ( namerge == 0 )
				nowId--;

			int startNo = (nowId*pageCnt) + 1;

			int btnEa = totalPageCnt - startNo + 1;
			if ( btnEa > 10 )
				btnEa = 10;

			int endNo = startNo + btnEa;

			if ( (totalPageCnt - endNo) >= 0 ) {
				is_next_btn = true;
				if ( (totalPageCnt - endNo) > pageCnt )
					is_last_btn = true;
			}

			if ( TOTAL_CNT == 0 )
				NOW_PAGE.Text = "1";
			TOTAL_PAGE.Text = totalPageCnt.ToString();

			DataTable result = new DataTable("DataTable");
			DataRow row = result.NewRow();

			result.Columns.Add(new DataColumn("PAGE", typeof(string)));

			int goPage = 0;

			string[] REMOVE = {"PAGE", "SORT_KEY", "SORY_BY"};
			string goURL = SYS.makeURL(PAGE, PAGE.Request.Path, REMOVE) + "PAGE=";

			if ( is_first_btn ) {
				goPage = 1;
				row = result.NewRow();
				row["PAGE"] = "<a href='" + goURL + goPage + "' class='btn prev'><img src='/resources/images/pagging/btnFirst.gif' alt='Go to first page' /><span class='lebel'>처음</span></a>";
				result.Rows.Add(row);
			}

			if ( is_prev_btn ) {
				goPage = tmpNOW_PAGE - 10;
				if ( goPage < 1 )
					goPage = 1;
				row = result.NewRow();
				row["PAGE"] = "<a href='" + goURL + goPage + "' class='btn pre'><img src='/resources/images/pagging/btnPrev.gif' alt='Go to before page " + pageCnt + "' /><span class='lebel'>이전</span></a>";
				result.Rows.Add(row);
			}

			for ( int i = startNo; i < endNo; i++ ) {
				goPage = i;
				row = result.NewRow();
				if ( i == tmpNOW_PAGE )
					row["PAGE"] = "<a href='#' class='on'>" + i.ToString() + "</a>";
				else
					row["PAGE"] = "<a href='" + goURL + goPage + "'>" + i.ToString() + "</a>";

				result.Rows.Add(row);
			}

			if ( is_next_btn ) {
				goPage = tmpNOW_PAGE + 10;
				if ( goPage > totalPageCnt )
					goPage = totalPageCnt;
				row = result.NewRow();
				row["PAGE"] = "<a href='" + goURL + goPage + "' class='btn nex'><img src='/resources/images/pagging/btnNext.gif' alt='Go to after page " + pageCnt + "' /><span class='lebel'>다음</span></a>";
				result.Rows.Add(row);
			}

			if ( is_last_btn ) {
				goPage = totalPageCnt;
				row = result.NewRow();
				row["PAGE"] = "<a href='" + goURL + goPage + "' class='btn next'><img src='/resources/images/pagging/btnLast.gif' alt='Go to last page' /><span class='lebel'>끝</span></a>";
				result.Rows.Add(row);
			}

			target.DataSource = result;
			target.DataBind();
		} catch ( DbException err ) {
			SYS.Save_Log(err.Message);
		}
	}
}
