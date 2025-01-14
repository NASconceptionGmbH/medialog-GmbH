tableextension 60718 "Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(60700; "Salesperson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Salesperson Code';

            trigger OnValidate()
            var
                SalespersonPurchaserL: Record "Salesperson/Purchaser";

            begin
                IF SalespersonPurchaserL.Get("Salesperson Code") then
                    Validate("Commission Salesperson", SalespersonPurchaserL."Commission %")
                else
                    Validate("Commission Salesperson", 0);

            end;
        }
        field(60701; "Salesperson Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Salesperson Code 2';

            trigger OnValidate()
            var
                SalespersonPurchaserL: Record "Salesperson/Purchaser";

            begin
                IF SalespersonPurchaserL.Get("Salesperson Code") then
                    Validate("Commission Salesperson 2", SalespersonPurchaserL."Commission %")
                else
                    Validate("Commission Salesperson 2", 0);

            end;
        }
        field(60702; "Related Sales Order"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Related Sales Order', Comment = 'DEU="Verknüpfter Verkaufsauftrag"';
        }
        field(60703; "Commission Salesperson"; Decimal)
        {
            Caption = 'Commission Salesperson', Comment = 'DEU="Provision Verkäufer"';
            DataClassification = ToBeClassified;
        }
        field(60704; "Commission Salesperson 2"; Decimal)
        {
            Caption = 'Commission Salesperson 2', Comment = 'DEU="Provision Verkäufer 2"';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}