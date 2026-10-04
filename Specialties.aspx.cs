using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Kadi12688e
{
    public partial class SpecialtiesPublic : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSpecialties();
            }
        }

        private void BindSpecialties()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT SpecialtyID, SpecialtyName FROM Specialties", con);
                con.Open();
                rptSpecialties.DataSource = cmd.ExecuteReader();
                rptSpecialties.DataBind();
            }
        }
    }
}