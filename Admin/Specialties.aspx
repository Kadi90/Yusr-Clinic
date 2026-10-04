<%@ Page Title="التخصصات" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Specialties.aspx.cs" Inherits="Kadi12688e.Admin.Specialties" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .page-title {
            color: #4A4238;
            font-size: 22px;
            font-weight: 600;
            margin: 20px 0;
            text-align: right;
        }
        .add-form {
            background-color: #F7F4EE;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            display: flex;
            gap: 12px;
            align-items: center;
        }
        .add-form input[type=text] {
            flex: 1;
            padding: 10px 14px;
            border: 1px solid #E5E0D5;
            border-radius: 8px;
            font-size: 14px;
            text-align: right;
        }
        .add-form input[type=submit] {
            background-color: #4A4238;
            color: #F7F4EE;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
        }
        .grid-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #FDFCFA;
            border-radius: 12px;
            overflow: hidden;
        }
        .grid-table th {
            background-color: #F7F4EE;
            color: #4A4238;
            padding: 14px;
            text-align: right;
            font-size: 13px;
        }
        .grid-table td {
            padding: 12px 14px;
            border-top: 1px solid #E5E0D5;
            color: #4A4238;
            font-size: 13px;
            text-align: right;
        }
        .grid-table a {
            color: #8A8172;
            text-decoration: none;
            margin-left: 10px;
            font-size: 13px;
        }
    </style>

    <div class="page-title">إدارة التخصصات</div>

    <div class="add-form">
        <asp:TextBox ID="txtSpecialtyName" runat="server" placeholder="اسم التخصص الجديد"></asp:TextBox>
        <asp:Button ID="btnAdd" runat="server" Text="إضافة" OnClick="btnAdd_Click" />
    </div>

    <asp:GridView ID="gvSpecialties" runat="server" 
        CssClass="grid-table" AutoGenerateColumns="false"
        DataKeyNames="SpecialtyID"
        OnRowDeleting="gvSpecialties_RowDeleting"
        OnRowEditing="gvSpecialties_RowEditing"
        OnRowUpdating="gvSpecialties_RowUpdating"
        OnRowCancelingEdit="gvSpecialties_RowCancelingEdit">
        <Columns>
            <asp:BoundField DataField="SpecialtyID" HeaderText="الرقم" ReadOnly="true" />
            <asp:BoundField DataField="SpecialtyName" HeaderText="اسم التخصص" />
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" 
                EditText="تعديل" DeleteText="حذف" CancelText="إلغاء" UpdateText="حفظ" />
        </Columns>
    </asp:GridView>

</asp:Content>
