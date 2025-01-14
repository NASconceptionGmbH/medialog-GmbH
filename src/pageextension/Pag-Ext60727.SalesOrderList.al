pageextension 60727 SalesOrderList extends "Sales Order List"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Subscription No."; Rec."Subscription No.")
            {
                ApplicationArea = All;
            }
            field("Subscription Order"; Rec."Subscription Order")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Sell-to Customer Name")
        {
            field("Remaining Amount"; CalculateRemainingAmounttoInvoice())
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Remaining Amount to Invoice';
            }
        }
    }

    local procedure CalculateRemainingAmounttoInvoice(): Decimal
    var
        SalesLineL: Record "Sales Line";
        RemainingAmounttoInvoiceL: Decimal;
    begin
        SalesLineL.SetRange("Document Type", Rec."Document Type"::Order);
        SalesLineL.SetRange("Document No.", Rec."No.");
        SalesLineL.SetRange(Type, SalesLineL.Type::Item);
        if SalesLineL.FindSet() then
            if SalesLineL.Quantity <= SalesLineL."Quantity Invoiced" then
                exit else
                repeat
                    if SalesLineL.Quantity > 0 then
                        RemainingAmounttoInvoiceL += (SalesLineL.Amount * SalesLineL."Outstanding Quantity" / SalesLineL.Quantity);
                until SalesLineL.Next() = 0;
        exit(RemainingAmounttoInvoiceL);
    end;
}