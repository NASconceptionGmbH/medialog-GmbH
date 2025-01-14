report 60715 "NC-6912"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger
            OnAfterGetRecord()
            var
                CustLedgerEntryL: Record "Cust. Ledger Entry";
                SalesHeaderL: Record "Sales Header";
            begin
                CustLedgerEntryL.SetRange("Customer No.", "No.");
                IF CustLedgerEntryL.FindFirst() then
                    CurrReport.Skip();
                SalesHeaderL.SetRange("Sell-to Customer No.", "No.");
                If SalesHeaderL.FindFirst() then
                    CurrReport.Skip();
                SalesHeaderL.Reset();
                SalesHeaderL.SetRange("Bill-to Customer No.", "No.");
                IF SalesHeaderL.FindFirst() then
                    CurrReport.Skip();
                IF Delete(true) then
                    Counter += 1;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    trigger
    OnPostReport()
    begin
        Message('Anzahl Debitoren gelöscht %1', Counter);
    end;

    var
        Counter: Integer;
}