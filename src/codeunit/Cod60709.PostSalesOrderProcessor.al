codeunit 60709 "Post Sales Order Processor"
{
    TableNo = "Sales Header";
    trigger OnRun()
    begin

        Rec.Ship := true;
        Rec.Invoice := true;
        CODEUNIT.Run(CODEUNIT::"Sales-Post", Rec);
    end;

    var
        myInt: Integer;
}