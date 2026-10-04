using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Kadi12688e
{
    public partial class DoctorsBySpecialty : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string specialtyId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(specialtyId))
                {
                    BindDoctors(specialtyId);
                }
            }
        }

        private void BindDoctors(string specialtyId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT D.DoctorID, (D.FName + ' ' + D.LName) AS FullName, S.SpecialtyName
                                  FROM Doctors D
                                  INNER JOIN Specialties S ON D.SpecialtyID = S.SpecialtyID
                                  WHERE D.SpecialtyID = @SpecialtyID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@SpecialtyID", specialtyId);
                con.Open();
                rptDoctors.DataSource = cmd.ExecuteReader();
                rptDoctors.DataBind();
            }
        }
    }
}