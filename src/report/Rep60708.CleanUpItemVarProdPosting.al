report 60708 "CleanUp ItemVar. Prod. Posting"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = false;
    dataset
    {
        dataitem(ItemVariant; "Item Variant")
        {
            trigger
            OnAfterGetRecord()
            begin
                "Gen. Product Posting Group" := 'ANZEIGEN PRINT';
                "VAT Product Posting Group" := 'VOLLE MWST NONBOOK';
                Modify();
            end;
        }
        dataitem(SalesLine; "Sales Line")
        {

            DataItemTableView = where("Variant Code" = filter(<> ''));
            trigger
            OnAfterGetRecord()
            var
                TempPrice: Decimal;
                SalesHeaderL: Record "Sales Header";
                ReleaseL: Boolean;
                ReleaseSalesDocument: Codeunit "Release Sales Document";
            begin
                ReleaseL := false;
                SalesHeaderL.get(SalesLine."Document Type", SalesLine."Document No.");
                If SalesHeaderL.Status = SalesHeaderL.Status::Released then begin
                    ReleaseL := true;
                    SalesHeaderL."Is Handled" := true;
                    ReleaseSalesDocument.Reopen(SalesHeaderL);
                    SalesHeaderL.Modify();
                end;
                //SalesLine."Is Handled" := true;
                TempPrice := SalesLine."Unit Price";
                SalesLine."Gen. Prod. Posting Group" := 'ANZEIGEN PRINT';
                SalesLine.Validate("VAT Prod. Posting Group", 'VOLLE MWST NONBOOK');
                SalesLine.Validate("Unit Price", TempPrice);
                //SalesLine."Is Handled" := false;
                SalesLine.Modify();
                IF ReleaseL then begin
                    ReleaseSalesDocument.ReleaseSalesHeader(SalesHeaderL, false);
                    SalesHeaderL."Is Handled" := false;
                    SalesHeaderL.Modify();
                end
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger
    OnPostReport()
    begin
        Message('Done');
    end;

    var
        myInt: Integer;
}