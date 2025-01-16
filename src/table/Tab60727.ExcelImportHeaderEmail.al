table 60727 "Excel Import Header Email"
{
    Caption = 'Excel Sent Email Import';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Reference';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "id_location"; Code[20])
        {
            Caption = 'id_location';
            DataClassification = ToBeClassified;
        }
        field(3; "id_communication"; code[2])
        {
            Caption = 'id_communication';
            DataClassification = ToBeClassified;
        }
        field(4; "communication_number"; text[250])
        {
            Caption = 'communication_number';
            DataClassification = ToBeClassified;
        }

        field(5; "Belegsendeprofil"; Code[20])
        {
            Caption = 'Belegsendeprofil';
            DataClassification = ToBeClassified;
        }
        field(6; "kind_of_communication"; Text[30])
        {
            Caption = 'kind_of_communication';
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