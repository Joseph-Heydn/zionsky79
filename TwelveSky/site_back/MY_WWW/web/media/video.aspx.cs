using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;


namespace _12sky2.web.media
{
    public partial class video : System.Web.UI.Page
    {
        webservice.T_MEDIA_BORD T_MEDIA_BORD = new webservice.T_MEDIA_BORD();

        private static int totalCnt = 0;
        private string NAT_CD = SYS.NAT_CD;
        private string DIV = "video";

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                getList();
            }
        }
        /*********************************************************************************************************************/
        /* get list
        /*********************************************************************************************************************/
        //
        private void getList()
        {
            try
            {
                int tmpTotalCnt = T_MEDIA_BORD.getTotalCnt(DIV, NAT_CD);

                UI.paging(this, PAGING, TOTAL_PAGE, NOW_PAGE, tmpTotalCnt, int.Parse(SYS.LIST_EA));
                tmpTotalCnt = tmpTotalCnt - ((int.Parse(NOW_PAGE.Text) - 1) * int.Parse(SYS.LIST_EA));
                totalCnt = tmpTotalCnt;

                DataTable result = T_MEDIA_BORD.getList(DIV, NAT_CD, int.Parse(NOW_PAGE.Text));

                for (int i = 0; i < result.Rows.Count; i++)
                {
                    string path = result.Rows[i]["PATH"].ToString();
                    string movie_id = path.Substring(path.LastIndexOf('/'));
                    result.Rows[i]["IMG_SRC"] = "<img src='http://img.youtube.com/vi" + movie_id + "/0.jpg' width='200'/>"; 

                }
            
                LIST.DataSource = result;
                LIST.DataBind();

                if (result.Rows.Count == 0) NO_LIST.Visible = true;
                else NO_LIST.Visible = false;


                if (SYS.is_login(this.Page)) btn_reg.Visible = true;
                else btn_reg.Visible = false;
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
            }

        }
        /*********************************************************************************************************************/
        /* data list click
        /*********************************************************************************************************************/
        //
        protected void btn_list_Click(object sender, EventArgs e)
        {
            LinkButton lnkBtn = (LinkButton)sender;
            string[] REMOVE = { };
            Response.Redirect(SYS.makeURL(this, "video_r.aspx", REMOVE) + "SEQ=" + lnkBtn.CommandName);
        }
        /*********************************************************************************************************************/
        /* data write
        /*********************************************************************************************************************/
        //
        protected void btn_reg_Click(object sender, EventArgs e)
        {
            string[] REMOVE = { };
            Response.Redirect(SYS.makeURL(this, "video_w.aspx", REMOVE));
        }
    }
}
