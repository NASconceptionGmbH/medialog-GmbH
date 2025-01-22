table 60732 "Excel Import Contact"
{
    Caption = 'Excel Sent Contact';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "id_location"; text[100])
        {
            Caption = 'id_location';
            DataClassification = ToBeClassified;
        }
        field(3; "Email"; text[100])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(4; "Name"; TExt[150])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; "position"; TExt[100])
        {
            Caption = 'position';
            DataClassification = ToBeClassified;
        }
        field(6; "Country"; Text[100])
        {
            Caption = 'Country';
            DataClassification = ToBeClassified;
        }
        field(7; "postal code"; text[20])
        {
            Caption = 'postal code';
            DataClassification = ToBeClassified;
        }
        field(8; "city"; text[100])
        {
            Caption = 'city';
            DataClassification = ToBeClassified;
        }
        field(9; "street"; Text[100])
        {
            Caption = 'street';
            DataClassification = ToBeClassified;
        }
        field(10; "id_juristic_person"; text[100])
        {
            Caption = 'id_juristic_person';
            DataClassification = ToBeClassified;
        }

        field(20; "processed"; Boolean)
        {
            Caption = 'processed';
            DataClassification = ToBeClassified;
        }
        field(21; "error"; text[250])
        {
            Caption = 'error';
            DataClassification = ToBeClassified;
        }





    }

    keys
    {
        key(pk; "Entry No")
        {
        }
    }
}