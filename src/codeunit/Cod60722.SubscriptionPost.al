codeunit 60722 SubscriptionPost
{
    TableNo = "Sales Header";
    trigger OnRun()
    var
        SalesPostL: Codeunit "Sales-Post";
        SubscriptionsL: Record Subscriptions;
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            Rec.Ship := true;
            Rec.Invoice := true;
        end;

        SalesPostL.SetSuppressCommit(true);
        SalesPostL.Run(Rec);
    end;


}