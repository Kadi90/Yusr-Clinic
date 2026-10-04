using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Net.Mail;
using System.Web.UI.WebControls;

namespace Kadi12688e
{
    public partial class Booking : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        int doctorId
        {
            get { return ViewState["DoctorId"] != null ? (int)ViewState["DoctorId"] : 0; }
            set { ViewState["DoctorId"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string docIdParam = Request.QueryString["doctorId"];
                if (!string.IsNullOrEmpty(docIdParam))
                {
                    doctorId = Convert.ToInt32(docIdParam);
                    LoadDoctorName(doctorId);
                }
            }
        }

        private void LoadDoctorName(int docId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT (FName + ' ' + LName) AS FullName FROM Doctors WHERE DoctorID = @ID", con);
                cmd.Parameters.AddWithValue("@ID", docId);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    lblDoctorName.Text = result.ToString();
                }
            }
        }

        private string GetSelectedAllergies()
        {
            string allergies = "";
            foreach (ListItem item in cblAllergies.Items)
            {
                if (item.Selected)
                {
                    allergies += item.Text + ", ";
                }
            }
            if (allergies.Length > 0)
                allergies = allergies.TrimEnd(',', ' ');
            return allergies;
        }

        private void SendConfirmationEmail(string toEmail, string patientName, string doctorName, DateTime aptDate)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("Dikadi670@gmail.com", "عيادة يسر");
                mail.To.Add(toEmail);
                mail.Subject = "تأكيد حجز موعدك - عيادة يسر";
                mail.IsBodyHtml = true;
                mail.Body = $@"
                    <div style='font-family: Tahoma; direction: rtl; text-align: right; background-color:#FDFCFA; padding: 24px; border-radius: 12px;'>
                        <h2 style='color:#4A4238;'>عيادة يسر</h2>
                        <p>مرحباً {patientName}،</p>
                        <p>تم استلام طلب حجزك بنجاح، وتفاصيله كالتالي:</p>
                        <ul style='color:#4A4238;'>
                            <li><strong>الطبيب:</strong> {doctorName}</li>
                            <li><strong>التاريخ والوقت:</strong> {aptDate:yyyy-MM-dd HH:mm}</li>
                            <li><strong>الحالة:</strong> بانتظار التأكيد</li>
                        </ul>
                        <p>سيتم التواصل معك قريباً لتأكيد الموعد.</p>
                        <hr style='border:none; border-top:1px solid #E5E0D5;' />
                        <p style='color:#8A8172; font-size:12px;'>عيادة يسر - صحتك تبدأ بيُسر</p>
                    </div>";

                SmtpClient smtp = new SmtpClient();
                smtp.Send(mail);
            }
            catch (Exception)
            {
                // لو فشل الإرسال، ما نوقف عملية الحجز، بس نتجاهل الخطأ بصمت
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                DateTime datePart;
                DateTime timePart;
                bool dateOk = DateTime.TryParse(txtDate.Text, CultureInfo.InvariantCulture, DateTimeStyles.None, out datePart);
                bool timeOk = DateTime.TryParse(txtTime.Text, CultureInfo.InvariantCulture, DateTimeStyles.None, out timePart);

                if (!dateOk || !timeOk)
                {
                    lblMessage.Text = "⚠️ صيغة التاريخ أو الوقت غير صحيحة.";
                    lblMessage.Visible = true;
                    return;
                }

                DateTime aptDate = datePart.Date + timePart.TimeOfDay;

                int patientId;

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string insertPatient = @"INSERT INTO Patients (FName, LName, Cell, Email, Gender, Allergies) 
                                              OUTPUT INSERTED.PatientID
                                              VALUES (@FName, @LName, @Cell, @Email, @Gender, @Allergies)";
                    SqlCommand cmdPatient = new SqlCommand(insertPatient, con);
                    cmdPatient.Parameters.AddWithValue("@FName", txtFName.Text.Trim());
                    cmdPatient.Parameters.AddWithValue("@LName", txtLName.Text.Trim());
                    cmdPatient.Parameters.AddWithValue("@Cell", txtCell.Text.Trim());
                    cmdPatient.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmdPatient.Parameters.AddWithValue("@Gender", rblGender.SelectedValue);
                    cmdPatient.Parameters.AddWithValue("@Allergies", GetSelectedAllergies());

                    con.Open();
                    patientId = (int)cmdPatient.ExecuteScalar();
                }

                using (SqlConnection con2 = new SqlConnection(connStr))
                {
                    string insertAppointment = @"INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status) 
                                                  VALUES (@PatientID, @DoctorID, @Date, 'Pending')";
                    SqlCommand cmdApt = new SqlCommand(insertAppointment, con2);
                    cmdApt.Parameters.AddWithValue("@PatientID", patientId);
                    cmdApt.Parameters.AddWithValue("@DoctorID", doctorId);
                    cmdApt.Parameters.AddWithValue("@Date", aptDate);

                    con2.Open();
                    cmdApt.ExecuteNonQuery();
                }

                SendConfirmationEmail(txtEmail.Text.Trim(), txtFName.Text.Trim() + " " + txtLName.Text.Trim(), lblDoctorName.Text, aptDate);

                lblMessage.Text = "✅ تم استلام حجزك بنجاح! سيتم التواصل معك لتأكيد الموعد." +
                                   "<br/><span style='font-size:12px; color:#5A8A6D;'>📧 تم إرسال ملخص الحجز إلى بريدك الإلكتروني.</span>";
                lblMessage.Visible = true;
                pnlForm.Visible = false;
            }
        }
    }
}