using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Kadi12688e.Admin
{
    public partial class Doctors : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindSpecialtiesDropDown();
                BindGrid();
            }
        }

        private void BindSpecialtiesDropDown()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT SpecialtyID, SpecialtyName FROM Specialties", con);
                con.Open();
                ddlSpecialty.DataSource = cmd.ExecuteReader();
                ddlSpecialty.DataBind();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT D.DoctorID, D.FName, D.LName, S.SpecialtyName, D.Cell, D.Email 
                                  FROM Doctors D
                                  INNER JOIN Specialties S ON D.SpecialtyID = S.SpecialtyID";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                gvDoctors.DataSource = cmd.ExecuteReader();
                gvDoctors.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtFName.Text) && !string.IsNullOrWhiteSpace(txtLName.Text))
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"INSERT INTO Doctors (FName, LName, SpecialtyID, Cell, Email) 
                                      VALUES (@FName, @LName, @SpecialtyID, @Cell, @Email)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@FName", txtFName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LName", txtLName.Text.Trim());
                    cmd.Parameters.AddWithValue("@SpecialtyID", ddlSpecialty.SelectedValue);
                    cmd.Parameters.AddWithValue("@Cell", txtCell.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                txtFName.Text = "";
                txtLName.Text = "";
                txtCell.Text = "";
                txtEmail.Text = "";
                BindGrid();
            }
        }

        protected void gvDoctors_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvDoctors.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Doctors WHERE DoctorID = @ID", con);
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }
    }
}