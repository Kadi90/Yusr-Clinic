<%@ Page Title="لوحة التحكم" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Kadi12688e.Admin.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .page-title {
            color: #4A4238;
            font-size: 26px;
            font-weight: 700;
            text-align: center;
            margin: 30px 0 40px;
        }
        .dash-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .dash-card {
            background-color: #FDFCFA;
            border-radius: 18px;
            padding: 32px 28px;
            width: 200px;
            text-align: center;
            text-decoration: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }
        .dash-card:hover {
            transform: translateY(-4px);
        }
        .dash-icon {
            font-size: 32px;
            margin-bottom: 12px;
        }
        .dash-name {
            color: #4A4238;
            font-size: 16px;
            font-weight: 600;
        }
    </style>

    <div class="page-title">لوحة تحكم الموظف</div>

    <div class="dash-grid">
        <a class="dash-card" href="Specialties.aspx">
            <div class="dash-icon">🏷️</div>
            <div class="dash-name">إدارة التخصصات</div>
        </a>
        <a class="dash-card" href="Doctors.aspx">
            <div class="dash-icon">👨‍⚕️</div>
            <div class="dash-name">إدارة الأطباء</div>
        </a>
        <a class="dash-card" href="Patients.aspx">
            <div class="dash-icon">🧑</div>
            <div class="dash-name">إدارة المرضى</div>
        </a>
        <a class="dash-card" href="Appointments.aspx">
            <div class="dash-icon">📅</div>
            <div class="dash-name">إدارة المواعيد</div>
        </a>
    </div>

</asp:Content>