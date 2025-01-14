codeunit 60726 Tempcleanup
{
    Permissions = tabledata "Sales Invoice Header" = rimd, tabledata "Job Queue Entry" = rimd;

    trigger OnRun()
    var
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        JobQueueEntryL: Record "Job Queue Entry";
        JobQueueEntry2L: Record "Job Queue Entry";

    begin
        JobQueueEntryL.SetRange("Object ID to Run", 260);
        if JobQueueEntryL.FindSet() then
            repeat
                JobQueueEntry2L.get(JobQueueEntryL.ID);
                JobQueueEntry2L.SetStatus(JobQueueEntry2L.Status::"On Hold");
                JobQueueEntry2L.delete(false);
            until JobQueueEntryL.Next() = 0;


        SalesInvoiceHeaderL.SetRange("Subscription Order", true);
        SalesInvoiceHeaderL.SetFilter("Posting Date", '07.11.2024');
        if SalesInvoiceHeaderL.FindSet() then begin
            SalesInvoiceHeaderL.ModifyAll("Subscription Email Sent", false, false);
            SalesInvoiceHeaderL.ModifyAll("Subscription Email Error", '', false);
            SalesInvoiceHeaderL.ModifyAll("No. Printed", 0, false);
        end;
    end;


}