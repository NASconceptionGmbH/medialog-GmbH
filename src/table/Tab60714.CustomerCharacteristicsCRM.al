table 60714 "Customer Characteristics CRM"
{
    DataClassification = ToBeClassified;
    Caption = 'Merkmale';

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
            Caption = 'Merkmal ID';
            DataClassification = ToBeClassified;
            TableRelation = "Item Attribute Value".ID;

            trigger OnValidate()
            var
                ItemAttributeValueL: Record "Item Attribute Value";
                EnvironmentInformationL: Codeunit "Environment Information";
                AttributeIDL: Integer;
            begin
                if EnvironmentInformationL.IsProduction() then
                    AttributeIDL := 21
                else
                    AttributeIDL := 22;

                if ItemAttributeValueL.Get(AttributeIDL, "Item Attribute Value ID") then
                    "Sparten Description" := ItemAttributeValueL.Value;
            end;
        }
        field(3; "Sparten Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Merkmal';

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