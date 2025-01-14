table 60725 "Extended Posting Matrix"
{
    Caption = 'Erweiterte Buchungsmatrix';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Country Code"; Code[20])
        {
            Caption = 'Erfüllungsland';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }

        field(2; "VAT No."; Boolean)
        {
            Caption = 'VAT oder GLN vorhanden';
            DataClassification = ToBeClassified;
        }
        field(3; "Destination Country Code"; Code[20])
        {
            Caption = 'Leistungsland';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(4; "General Bus. Posting Group"; Code[20])
        {
            Caption = 'Geschäftsbuchungsgruppe';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
        }
        field(5; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'MwSt.-Geschäftsbuchungsgruppe';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }
        field(6; "Customer Posting Group"; Code[20])
        {
            Caption = 'Debitorenbuchungsgruppe';
            DataClassification = ToBeClassified;
            TableRelation = "Customer Posting Group";
        }
        field(7; "Price Incl. VAT"; Boolean)
        {
            Caption = 'Preise inkl. MwSt.';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Country Code", "VAT No.", "Destination Country Code")
        {
            Clustered = true;
        }
    }
}
