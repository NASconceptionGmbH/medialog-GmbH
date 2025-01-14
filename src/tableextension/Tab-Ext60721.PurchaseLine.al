tableextension 60721 "Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(60700; "Sales Order Line No. Add"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Order Line No.', Comment = 'DEU="Verkaufsauftragszeile Nr."';
        }
        field(60701; "Sales Order No. Add"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Order No.', Comment = 'DEU="Verkaufsauftrag Nr."';
        }
    }

    var
        myInt: Integer;
}