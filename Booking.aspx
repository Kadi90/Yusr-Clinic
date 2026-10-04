<%@ Page Title="تأكيد الحجز" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="Kadi12688e.Booking" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .page-title {
            color: #4A4238;
            font-size: 24px;
            font-weight: 700;
            text-align: center;
            margin: 24px 0 6px;
        }
        .doctor-badge {
            text-align: center;
            color: #8A8172;
            font-size: 14px;
            margin-bottom: 24px;
        }
        .doctor-badge strong {
            color: #4A4238;
        }
        .booking-box {
            background-color: #FDFCFA;
            border-radius: 20px;
            padding: 32px;
            max-width: 480px;
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
        .form-group input[type=text] {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #E5E0D5;
            border-radius: 10px;
            font-size: 14px;
            text-align: right;
            background-color: #FDFCFA;
            box-sizing: border-box;
        }
        .radio-group label, .checkbox-group label {
            display: inline-block;
            margin-left: 20px;
            font-weight: 400;
            font-size: 14px;
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
        .success-msg {
            background-color: #E8F1EC;
            color: #5A8A6D;
            padding: 16px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
            display: block;
        }
    </style>

    <div class="page-title">تأكيد الحجز</div>
    <div class="doctor-badge">الحجز مع الطبيب: <strong><asp:Label ID="lblDoctorName" runat="server"></asp:Label></strong></div>

    <div class="booking-box">

        <asp:Label ID="lblMessage" runat="server" CssClass="success-msg" Visible="false"></asp:Label>

        <asp:Panel ID="pnlForm" runat="server">

            <div class="form-group">
                <label>الاسم الأول</label>
                <asp:TextBox ID="txtFName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFName" 
                    ErrorMessage="الاسم الأول مطلوب" ForeColor="#C0564E" Font-Size="12px" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>الاسم الأخير</label>
                <asp:TextBox ID="txtLName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLName" 
                    ErrorMessage="الاسم الأخير مطلوب" ForeColor="#C0564E" Font-Size="12px" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>رقم الجوال</label>
                <asp:TextBox ID="txtCell" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCell" 
                    ErrorMessage="رقم الجوال مطلوب" ForeColor="#C0564E" Font-Size="12px" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>الإيميل</label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ErrorMessage="صيغة الإيميل غير صحيحة" ForeColor="#C0564E" Font-Size="12px" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>الجنس</label>
                <div class="radio-group">
                    <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="ذكر" Value="Male" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="أنثى" Value="Female"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>

            <div class="form-group">
                <label>هل لديك حساسية من أي مما يلي؟ (اختياري)</label>
                <div class="checkbox-group">
                    <asp:CheckBoxList ID="cblAllergies" runat="server" RepeatDirection="Horizontal" RepeatColumns="2">
                        <asp:ListItem Text="بنسلين" Value="Penicillin"></asp:ListItem>
                        <asp:ListItem Text="أسبرين" Value="Aspirin"></asp:ListItem>
                        <asp:ListItem Text="مواد تخدير" Value="Anesthesia"></asp:ListItem>
                        <asp:ListItem Text="لاتكس" Value="Latex"></asp:ListItem>
                    </asp:CheckBoxList>
                </div>
            </div>

            <div class="form-group">
                <label>تاريخ الموعد</label>
                <asp:TextBox ID="txtDate" runat="server" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" 
                    ErrorMessage="التاريخ مطلوب" ForeColor="#C0564E" Font-Size="12px" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>وقت الموعد</label>
                <asp:TextBox ID="txtTime" runat="server" TextMode="Time"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTime" 
                    ErrorMessage="الوقت مطلوب" ForeColor="#C0564E" Font-Size="12px" Display="Dynamic" />
            </div>

            <asp:Button ID="btnBook" runat="server" Text="تأكيد الحجز" CssClass="btn-submit" OnClick="btnBook_Click" />

        </asp:Panel>

    </div>

</asp:Content>