<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Kadi12688e._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .hero-section {
        background-color: #F7F4EE;
        border-radius: 16px;
        padding: 60px 24px;
        text-align: center;
        margin: 20px 0;
    }
    .hero-icon {
        width: 52px;
        height: 52px;
        margin: 0 auto 18px;
        border-radius: 50%;
        background-color: #FDFCFA;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .hero-title {
        font-size: 26px;
        font-weight: 600;
        color: #4A4238;
    }
    .hero-subtitle {
        font-size: 14px;
        color: #8A8172;
        margin-top: 14px;
    }
    .hero-button {
        margin-top: 26px;
        background-color: #4A4238;
        color: #F7F4EE;
        border: none;
        padding: 12px 32px;
        border-radius: 24px;
        font-size: 14px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
    }
</style>

<div class="hero-section">
    <div class="hero-title">صحتك تبدأ بيُسر</div>
    <div class="hero-subtitle">احجزي موعدك مع أفضل الأطباء بخطوات بسيطة وسريعة</div>
    <a href="Specialties.aspx" class="hero-button">احجز الآن</a>
</div>
  <style>
    .about-section {
        background-color: #FDFCFA;
        border-radius: 16px;
        overflow: hidden;
        margin: 20px 0;
        border: 1px solid #E5E0D5;
    }
    .accordion-item {
        border-bottom: 1px solid #E5E0D5;
        padding: 0;
    }
    .accordion-item:last-child {
        border-bottom: none;
    }
    .accordion-item summary {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 18px 20px;
        cursor: pointer;
        color: #4A4238;
        font-size: 15px;
        font-weight: 500;
        list-style: none;
    }
    .accordion-item summary::-webkit-details-marker {
        display: none;
    }
    .accordion-item summary::after {
        content: "+";
        color: #8A8172;
        font-size: 20px;
    }
    .accordion-item[open] summary::after {
        content: "−";
    }
    .accordion-item p {
        padding: 0 20px 18px;
        margin: 0;
        color: #8A8172;
        font-size: 13px;
        line-height: 1.9;
    }
</style>

<div class="about-section">

    <details class="accordion-item">
        <summary>عن العيادة</summary>
        <p>عيادة يسر تقدم رعاية طبية متكاملة بأيدي نخبة من الأطباء المتخصصين، بهدف تسهيل رحلتك الصحية من أول خطوة.</p>
    </details>

    <details class="accordion-item">
        <summary>ساعات العمل</summary>
        <p>السبت - الخميس: 9 صباحاً - 9 مساءً<br />الجمعة: مغلق</p>
    </details>

    <details class="accordion-item">
        <summary>وسائل التواصل</summary>
        <p>هاتف: 920001234<br />البريد: info@yusrclinic.com</p>
    </details>

</div>
</asp:Content>
