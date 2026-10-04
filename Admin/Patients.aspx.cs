using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Kadi12688e.Admin
{
    public partial class Patients : System.Web.UI.Page
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
                SqlCommand cmd = new SqlCommand("SELECT PatientID, FName, LName, Cell, Email, Gender FROM Patients", con);
                con.Open();
                gvPatients.DataSource = cmd.ExecuteReader();
                gvPatients.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtFName.Text) && !string.IsNullOrWhiteSpace(txtLName.Text))
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"INSERT INTO Patients (FName, LName, Cell, Email, Gender) 
                                      VALUES (@FName, @LName, @Cell, @Email, @Gender)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@FName", txtFName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LName", txtLName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Cell", txtCell.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
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

        protected void gvPatients_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvPatients.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Patients WHERE PatientID = @ID", con);
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }

        protected void gvPatients_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPatients.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvPatients_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPatients.EditIndex = -1;
            BindGrid();
        }

        protected void gvPatients_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvPatients.DataKeys[e.RowIndex].Value);
            TextBox txtF = (TextBox)gvPatients.Rows[e.RowIndex].Cells[1].Controls[0];
            TextBox txtL = (TextBox)gvPatients.Rows[e.RowIndex].Cells[2].Controls[0];
            TextBox txtC = (TextBox)gvPatients.Rows[e.RowIndex].Cells[3].Controls[0];
            TextBox txtE = (TextBox)gvPatients.Rows[e.RowIndex].Cells[4].Controls[0];
            TextBox txtG = (TextBox)gvPatients.Rows[e.RowIndex].Cells[5].Controls[0];

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"UPDATE Patients SET FName=@FName, LName=@LName, Cell=@Cell, Email=@Email, Gender=@Gender 
                                  WHERE PatientID=@ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FName", txtF.Text.Trim());
                cmd.Parameters.AddWithValue("@LName", txtL.Text.Trim());
                cmd.Parameters.AddWithValue("@Cell", txtC.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtE.Text.Trim());
                cmd.Parameters.AddWithValue("@Gender", txtG.Text.Trim());
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            gvPatients.EditIndex = -1;
            BindGrid();
        }
    }
}