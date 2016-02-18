using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.Launcher.List02
{
    public partial class index : System.Web.UI.Page
    {
        webservice.T_NOTI_BORD T_NOTI_BORD = new webservice.T_NOTI_BORD();
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getList();
            }
        }

        private void getList()
        {
            DataTable result1 = T_NOTI_BORD.getTop4List("announcement", NAT_CD);

            LIST1.DataSource = result1;
            LIST1.DataBind();

            DataTable result2 = T_NOTI_BORD.getTop4List("notice", NAT_CD);

            LIST2.DataSource = result2;
            LIST2.DataBind();
        }
    }
}
