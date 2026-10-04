<%@ Page Title="التخصصات" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Specialties.aspx.cs" Inherits="Kadi12688e.SpecialtiesPublic" %>

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
        .spec-card {
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
        .spec-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }
        .spec-icon {
            width: 56px;
            height: 56px;
            margin: 0 auto 16px;
            border-radius: 50%;
            background-color: #F7F4EE;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }
        .spec-name {
            color: #4A4238;
            font-size: 16px;
            font-weight: 600;
        }
        .spec-arrow {
            color: #B08968;
            font-size: 12px;
            margin-top: 8px;
        }
    </style>

    <div class="page-title">اختر التخصص المناسب</div>
    <div class="page-subtitle"> يرجى اختيار التخصص الطبي المراد حجز موعد فيه </div>

    <div class="cards-grid">
        <asp:Repeater ID="rptSpecialties" runat="server">
            <ItemTemplate>
                <a class="spec-card" href='<%# "DoctorsBySpecialty.aspx?id=" + Eval("SpecialtyID") %>'>
                    <div class="spec-icon">🩺</div>
                    <div class="spec-name"><%# Eval("SpecialtyName") %></div>
                    <div class="spec-arrow">اختر ←</div>
                </a>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</asp:Content>