table 60717 "Import Buffer Correction"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Ext. Doc No."; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Error Text"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}