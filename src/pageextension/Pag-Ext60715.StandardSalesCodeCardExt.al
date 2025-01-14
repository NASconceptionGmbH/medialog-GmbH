pageextension 60715 "StandardSalesCodeCardExt" extends "Standard Sales Code Card"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = all;
            }
            field(CustomerName; GetCustomerName())
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Magazine Type"; Rec."Magazine Type")
            {
                ApplicationArea = All;
            }
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
            field(Commission; Rec.Commission)
            {
                ApplicationArea = All;
            }
            field("Salesperson Code 2"; Rec."Salesperson Code 2")
            {
                ApplicationArea = All;
            }
            field("Commission 2"; Rec."Commission 2")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code") // CR-920
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action("Copy Recurring Sales Line")
            {
                ApplicationArea = All;
                Caption = 'Wiederkehrende Zeilen Kopieren';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Copy;
                trigger OnAction()
                var
                    StdCSalesCodeL: Record "Standard Sales Code";
                    StandardSalesCodesL: Page "Standard Sales Codes";
                    StandardSalesLineL, StandardSalesLine2L : Record "Standard Sales Line";
                begin
                    Rec.TestField(Rec.Code);
                    StdCSalesCodeL.Reset();
                    IF Page.RunModal(Page::"Standard Sales Codes", StdCSalesCodeL) = ACTION::LookupOK then begin
                        StandardSalesLineL.Reset();
                        StandardSalesLineL.SetRange("Standard Sales Code", StdCSalesCodeL.Code);
                        if StandardSalesLineL.FindSet() then
                            repeat
                                Rec.Validate("Magazine Type", StdCSalesCodeL."Magazine Type");
                                Rec.Validate("Salesperson Code", StdCSalesCodeL."Salesperson Code");
                                Rec.Validate("Salesperson Code 2", StdCSalesCodeL."Salesperson Code 2");
                                Rec.Commission := StdCSalesCodeL.Commission;
                                Rec."Commission 2" := StdCSalesCodeL."Commission 2";
                                StandardSalesLine2L.Init();
                                StandardSalesLine2L.TransferFields(StandardSalesLineL);
                                StandardSalesLine2L.Validate("Standard Sales Code", Rec.Code);
                                StandardSalesLine2L.Insert(true);
                            until StandardSalesLineL.Next() = 0;
                    end;
                end;
            }
        }
    }

    local procedure GetCustomerName(): text[100]
    var
        CustomerL: record Customer;
    begin
        Rec.CalcFields("Customer No.");
        if CustomerL.Get(Rec."Customer No.") then
            exit(CustomerL.Name);

        exit('');
    end;
}
