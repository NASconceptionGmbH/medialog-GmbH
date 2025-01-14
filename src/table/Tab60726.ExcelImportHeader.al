table 60726 "Excel Import Header"
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
        field(2; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; Time; Time)
        {
            Caption = 'Time';
            DataClassification = ToBeClassified;
        }
        field(4; "Invoice No"; Code[20])
        {
            Caption = 'Invoice No';
            DataClassification = ToBeClassified;
        }
        field(5; Date; Date)
        {
            Caption = 'Date';
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