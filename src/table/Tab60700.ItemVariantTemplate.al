table 60700 "Item Variant Template"
{
    DataClassification = ToBeClassified;
    ObsoleteState = Removed;
    ObsoleteReason = 'NOT USED anymore';
    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(2; "Variant Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(3; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Pk; "Item No.", "Variant Code")
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