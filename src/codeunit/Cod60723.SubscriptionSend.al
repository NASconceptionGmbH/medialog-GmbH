codeunit 60723 SubscriptionSend
{
    TableNo = "Sales Invoice Header";


    trigger OnRun()
    var
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        ReportSelectionsL: Record "Report Selections";
    begin
        // Rec.EmailRecords(false);
        // Rec.SendRecords();

        SalesInvoiceHeaderL.SetRange("No.", Rec."No.");
        SalesInvoiceHeaderL.FindFirst();
        SalesInvoiceHeaderL.EmailRecords(false);
    end;

}