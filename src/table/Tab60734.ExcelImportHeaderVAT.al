table 60734 "Excel Import Header SP"
{
    Caption = 'Excel Import Header Salesperson';

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "order no"; code[20])
        {
            Caption = 'order no';
            DataClassification = ToBeClassified;
        }
        field(3; "Salesperson"; Code[20])
        {
            Caption = 'Salesperson';
            DataClassification = ToBeClassified;
        }

        field(4; "Clerk"; Code[20])
        {
            Caption = 'Clerk';
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