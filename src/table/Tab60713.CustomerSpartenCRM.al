table 60713 "Customer Sparten CRM"
{
    DataClassification = ToBeClassified;
    Caption = 'Sparten';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Kunden Nr.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }

        field(2; "Item Attribute Value ID"; Integer)
        {
            Caption = 'Sparten ID';
            DataClassification = ToBeClassified;
            TableRelation = "Item Attribute Value".ID;

            trigger OnValidate()
            var
                ItemAttributeValueL: Record "Item Attribute Value";
            begin
                if ItemAttributeValueL.Get(19, "Item Attribute Value ID") then
                    "Sparten Description" := ItemAttributeValueL.Value;
            end;
        }
        field(3; "Sparten Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sparte';

        }
        field(10; Synced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Customer No.", "Item Attribute Value ID")
        {
            Clustered = true;
        }
    }

}