using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Kadi12688e
{
    public partial class Login : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["ClinicDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT Role FROM Users WHERE Username = @Username AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    // تسجيل دخول ناجح
                    Session["Username"] = txtUsername.Text.Trim();
                    Session["Role"] = result.ToString();

                    if (result.ToString() == "Admin")
                    {
                        Response.Redirect("Admin/Dashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
                else
                {
                    lblError.Text = "⚠️ اسم المستخدم أو كلمة المرور غير صحيحة.";
                    lblError.Visible = true;
                }
            }
        }
    }
}