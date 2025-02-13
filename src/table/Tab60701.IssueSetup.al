table 60701 "Issue Setup"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Issue Category Code"; Code[50])
        {
            Caption = 'Anzeigen Artikelkategorie';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(3; "Subscription Category Code"; Code[20])
        {
            Caption = 'Abo Artikelkategorie';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(4; "Template Category Code"; Code[20])
        {
            Caption = 'Vorlage Artikelkategorie';
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Moved to ItemCategory Table Ext.';
        }
        field(5; "Mail Reminder Dateformula"; DateFormula)
        {
            Caption = 'Emailerinnerung Datumsformel';
            DataClassification = ToBeClassified;
        }
        field(6; "Mail Reminder Interval"; DateFormula)
        {
            Caption = 'Emailerinnerung Intervall';
            DataClassification = ToBeClassified;
        }
        field(7; "Sales Person Code"; COde[20])
        {
            Caption = 'Abo Verkäufercode';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser".Code;
        }

        field(8; "Type of Business"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Type of Business".Code;
            Caption = 'Abo Art des Geschäfts';

        }
        field(9; "Subscription Deferal Code"; Code[20])
        {
            Caption = 'Subscription Deferal Code';
            DataClassification = ToBeClassified;
            TableRelation = "Deferral Template"."Deferral Code";
        }

        field(10; "Test Mail Recipient"; text[100])
        {
            Caption = 'Test Mail Recipient';
            DataClassification = ToBeClassified;
        }
        field(11; "Enable OSS"; Boolean)
        {
            Caption = 'Enable OSS';
            DataClassification = ToBeClassified;
        }


        field(12; "Autom. Bom Explode"; Boolean)
        {
            Caption = 'Autom. Stücklisten Entfaltung';
            DataClassification = ToBeClassified;
        }
        field(13; "SkipCRMOrderCreation(sandbox)"; Boolean)
        {
            Caption = 'Skip CRM in OrderCreation (sandbox)';
            DataClassification = ToBeClassified;
        }
        field(14; "Last Issue Ad Update"; DateTime)
        {
            Caption = 'Last Issue Ad Update';
            DataClassification = ToBeClassified;
        }
        field(15; "Mail Recip. for Issue Reminder"; Text[250])
        {
            Caption = 'Mail Recip. for Issue Reminder';
        }
    }

    keys
    {
        key(PK; "Primary Key")
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