tableextension 60711 "SalesCreditMemoHeader" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(60706; "Is Issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60707; "Clerk"; Code[20])
        {
            Caption = 'Sachbearbeiter';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
        }
        field(60702; "Salesperson Code 2"; Code[20])
        {
            Caption = 'Verkäufercode 2';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = ToBeClassified;
            trigger
            OnValidate()
            var
                SalespersonPurchaserL: Record "Salesperson/Purchaser";
            begin
                IF SalespersonPurchaserL.Get("Salesperson Code") then
                    "Commission Salesperson 2" := SalespersonPurchaserL."Commission %"
                else
                    "Commission Salesperson 2" := 0;
            end;
        }
        field(60703; "Commission Salesperson"; Decimal)
        {
            Caption = 'Provision Verkäufer';
            DataClassification = ToBeClassified;
        }
        field(60704; "Commission Salesperson 2"; Decimal)
        {
            Caption = 'Provision Verkäufer 2';
            DataClassification = ToBeClassified;
        }
    }

}