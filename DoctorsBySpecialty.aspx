<%@ Page Title="الأطباء" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DoctorsBySpecialty.aspx.cs" Inherits="Kadi12688e.DoctorsBySpecialty" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .page-title {
            color: #4A4238;
            font-size: 26px;
            font-weight: 700;
            text-align: center;
            margin: 30px 0 10px;
        }
        .page-subtitle {
            color: #8A8172;
            font-size: 14px;
            text-align: center;
            margin-bottom: 32px;
        }
        .cards-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .doc-card {
            background-color: #FDFCFA;
            border-radius: 18px;
            padding: 28px 24px;
            width: 220px;
            text-align: center;
            text-decoration: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
            display: block;
        }
        .doc-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }
        .doc-avatar {
            width: 64px;
            height: 64px;
            margin: 0 auto 16px;
            border-radius: 50%;
            background-color: #F7F4EE;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
        }
        .doc-name {
            color: #4A4238;
            font-size: 16px;
            font-weight: 600;
        }
        .doc-specialty {
            color: #8A8172;
            font-size: 12px;
            margin-top: 4px;
        }
        .doc-arrow {
            color: #B08968;
            font-size: 12px;
            margin-top: 12px;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #8A8172;
            font-size: 13px;
            text-decoration: none;
        }
    </style>

    <a href="Specialties.aspx" class="back-link">→ رجوع للتخصصات</a>

    <div class="page-title">الأطباء المتاحين</div>
    <div class="page-subtitle">اختر الطبيب المناسب لك</div>

    <div class="cards-grid">
        <asp:Repeater ID="rptDoctors" runat="server">
            <ItemTemplate>
                <a class="doc-card" href='<%# "Booking.aspx?doctorId=" + Eval("DoctorID") %>'>
                    <div class="doc-avatar">👨‍⚕️</div>
                    <div class="doc-name"><%# Eval("FullName") %></div>
                    <div class="doc-specialty"><%# Eval("SpecialtyName") %></div>
                    <div class="doc-arrow">احجز مع هذا الطبيب ←</div>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Content>