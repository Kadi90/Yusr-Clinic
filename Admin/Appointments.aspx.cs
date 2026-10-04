using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Kadi12688e.Admin
{
    public partial class Appointments : System.Web.UI.Page
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
                BindDropDowns();
                BindGrid();
            }
        }

        private void BindDropDowns()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlCommand cmdP = new SqlCommand("SELECT PatientID, (FName + ' ' + LName) AS FullName FROM Patients", con);
                ddlPatient.DataSource = cmdP.ExecuteReader();
                ddlPatient.DataBind();
                con.Close();

                con.Open();
                SqlCommand cmdD = new SqlCommand("SELECT DoctorID, (FName + ' ' + LName) AS FullName FROM Doctors", con);
                ddlDoctor.DataSource = cmdD.ExecuteReader();
                ddlDoctor.DataBind();
            }
        }

        private void BindGrid()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT A.AppointmentID, 
                                         (P.FName + ' ' + P.LName) AS PatientName, 
                                         (D.FName + ' ' + D.LName) AS DoctorName, 
                                         A.AppointmentDate, A.Status
                                  FROM Appointments A
                                  INNER JOIN Patients P ON A.PatientID = P.PatientID
                                  INNER JOIN Doctors D ON A.DoctorID = D.DoctorID
                                  ORDER BY A.AppointmentID";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            rptAppointments.DataSource = dt;
            rptAppointments.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtDate.Text))
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status) 
                                      VALUES (@PatientID, @DoctorID, @Date, @Status)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@PatientID", ddlPatient.SelectedValue);
                    cmd.Parameters.AddWithValue("@DoctorID", ddlDoctor.SelectedValue);
                    cmd.Parameters.AddWithValue("@Date", txtDate.Text);
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                txtDate.Text = "";
            }
            Response.Redirect(Request.RawUrl);
        }

        protected void rptAppointments_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                if (e.CommandName == "Delete")
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Appointments WHERE AppointmentID = @ID", con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    cmd.ExecuteNonQuery();
                }
                else if (e.CommandName == "Confirm")
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Appointments SET Status = 'Confirmed' WHERE AppointmentID = @ID", con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect(Request.RawUrl);
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"SELECT A.AppointmentID AS [الرقم], 
                                         (P.FName + ' ' + P.LName) AS [المريض], 
                                         (D.FName + ' ' + D.LName) AS [الطبيب], 
                                         A.AppointmentDate AS [التاريخ], A.Status AS [الحالة]
                                  FROM Appointments A
                                  INNER JOIN Patients P ON A.PatientID = P.PatientID
                                  INNER JOIN Doctors D ON A.DoctorID = D.DoctorID";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<table border='1'><tr style='background-color:#4A4238; color:white;'>");
            foreach (DataColumn col in dt.Columns)
                sb.Append("<th>" + col.ColumnName + "</th>");
            sb.Append("</tr>");
            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("<tr>");
                foreach (DataColumn col in dt.Columns)
                    sb.Append("<td>" + dr[col].ToString() + "</td>");
                sb.Append("</tr>");
            }
            sb.Append("</table>");

            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Appointments.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            Response.Write(sb.ToString());
            Response.End();
        }
    }
}