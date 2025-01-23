table 60734 "Excel Import Header VAT"
{
    Caption = 'Excel Import Header VAT';

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
        field(3; "id_juristic_person"; Text[100])
        {
            Caption = 'id_juristic_person';
            DataClassification = ToBeClassified;
        }
        field(4; "ust id"; text[50])
        {
            Caption = 'ust id';
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