table 60705 "Customer Type"
{
    DataClassification = ToBeClassified;
    Caption = 'Kundenart';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Kunden Nr.';
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(2; "Type of Business Code"; Code[20])
        {
            Caption = 'Artikelkategoriencode';
            DataClassification = ToBeClassified;
            TableRelation = "Type of Business".Code;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                TypeofBusinessL: Record "Type of Business";
            begin
                TypeofBusinessL.Get("Type of Business Code");
                "Type of Business Description" := TypeofBusinessL.Description;
            end;
        }
        field(3; "Type of Business Description"; Text[100])
        {
            Caption = 'Beschreibung';
            DataClassification = ToBeClassified;
        }

        field(10; Synced; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Customer No.", "Type of Business Code")
        {
            Clustered = true;
        }
    }

}