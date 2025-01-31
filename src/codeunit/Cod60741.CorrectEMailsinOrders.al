codeunit 60741 "Correct EMails in Orders"
{
    trigger OnRun()
    var

        ExcelImportOrdersL: Record "Excel Import Orders";
        SalesHeaderL: Record "Sales Header";
        IssueAdL: Record "Issue Ad";
    begin
        ExcelImportOrdersL.SetFilter("Liefern an Debitor", '<>%1', '');
        if ExcelImportOrdersL.FindSet() then
            repeat
                if ExcelImportOrdersL."Debitor Kontakt Email" <> '' then begin
                    if SalesHeaderL.get(SalesHeaderL."Document Type"::Order, ExcelImportOrdersL."order no") then begin
                        SalesHeaderL.validate("Sell-to E-Mail", ExcelImportOrdersL."Debitor Kontakt Email");
                        SalesHeaderL.modify(true);

                        IssueAdL.SetRange("Sales Order No.", SalesHeaderL."No.");
                        IssueAdL.SetRange(Status, IssueAdL.Status::Open);
                        if IssueAdL.FindSet(true) then
                            repeat
                                IssueAdL.Email := ExcelImportOrdersL."Debitor Kontakt Email";
                                IssueAdL.modify();
                            until IssueAdL.next() = 0;
                    end;
                end;

            until ExcelImportOrdersL.next() = 0;
    end;

    var
        myInt: Integer;
}