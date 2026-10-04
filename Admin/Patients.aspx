<%@ Page Title="إدارة المرضى" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Patients.aspx.cs" Inherits="Kadi12688e.Admin.Patients" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .page-title {
            color: #4A4238;
            font-size: 24px;
            font-weight: 700;
            margin: 24px 0;
            text-align: right;
        }
        .add-form {
            background: linear-gradient(135deg, #F7F4EE, #F1EBE0);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            align-items: center;
        }
        .add-form input[type=text], .add-form select {
            flex: 1;
            min-width: 130px;
            padding: 12px 16px;
            border: 1px solid #E5E0D5;
            border-radius: 10px;
            font-size: 14px;
            text-align: right;
            background-color: #FDFCFA;
        }
        .add-form input[type=submit] {
            background-color: #4A4238;
            color: #F7F4EE;
            border: none;
            padding: 12px 28px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
        }
        .grid-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: #FDFCFA;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .grid-table th {
            background-color: #4A4238;
            color: #F7F4EE;
            padding: 16px;
            text-align: right;
            font-size: 13px;
        }
        .grid-table td {
            padding: 14px 16px;
            border-top: 1px solid #F1EBE0;
            color: #4A4238;
            font-size: 13px;
            text-align: right;
        }
        .grid-table a {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            text-decoration: none;
            margin-left: 8px;
            font-size: 12px;
            font-weight: 600;
        }
    </style>

    <div class="page-title">إدارة المرضى</div>

    <div class="add-form">
        <asp:TextBox ID="txtFName" runat="server" placeholder="الاسم الأول"></asp:TextBox>
        <asp:TextBox ID="txtLName" runat="server" placeholder="الاسم الأخير"></asp:TextBox>
        <asp:TextBox ID="txtCell" runat="server" placeholder="الجوال"></asp:TextBox>
        <asp:TextBox ID="txtEmail" runat="server" placeholder="الإيميل"></asp:TextBox>
        <asp:DropDownList ID="ddlGender" runat="server">
            <asp:ListItem Text="ذكر" Value="Male"></asp:ListItem>
            <asp:ListItem Text="أنثى" Value="Female"></asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnAdd" runat="server" Text="إضافة" OnClick="btnAdd_Click" />
    </div>

    <asp:GridView ID="gvPatients" runat="server" 
        CssClass="grid-table" AutoGenerateColumns="false"
        DataKeyNames="PatientID"
        OnRowDeleting="gvPatients_RowDeleting"
        OnRowEditing="gvPatients_RowEditing"
        OnRowUpdating="gvPatients_RowUpdating"
        OnRowCancelingEdit="gvPatients_RowCancelingEdit">
        <Columns>
            <asp:BoundField DataField="PatientID" HeaderText="الرقم" ReadOnly="true" />
            <asp:BoundField DataField="FName" HeaderText="الاسم الأول" />
            <asp:BoundField DataField="LName" HeaderText="الاسم الأخير" />
            <asp:BoundField DataField="Cell" HeaderText="الجوال" />
            <asp:BoundField DataField="Email" HeaderText="الإيميل" />
            <asp:BoundField DataField="Gender" HeaderText="الجنس" />
            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" 
                EditText="تعديل" DeleteText="حذف" CancelText="إلغاء" UpdateText="حفظ" />
        </Columns>
    </asp:GridView>

</asp:Content>