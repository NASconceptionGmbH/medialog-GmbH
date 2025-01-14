tableextension 60720 "Purchase Header Archive" extends "Purchase Header Archive"
{
    fields
    {
        field(60700; "Salesperson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Salesperson Code';
        }
        field(60701; "Salesperson Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            Caption = 'Salesperson Code 2';
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