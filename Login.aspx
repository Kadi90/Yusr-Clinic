<%@ Page Title="تسجيل الدخول" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Kadi12688e.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .page-title {
            color: #4A4238;
            font-size: 24px;
            font-weight: 700;
            text-align: center;
            margin: 40px 0 24px;
        }
        .login-box {
            background-color: #FDFCFA;
            border-radius: 20px;
            padding: 32px;
            max-width: 380px;
            margin: 0 auto;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            color: #4A4238;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 8px;
            text-align: right;
        }
        .form-group input[type=text], .form-group input[type=password] {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #E5E0D5;
            border-radius: 10px;
            font-size: 14px;
            text-align: right;
            background-color: #FDFCFA;
            box-sizing: border-box;
        }
        .btn-submit {
            width: 100%;
            background-color: #4A4238;
            color: #F7F4EE;
            border: none;
            padding: 14px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            margin-top: 10px;
        }
        .error-msg {
            background-color: #FBEAE8;
            color: #C0564E;
            padding: 12px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 16px;
            font-size: 13px;
            display: block;
        }
    </style>

    <div class="page-title">تسجيل دخول الموظفين</div>

    <div class="login-box">

        <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false"></asp:Label>

        <div class="form-group">
            <label>اسم المستخدم</label>
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>كلمة المرور</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="تسجيل الدخول" CssClass="btn-submit" OnClick="btnLogin_Click" />

    </div>

</asp:Content>