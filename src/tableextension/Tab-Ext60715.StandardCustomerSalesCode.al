tableextension 60715 "Standard Customer Sales Code" extends "Standard Customer Sales Code"
{
    fields
    {
        field(60701; "Magazine Type"; Code[20])
        {
            TableRelation = "Magazine Type";
            DataClassification = ToBeClassified;
        }
        field(60702; "Salesperson Code"; code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Verkäufer';
            DataClassification = ToBeClassified;
        }
        field(60703; "Commission"; Decimal)
        {
            Caption = 'Provision';
            DataClassification = ToBeClassified;
        }
        field(60704; "Salesperson Code 2"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Verkäufer 2';
            DataClassification = ToBeClassified;
        }
        field(60705; "Commission 2"; Decimal)
        {
            Caption = 'Provision 2';
            DataClassification = ToBeClassified;
        }
        field(60706; "Global Dimension 1 Code"; Code[20]) // CR-920
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        modify(Code)
        {
            trigger
            OnAfterValidate()
            var
                StandardSalesCodeL: Record "Standard Sales Code";
            begin
                IF StandardSalesCodeL.Get(Code) then begin
                    "Magazine Type" := StandardSalesCodeL."Magazine Type";
                    "Salesperson Code" := StandardSalesCodeL."Salesperson Code";
                    Commission := StandardSalesCodeL.Commission;
                    "Salesperson Code 2" := StandardSalesCodeL."Salesperson Code 2";
                    "Commission 2" := StandardSalesCodeL."Commission 2";
                    "Global Dimension 1 Code" := StandardSalesCodeL."Global Dimension 1 Code"; // CR-920
                end;
            end;
        }
        // Add changes to table fields here
    }
    var
        myInt: Integer;
}