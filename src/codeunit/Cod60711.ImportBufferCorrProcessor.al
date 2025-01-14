codeunit 60711 "Import Buffer Corr Processor"
{
    TableNo = "Import Buffer Correction";
    trigger OnRun()
    var
        SalesHeaderL: Record "Sales Header";
        SalesLineL: Record "Sales Line";
    begin
        SalesHeaderL.SetRange("External Document No.", Rec."Ext. Doc No.");
        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
        IF SalesHeaderL.FindFirst() then begin
            SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
            SalesLineL.SetRange("Document No.", SalesHeaderL."No.");
            SalesLineL.SetRange("Line No.", 10000);
            IF SalesLineL.FindFirst() then begin
                SalesLineL.Validate("No.", '5398-01-22');
                SalesLineL.Validate("Line Discount %", Rec."Line Discount");
                SalesHeaderL."Shortcut Dimension 1 Code" := SalesLineL."Shortcut Dimension 1 Code";
                SalesLineL.Modify();
                SalesHeaderL.Modify();
                Rec.Delete();
            end;
        end;
    end;

    var
        myInt: Integer;
}