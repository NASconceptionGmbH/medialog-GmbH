tableextension 60714 "Standard Sales Line" extends "Standard Sales Line"
{
    fields
    {
        field(60700; "Unit Price"; Decimal)
        {
            Caption = 'VK-Preis';
            DataClassification = ToBeClassified;
        }
        field(60701; "Type of Business"; Code[20])
        {
            Caption = 'Kundenart';
            DataClassification = ToBeClassified;
            TableRelation = "Type of Business".Code;
        }
        field(60702; "Line Discount %"; Decimal)
        {
            Caption = 'Zeilenrabatt %';
            DataClassification = ToBeClassified;
        }
        field(60703; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
            Caption = 'Produktbuchungsgruppe';
            DataClassification = ToBeClassified;
        }
        field(60704; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
            Caption = 'MwSt. Produktbuchungsgruppe';
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger
            OnAfterValidate()
            var
                ItemL: Record Item;
            begin
                if Type = Type::Item then begin
                    ItemL.Get("No.");
                    "Gen. Prod. Posting Group" := ItemL."Gen. Prod. Posting Group";
                    "VAT Prod. Posting Group" := ItemL."VAT Prod. Posting Group";
                end
            end;
        }
    }
}
