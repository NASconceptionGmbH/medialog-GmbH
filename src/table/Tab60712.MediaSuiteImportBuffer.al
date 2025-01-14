table 60712 "MediaSuiteImportBuffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; "Ship-to Customer Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Ship-to Customer No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Sell-to Customer Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Sell-to Customer No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Sell-to Customer Name 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Sell-to Customer Country Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Sell-to Customer Post Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Sell-to City"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Sell-to Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Orderdate"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Invoice Discount"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "MwSt"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Unit Price"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Line Discount"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "External Document No."; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Contact; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Commission; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Salesperson"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Commission 2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Salesperson 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Item No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Object"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Variant Code"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Type of Business"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; Format; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Motiv; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Salesperson Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(29; "Salesperson Code 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Sell-To CRM ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Ship-To CRM ID"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Comment Sales Line"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Youre Reference"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Sell-to Contact VN"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Sell-to Contact LN"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Ship-to Contact VN"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Ship-to Contact LN"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Ship-to Address 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Ship-to Address 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Ship-to City"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Ship-To County Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Ship-To Post Code"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Error Text"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Item Description"; Text[500])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Entry No.")
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