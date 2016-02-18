using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace _12sky2.admin.support.code
{
    public partial class cd : System.Web.UI.Page
    {
        webservice.T_QUST_CD T_QUST_CD = new webservice.T_QUST_CD();
        private string NAT_CD = SYS.NAT_CD;

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] KEY = { };
            if (!SYS.is_check(this.Page, KEY)) return;

            if (!IsPostBack)
            {
                setParentCode();
            }
        }
        /*********************************************************************************************************************/
        /* setParentCode
        /*********************************************************************************************************************/
        //
        private void setParentCode()
        {
            try
            {
                DataTable result = T_QUST_CD.getList("0", NAT_CD);

                UP_CD_NO.Items.Clear();
                for (int i = 0; i < result.Rows.Count; i++)
                {
                    ListItem item = new ListItem();
                    item.Value = result.Rows[i]["CD_NO"].ToString();
                    item.Text = result.Rows[i]["CD_NM"].ToString();
                    UP_CD_NO.Items.Add(item);
                }
            }
            catch (Exception ex)
            {
                //SYS.Save_Log(ex.Message);
                SYS.errScript(this);
            }
            finally { }
        }
        /*********************************************************************************************************************/
        /* save
        /*********************************************************************************************************************/
        //
        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                T_QUST_CD.insert(CD_NM.Text, UP_CD_NO.SelectedValue, Session["USER_ID"].ToString(), NAT_CD);

                string[] REMOVE = { };
                SYS.Javascript(this.Page, "if(opener) {opener.location.reload();}self.close();");
            }
            catch (Exception ex)
            {
                SYS.Javascript(this.Page, "alert('Failed to save!');");
            }

        }
    }
}
