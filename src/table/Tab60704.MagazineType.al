table 60704 "Magazine Type"
{
    DataClassification = ToBeClassified;
    Caption = 'Magazin Typ';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Description"; Text[50])
        {
            Caption = 'Beschreibung';
            DataClassification = ToBeClassified;
        }
        field(3; Picture; Media)
        {
            Caption = 'Picture';
        }
        field(4; "Has Picture"; Boolean)
        {
            Caption = 'Has Picture';
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

}