using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Kadi12688e.Admin
{
    public partial class Specialties : System.Web.UI.Page
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
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT SpecialtyID, SpecialtyName FROM Specialties", con);
                con.Open();
                gvSpecialties.DataSource = cmd.ExecuteReader();
                gvSpecialties.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtSpecialtyName.Text))
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("INSERT INTO Specialties (SpecialtyName) VALUES (@Name)", con);
                    cmd.Parameters.AddWithValue("@Name", txtSpecialtyName.Text.Trim());
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                txtSpecialtyName.Text = "";
                BindGrid();
            }
        }

        protected void gvSpecialties_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvSpecialties.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Specialties WHERE SpecialtyID = @ID", con);
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }

        protected void gvSpecialties_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSpecialties.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvSpecialties_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSpecialties.EditIndex = -1;
            BindGrid();
        }

        protected void gvSpecialties_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvSpecialties.DataKeys[e.RowIndex].Value);
            TextBox txtName = (TextBox)gvSpecialties.Rows[e.RowIndex].Cells[1].Controls[0];

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Specialties SET SpecialtyName = @Name WHERE SpecialtyID = @ID", con);
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            gvSpecialties.EditIndex = -1;
            BindGrid();
        }
    }
}