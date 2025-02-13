codeunit 60736 "Update Prices"
{
    trigger OnRun()
    var
        SalesHeaderL: Record "Sales Header";
        SalesLineL: Record "Sales Line";
    begin
        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
        SalesHeaderL.SetRange("order state", 'fakturiert');
        if SalesHeaderL.FindSet() then
            repeat
                SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
                SalesLineL.SetRange("Document No.", SalesHeaderL."No.");
                SalesLineL.SetRange(Type, SalesLineL.Type::Item);
                if SalesLineL.FindSet() then
                    repeat
                        SalesLineL.validate("Unit Price", 0);
                        SalesLineL.modify();
                    until SalesLineL.next() = 0;
            until SalesHeaderL.next() = 0;
    end;

    var
        myInt: Integer;
}