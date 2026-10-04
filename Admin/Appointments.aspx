<%@ Page Title="إدارة المواعيد" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Appointments.aspx.cs" Inherits="Kadi12688e.Admin.Appointments" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .page-title { color: #4A4238; font-size: 24px; font-weight: 700; margin: 24px 0; text-align: right; }
        .add-form { background: linear-gradient(135deg, #F7F4EE, #F1EBE0); border-radius: 16px; padding: 24px; margin-bottom: 24px; display: flex; flex-wrap: wrap; gap: 12px; align-items: center; }
        .add-form input[type=text], .add-form select { flex: 1; min-width: 140px; padding: 12px 16px; border: 1px solid #E5E0D5; border-radius: 10px; font-size: 14px; text-align: right; background-color: #FDFCFA; }
        .export-bar { text-align: left; margin-bottom: 16px; }
        .btn-export { background-color: #4A4238; color: #F7F4EE; border: none; padding: 10px 24px; border-radius: 10px; cursor: pointer; font-size: 14px; font-weight: 600; }
        .grid-table { width: 100%; border-collapse: separate; border-spacing: 0; background-color: #FDFCFA; border-radius: 16px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
        .grid-table th { background-color: #4A4238; color: #F7F4EE; padding: 16px; text-align: right; font-size: 13px; }
        .grid-table td { padding: 14px 16px; border-top: 1px solid #F1EBE0; color: #4A4238; font-size: 13px; text-align: right; }
        .btn-action { background: none; border: none; color: #5A8A6D; text-decoration: underline; cursor: pointer; font-size: 13px; padding: 4px 8px; }
        .btn-action.danger { color: #C0564E; }
    </style>

    <div class="page-title">إدارة المواعيد</div>

    <div class="export-bar">
        <asp:Button ID="btnExport" runat="server" Text="📊 تصدير Excel" OnClick="btnExport_Click" CssClass="btn-export" />
    </div>

    <div class="add-form">
        <asp:DropDownList ID="ddlPatient" runat="server" DataTextField="FullName" DataValueField="PatientID"></asp:DropDownList>
        <asp:DropDownList ID="ddlDoctor" runat="server" DataTextField="FullName" DataValueField="DoctorID"></asp:DropDownList>
        <asp:TextBox ID="txtDate" runat="server" TextMode="DateTime" placeholder="تاريخ الموعد"></asp:TextBox>
        <asp:DropDownList ID="ddlStatus" runat="server">
            <asp:ListItem Text="بانتظار" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="مؤكد" Value="Confirmed"></asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnAdd" runat="server" Text="إضافة" OnClick="btnAdd_Click" />
    </div>

    <table class="grid-table">
        <tr>
            <th>الرقم</th><th>المريض</th><th>الطبيب</th><th>التاريخ</th><th>الحالة</th><th></th><th></th>
        </tr>
        <asp:Repeater ID="rptAppointments" runat="server" OnItemCommand="rptAppointments_ItemCommand">
            <ItemTemplate>
                <tr>
                    <td><%# Eval("AppointmentID") %></td>
                    <td><%# Eval("PatientName") %></td>
                    <td><%# Eval("DoctorName") %></td>
                    <td><%# Eval("AppointmentDate", "{0:yyyy-MM-dd HH:mm}") %></td>
                    <td><%# Eval("Status") %></td>
                    <td>
                        <asp:LinkButton runat="server" CssClass="btn-action" Text="تأكيد" 
                            CommandName="Confirm" CommandArgument='<%# Eval("AppointmentID") %>' />
                    </td>
                    <td>
                        <asp:LinkButton runat="server" CssClass="btn-action danger" Text="حذف" 
                            CommandName="Delete" CommandArgument='<%# Eval("AppointmentID") %>' />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>

</asp:Content>